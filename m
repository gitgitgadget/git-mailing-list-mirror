X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] index-pack usage of mmap() is unacceptably slower on many OSes other than Linux
Date: Tue, 19 Dec 2006 17:12:42 -0800
Message-ID: <7v7iwnnzed.fsf@assigned-by-dhcp.cox.net>
References: <86y7p57y05.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612181251020.3479@woody.osdl.org>
	<86r6uw9azn.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612181625140.18171@xanadu.home>
	<86hcvs984c.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612181414200.3479@woody.osdl.org>
	<8664c896xv.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612181511260.3479@woody.osdl.org>
	<Pine.LNX.4.64.0612181906450.18171@xanadu.home>
	<20061219051108.GA29405@thunk.org>
	<Pine.LNX.4.64.0612182234260.3479@woody.osdl.org>
	<Pine.LNX.4.63.0612190930460.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v1wmwtfmk.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612191027270.18171@xanadu.home>
	<7vk60npv7x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612191409500.18171@xanadu.home>
	<Pine.LNX.4.64.0612191148270.3483@woody.osdl.org>
	<4588453A.3060904@garzik.org>
	<7vzm9jo1df.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612191640010.6766@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 01:12:52 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, Nicolas Pitre <nico@cam.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612191640010.6766@woody.osdl.org> (Linus
	Torvalds's message of "Tue, 19 Dec 2006 16:40:58 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34883>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gwq0n-0000Dk-2Q for gcvg-git@gmane.org; Wed, 20 Dec
 2006 02:12:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932805AbWLTBMq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 20:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932815AbWLTBMp
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 20:12:45 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:41862 "EHLO
 fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932805AbWLTBMo (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 20:12:44 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061220011243.BMRV19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>; Tue, 19
 Dec 2006 20:12:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id 0pC11W00A1kojtg0000000; Tue, 19 Dec 2006
 20:12:02 -0500
To: Jeff Garzik <jeff@garzik.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 19 Dec 2006, Junio C Hamano wrote:
>
>> Jeff Garzik <jeff@garzik.org> writes:
>> 
>> > If you are going to do this, you have to audit -every- file, to make
>> > sure git-compat-util.h is -always- the first header.
>> 
>> Will do.
>
> Well, since any cases where it isn't (and where we'd care) will  show up 
> as just a compiler warning, I doubt we really even need to. We can fix 
> things up as they get reported too..

True, but I've done it already, so... 

Test compile especially on non Linux boxes are appreciated (I'll
do one on an OpenBSD bochs tomorrow myself anyway, though).

-- >8 --
[PATCH] simplify inclusion of system header files.

This is a mechanical clean-up of the way *.c files include
system header files.

 (1) sources under compat/, platform sha-1 implementations, and
     xdelta code are exempt from the following rules;

 (2) the first #include must be "git-compat-util.h" or one of
     our own header file that includes it first (e.g. config.h,
     builtin.h, pkt-line.h);

 (3) system headers that are included in "git-compat-util.h"
     need not be included in individual C source files.

 (4) "git-compat-util.h" does not have to include subsystem
     specific header files (e.g. expat.h).

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 archive-tar.c            |    1 -
 archive-zip.c            |    1 -
 blob.c                   |    1 -
 builtin-add.c            |    2 --
 builtin-apply.c          |    1 -
 builtin-archive.c        |    1 -
 builtin-blame.c          |    4 ----
 builtin-branch.c         |    2 +-
 builtin-for-each-ref.c   |    1 -
 builtin-grep.c           |    3 ---
 builtin-log.c            |    2 --
 builtin-ls-files.c       |    2 --
 builtin-mailinfo.c       |    9 ---------
 builtin-mailsplit.c      |    7 -------
 builtin-mv.c             |    2 --
 builtin-name-rev.c       |    1 -
 builtin-pack-objects.c   |    2 --
 builtin-repo-config.c    |    1 -
 builtin-runstatus.c      |    2 +-
 builtin-shortlog.c       |    1 -
 builtin-show-branch.c    |    2 --
 builtin-stripspace.c     |    3 ---
 builtin-tar-tree.c       |    1 -
 builtin-unpack-objects.c |    2 --
 builtin-upload-archive.c |    3 ---
 color.c                  |    5 +----
 compat/mmap.c            |    4 ----
 compat/setenv.c          |    3 +--
 compat/strlcpy.c         |    2 +-
 compat/unsetenv.c        |    3 +--
 config.c                 |    1 -
 connect.c                |    6 ------
 convert-objects.c        |    4 ----
 daemon.c                 |   16 +++-------------
 date.c                   |    3 ---
 diff-delta.c             |    5 +----
 diff.c                   |    3 ---
 diffcore-order.c         |    1 -
 diffcore-pickaxe.c       |    2 --
 dir.c                    |    3 ---
 entry.c                  |    2 --
 fetch-pack.c             |    1 -
 fetch.c                  |    3 +--
 fsck-objects.c           |    3 ---
 git-compat-util.h        |   23 +++++++++++++++++++++++
 git.c                    |   14 +-------------
 grep.c                   |    1 -
 help.c                   |    3 +--
 ident.c                  |    3 ---
 imap-send.c              |    7 -------
 interpolate.c            |    2 --
 lockfile.c               |    1 -
 merge-base.c             |    1 -
 merge-index.c            |    4 ----
 merge-recursive.c        |    7 -------
 path-list.c              |    1 -
 path.c                   |    1 -
 receive-pack.c           |    1 -
 refs.c                   |    4 +---
 revision.c               |    1 -
 rsh.c                    |    6 +-----
 run-command.c            |    1 -
 ssh-upload.c             |    2 --
 strbuf.c                 |    4 +---
 test-date.c              |    3 ---
 test-delta.c             |    8 +-------
 tree.c                   |    1 -
 unpack-trees.c           |    2 --
 upload-pack.c            |    3 ---
 var.c                    |    3 ---
 wt-status.c              |    2 +-
 71 files changed, 41 insertions(+), 195 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index ff0f6e2..af47fdc 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -1,7 +1,6 @@
 /*
  * Copyright (c) 2005, 2006 Rene Scharfe
  */
-#include <time.h>
 #include "cache.h"
 #include "commit.h"
 #include "strbuf.h"
diff --git a/archive-zip.c b/archive-zip.c
index 36e922a..f31b8ed 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -1,7 +1,6 @@
 /*
  * Copyright (c) 2006 Rene Scharfe
  */
-#include <time.h>
 #include "cache.h"
 #include "commit.h"
 #include "blob.h"
diff --git a/blob.c b/blob.c
index d1af2e6..9776bea 100644
--- a/blob.c
+++ b/blob.c
@@ -1,6 +1,5 @@
 #include "cache.h"
 #include "blob.h"
-#include <stdlib.h>
 
 const char *blob_type = "blob";
 
diff --git a/builtin-add.c b/builtin-add.c
index b3f9206..c8a114f 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -3,8 +3,6 @@
  *
  * Copyright (C) 2006 Linus Torvalds
  */
-#include <fnmatch.h>
-
 #include "cache.h"
 #include "builtin.h"
 #include "dir.h"
diff --git a/builtin-apply.c b/builtin-apply.c
index 436d9e1..1c35837 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -6,7 +6,6 @@
  * This applies patches on top of some (arbitrary) version of the SCM.
  *
  */
-#include <fnmatch.h>
 #include "cache.h"
 #include "cache-tree.h"
 #include "quote.h"
diff --git a/builtin-archive.c b/builtin-archive.c
index a8a1f07..391cf43 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -2,7 +2,6 @@
  * Copyright (c) 2006 Franck Bui-Huu
  * Copyright (c) 2006 Rene Scharfe
  */
-#include <time.h>
 #include "cache.h"
 #include "builtin.h"
 #include "archive.h"
diff --git a/builtin-blame.c b/builtin-blame.c
index a250724..9bf6ec9 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -15,10 +15,6 @@
 #include "revision.h"
 #include "xdiff-interface.h"
 
-#include <time.h>
-#include <sys/time.h>
-#include <regex.h>
-
 static char blame_usage[] =
 "git-blame [-c] [-l] [-t] [-f] [-n] [-p] [-L n,m] [-S <revs-file>] [-M] [-C] [-C] [commit] [--] file\n"
 "  -c, --compatibility Use the same output mode as git-annotate (Default: off)\n"
diff --git a/builtin-branch.c b/builtin-branch.c
index 560309c..515330c 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -5,8 +5,8 @@
  * Based on git-branch.sh by Junio C Hamano.
  */
 
-#include "color.h"
 #include "cache.h"
+#include "color.h"
 #include "refs.h"
 #include "commit.h"
 #include "builtin.h"
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 227aa3c..af72a12 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -6,7 +6,6 @@
 #include "tree.h"
 #include "blob.h"
 #include "quote.h"
-#include <fnmatch.h>
 
 /* Quoting styles */
 #define QUOTE_NONE 0
diff --git a/builtin-grep.c b/builtin-grep.c
index 9873e3d..3b1b1cb 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -10,10 +10,7 @@
 #include "tag.h"
 #include "tree-walk.h"
 #include "builtin.h"
-#include <regex.h>
 #include "grep.h"
-#include <fnmatch.h>
-#include <sys/wait.h>
 
 /*
  * git grep pathspecs are somewhat different from diff-tree pathspecs;
diff --git a/builtin-log.c b/builtin-log.c
index 17014f7..8df3c13 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -11,8 +11,6 @@
 #include "log-tree.h"
 #include "builtin.h"
 #include "tag.h"
-#include <time.h>
-#include <sys/time.h>
 
 static int default_show_root = 1;
 
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index bc79ce4..21c2a6e 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -5,8 +5,6 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#include <fnmatch.h>
-
 #include "cache.h"
 #include "quote.h"
 #include "dir.h"
diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index b8d7dbc..e647229 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -2,15 +2,6 @@
  * Another stupid program, this one parsing the headers of an
  * email to figure out authorship and subject
  */
-#define _GNU_SOURCE
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <ctype.h>
-#ifndef NO_ICONV
-#include <iconv.h>
-#endif
-#include "git-compat-util.h"
 #include "cache.h"
 #include "builtin.h"
 
diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index 91a699d..3bca855 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -4,13 +4,6 @@
  * It just splits a mbox into a list of files: "0001" "0002" ..
  * so you can process them further from there.
  */
-#include <unistd.h>
-#include <stdlib.h>
-#include <fcntl.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <string.h>
-#include <stdio.h>
 #include "cache.h"
 #include "builtin.h"
 
diff --git a/builtin-mv.c b/builtin-mv.c
index d14a4a7..737af35 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -3,8 +3,6 @@
  *
  * Copyright (C) 2006 Johannes Schindelin
  */
-#include <fnmatch.h>
-
 #include "cache.h"
 #include "builtin.h"
 #include "dir.h"
diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index 618aa31..b4f15cc 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -1,4 +1,3 @@
-#include <stdlib.h>
 #include "builtin.h"
 #include "cache.h"
 #include "commit.h"
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index a2dc7d1..807be8c 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -12,8 +12,6 @@
 #include "diff.h"
 #include "revision.h"
 #include "list-objects.h"
-#include <sys/time.h>
-#include <signal.h>
 
 static const char pack_usage[] = "\
 git-pack-objects [{ -q | --progress | --all-progress }] \n\
diff --git a/builtin-repo-config.c b/builtin-repo-config.c
index a38099a..a7ab4ce 100644
--- a/builtin-repo-config.c
+++ b/builtin-repo-config.c
@@ -1,6 +1,5 @@
 #include "builtin.h"
 #include "cache.h"
-#include <regex.h>
 
 static const char git_config_set_usage[] =
 "git-repo-config [ --global ] [ --bool | --int ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --list";
diff --git a/builtin-runstatus.c b/builtin-runstatus.c
index 0b63037..4b489b1 100644
--- a/builtin-runstatus.c
+++ b/builtin-runstatus.c
@@ -1,5 +1,5 @@
-#include "wt-status.h"
 #include "cache.h"
+#include "wt-status.h"
 
 extern int wt_status_use_color;
 
diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index 3fc43dd..edb4042 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -4,7 +4,6 @@
 #include "diff.h"
 #include "path-list.h"
 #include "revision.h"
-#include <string.h>
 
 static const char shortlog_usage[] =
 "git-shortlog [-n] [-s] [<commit-id>... ]";
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index a38ac34..b9d9781 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -1,5 +1,3 @@
-#include <stdlib.h>
-#include <fnmatch.h>
 #include "cache.h"
 #include "commit.h"
 #include "refs.h"
diff --git a/builtin-stripspace.c b/builtin-stripspace.c
index 09cc910..f0d4d9e 100644
--- a/builtin-stripspace.c
+++ b/builtin-stripspace.c
@@ -1,6 +1,3 @@
-#include <stdio.h>
-#include <string.h>
-#include <ctype.h>
 #include "builtin.h"
 
 /*
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index 4d4cfec..11e62fc 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -1,7 +1,6 @@
 /*
  * Copyright (c) 2005, 2006 Rene Scharfe
  */
-#include <time.h>
 #include "cache.h"
 #include "commit.h"
 #include "tar.h"
diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
index e6d7574..d351e02 100644
--- a/builtin-unpack-objects.c
+++ b/builtin-unpack-objects.c
@@ -8,8 +8,6 @@
 #include "tag.h"
 #include "tree.h"
 
-#include <sys/time.h>
-
 static int dry_run, quiet, recover, has_errors;
 static const char unpack_usage[] = "git-unpack-objects [-n] [-q] [-r] < pack-file";
 
diff --git a/builtin-upload-archive.c b/builtin-upload-archive.c
index 45c92e1..e4156f8 100644
--- a/builtin-upload-archive.c
+++ b/builtin-upload-archive.c
@@ -1,9 +1,6 @@
 /*
  * Copyright (c) 2006 Franck Bui-Huu
  */
-#include <time.h>
-#include <sys/wait.h>
-#include <sys/poll.h>
 #include "cache.h"
 #include "builtin.h"
 #include "archive.h"
diff --git a/color.c b/color.c
index d8c8399..09d82ee 100644
--- a/color.c
+++ b/color.c
@@ -1,8 +1,5 @@
-#include "color.h"
 #include "cache.h"
-#include "git-compat-util.h"
-
-#include <stdarg.h>
+#include "color.h"
 
 #define COLOR_RESET "\033[m"
 
diff --git a/compat/mmap.c b/compat/mmap.c
index a4d2e50..0fd46e7 100644
--- a/compat/mmap.c
+++ b/compat/mmap.c
@@ -1,7 +1,3 @@
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <errno.h>
 #include "../git-compat-util.h"
 
 void *gitfakemmap(void *start, size_t length, int prot , int flags, int fd, off_t offset)
diff --git a/compat/setenv.c b/compat/setenv.c
index b7d7678..3a22ea7 100644
--- a/compat/setenv.c
+++ b/compat/setenv.c
@@ -1,5 +1,4 @@
-#include <stdlib.h>
-#include <string.h>
+#include "../git-compat-util.h"
 
 int gitsetenv(const char *name, const char *value, int replace)
 {
diff --git a/compat/strlcpy.c b/compat/strlcpy.c
index b66856a..4024c36 100644
--- a/compat/strlcpy.c
+++ b/compat/strlcpy.c
@@ -1,4 +1,4 @@
-#include <string.h>
+#include "../git-compat-util.h"
 
 size_t gitstrlcpy(char *dest, const char *src, size_t size)
 {
diff --git a/compat/unsetenv.c b/compat/unsetenv.c
index 3a5e4ec..eb29f5e 100644
--- a/compat/unsetenv.c
+++ b/compat/unsetenv.c
@@ -1,5 +1,4 @@
-#include <stdlib.h>
-#include <string.h>
+#include "../git-compat-util.h"
 
 void gitunsetenv (const char *name)
 {
diff --git a/config.c b/config.c
index 663993f..913509f 100644
--- a/config.c
+++ b/config.c
@@ -6,7 +6,6 @@
  *
  */
 #include "cache.h"
-#include <regex.h>
 
 #define MAXNAME (256)
 
diff --git a/connect.c b/connect.c
index f7edba8..66daa11 100644
--- a/connect.c
+++ b/connect.c
@@ -3,12 +3,6 @@
 #include "pkt-line.h"
 #include "quote.h"
 #include "refs.h"
-#include <sys/wait.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>
-#include <netdb.h>
-#include <signal.h>
 
 static char *server_capabilities;
 
diff --git a/convert-objects.c b/convert-objects.c
index 8812583..a630132 100644
--- a/convert-objects.c
+++ b/convert-objects.c
@@ -1,7 +1,3 @@
-#define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
-#define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
-#define _GNU_SOURCE
-#include <time.h>
 #include "cache.h"
 #include "blob.h"
 #include "commit.h"
diff --git a/daemon.c b/daemon.c
index e66bb80..b129b83 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1,20 +1,10 @@
-#include <signal.h>
-#include <sys/wait.h>
-#include <sys/socket.h>
-#include <sys/time.h>
-#include <sys/poll.h>
-#include <netdb.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>
-#include <syslog.h>
-#include <pwd.h>
-#include <grp.h>
-#include <limits.h>
-#include "pkt-line.h"
 #include "cache.h"
+#include "pkt-line.h"
 #include "exec_cmd.h"
 #include "interpolate.h"
 
+#include <syslog.h>
+
 #ifndef HOST_NAME_MAX
 #define HOST_NAME_MAX 256
 #endif
diff --git a/date.c b/date.c
index 1825922..7acb8cb 100644
--- a/date.c
+++ b/date.c
@@ -4,9 +4,6 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 
-#include <time.h>
-#include <sys/time.h>
-
 #include "cache.h"
 
 static time_t my_mktime(struct tm *tm)
diff --git a/diff-delta.c b/diff-delta.c
index fa16d06..9f998d0 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -18,11 +18,8 @@
  *  licensing gets turned into GPLv2 within this project.
  */
 
-#include <stdlib.h>
-#include <string.h>
-#include "delta.h"
-
 #include "git-compat-util.h"
+#include "delta.h"
 
 /* maximum hash entry list for the same hash bucket */
 #define HASH_LIMIT 64
diff --git a/diff.c b/diff.c
index 9974435..61889d7 100644
--- a/diff.c
+++ b/diff.c
@@ -1,9 +1,6 @@
 /*
  * Copyright (C) 2005 Junio C Hamano
  */
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <signal.h>
 #include "cache.h"
 #include "quote.h"
 #include "diff.h"
diff --git a/diffcore-order.c b/diffcore-order.c
index aef6da6..7ad0946 100644
--- a/diffcore-order.c
+++ b/diffcore-order.c
@@ -4,7 +4,6 @@
 #include "cache.h"
 #include "diff.h"
 #include "diffcore.h"
-#include <fnmatch.h>
 
 static char **order;
 static int order_cnt;
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index cfcce31..de44ada 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -5,8 +5,6 @@
 #include "diff.h"
 #include "diffcore.h"
 
-#include <regex.h>
-
 static unsigned int contains(struct diff_filespec *one,
 			     const char *needle, unsigned long len,
 			     regex_t *regexp)
diff --git a/dir.c b/dir.c
index e6a61ee..16401d8 100644
--- a/dir.c
+++ b/dir.c
@@ -5,9 +5,6 @@
  * Copyright (C) Linus Torvalds, 2005-2006
  *		 Junio Hamano, 2005-2006
  */
-#include <dirent.h>
-#include <fnmatch.h>
-
 #include "cache.h"
 #include "dir.h"
 
diff --git a/entry.c b/entry.c
index b2ea0ef..88df713 100644
--- a/entry.c
+++ b/entry.c
@@ -1,5 +1,3 @@
-#include <sys/types.h>
-#include <dirent.h>
 #include "cache.h"
 #include "blob.h"
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 743eab7..92322cf 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -5,7 +5,6 @@
 #include "tag.h"
 #include "exec_cmd.h"
 #include "sideband.h"
-#include <sys/wait.h>
 
 static int keep_pack;
 static int quiet;
diff --git a/fetch.c b/fetch.c
index 663b4b2..f69be82 100644
--- a/fetch.c
+++ b/fetch.c
@@ -1,6 +1,5 @@
-#include "fetch.h"
-
 #include "cache.h"
+#include "fetch.h"
 #include "commit.h"
 #include "tree.h"
 #include "tree-walk.h"
diff --git a/fsck-objects.c b/fsck-objects.c
index 46b628c..409aea0 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -1,6 +1,3 @@
-#include <sys/types.h>
-#include <dirent.h>
-
 #include "cache.h"
 #include "commit.h"
 #include "tree.h"
diff --git a/git-compat-util.h b/git-compat-util.h
index 0272d04..87fde99 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -11,6 +11,10 @@
 
 #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
 
+#define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
+#define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
+#define _GNU_SOURCE
+
 #include <unistd.h>
 #include <stdio.h>
 #include <sys/stat.h>
@@ -25,6 +29,25 @@
 #include <netinet/in.h>
 #include <sys/types.h>
 #include <dirent.h>
+#include <sys/time.h>
+#include <time.h>
+#include <signal.h>
+#include <sys/wait.h>
+#include <fnmatch.h>
+#include <sys/poll.h>
+#include <sys/socket.h>
+#include <assert.h>
+#include <regex.h>
+#include <netinet/in.h>
+#include <netinet/tcp.h>
+#include <arpa/inet.h>
+#include <netdb.h>
+#include <pwd.h>
+#include <grp.h>
+
+#ifndef NO_ICONV
+#include <iconv.h>
+#endif
 
 /* On most systems <limits.h> would have given us this, but
  * not on some systems (e.g. GNU/Hurd).
diff --git a/git.c b/git.c
index 016ee8a..73cf4d4 100644
--- a/git.c
+++ b/git.c
@@ -1,20 +1,8 @@
-#include <stdio.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <dirent.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <string.h>
-#include <errno.h>
-#include <limits.h>
-#include <stdarg.h>
-#include "git-compat-util.h"
+#include "builtin.h"
 #include "exec_cmd.h"
 #include "cache.h"
 #include "quote.h"
 
-#include "builtin.h"
-
 const char git_usage_string[] =
 	"git [--version] [--exec-path[=GIT_EXEC_PATH]] [-p|--paginate] [--bare] [--git-dir=GIT_DIR] [--help] COMMAND [ARGS]";
 
diff --git a/grep.c b/grep.c
index 0fc078e..fcc6762 100644
--- a/grep.c
+++ b/grep.c
@@ -1,5 +1,4 @@
 #include "cache.h"
-#include <regex.h>
 #include "grep.h"
 
 void append_grep_pattern(struct grep_opt *opt, const char *pat,
diff --git a/help.c b/help.c
index 0824c25..341b9e3 100644
--- a/help.c
+++ b/help.c
@@ -3,12 +3,11 @@
  *
  * Builtin help-related commands (help, usage, version)
  */
-#include <sys/ioctl.h>
 #include "cache.h"
 #include "builtin.h"
 #include "exec_cmd.h"
 #include "common-cmds.h"
-
+#include <sys/ioctl.h>
 
 /* most GUI terminals set COLUMNS (although some don't export it) */
 static int term_columns(void)
diff --git a/ident.c b/ident.c
index d7faba6..6ad8fed 100644
--- a/ident.c
+++ b/ident.c
@@ -7,9 +7,6 @@
  */
 #include "cache.h"
 
-#include <pwd.h>
-#include <netdb.h>
-
 static char git_default_date[50];
 
 static void copy_gecos(struct passwd *w, char *name, int sz)
diff --git a/imap-send.c b/imap-send.c
index a6a6568..894cbbd 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -24,13 +24,6 @@
 
 #include "cache.h"
 
-#include <assert.h>
-#include <netinet/in.h>
-#include <netinet/tcp.h>
-#include <arpa/inet.h>
-#include <sys/socket.h>
-#include <netdb.h>
-
 typedef struct store_conf {
 	char *name;
 	const char *path; /* should this be here? its interpretation is driver-specific */
diff --git a/interpolate.c b/interpolate.c
index 5d9d188..f992ef7 100644
--- a/interpolate.c
+++ b/interpolate.c
@@ -2,8 +2,6 @@
  * Copyright 2006 Jon Loeliger
  */
 
-#include <string.h>
-
 #include "git-compat-util.h"
 #include "interpolate.h"
 
diff --git a/lockfile.c b/lockfile.c
index 2a2fea3..261baff 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -1,7 +1,6 @@
 /*
  * Copyright (c) 2005, Junio C Hamano
  */
-#include <signal.h>
 #include "cache.h"
 
 static struct lock_file *lock_file_list;
diff --git a/merge-base.c b/merge-base.c
index 009caf8..385f4ba 100644
--- a/merge-base.c
+++ b/merge-base.c
@@ -1,4 +1,3 @@
-#include <stdlib.h>
 #include "cache.h"
 #include "commit.h"
 
diff --git a/merge-index.c b/merge-index.c
index 646d090..a9983dd 100644
--- a/merge-index.c
+++ b/merge-index.c
@@ -1,7 +1,3 @@
-#include <sys/types.h>
-#include <sys/wait.h>
-#include <signal.h>
-
 #include "cache.h"
 
 static const char *pgm;
diff --git a/merge-recursive.c b/merge-recursive.c
index 6dd6e2e..1de273e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3,13 +3,6 @@
  * Fredrik Kuivinen.
  * The thieves were Alex Riesen and Johannes Schindelin, in June/July 2006
  */
-#include <stdarg.h>
-#include <string.h>
-#include <assert.h>
-#include <sys/wait.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <time.h>
 #include "cache.h"
 #include "cache-tree.h"
 #include "commit.h"
diff --git a/path-list.c b/path-list.c
index f8800f8..caaa5cc 100644
--- a/path-list.c
+++ b/path-list.c
@@ -1,4 +1,3 @@
-#include <stdio.h>
 #include "cache.h"
 #include "path-list.h"
 
diff --git a/path.c b/path.c
index d2c076d..066f621 100644
--- a/path.c
+++ b/path.c
@@ -11,7 +11,6 @@
  * which is what it's designed for.
  */
 #include "cache.h"
-#include <pwd.h>
 
 static char bad_path[] = "/bad-path/";
 
diff --git a/receive-pack.c b/receive-pack.c
index 5e5510b..59b682c 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -6,7 +6,6 @@
 #include "exec_cmd.h"
 #include "commit.h"
 #include "object.h"
-#include <sys/wait.h>
 
 static const char receive_pack_usage[] = "git-receive-pack <git-dir>";
 
diff --git a/refs.c b/refs.c
index d911b9e..a101ff3 100644
--- a/refs.c
+++ b/refs.c
@@ -1,10 +1,8 @@
-#include "refs.h"
 #include "cache.h"
+#include "refs.h"
 #include "object.h"
 #include "tag.h"
 
-#include <errno.h>
-
 /* ISSYMREF=01 and ISPACKED=02 are public interfaces */
 #define REF_KNOWS_PEELED 04
 
diff --git a/revision.c b/revision.c
index 993bb66..7b6f91f 100644
--- a/revision.c
+++ b/revision.c
@@ -6,7 +6,6 @@
 #include "diff.h"
 #include "refs.h"
 #include "revision.h"
-#include <regex.h>
 #include "grep.h"
 
 static char *path_name(struct name_path *path, const char *name)
diff --git a/rsh.c b/rsh.c
index f34409e..5754a23 100644
--- a/rsh.c
+++ b/rsh.c
@@ -1,10 +1,6 @@
-#include <string.h>
-#include <sys/types.h>
-#include <sys/socket.h>
-
+#include "cache.h"
 #include "rsh.h"
 #include "quote.h"
-#include "cache.h"
 
 #define COMMAND_SIZE 4096
 
diff --git a/run-command.c b/run-command.c
index 6190868..492ad3e 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1,6 +1,5 @@
 #include "cache.h"
 #include "run-command.h"
-#include <sys/wait.h>
 #include "exec_cmd.h"
 
 int run_command_v_opt(int argc, const char **argv, int flags)
diff --git a/ssh-upload.c b/ssh-upload.c
index 20b15ea..0b52ae1 100644
--- a/ssh-upload.c
+++ b/ssh-upload.c
@@ -12,8 +12,6 @@
 #include "rsh.h"
 #include "refs.h"
 
-#include <string.h>
-
 static unsigned char local_version = 1;
 static unsigned char remote_version;
 
diff --git a/strbuf.c b/strbuf.c
index 9d9d8be..7f14b0f 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,7 +1,5 @@
-#include <stdio.h>
-#include <stdlib.h>
-#include "strbuf.h"
 #include "cache.h"
+#include "strbuf.h"
 
 void strbuf_init(struct strbuf *sb) {
 	sb->buf = NULL;
diff --git a/test-date.c b/test-date.c
index 93e8027..62e8f23 100644
--- a/test-date.c
+++ b/test-date.c
@@ -1,6 +1,3 @@
-#include <stdio.h>
-#include <time.h>
-
 #include "cache.h"
 
 int main(int argc, char **argv)
diff --git a/test-delta.c b/test-delta.c
index 1be8ee0..795aa08 100644
--- a/test-delta.c
+++ b/test-delta.c
@@ -8,13 +8,7 @@
  * published by the Free Software Foundation.
  */
 
-#include <stdio.h>
-#include <unistd.h>
-#include <string.h>
-#include <fcntl.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/mman.h>
+#include "git-compat-util.h"
 #include "delta.h"
 
 static const char usage[] =
diff --git a/tree.c b/tree.c
index ea386e5..b6f02fe 100644
--- a/tree.c
+++ b/tree.c
@@ -4,7 +4,6 @@
 #include "commit.h"
 #include "tag.h"
 #include "tree-walk.h"
-#include <stdlib.h>
 
 const char *tree_type = "tree";
 
diff --git a/unpack-trees.c b/unpack-trees.c
index b8689eb..2e2232c 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1,5 +1,3 @@
-#include <signal.h>
-#include <sys/time.h>
 #include "cache.h"
 #include "dir.h"
 #include "tree.h"
diff --git a/upload-pack.c b/upload-pack.c
index 4572fff..32b06b2 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1,6 +1,3 @@
-#include <signal.h>
-#include <sys/wait.h>
-#include <sys/poll.h>
 #include "cache.h"
 #include "refs.h"
 #include "pkt-line.h"
diff --git a/var.c b/var.c
index a57a33b..39977b9 100644
--- a/var.c
+++ b/var.c
@@ -4,9 +4,6 @@
  * Copyright (C) Eric Biederman, 2005
  */
 #include "cache.h"
-#include <stdio.h>
-#include <errno.h>
-#include <string.h>
 
 static const char var_usage[] = "git-var [-l | <variable>]";
 
diff --git a/wt-status.c b/wt-status.c
index cface6c..db42738 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1,6 +1,6 @@
+#include "cache.h"
 #include "wt-status.h"
 #include "color.h"
-#include "cache.h"
 #include "object.h"
 #include "dir.h"
 #include "commit.h"
-- 
1.4.4.2.g205bf

