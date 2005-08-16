From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-format-patch fix
Date: Tue, 16 Aug 2005 15:31:05 -0700
Message-ID: <7vek8t7bva.fsf@assigned-by-dhcp.cox.net>
References: <20050816214707.6842.qmail@web26302.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Costalba <mcostalba@yahoo.it>
X-From: git-owner@vger.kernel.org Wed Aug 17 00:31:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E59xf-0001N4-2K
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 00:31:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbVHPWbI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 18:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbVHPWbI
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 18:31:08 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:5035 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750701AbVHPWbH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2005 18:31:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050816223105.GYIN550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 16 Aug 2005 18:31:05 -0400
To: git@vger.kernel.org
In-Reply-To: <20050816214707.6842.qmail@web26302.mail.ukl.yahoo.com> (Marco
	Costalba's message of "Tue, 16 Aug 2005 14:47:07 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Introduces --keep-subjects flag to tell it not to munge the
first line of the commit message.  Running "git applymbox" on
the output from "git format-patch -m -k" would preserve the
original commit information better this way.

At the same time, prefix Subject: on the first line of the
commit, to help people cut&copy.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

Marco Costalba <mcostalba@yahoo.it> writes:

> The extra '[PATCH]' in the subject was introduced by git-format-patch --mbox.
> Perhaps I have made something wrong.

No, sorry, I noticed that myself after I wrote that message.
There should be an option to tell --mbox format not do that.  My
thinko. 

Adding [PATCH] on the subject line even in --mbox format should
also be supported for people who run "git send-email" to send
things out.  So there is a new option '-k' to keep the original
subject line for the "cherry-pick" operation.

This also changes it to always prefix "Subject: ".  I think it
makes the output look consistent, even without --mbox option,
and would help people cutting and pasting the Subject line,
depending on their MUAs (it would certainly help me), but at the
same time it may make cutting and pasting cumbersome for some
other people.  Opinions?  Objections?

------------

 git-format-patch-script |   31 ++++++++++++++++++++-----------
 1 files changed, 20 insertions(+), 11 deletions(-)

32128d94ab63ea65bb86cb7fa7425e51e0dfeeb0
diff --git a/git-format-patch-script b/git-format-patch-script
--- a/git-format-patch-script
+++ b/git-format-patch-script
@@ -6,7 +6,7 @@
 . git-sh-setup-script || die "Not a git archive."
 
 usage () {
-    echo >&2 "usage: $0"' [-n] [-o dir] [--mbox] [--check] [--signoff] [-<diff options>...] upstream [ our-head ]
+    echo >&2 "usage: $0"' [-n] [-o dir] [--keep-subject] [--mbox] [--check] [--signoff] [-<diff options>...] upstream [ our-head ]
 
 Prepare each commit with its patch since our-head forked from upstream,
 one file per patch, for e-mail submission.  Each output file is
@@ -44,6 +44,9 @@ do
     date=t ;;
     -m|--m|--mb|--mbo|--mbox)
     date=t author=t mbox=t ;;
+    -k|--k|--ke|--kee|--keep|--keep-|--keep-s|--keep-su|--keep-sub|\
+    --keep-subj|--keep-subje|--keep-subjec|--keep-subject)
+    keep_subject=t ;;
     -n|--n|--nu|--num|--numb|--numbe|--number|--numbere|--numbered)
     numbered=t ;;
     -s|--s|--si|--sig|--sign|--signo|--signof|--signoff)
@@ -64,6 +67,11 @@ do
     shift
 done
 
+case "$keep_subject$numbered" in
+tt)
+	die '--keep-subject and --numbered are incompatible.' ;;
+esac
+
 revpair=
 case "$#" in
 2)
@@ -142,21 +150,22 @@ do
     {
 	mailScript='
 	/./d
-	/^$/n
-	s|^\[PATCH[^]]*\] *||'
-
-	case "$mbox" in
-	t)
-	    echo 'From nobody Mon Sep 17 00:00:00 2001' ;# UNIX "From" line
-	    mailScript="$mailScript"'
-	    s|^|Subject: [PATCH'"$num"'] |'
-	    ;;
+	/^$/n'
+	case "$keep_subject" in
+	t)  ;;
 	*)
 	    mailScript="$mailScript"'
+	    s|^\[PATCH[^]]*\] *||
 	    s|^|[PATCH'"$num"'] |'
 	    ;;
 	esac
-
+	mailScript="$mailScript"'
+	s|^|Subject: |'
+	case "$mbox" in
+	t)
+	    echo 'From nobody Mon Sep 17 00:00:00 2001' ;# UNIX "From" line
+	    ;;
+	esac
 	eval "$(sed -ne "$whosepatchScript" $commsg)"
 	test "$author,$au" = ",$me" || {
 		mailScript="$mailScript"'
