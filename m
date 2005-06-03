From: Jason McMullan <jason.mcmullan@timesys.com>
Subject: [PATCH] git-daemon server
Date: Fri, 3 Jun 2005 11:22:12 -0400
Message-ID: <20050603152212.GA4598@jmcmullan.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org
X-From: git-owner@vger.kernel.org Fri Jun 03 17:24:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DeDyQ-00039o-8y
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 17:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVFCPXq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 11:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261324AbVFCPXq
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 11:23:46 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:4273 "EHLO
	timesys.com") by vger.kernel.org with ESMTP id S261322AbVFCPWN
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Jun 2005 11:22:13 -0400
Received: by timesys.com (Postfix, from userid 623)
	id 7F31F16E0B; Fri,  3 Jun 2005 11:22:12 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

git-daemon - Client/server for exchanging GIT objects

Requires: [PATCH] Expose more sha1_file.c interfaces
Requires: [PATCH] Anal retentive 'const unsigned char *sha1'
Signed-off-by: Jason McMullan <jason.mcmullan@timesys.com>

GIT daemon is a symmetric protocol for exchanging objects
between repositories. It has the following features:

	* Can use TCP, Unix domain sockets, or stdin/stdout
	* Verifies received SHA1 objects are valid and fully
	  connected before they are stored in the object database,
	  including delta objects.
	* Fully symmetric protocol
	* Only pulls the dependencies of the requested object -
	  allows you to place *multiple* projects in one GIT database.
	* Proper head locking, allows either lazy or cmp-xchg updates
	  (lazy is just 'head head-id old-sha1 new-sha1', cmp-xchg is
           'send new-sha1; head head-id old-sha1 new-sha1' )

TODO:
-----

	* Command line 'send' of a SHA1 from the local database
	  (for the cmd-xchg mechanism. Lazy works out-of-the box)
	* Optional auto-deltification of transmitted objects
	* More documentation
	* Test cases for 'make test'
	* Merge verify-before-update logic into pull.c

GIT Daemon Protocol Commands:
-----------------------------

version::
        Requests the version string, returned in an error message
        Expects: 'error'

head <head-id>::
        Requests SHA1 of the <head-id>
        Expects: 'sha1' or 'error'

head <head-id> <old-sha1> <new-sha1>::
        Requests that <head-id> be updated with <new-sha1>. Use
        '--' for <old-sha1> to create a new head.
        Expects: 'sha1', 'request', or 'error'

exists <sha1>::
        Determine if SHA1 exists in remote
        Expects: 'sha1' or 'error'

request <sha1>::
        Request SHA1 object. 
        Expects: 'send' or 'error'

send <sha1>::
        Send SHA1 object.
        Expects: 'sha1' or 'error'

error <key> <hex-code> <error-message>::
        Returned error code
        Expects: Nothing

sha1 <key> <hex-sha1>::
        Success message for 'head' and 'send' commands.


diff -u b/daemon.c b/daemon.c
--- b/daemon.c
+++ b/daemon.c
@@ -0,0 +1,827 @@
+#include <stdio.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <ctype.h>
+#include <assert.h>
+#include <signal.h>
+#include <sys/un.h>
+#include <sys/file.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <netinet/ip.h>
+#include <arpa/inet.h>
+#include <netdb.h>
+
+#ifndef UNIX_PATH_MAX
+#define UNIX_PATH_MAX sizeof(((struct sockaddr_un *)NULL)->sun_path)
+#endif
+
+#include "cache.h"
+#include "delta.h"
+#include "object.h"
+#include "blob.h"
+#include "tree.h"
+#include "commit.h"
+#include "tag.h"
+
+#define ERROR_VERSION			0,"GIT Daemon protocol version 0.0"
+#define ERROR_INVALID			1,"Invalid command"
+#define ERROR_REQUEST_INVALID		100,"SHA1 does not exist"
+#define ERROR_HEAD_BAD(hash)		200,"Head is not at hash %s",hash
+#define ERROR_HEAD_INVALID		201,"Head does not exist"
+#define ERROR_HEAD_LOCK			202,"Head can't be locked"
+#define ERROR_HEAD_UPDATE		203,"Head can't be updated"
+#define ERROR_HEAD_SHA1_INVALID(sha1)	204,"SHA1 %s does not exist",sha1
+#define ERROR_SEND_INVALID		300,"Invalid data sent on send"
+
+/* Protocol is symmetric, both client and server
+ * use the same commands.
+ *
+ * version\n -> error -- 0 <Version string>\n
+ *
+ * head <head-id>\n -> sha1 <head-id> <sha1>\n
+ *
+ * head <head-id> <old-sha1> <new-sha1>\n -> sha1 <head-id> <new-sha1>\n
+ *
+ * request <sha1>\n -> send <sha1> <hex-bytes>\n<bytes...>
+ *
+ * send <sha1> <hex-bytes>\n<bytes...> -> sha1 -- <sha1>\n
+ *
+ * exists <sha1>\n -> sha1 -- <sha1>\n
+ *
+ * sha1 <any> <sha1>\n -> no-op
+ *
+ * error <key> <hex-code> <error string>\n -> no-op
+ *
+ */
+
+static int fd_in=0, fd_out=1;
+
+static int process_request();
+static int send_request(const unsigned char *sha1);
+static const char *git_dir;
+
+void *map_file(int fd, size_t size)
+{
+	void *map;
+
+	if (fd < 0) {
+		error("cannot map file on fd %d", fd);
+		return NULL;
+	}
+
+	map = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (-1 == (int)(long)map)
+		return NULL;
+	return map;
+}
+
+static int sha1_retrieve(const unsigned char *sha1)
+{
+	int err;
+
+       	if (!has_sha1_file(sha1)) {
+		err = send_request(sha1);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+static int verify_file(int fd, unsigned long mapsize, const unsigned char *sha1, char *type)
+{
+	void *map, *buffer;
+	char hdr[8192];
+	struct object *obj;
+	unsigned long size;
+	z_stream stream;
+	int err;
+
+	map = map_file(fd, mapsize);
+	if (map) {
+		err = unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr));
+		if (err < Z_OK || parse_sha1_header(hdr, type, &size) < 0) {
+			munmap(map, mapsize);
+			return -1;
+		}
+		buffer = unpack_sha1_rest(&stream, hdr, size);
+		munmap(map, size);
+
+		if (buffer == NULL) {
+			return -1;
+		}
+
+		if (buffer && !strcmp(type, "delta")) {
+			void *ref = NULL, *delta = buffer;
+			unsigned long ref_size, delta_size = size;
+			buffer = NULL;
+			if (delta_size <= 20) {
+				free(buffer);
+				return -1;
+			}
+			err = sha1_retrieve(delta);
+			if (err < 0) {
+				free(buffer);
+				return err;
+			}
+			ref = read_sha1_file(delta, type, &ref_size);
+
+			if (ref == NULL) {
+				free(buffer);
+				return err;
+			}
+
+			buffer = patch_delta(ref, ref_size,
+					  delta+20, delta_size-20, 
+					  &size);
+			free(delta);
+			free(ref);
+		}
+
+		if (!strcmp(type, "blob")) {
+			struct blob *blob = lookup_blob(sha1);
+			parse_blob_buffer(blob, buffer, size);
+			obj = &blob->object;
+		} else if (!strcmp(type, "tree")) {
+			struct tree *tree = lookup_tree(sha1);
+			parse_tree_buffer(tree, buffer, size);
+			obj = &tree->object;
+		} else if (!strcmp(type, "commit")) {
+			struct commit *commit = lookup_commit(sha1);
+			parse_commit_buffer(commit, buffer, size);
+			if (!commit->buffer) {
+				commit->buffer = buffer;
+				buffer = NULL;
+			}
+			obj = &commit->object;
+		} else if (!strcmp(type, "tag")) {
+			struct tag *tag = lookup_tag(sha1);
+			parse_tag_buffer(tag, buffer, size);
+			obj = &tag->object;
+		} else {
+			obj = NULL;
+		}
+
+		free(buffer);
+
+		if (obj) {
+			struct object_list *refs;
+
+			for (refs = obj->refs; refs ; refs = refs->next) {
+				err = sha1_retrieve(refs->item->sha1);
+				if (err < 0)
+					return err;
+			}
+		
+			return 0;
+		}
+
+	}
+	return -1;
+}
+
+static int send_command(int argc, char **argv)
+{
+	char buff[1024];
+	int len, size;
+
+	size = snprintf(buff, sizeof(buff), "%s", argv[0]);
+	for ( argc--,argv++; argc > 0 ; argc--, argv++) {
+		len = snprintf(buff + size, sizeof(buff) - size, " %s", argv[0]);
+		size += len;
+	}
+	buff[size++]='\n';
+	return write(fd_out, buff, size);
+}
+
+static int send_error(const char *key,int code,const char *errstr,...)
+{
+	va_list args;
+	static char buff[1024];
+	int len;
+
+	va_start(args, errstr);
+
+	len = snprintf(buff, sizeof(buff), "error %s %x ", key ? key : "--", code);
+	write(fd_out, buff, len);
+	len = vsnprintf(buff, sizeof(buff), errstr, args);
+	write(fd_out, buff, len);
+	write(fd_out, "\n", 1);
+
+	va_end(args);
+
+	return 0;
+}
+
+static int send_sha1(const char *key, const unsigned char *sha1)
+{
+	char buff[2048];
+	int len;
+
+	len = snprintf(buff,sizeof(buff), "sha1 %s %s\n",key ? key : "--", sha1_to_hex(sha1));
+	return write(fd_out, buff, len);
+}
+
+static int send_send(const unsigned char *sha1, int size, void *data)
+{
+	char buff[2048];
+	int len, err;
+
+	len = snprintf(buff,sizeof(buff), "send %s %x\n",sha1_to_hex(sha1),size);
+	err = write(fd_out, buff, len);
+
+	if (err < 0)
+		return err;
+
+	err = write(fd_out, data, size);
+	if (err < 0)
+		return err;
+
+	return process_request();
+}
+
+static int send_request(const unsigned char *sha1)
+{
+	char buff[2048];
+	int len, err;
+
+	len = snprintf(buff,sizeof(buff), "request %s\n",sha1_to_hex(sha1));
+	err = write(fd_out, buff, len);
+	if (err < 0)
+		return err;
+
+	return process_request();
+}
+
+
+static inline int lock_file(const char *path, int is_create)
+{
+	int fd;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0 && is_create) {
+		fd = open(path, O_RDWR | O_CREAT | O_TRUNC, 0644);
+	} else if (is_create) {
+		close(fd);
+		return -1;
+	}
+
+	if (fd < 0)
+		return -1;
+
+	if (flock(fd, LOCK_EX | LOCK_NB) < 0) {
+		close(fd);
+		if (is_create)
+			unlink(path);
+		return -1;
+	}
+
+	return fd;
+}
+
+static inline void unlock_file(int fd)
+{
+	flock(fd, LOCK_UN);
+	close(fd);
+}
+
+static int cmd_version(int argc, char **argv)
+{
+	return send_error("--",ERROR_VERSION);
+}
+
+/* Return < 0 on I/O error
+ */
+static int cmd_head(int argc, char **argv)
+{
+	int len, err;
+
+	if (argc == 2) {
+		unsigned char sha1[20];
+
+		/* Get SHA1 for head */
+	       	err = get_sha1(argv[1], sha1);
+		if (err < 0)
+			return send_error(argv[1],ERROR_HEAD_INVALID);
+
+		return send_sha1(argv[1],sha1);
+	} else if (argc == 4) {
+		char head_sha1[20], sha1[20], sha1_new[20];
+		int fd, head_fd;
+		static char buff[256];
+		static char hfile[PATH_MAX];
+		static char hfile_new[PATH_MAX];
+		int is_create;
+		const char *head=argv[1], *old_hash=argv[2], *new_hash=argv[3];
+
+		is_create = (strcmp(old_hash,"--")==0);
+
+		/* Is the head name valid? */
+		if (strchr(head,'/') != NULL)
+			return send_error(head,ERROR_HEAD_INVALID);
+
+		/* lock head */
+		len = snprintf(hfile, sizeof(hfile), "%s/refs/heads/%s", git_dir, argv[1]);
+		strcpy(hfile_new, hfile);
+		strcpy(hfile_new + len, ".new");
+		head_fd = lock_file(hfile, is_create);
+		if (head_fd < 0) {
+			return send_error(head,ERROR_HEAD_LOCK);
+		}
+
+		/* Verify that we know what we're doing
+		 * to do a cmp-xchg update
+		 */
+		if (!is_create) {
+	       		err = get_sha1(head, head_sha1);
+			if (err < 0) {
+				if (is_create) unlink(hfile);
+				unlock_file(head_fd);
+				return send_error(head, ERROR_HEAD_INVALID);
+			}
+
+			err = get_sha1(old_hash, sha1);
+			if (err < 0) {
+				if (is_create) unlink(hfile);
+				unlock_file(head_fd);
+				return send_error(head, ERROR_HEAD_SHA1_INVALID(old_hash));
+			}
+
+			if (memcmp(head_sha1, sha1, 20) != 0) {
+				if (is_create) unlink(hfile);
+				unlock_file(head_fd);
+				return send_error(head, ERROR_HEAD_BAD(old_hash));
+			}
+		}
+
+
+		/* Is the new head id even a valid string? */
+		err = get_sha1(new_hash, sha1_new);
+		if (err < 0) {
+			if (is_create) unlink(hfile);
+			unlock_file(head_fd);
+			return send_error(head,ERROR_HEAD_SHA1_INVALID(new_hash));
+		}
+
+		/* If new-sha1 == old-sha1, short circuit to end */
+		if (memcmp(sha1_new, sha1, 20) == 0)
+			goto done;
+
+		/* Verify that new-sha1 is in the database */
+		err = sha1_retrieve(sha1_new);
+		if (err < 0) {
+			if (is_create) unlink(hfile);
+			unlock_file(head_fd);
+			return err;
+		}
+
+		/* We now have the SHA1. Update head */
+		fd = open(hfile_new, O_RDWR | O_CREAT | O_TRUNC, 0644);
+		if (fd < 0) {
+			if (is_create) unlink(hfile);
+			unlock_file(head_fd);
+			return send_error(argv[1],ERROR_HEAD_UPDATE);
+		}
+
+		len = snprintf(buff, sizeof(buff), "%s\n", sha1_to_hex(sha1_new));
+		err = write(fd, buff, len);
+		close(fd);
+		if (err != len) {
+			if (is_create) unlink(hfile);
+			unlink(hfile_new);
+			unlock_file(head_fd);
+			return send_error(argv[1],ERROR_HEAD_UPDATE);
+		}
+
+		err = rename(hfile_new, hfile);
+		if (err < 0) {
+			if (is_create) unlink(hfile);
+			unlock_file(head_fd);
+			return send_error(argv[1],ERROR_HEAD_UPDATE);
+		}
+
+done:
+		/* Unlock head */
+		unlock_file(head_fd);
+		return send_sha1(argv[1], sha1_new);
+		write(fd_out, buff, len);
+	} else {
+		return send_error(argv[1],ERROR_INVALID);
+	}
+
+	return 0;
+}
+
+/* Return < 0 on I/O error
+ */
+static int cmd_request(int argc, char **argv)
+{
+	int err;
+
+	if (argc == 2) {
+		char sha1[40];
+		void *data;
+		unsigned long size;
+
+ 		err = get_sha1(argv[1], sha1);
+
+		/* If sha1 exists, send it. */
+		if (err < 0)
+			return send_error(argv[1],ERROR_REQUEST_INVALID);
+
+		data = map_sha1_file(sha1, &size);
+		if (data == NULL)
+			return send_error(argv[1],ERROR_REQUEST_INVALID);
+
+		err = send_send(sha1, size, data);
+		if (err < 0)
+			return err;
+		err = process_request();
+		munmap(data, size);
+	} else {
+		err = send_error(argv[1],ERROR_INVALID);
+	}
+
+	return err;
+}
+
+static int cmd_send(int argc, char **argv)
+{
+	int err;
+	int tmpfd = -1;
+	char tmpn[]="/tmp/git.daemon.XXXXXX";
+
+	if (argc == 3) {
+		char sha1[20];
+		int size = strtol(argv[2],NULL,16);
+		char type[32];
+		void *buff;
+		const char *fname;
+		int fd;
+		int exists = 0;
+
+ 		err = get_sha1(argv[1], sha1);
+		/* If sha1 exists, just drop all the bytes on the floor */
+		/* Otherwise, create a temp file, and stuff the bytes there */
+
+		if (err == 0) {
+			tmpfd = mkstemp(tmpn);
+			unlink(tmpn);
+		} else {
+			exists = 1;
+			tmpfd = open("/dev/null", O_RDWR);
+		}
+
+		err = write_sha1_from_fd_to_fd(sha1, fd_in, tmpfd);
+		if (err < 0 || size != err) {
+			close(tmpfd);
+			return send_error(argv[1],ERROR_SEND_INVALID);
+		}
+
+		if (exists)
+			goto done;
+
+		/* Verify that the temp file contains a valid blob/tree 
+		 * This step also recurses and gets all the 'good stuff'
+		 */
+		err = verify_file(tmpfd, size, sha1, type);
+		if (err < 0) {
+			close(tmpfd);
+			return send_error(argv[1],ERROR_SEND_INVALID);
+		}	
+
+		/* Write to database if verified */
+		buff = map_file(tmpfd, size);
+		fname = sha1_file_name(sha1);
+		fd = open(fname, O_RDWR | O_CREAT | O_TRUNC, 0644);
+		err = write(fd, buff, size);
+		close(fd);
+		if (err != size) {
+			unlink(fname);
+			close(tmpfd);
+			return send_error(argv[1],ERROR_SEND_INVALID);
+		}
+
+done:
+		close(tmpfd);
+		return send_sha1(NULL, sha1);
+	} else {
+		err = send_error(argv[1],ERROR_INVALID);
+	}
+
+	return err;
+}
+
+int cmd_exists(int argc, char **argv)
+{
+	int err;
+
+	if (argc == 2) {
+		char sha1[20];
+
+ 		err = get_sha1(argv[1], sha1);
+
+		/* If sha1 exists, say so. Otherwise say 'send sha1'*/
+		if (err >= 0)
+			return send_sha1(NULL, sha1);
+
+		return send_error(NULL, ERROR_REQUEST_INVALID);
+	} else {
+		err = send_error(argv[1],ERROR_INVALID);
+	}
+
+	return err;
+}
+
+int cmd_sha1(int argc, char **argv)
+{
+	int i;
+
+	fprintf(stderr, "%s",argv[0]);
+	for ( i=1; i < argc; i++)
+		fprintf(stderr, " %s",argv[i]);
+	fprintf(stderr, "\n");
+	return 0;
+}
+
+static int cmd_error(int argc, char **argv)
+{
+	int i;
+
+	fprintf(stderr, "%s",argv[0]);
+	for ( i=1; i < argc; i++)
+		fprintf(stderr, " %s",argv[i]);
+	fprintf(stderr, "\n");
+	return 0;
+}
+
+static int command(int argc, char **argv)
+{
+	int err;
+#if 0
+	int i;
+
+	fprintf(stderr, "%s",argv[0]);
+	for ( i=1; i < argc; i++)
+		fprintf(stderr, " %s",argv[i]);
+	fprintf(stderr, "\n");
+#endif
+
+	if (argc < 1)
+		goto invalid;
+
+	if (strcmp(argv[0],"version")==0) {
+		err = cmd_version(argc,argv);
+		return err;
+	} else if (strcmp(argv[0],"head")==0) {
+		err = cmd_head(argc,argv);
+		return err;
+	} else if (strcmp(argv[0],"send")==0) {
+		err = cmd_send(argc,argv);
+		return err;
+	} else if (strcmp(argv[0],"request")==0) {
+		err = cmd_request(argc,argv);
+		return err;
+	} else if (strcmp(argv[0],"exists")==0) {
+		err = cmd_exists(argc,argv);
+		return err;
+	} else if (strcmp(argv[0],"sha1")==0) {
+		err = cmd_sha1(argc,argv);
+		return err;
+	} else if (strcmp(argv[0],"error")==0) {
+		err = cmd_error(argc,argv);
+		return err;
+	}
+
+invalid:
+	return send_error("--",ERROR_INVALID);
+}
+
+/* This *intentionally* drops requests on the floor that are
+ * larger than sizeof(buffer)
+ */
+static int process_request()
+{
+	char buffer[1024];
+	int offset;
+	char **argv,*cp;
+	int argc,err;
+
+	offset=0;
+
+	while (read(fd_in, &buffer[offset], 1)==1) {
+		if (buffer[offset++]=='\n')
+			break;
+		if (offset == sizeof(buffer))
+			return -1;
+	}
+	offset--;
+
+	if (offset < 0 || buffer[offset]!='\n')
+		return -1;
+
+	buffer[offset]=0;
+	argc=0;
+	argv=xmalloc(sizeof(char *));
+
+	cp = &buffer[0];
+	while (1) {
+		while (*cp && isspace(*cp)) cp++;
+		if (*cp == 0)
+			break;
+		argv[argc++]=cp;
+		argv=xrealloc(argv, (argc+1)*sizeof(char *));
+		while (*cp && !isspace(*cp)) cp++;
+		if (*cp == 0)
+			break;
+		*(cp++) = 0;
+	};
+
+	argv[argc]=NULL;
+	err = command(argc,argv);
+	free(argv);
+
+	return err;
+}
+
+/* Reap children */
+static void reaper(int sig)
+{
+	int status;
+
+	waitpid(-1, &status, WNOHANG);
+}
+
+static int get_ip_addr(const char *ip, struct in_addr *addr)
+{
+	int err;
+	struct hostent *host;
+
+	err = inet_pton(AF_INET, ip, addr);
+	if (err < 0)
+		return 0;
+
+	host = gethostbyname(ip);
+	if (host == NULL)
+		return -1;
+
+	return inet_pton(AF_INET, host->h_addr, addr);
+}
+
+static int get_port(const char *port)
+{
+	struct servent *serv;
+	int p;
+
+	if (sscanf(port,"%d",&p) == 1)
+		return p;
+
+	serv = getservbyname(port,"tcp");
+	if (serv == NULL)
+		return -1;
+
+	return serv->s_port;
+}
+
+int main(int argc, char **argv)
+{
+	enum {
+		MODE_STDIO,
+		MODE_UNIX,
+		MODE_TCP,
+	} mode = MODE_STDIO;
+	const char *port = "/tmp/.gitd",*host="127.0.0.1";
+	union {
+		struct sockaddr	   generic;
+		struct sockaddr_un un;
+		struct sockaddr_in in;
+	} sock;
+	struct sockaddr_un *s_unix = (void *)&sock.un;
+	struct sockaddr_in *s_inet = (void *)&sock.in;
+	size_t s_size = 0;
+	int max_clients=100, err;
+
+	git_dir = gitenv(GIT_DIR_ENVIRONMENT) ? : DEFAULT_GIT_DIR_ENVIRONMENT;
+
+	argv++;
+	argc--;
+	for (; argc > 0; argv++, argc--) {
+		char *path = argv[0];
+
+		if (path[0] != '-')
+		       break;
+
+		if (!strcmp(path,"--")) {
+			argv++;
+			argc--;
+			break;
+		}
+
+		if (!strcmp(path,"--unix")) {
+			mode = MODE_UNIX;
+			continue;
+		}
+		
+		if (!strcmp(path,"--tcp")) {
+			mode = MODE_TCP;
+			continue;
+		}
+		
+		if (!strcmp(path, "--max-clients")) {
+			if (argc < 2)
+				die("git-daemon: --max-clients <number>");
+			max_clients = strtoul(argv[1],NULL,0);
+			argv++;
+			argc--;
+			continue;
+		}
+
+		if (!strcmp(path, "--host")) {
+			if (argc < 2)
+				die("git-daemon: --host <host>");
+			host = argv[1];
+			argv++;
+			argc--;
+			continue;
+		}
+
+		if (!strcmp(path, "--port")) {
+			if (argc < 2)
+				die("git-daemon: --port <port>");
+			port = argv[1];
+			argv++;
+			argc--;
+			continue;
+		}
+
+		if (!strcmp(path, "--db")) {
+			if (argc < 2)
+				die("git-daemon: --db <path/.git>");
+			git_dir = argv[2];
+			argv++;
+			argc--;
+			continue;
+		}
+	}
+
+	switch (mode) {
+		case MODE_STDIO: fd_in = 0; fd_out = 1; break;
+		case MODE_UNIX:
+			fd_in = fd_out = socket(PF_UNIX, SOCK_STREAM, 0);
+			if (fd_in < 0)
+				die("git-daemon: Can't create local domain socket");
+			strncpy(s_unix->sun_path, port, UNIX_PATH_MAX);
+			s_unix->sun_path[UNIX_PATH_MAX-1]=0;
+			s_unix->sun_family = AF_UNIX;
+			s_size = sizeof(*s_unix);
+			break;
+		case MODE_TCP:
+			fd_in = fd_out = socket(PF_INET, SOCK_STREAM, 0);
+			if (fd_in < 0)
+				die("git-daemon: Can't create TCP/IP socket");
+			s_inet->sin_family = AF_INET;
+			err = get_ip_addr(host, &s_inet->sin_addr);
+			s_inet->sin_port = htons(get_port(port));
+			s_size = sizeof(*s_inet);
+			break;
+	}
+
+
+	if (argc > 0) {
+		if (s_size != 0) {
+			err = connect(fd_in, &sock.generic, s_size);
+			if (err < 0)
+				die("git-daemon: Can't connect to socket \"%s\"",port);
+		}
+
+		err = send_command(argc, argv);
+		if (err < 0)
+			return err;
+		return  process_request();
+        }
+
+	if (s_size != 0) {
+		int one = 1;
+		err = setsockopt(fd_in, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one));
+		err = bind(fd_in, &sock.generic, s_size);
+		listen(fd_in, max_clients);
+		do {
+			signal(SIGCHLD, reaper);
+			fd_out = accept(fd_in, NULL, NULL);
+			if (fd_out < 0)
+				die("git-daemon: Failed to start listening");
+			if (fork()==0) 
+				break;
+			close(fd_out);
+		} while (1);
+
+		fd_in = fd_out;
+	}
+
+	while (process_request() >= 0);
+
+	return 0;
+}
only in patch2:
unchanged:
--- /dev/null
+++ b/Documentation/git-daemon.txt
@@ -0,0 +1,92 @@
+git-daemon(1)
+=============
+v0.1, May 2005
+
+NAME
+----
+git-daemon - Client/server for exchanging GIT objects
+
+
+SYNOPSIS
+--------
+'git-daemon' [--db <git-db-path>] [--stdio | --tcp | --udp] 
+	     [--port <port>] [--host <host>] [-- command...]
+
+DESCRIPTION
+-----------
+
+OPTIONS
+-------
+--db::
+	Set the GIT object database path to use
+
+--stdio::
+	Use stdin/stdout as the transport (default)
+
+--tcp::
+	Use TCP as the transport
+
+--unix::
+	Use Unix domain sockets as the transport
+
+--host::
+	Specify IPv4 host for --tcp transport
+
+--port::
+	Specify IPv4 port for --tcp transport, or the
+	filesystem socket path for the --unix transport
+
+--::
+	Stop argument processing
+
+<command>::
+	GIT Daemon protocol command
+
+GIT Daemon Protocol Commands:
+-----------------------------
+
+version::
+	Requests the version string, returned in an error message
+	Expects: 'error'
+
+head <head-id>::
+	Requests SHA1 of the <head-id>
+	Expects: 'sha1' or 'error'
+
+head <head-id> <old-sha1> <new-sha1>::
+	Requests that <head-id> be updated with <new-sha1>. Use
+	'--' for <old-sha1> to create a new head.
+	Expects: 'sha1', 'request', or 'error'
+
+exists <sha1>::
+	Determine if SHA1 exists in remote
+	Expects: 'sha1' or 'error'
+
+request <sha1>::
+	Request SHA1 object. 
+	Expects: 'send' or 'error'
+
+send <sha1>::
+	Send SHA1 object.
+	Expects: 'sha1' or 'error'
+
+error <key> <hex-code> <error-message>::
+	Returned error code
+	Expects: Nothing
+
+sha1 <key> <hex-sha1>::
+	Success message for 'head' and 'send' commands.
+	Expects: Nothing
+
+Author
+------
+Written by Jason McMullan <jason.mcmullan@timesys.com>
+
+Documentation
+--------------
+Documentation by Jason McMullan and the git-list <git@vger.kernel.org>.
+
+GIT
+---
+Part of the link:git.html[git] suite
+
-- 
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation
