From: "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: reducing prune sync()s
Date: Fri, 30 May 2008 11:25:27 -0400
Message-ID: <20080530152527.GF4032@redhat.com>
References: <20080529205743.GC17123@redhat.com> <alpine.LFD.1.10.0805291656260.3141@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linuxfoundation.org>
X-From: git-owner@vger.kernel.org Fri May 30 17:30:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K26Yw-0001fs-MY
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 17:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328AbYE3P3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 11:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752314AbYE3P3r
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 11:29:47 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48862 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751480AbYE3P3p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 11:29:45 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m4UFQcB0029759;
	Fri, 30 May 2008 11:26:38 -0400
Received: from pobox-3.corp.redhat.com (pobox-3.corp.redhat.com [10.11.255.67])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m4UFQc1k030779;
	Fri, 30 May 2008 11:26:38 -0400
Received: from touchme.toronto.redhat.com (IDENT:postfix@touchme.yyz.redhat.com [10.15.16.9])
	by pobox-3.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m4UFQ5uW013178;
	Fri, 30 May 2008 11:26:37 -0400
Received: from ton.toronto.redhat.com (ton.yyz.redhat.com [10.15.16.15])
	by touchme.toronto.redhat.com (Postfix) with ESMTP
	id 8ECDE8001FF; Fri, 30 May 2008 11:25:48 -0400 (EDT)
Received: from ton.toronto.redhat.com (localhost.localdomain [127.0.0.1])
	by ton.toronto.redhat.com (8.13.1/8.13.1) with ESMTP id m4UFPVet031755;
	Fri, 30 May 2008 11:25:31 -0400
Received: (from fche@localhost)
	by ton.toronto.redhat.com (8.13.1/8.13.1/Submit) id m4UFPRxD031754;
	Fri, 30 May 2008 11:25:27 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0805291656260.3141@woody.linux-foundation.org>
User-Agent: Mutt/1.4.1i
X-Scanned-By: MIMEDefang 2.58 on 172.16.52.254
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83309>

Hi -

On Thu, May 29, 2008 at 05:27:35PM -0700, Linus Torvalds wrote:
> [...]
> >	  Or perhaps having the blanket sync be replaced a
> > list of fsync()s for only the relevant git repository files?
> [...]
> Soemthing like this *may* work. THIS IS TOTALLY UNTESTED. And when I say 
> "TOTALLY UNTESTED", I mean it. Zero testing. None. Nada. Zilch. Testing is 
> for people who are actually interested in the feature (hint, hint).

The patch does add an fsync or two into the mix, a "git gc" or 
"git repack -a" still goes through the "git-repack" shell script, which
still did its "sync".  How about this patch, which adds a "git-fsync"
builtin for the shell scripts?  Added to yours, it replaces all the
syncs with fsync's, and tests fine in the same environment originally
reported.  (Lots of dirty data for another filesystem does not block
the fsyncs.)

diff --git a/.gitignore b/.gitignore
index 4ff2fec..708c5ac 100644
--- a/.gitignore
+++ b/.gitignore
@@ -47,6 +47,7 @@ git-for-each-ref
 git-format-patch
 git-fsck
 git-fsck-objects
+git-fsync
 git-gc
 git-get-tar-commit-id
 git-grep
diff --git a/Makefile b/Makefile
index 865e2bf..2148196 100644
--- a/Makefile
+++ b/Makefile
@@ -500,6 +500,7 @@ BUILTIN_OBJS += builtin-fetch.o
 BUILTIN_OBJS += builtin-fmt-merge-msg.o
 BUILTIN_OBJS += builtin-for-each-ref.o
 BUILTIN_OBJS += builtin-fsck.o
+BUILTIN_OBJS += builtin-fsync.o
 BUILTIN_OBJS += builtin-gc.o
 BUILTIN_OBJS += builtin-grep.o
 BUILTIN_OBJS += builtin-init-db.o
diff --git a/builtin-fsync.c b/builtin-fsync.c
new file mode 100644
index 0000000..8c4c7f7
--- /dev/null
+++ b/builtin-fsync.c
@@ -0,0 +1,31 @@
+/*
+ * Copyright (c) 2008 Frank Ch. Eigler
+ */
+#include "cache.h"
+#include "commit.h"
+#include "tar.h"
+#include "builtin.h"
+#include "quote.h"
+
+static const char fsync_usage[] =
+"git-fsync <filepattern>...\n";
+
+int cmd_fsync(int argc, const char **argv, const char *prefix)
+{
+	int i;
+	for (i=1; i<argc; i++) {
+		int fd = open (argv[i], O_RDONLY);
+		if (fd < 0) {
+			error("unable to open for fsync %s", argv[i]);
+			return 1;
+		} else {
+			int rc = fsync (fd);
+			if (rc < 0) {
+				error("unable to fsync %s", argv[i]);
+				return 1;
+			}
+			close (fd);
+		}
+	}
+	return 0;
+}
diff --git a/builtin-prune.c b/builtin-prune.c
index 25f9304..d79a6ff 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -155,8 +155,6 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 	}
 	mark_reachable_objects(&revs, 1);
 	prune_object_dir(get_object_directory());
-
-	sync();
 	prune_packed_objects(show_only);
 	remove_temporary_files();
 	return 0;
diff --git a/builtin.h b/builtin.h
index 95126fd..4cedc5d 100644
--- a/builtin.h
+++ b/builtin.h
@@ -41,6 +41,7 @@ extern int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix);
 extern int cmd_for_each_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_format_patch(int argc, const char **argv, const char *prefix);
 extern int cmd_fsck(int argc, const char **argv, const char *prefix);
+extern int cmd_fsync(int argc, const char **argv, const char *prefix);
 extern int cmd_gc(int argc, const char **argv, const char *prefix);
 extern int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix);
 extern int cmd_grep(int argc, const char **argv, const char *prefix);
diff --git a/git-repack.sh b/git-repack.sh
index 501519a..650372c 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -125,12 +125,11 @@ then
 	# We know $existing are all redundant.
 	if [ -n "$existing" ]
 	then
-		sync
 		( cd "$PACKDIR" &&
 		  for e in $existing
 		  do
 			case " $fullbases " in
-			*" $e "*) ;;
+			*" $e "*) git-fsync "$e.pack" "$e.idx" ;;
 			*)	rm -f "$e.pack" "$e.idx" "$e.keep" ;;
 			esac
 		  done
diff --git a/git.c b/git.c
index 89b431f..21f3b7d 100644
--- a/git.c
+++ b/git.c
@@ -305,6 +305,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "format-patch", cmd_format_patch, RUN_SETUP },
 		{ "fsck", cmd_fsck, RUN_SETUP },
 		{ "fsck-objects", cmd_fsck, RUN_SETUP },
+		{ "fsync", cmd_fsync },
 		{ "gc", cmd_gc, RUN_SETUP },
 		{ "get-tar-commit-id", cmd_get_tar_commit_id },
 		{ "grep", cmd_grep, RUN_SETUP | USE_PAGER },
