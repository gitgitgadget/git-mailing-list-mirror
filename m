From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] C version of git-count-objects
Date: Thu, 27 Apr 2006 15:07:37 -0700
Message-ID: <7vaca6k6za.fsf@assigned-by-dhcp.cox.net>
References: <20060427101254.GA22769@peppar.cs.umu.se>
	<Pine.LNX.4.64.0604270914570.18816@localhost.localdomain>
	<7vhd4ekfu1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604271535460.18816@localhost.localdomain>
	<20060427194559.GA26386@brainysmurf.cs.umu.se>
	<Pine.LNX.4.64.0604271257010.3701@g5.osdl.org>
	<20060427205155.GA26856@brainysmurf.cs.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 28 00:07:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZEeF-0003qj-E8
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 00:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbWD0WHk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 18:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751814AbWD0WHk
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 18:07:40 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:40932 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751813AbWD0WHi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Apr 2006 18:07:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060427220738.JXYC25666.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 27 Apr 2006 18:07:38 -0400
To: Peter Hagervall <hager@cs.umu.se>
In-Reply-To: <20060427205155.GA26856@brainysmurf.cs.umu.se> (Peter Hagervall's
	message of "Thu, 27 Apr 2006 22:51:56 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19245>

Peter Hagervall <hager@cs.umu.se> writes:

> Thanks, I'll make a third stab at it tomorrow, if anyone is interested
> that is?

How about something like this instead?

-- >8 --

 Makefile        |    2 -
 builtin-count.c |  124 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h       |    1 
 git.c           |    1 
 4 files changed, 127 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 8ce27a6..14193aa 100644
--- a/Makefile
+++ b/Makefile
@@ -214,7 +214,7 @@ LIB_OBJS = \
 	$(DIFF_OBJS)
 
 BUILTIN_OBJS = \
-	builtin-log.o builtin-help.o
+	builtin-log.o builtin-help.o builtin-count.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 LIBS = $(GITLIBS) -lz
diff --git a/builtin-count.c b/builtin-count.c
new file mode 100644
index 0000000..cbbb7dd
--- /dev/null
+++ b/builtin-count.c
@@ -0,0 +1,124 @@
+/*
+ * Builtin "git count-objects".
+ *
+ * Copyright (c) 2006 Junio C Hamano
+ */
+
+#include "cache.h"
+
+static const char count_objects_usage[] = "git-count-objects [-v]";
+
+static void count_objects(DIR *d, char *path, int len, int verbose, 
+			  unsigned long *loose,
+			  unsigned long *loose_size,
+			  unsigned long *packed_loose,
+			  unsigned long *garbage)
+{
+	struct dirent *ent;
+	while ((ent = readdir(d)) != NULL) {
+		char hex[41];
+		unsigned char sha1[20];
+		const char *cp;
+		int bad = 0;
+
+		if ((ent->d_name[0] == '.') &&
+		    (ent->d_name[1] == 0 ||
+		     ((ent->d_name[1] == '.') && (ent->d_name[2] == 0))))
+			continue;
+		for (cp = ent->d_name; *cp; cp++) {
+			int ch = *cp;
+			if (('0' <= ch && ch <= '9') ||
+			    ('a' <= ch && ch <= 'f'))
+				continue;
+			bad = 1;
+			break;
+		}
+		if (cp - ent->d_name != 38)
+			bad = 1;
+		else {
+			struct stat st;
+			memcpy(path + len + 3, ent->d_name, 38);
+			path[len + 2] = '/';
+			path[len + 41] = 0;
+			if (stat(path, &st)) {
+				die("OOPS <%s>", path);
+				bad = 1;
+			}
+			else
+				(*loose_size) += st.st_blocks;
+		}
+		if (bad) {
+			if (verbose) {
+				error("garbage found: %.*s/%s",
+				      len + 2, path, ent->d_name);
+				(*garbage)++;
+			}
+			continue;
+		}
+		(*loose)++;
+		if (!verbose)
+			continue;
+		memcpy(hex, path+len, 2);
+		memcpy(hex+2, ent->d_name, 38);
+		hex[40] = 0;
+		if (get_sha1_hex(hex, sha1))
+			die("internal error");
+		if (has_sha1_pack(sha1))
+			(*packed_loose)++;
+	}
+}
+
+int cmd_count_objects(int ac, const char **av, char *ep)
+{
+	int i;
+	int verbose = 0;
+	const char *objdir = get_object_directory();
+	int len = strlen(objdir);
+	char *path = xmalloc(len + 50);
+	unsigned long loose = 0, packed = 0, packed_loose = 0, garbage = 0;
+	unsigned long loose_size = 0;
+
+	for (i = 1; i < ac; i++) {
+		const char *arg = av[i];
+		if (*arg != '-')
+			break;
+		else if (!strcmp(arg, "-v"))
+			verbose = 1;
+		else
+			usage(count_objects_usage);
+	}
+
+	/* we do not take arguments other than flags for now */
+	if (i < ac)
+		usage(count_objects_usage);
+	memcpy(path, objdir, len);
+	if (len && objdir[len-1] != '/')
+		path[len++] = '/';
+	for (i = 0; i < 256; i++) {
+		DIR *d;
+		sprintf(path + len, "%02x", i);
+		d = opendir(path);
+		if (!d)
+			continue;
+		count_objects(d, path, len, verbose,
+			      &loose, &loose_size, &packed_loose, &garbage);
+		closedir(d);
+	}
+	if (verbose) {
+		struct packed_git *p;
+		for (p = packed_git; p; p = p->next) {
+			if (!p->pack_local)
+				continue;
+			packed += num_packed_objects(p);
+		}
+		printf("count: %lu\n", loose);
+		printf("size: %lu\n", loose_size / 2);
+		printf("in-pack: %lu\n", packed);
+		printf("prune-packable: %lu\n", packed_loose);
+		printf("garbage: %lu\n", garbage);
+	}
+	else
+		printf("%lu objects, %lu kilobytes\n",
+		       loose, loose_size / 2);
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index 47408a0..76169e3 100644
--- a/builtin.h
+++ b/builtin.h
@@ -19,5 +19,6 @@ extern int cmd_version(int argc, const c
 extern int cmd_whatchanged(int argc, const char **argv, char **envp);
 extern int cmd_show(int argc, const char **argv, char **envp);
 extern int cmd_log(int argc, const char **argv, char **envp);
+extern int cmd_count_objects(int argc, const char **argv, char **envp);
 
 #endif
diff --git a/git.c b/git.c
index 01b7e28..00fb399 100644
--- a/git.c
+++ b/git.c
@@ -46,6 +46,7 @@ static void handle_internal_command(int 
 		{ "log", cmd_log },
 		{ "whatchanged", cmd_whatchanged },
 		{ "show", cmd_show },
+		{ "count-objects", cmd_count_objects },
 	};
 	int i;
 
