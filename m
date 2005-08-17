From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Teach applymbox to keep the Subject: line.
Date: Tue, 16 Aug 2005 22:47:07 -0700
Message-ID: <7vk6il2jz8.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050816214707.6842.qmail@web26302.mail.ukl.yahoo.com>
	<7vek8t7bva.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Aug 17 07:48:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5GmB-0008NS-5L
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 07:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbVHQFrL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 01:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbVHQFrL
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 01:47:11 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:28594 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750897AbVHQFrK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 01:47:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050817054708.MHDZ16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 17 Aug 2005 01:47:08 -0400
To: git@vger.kernel.org
In-Reply-To: <7vek8t7bva.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 16 Aug 2005 15:31:05 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a companion patch to the previous format-patch fix.
With "-k", format-patch can be told not to remove the [PATCH] in
the original commit, nor to add the [PATCH] on its own.

However, applymbox toolchain has a code to remove [PATCH] (among
other things) from the Subject: line, which is the right thing
to do when dealing with real e-mailed patches, but it interferes
with the "format-patch to applymbox" cherry-picking.  The -k
flag disables this.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 tools/git-applymbox  |   11 ++++++++---
 tools/git-applypatch |    5 ++++-
 tools/mailinfo.c     |   15 +++++++++++++++
 3 files changed, 27 insertions(+), 4 deletions(-)

6bff6a60680ef402f614abae8189c2cb198cfa49
diff --git a/tools/git-applymbox b/tools/git-applymbox
--- a/tools/git-applymbox
+++ b/tools/git-applymbox
@@ -9,7 +9,7 @@
 ## You give it a mbox-format collection of emails, and it will try to
 ## apply them to the kernel using "applypatch"
 ##
-## applymbox [ -q ] (-c .dotest/msg-number | mail_archive) [Signoff_file]"
+## applymbox [ -k ] [ -q ] (-c .dotest/msg-number | mail_archive) [Signoff_file]"
 ##
 ## The patch application may fail in the middle.  In which case:
 ## (1) look at .dotest/patch and fix it up to apply
@@ -18,10 +18,11 @@
 ## use a Signoff_file, because applypatch wants to append the sign-off
 ## message to msg-clean every time it is run.
 
-query_apply= continue= resume=t
+keep_subject= query_apply= continue= resume=t
 while case "$#" in 0) break ;; esac
 do
 	case "$1" in
+	-k)	keep_subject=-k ;;
 	-q)	query_apply=t ;;
 	-c)	continue="$2"; resume=f; shift ;;
 	-*)	usage ;;
@@ -41,6 +42,9 @@ esac
 case "$query_apply" in
 t)	touch .dotest/.query_apply
 esac
+case "$keep_subject" in
+-k)	: >.dotest/.keep_subject
+esac
 
 signoff="$1"
 set x .dotest/0*
@@ -52,7 +56,8 @@ do
     f,$i)	resume=t;;
     f,*)	continue;;
     *)
-	    git-mailinfo .dotest/msg .dotest/patch <$i >.dotest/info || exit 1
+	    git-mailinfo $keep_subject \
+		.dotest/msg .dotest/patch <$i >.dotest/info || exit 1
 	    git-stripspace < .dotest/msg > .dotest/msg-clean
 	    ;;
     esac
diff --git a/tools/git-applypatch b/tools/git-applypatch
--- a/tools/git-applypatch
+++ b/tools/git-applypatch
@@ -16,6 +16,7 @@ final=.dotest/final-commit
 ## If this file exists, we ask before applying
 ##
 query_apply=.dotest/.query_apply
+keep_subject=.dotest/.keep_subject
 MSGFILE=$1
 PATCHFILE=$2
 INFO=$3
@@ -30,8 +31,10 @@ export SUBJECT="$(sed -n '/^Subject/ s/S
 if [ -n "$signoff" -a -f "$signoff" ]; then
 	cat $signoff >> $MSGFILE
 fi
+patch_header=
+test -f "$keep_subject" || patch_header='[PATCH] '
 
-(echo "[PATCH] $SUBJECT" ; if [ -s $MSGFILE ]; then echo ; cat $MSGFILE; fi ) > $final
+(echo "$patch_header$SUBJECT" ; if [ -s $MSGFILE ]; then echo ; cat $MSGFILE; fi ) > $final
 
 f=0
 [ -f $query_apply ] || f=1
diff --git a/tools/mailinfo.c b/tools/mailinfo.c
--- a/tools/mailinfo.c
+++ b/tools/mailinfo.c
@@ -9,6 +9,7 @@
 
 static FILE *cmitmsg, *patchfile;
 
+static int keep_subject = 0;
 static char line[1000];
 static char date[1000];
 static char name[1000];
@@ -101,6 +102,8 @@ static void check_line(char *line, int l
 
 static char * cleanup_subject(char *subject)
 {
+	if (keep_subject)
+		return subject;
 	for (;;) {
 		char *p;
 		int len, remove;
@@ -242,8 +245,20 @@ static void usage(void)
 	exit(1);
 }
 
+static const char mailinfo_usage[] =
+"git-mailinfo [-k] msg patch <mail >info";
 int main(int argc, char ** argv)
 {
+	while (1 < argc && argv[1][0] == '-') {
+		if (!strcmp(argv[1], "-k"))
+			keep_subject = 1;
+		else {
+			fprintf(stderr, "usage: %s\n", mailinfo_usage);
+			exit(1);
+		}
+		argc--; argv++;
+	}
+
 	if (argc != 3)
 		usage();
 	cmitmsg = fopen(argv[1], "w");
