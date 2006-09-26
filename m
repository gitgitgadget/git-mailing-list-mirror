From: Jon Loeliger <jdl@jdl.com>
Subject: [PATCH Rev 2] Cleaned up git-daemon virtual hosting support.
Date: Tue, 26 Sep 2006 09:04:57 -0500
Message-ID: <E1GSDYP-000526-Ly@jdl.com>
X-From: git-owner@vger.kernel.org Tue Sep 26 16:05:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSDYb-0005VM-5W
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 16:05:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521AbWIZOFF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 10:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbWIZOFF
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 10:05:05 -0400
Received: from colo.jdl.com ([66.118.10.122]:39827 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S1751521AbWIZOFB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Sep 2006 10:05:01 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1GSDYP-000526-Ly
	for git@vger.kernel.org; Tue, 26 Sep 2006 09:05:00 -0500
To: git@vger.kernel.org
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27793>


Standardized on lowercase hostnames from client.

Added interpolation values for the IP address, Port and
canonical hostname of the server as it is contacted and
named by the client and passed in via the extended args.

Added --listen=host_or_ipaddr option suport.  Renamed port
variable as "listen_port" correspondingly as well.

Documented mutual exclusivity of --inetd option with
--user, --group, --host and --port options.

Added compat_inet_pton from Paul Vixie as needed.

Small memory leaks need to be cleaned up still.

Signed-off-by: Jon Loeliger <jdl@jdl.com>

---

Junio,

Renamed the "--host=" option as "--listen=" per request.
Follow-up patch to fix small leaks to come still.

Thanks,
jdl


 Documentation/git-daemon.txt |   45 +++++++--
 Makefile                     |    3 +
 compat/inet_pton.c           |  220 ++++++++++++++++++++++++++++++++++++++++++
 daemon.c                     |  146 ++++++++++++++++++++++++----
 4 files changed, 387 insertions(+), 27 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 87444b4..422cc37 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -8,14 +8,15 @@ git-daemon - A really simple server for 
 SYNOPSIS
 --------
 [verse]
-'git-daemon' [--verbose] [--syslog] [--inetd | --port=n] [--export-all]
+'git-daemon' [--verbose] [--syslog] [--export-all]
              [--timeout=n] [--init-timeout=n] [--strict-paths]
              [--base-path=path] [--user-path | --user-path=path]
              [--interpolated-path=pathtemplate]
+             [--reuseaddr] [--detach] [--pid-file=file]
              [--enable=service] [--disable=service]
 	     [--allow-override=service] [--forbid-override=service]
-             [--reuseaddr] [--detach] [--pid-file=file]
-             [--user=user [--group=group]] [directory...]
+	     [--inetd | [--host=host_or_ipaddr] [--port=n] [--user=user [--group=group]]
+	     [directory...]
 
 DESCRIPTION
 -----------
@@ -54,8 +55,12 @@ OPTIONS
 --interpolated-path=pathtemplate::
 	To support virtual hosting, an interpolated path template can be
 	used to dynamically construct alternate paths.  The template
-	supports %H for the target hostname as supplied by the client,
-	and %D for the absolute path of the named repository.	
+	supports %H for the target hostname as supplied by the client but
+	converted to all lowercase, %CH for the canonical hostname,
+	%IP for the server's IP address, %P for the port number,
+	and %D for the absolute path of the named repository.
+	After interpolation, the path is validated against the directory
+	whitelist.
 
 --export-all::
 	Allow pulling from all directories that look like GIT repositories
@@ -64,9 +69,17 @@ OPTIONS
 
 --inetd::
 	Have the server run as an inetd service. Implies --syslog.
+	Incompatible with --port, --host, --user and --group options.
+
+--host=host_or_ipaddr::
+	Listen on an a specific IP address or hostname.  IP addresses can
+	be either an IPv4 address or an IPV6 address if supported.  If IPv6
+	is not supported, then --host=hostname is also not supported and
+	--host must be given an IPv4 address.
+	Incompatible with '--inetd' option.
 
---port::
-	Listen on an alternative port.
+--port=n::
+	Listen on an alternative port.  Incompatible with '--inetd' option.
 
 --init-timeout::
 	Timeout between the moment the connection is established and the
@@ -182,6 +195,24 @@ clients, a symlink from `/software` into
 default repository could be made as well.
 
 
+git-daemon as regular daemon for virtual hosts::
+	To set up `git-daemon` as a regular, non-inetd service that
+	handles repositories for multiple virtual hosts based on
+	their IP addresses, start the daemon like this:
++
+------------------------------------------------
+	git-daemon --verbose --export-all
+		--interpolated-path=/pub/%IP/%D
+		/pub/192.168.1.200/software
+		/pub/10.10.220.23/software
+------------------------------------------------
++
+In this example, the root-level directory `/pub` will contain
+a subdirectory for each virtual host IP address supported.
+Repositories can still be accessed by hostname though, assuming
+they correspond to these IP addresses.
+
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>, YOSHIFUJI Hideaki
diff --git a/Makefile b/Makefile
index 673ba2d..bae4822 100644
--- a/Makefile
+++ b/Makefile
@@ -520,6 +520,9 @@ endif
 ifdef NO_INET_NTOP
 	LIB_OBJS += compat/inet_ntop.o
 endif
+ifdef NO_INET_PTON
+	LIB_OBJS += compat/inet_pton.o
+endif
 
 ifdef NO_ICONV
 	ALL_CFLAGS += -DNO_ICONV
diff --git a/compat/inet_pton.c b/compat/inet_pton.c
new file mode 100644
index 0000000..5704e0d
--- /dev/null
+++ b/compat/inet_pton.c
@@ -0,0 +1,220 @@
+/*
+ * Copyright (C) 1996-2001  Internet Software Consortium.
+ *
+ * Permission to use, copy, modify, and distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND INTERNET SOFTWARE CONSORTIUM
+ * DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL
+ * INTERNET SOFTWARE CONSORTIUM BE LIABLE FOR ANY SPECIAL, DIRECT,
+ * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING
+ * FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
+ * NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION
+ * WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ */
+
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <arpa/inet.h>
+#include <stdio.h>
+#include <string.h>
+
+#ifndef NS_INT16SZ
+#define NS_INT16SZ       2
+#endif
+
+#ifndef NS_INADDRSZ
+#define NS_INADDRSZ      4
+#endif
+
+#ifndef NS_IN6ADDRSZ
+#define NS_IN6ADDRSZ    16
+#endif
+
+/*
+ * WARNING: Don't even consider trying to compile this on a system where
+ * sizeof(int) < 4.  sizeof(int) > 4 is fine; all the world's not a VAX.
+ */
+
+static int inet_pton4(const char *src, unsigned char *dst);
+static int inet_pton6(const char *src, unsigned char *dst);
+
+/* int
+ * inet_pton4(src, dst)
+ *      like inet_aton() but without all the hexadecimal and shorthand.
+ * return:
+ *      1 if `src' is a valid dotted quad, else 0.
+ * notice:
+ *      does not touch `dst' unless it's returning 1.
+ * author:
+ *      Paul Vixie, 1996.
+ */
+static int
+inet_pton4(const char *src, unsigned char *dst)
+{
+        static const char digits[] = "0123456789";
+        int saw_digit, octets, ch;
+        unsigned char tmp[NS_INADDRSZ], *tp;
+
+        saw_digit = 0;
+        octets = 0;
+        *(tp = tmp) = 0;
+        while ((ch = *src++) != '\0') {
+                const char *pch;
+
+                if ((pch = strchr(digits, ch)) != NULL) {
+                        unsigned int new = *tp * 10 + (pch - digits);
+
+                        if (new > 255)
+                                return (0);
+                        *tp = new;
+                        if (! saw_digit) {
+                                if (++octets > 4)
+                                        return (0);
+                                saw_digit = 1;
+                        }
+                } else if (ch == '.' && saw_digit) {
+                        if (octets == 4)
+                                return (0);
+                        *++tp = 0;
+                        saw_digit = 0;
+                } else
+                        return (0);
+        }
+        if (octets < 4)
+                return (0);
+        memcpy(dst, tmp, NS_INADDRSZ);
+        return (1);
+}
+
+/* int
+ * inet_pton6(src, dst)
+ *      convert presentation level address to network order binary form.
+ * return:
+ *      1 if `src' is a valid [RFC1884 2.2] address, else 0.
+ * notice:
+ *      (1) does not touch `dst' unless it's returning 1.
+ *      (2) :: in a full address is silently ignored.
+ * credit:
+ *      inspired by Mark Andrews.
+ * author:
+ *      Paul Vixie, 1996.
+ */
+
+#ifndef NO_IPV6
+static int
+inet_pton6(const char *src, unsigned char *dst)
+{
+        static const char xdigits_l[] = "0123456789abcdef",
+                          xdigits_u[] = "0123456789ABCDEF";
+        unsigned char tmp[NS_IN6ADDRSZ], *tp, *endp, *colonp;
+        const char *xdigits, *curtok;
+        int ch, saw_xdigit;
+        unsigned int val;
+
+        memset((tp = tmp), '\0', NS_IN6ADDRSZ);
+        endp = tp + NS_IN6ADDRSZ;
+        colonp = NULL;
+        /* Leading :: requires some special handling. */
+        if (*src == ':')
+                if (*++src != ':')
+                        return (0);
+        curtok = src;
+        saw_xdigit = 0;
+        val = 0;
+        while ((ch = *src++) != '\0') {
+                const char *pch;
+
+                if ((pch = strchr((xdigits = xdigits_l), ch)) == NULL)
+                        pch = strchr((xdigits = xdigits_u), ch);
+                if (pch != NULL) {
+                        val <<= 4;
+                        val |= (pch - xdigits);
+                        if (val > 0xffff)
+                                return (0);
+                        saw_xdigit = 1;
+                        continue;
+                }
+                if (ch == ':') {
+                        curtok = src;
+                        if (!saw_xdigit) {
+                                if (colonp)
+                                        return (0);
+                                colonp = tp;
+                                continue;
+                        }
+                        if (tp + NS_INT16SZ > endp)
+                                return (0);
+                        *tp++ = (unsigned char) (val >> 8) & 0xff;
+                        *tp++ = (unsigned char) val & 0xff;
+                        saw_xdigit = 0;
+                        val = 0;
+                        continue;
+                }
+                if (ch == '.' && ((tp + NS_INADDRSZ) <= endp) &&
+                    inet_pton4(curtok, tp) > 0) {
+                        tp += NS_INADDRSZ;
+                        saw_xdigit = 0;
+                        break;  /* '\0' was seen by inet_pton4(). */
+                }
+                return (0);
+        }
+        if (saw_xdigit) {
+                if (tp + NS_INT16SZ > endp)
+                        return (0);
+                *tp++ = (unsigned char) (val >> 8) & 0xff;
+                *tp++ = (unsigned char) val & 0xff;
+        }
+        if (colonp != NULL) {
+                /*
+                 * Since some memmove()'s erroneously fail to handle
+                 * overlapping regions, we'll do the shift by hand.
+                 */
+                const int n = tp - colonp;
+                int i;
+
+                for (i = 1; i <= n; i++) {
+                        endp[- i] = colonp[n - i];
+                        colonp[n - i] = 0;
+                }
+                tp = endp;
+        }
+        if (tp != endp)
+                return (0);
+        memcpy(dst, tmp, NS_IN6ADDRSZ);
+        return (1);
+}
+#endif
+
+/* int
+ * isc_net_pton(af, src, dst)
+ *      convert from presentation format (which usually means ASCII printable)
+ *      to network format (which is usually some kind of binary format).
+ * return:
+ *      1 if the address was valid for the specified address family
+ *      0 if the address wasn't valid (`dst' is untouched in this case)
+ *      -1 if some other error occurred (`dst' is untouched in this case, too)
+ * author:
+ *      Paul Vixie, 1996.
+ */
+int
+inet_pton(int af, const char *src, void *dst)
+{
+        switch (af) {
+        case AF_INET:
+                return (inet_pton4(src, dst));
+#ifndef NO_IPV6
+        case AF_INET6:
+                return (inet_pton6(src, dst));
+#endif
+        default:
+                errno = EAFNOSUPPORT;
+                return (-1);
+        }
+        /* NOTREACHED */
+}
diff --git a/daemon.c b/daemon.c
index ef3a955..5f01184 100644
--- a/daemon.c
+++ b/daemon.c
@@ -9,6 +9,7 @@ #include <arpa/inet.h>
 #include <syslog.h>
 #include <pwd.h>
 #include <grp.h>
+#include <limits.h>
 #include "pkt-line.h"
 #include "cache.h"
 #include "exec_cmd.h"
@@ -19,13 +20,14 @@ static int verbose;
 static int reuseaddr;
 
 static const char daemon_usage[] =
-"git-daemon [--verbose] [--syslog] [--inetd | --port=n] [--export-all]\n"
+"git-daemon [--verbose] [--syslog] [--export-all]\n"
 "           [--timeout=n] [--init-timeout=n] [--strict-paths]\n"
 "           [--base-path=path] [--user-path | --user-path=path]\n"
 "           [--interpolated-path=path]\n"
 "           [--reuseaddr] [--detach] [--pid-file=file]\n"
 "           [--[enable|disable|allow-override|forbid-override]=service]\n"
-"           [--user=user [[--group=group]] [directory...]";
+"           [--inetd | [--host=host_or_ipaddr] [--port=n] [--user=user [--group=group]]\n"
+"           [directory...]";
 
 /* List of acceptable pathname prefixes */
 static char **ok_paths;
@@ -56,11 +58,17 @@ static unsigned int init_timeout;
  * Feel free to make dynamic as needed.
  */
 #define INTERP_SLOT_HOST	(0)
-#define INTERP_SLOT_DIR		(1)
-#define INTERP_SLOT_PERCENT	(2)
+#define INTERP_SLOT_CANON_HOST	(1)
+#define INTERP_SLOT_IP		(2)
+#define INTERP_SLOT_PORT	(3)
+#define INTERP_SLOT_DIR		(4)
+#define INTERP_SLOT_PERCENT	(5)
 
 static struct interp interp_table[] = {
 	{ "%H", 0},
+	{ "%CH", 0},
+	{ "%IP", 0},
+	{ "%P", 0},
 	{ "%D", 0},
 	{ "%%", "%"},
 };
@@ -401,9 +409,17 @@ static void parse_extra_args(char *extra
 			val = extra_args + 5;
 			vallen = strlen(val) + 1;
 			if (*val) {
-				char *save = xmalloc(vallen);
+				char *port;
+				char *save = xmalloc(vallen);	/* FIXME: Leak */
+
 				interp_table[INTERP_SLOT_HOST].value = save;
 				strlcpy(save, val, vallen);
+				port = strrchr(save, ':');
+				if (port) {
+					*port = 0;
+					port++;
+					interp_table[INTERP_SLOT_PORT].value = port;
+				}
 			}
 			/* On to the next one */
 			extra_args = val + vallen;
@@ -411,6 +427,73 @@ static void parse_extra_args(char *extra
 	}
 }
 
+void fill_in_extra_table_entries(struct interp *itable)
+{
+	char *hp;
+	char *canon_host = NULL;
+	char *ipaddr = NULL;
+
+	/*
+	 * Replace literal host with lowercase-ized hostname.
+	 */
+	hp = interp_table[INTERP_SLOT_HOST].value;
+	for ( ; *hp; hp++)
+		*hp = tolower(*hp);
+
+	/*
+	 * Locate canonical hostname and its IP address.
+	 */
+#ifndef NO_IPV6
+	{
+		struct addrinfo hints;
+		struct addrinfo *ai, *ai0;
+		int gai;
+		static char addrbuf[HOST_NAME_MAX + 1];
+
+		memset(&hints, 0, sizeof(hints));
+		hints.ai_flags = AI_CANONNAME;
+
+		gai = getaddrinfo(interp_table[INTERP_SLOT_HOST].value, 0, &hints, &ai0);
+		if (!gai) {
+			for (ai = ai0; ai; ai = ai->ai_next) {
+				struct sockaddr_in *sin_addr = (void *)ai->ai_addr;
+
+				canon_host = xstrdup(ai->ai_canonname);
+				inet_ntop(AF_INET, &sin_addr->sin_addr,
+					  addrbuf, sizeof(addrbuf));
+				ipaddr = addrbuf;
+				break;
+			}
+			freeaddrinfo(ai0);
+		}
+	}
+#else
+	{
+		struct hostent *hent;
+		struct sockaddr_in sa;
+		char **ap;
+		static char addrbuf[HOST_NAME_MAX + 1];
+
+		hent = gethostbyname(interp_table[INTERP_SLOT_HOST].value);
+		canon_host = xstrdup(hent->h_name);
+
+		ap = hent->h_addr_list;
+		memset(&sa, 0, sizeof sa);
+		sa.sin_family = hent->h_addrtype;
+		sa.sin_port = htons(0);
+		memcpy(&sa.sin_addr, *ap, hent->h_length);
+			
+		inet_ntop(hent->h_addrtype, &sa.sin_addr,
+			  addrbuf, sizeof(addrbuf));
+		ipaddr = addrbuf;
+	}
+#endif
+
+	interp_table[INTERP_SLOT_CANON_HOST].value = canon_host;	/* FIXME: Leak */
+	interp_table[INTERP_SLOT_IP].value = xstrdup(ipaddr);		/* FIXME: Leak */
+}
+
+
 static int execute(struct sockaddr *addr)
 {
 	static char line[1000];
@@ -451,8 +534,10 @@ #endif
 	if (len && line[len-1] == '\n')
 		line[--len] = 0;
 
-	if (len != pktlen)
+	if (len != pktlen) {
 	    parse_extra_args(line + len + 1, pktlen - len - 1);
+	    fill_in_extra_table_entries(interp_table);
+	}
 
 	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
 		struct daemon_service *s = &(daemon_service[i]);
@@ -656,12 +741,11 @@ static int set_reuse_addr(int sockfd)
 
 #ifndef NO_IPV6
 
-static int socksetup(int port, int **socklist_p)
+static int socksetup(char *host, int port, int **socklist_p)
 {
 	int socknum = 0, *socklist = NULL;
 	int maxfd = -1;
 	char pbuf[NI_MAXSERV];
-
 	struct addrinfo hints, *ai0, *ai;
 	int gai;
 
@@ -672,7 +756,7 @@ static int socksetup(int port, int **soc
 	hints.ai_protocol = IPPROTO_TCP;
 	hints.ai_flags = AI_PASSIVE;
 
-	gai = getaddrinfo(NULL, pbuf, &hints, &ai0);
+	gai = getaddrinfo(host, pbuf, &hints, &ai0);
 	if (gai)
 		die("getaddrinfo() failed: %s\n", gai_strerror(gai));
 
@@ -726,20 +810,27 @@ #endif
 
 #else /* NO_IPV6 */
 
-static int socksetup(int port, int **socklist_p)
+static int socksetup(char *host, int port, int **socklist_p)
 {
 	struct sockaddr_in sin;
 	int sockfd;
 
-	sockfd = socket(AF_INET, SOCK_STREAM, 0);
-	if (sockfd < 0)
-		return 0;
-
 	memset(&sin, 0, sizeof sin);
 	sin.sin_family = AF_INET;
-	sin.sin_addr.s_addr = htonl(INADDR_ANY);
 	sin.sin_port = htons(port);
 
+	if (host) {
+		/* Well, host better be an IP address here. */
+		if (inet_pton(AF_INET, host, &sin.sin_addr.s_addr) <= 0)
+			return 0;
+	} else {
+		sin.sin_addr.s_addr = htonl(INADDR_ANY);
+	}
+
+	sockfd = socket(AF_INET, SOCK_STREAM, 0);
+	if (sockfd < 0)
+		return 0;
+
 	if (set_reuse_addr(sockfd)) {
 		close(sockfd);
 		return 0;
@@ -848,13 +939,14 @@ static void store_pid(const char *path)
 	fclose(f);
 }
 
-static int serve(int port, struct passwd *pass, gid_t gid)
+static int serve(char *host, int port, struct passwd *pass, gid_t gid)
 {
 	int socknum, *socklist;
 
-	socknum = socksetup(port, &socklist);
+	socknum = socksetup(host, port, &socklist);
 	if (socknum == 0)
-		die("unable to allocate any listen sockets on port %u", port);
+		die("unable to allocate any listen sockets on host %s port %u",
+		    host, port);
 
 	if (pass && gid &&
 	    (initgroups(pass->pw_name, gid) || setgid (gid) ||
@@ -866,7 +958,8 @@ static int serve(int port, struct passwd
 
 int main(int argc, char **argv)
 {
-	int port = DEFAULT_GIT_PORT;
+	int port = 0;
+	char *host = NULL;
 	int inetd_mode = 0;
 	const char *pid_file = NULL, *user_name = NULL, *group_name = NULL;
 	int detach = 0;
@@ -883,6 +976,14 @@ int main(int argc, char **argv)
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
 
+		if (!strncmp(arg, "--host=", 7)) {
+		    char *p = arg + 7;
+		    char *ph = host = xmalloc(strlen(arg + 7) + 1);
+		    while (*p)
+			*ph++ = tolower(*p++);
+		    *ph = 0;		    
+		    continue;
+		}
 		if (!strncmp(arg, "--port=", 7)) {
 			char *end;
 			unsigned long n;
@@ -988,6 +1089,11 @@ int main(int argc, char **argv)
 	if (inetd_mode && (group_name || user_name))
 		die("--user and --group are incompatible with --inetd");
 
+	if (inetd_mode && (port || host))
+		die("--host= and --port= are incompatible with --inetd");
+	else if (port == 0)
+		port = DEFAULT_GIT_PORT;
+
 	if (group_name && !user_name)
 		die("--group supplied without --user");
 
@@ -1036,5 +1142,5 @@ int main(int argc, char **argv)
 	if (pid_file)
 		store_pid(pid_file);
 
-	return serve(port, pass, gid);
+	return serve(host, port, pass, gid);
 }
-- 
1.4.2.1.g85d8-dirty
