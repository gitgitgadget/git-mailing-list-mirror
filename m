From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: [PATCH] add -C[NUM] to git-am
Date: Thu, 8 Feb 2007 15:57:08 +0200
Message-ID: <20070208135708.GD20183@mellanox.co.il>
References: <7vfy9h13yu.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 08 14:56:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HF9lY-0002fR-5P
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 14:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422994AbXBHN4n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 08:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752328AbXBHN4n
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 08:56:43 -0500
Received: from dev.mellanox.co.il ([194.90.237.44]:33246 "EHLO
	dev.mellanox.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752326AbXBHN4m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 08:56:42 -0500
Received: from mellanox.co.il ([194.90.237.34])
	by dev.mellanox.co.il (8.13.1/8.13.1) with SMTP id l18DuYu0016629;
	Thu, 8 Feb 2007 15:56:34 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Thu,  8 Feb 2007 15:57:08 +0200
Content-Disposition: inline
In-Reply-To: <7vfy9h13yu.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39057>

> Quoting Junio C Hamano <junkio@cox.net>:
> Subject: Re: [PATCH] add -C[NUM] to git-am
> 
> "Michael S. Tsirkin" <mst@mellanox.co.il> writes:
> 
> >> Quoting r. Junio C Hamano <junkio@cox.net>:
> >> 
> >> FWIW, I am in favor although I do not foresee myself ever using
> >> it.  However, this has slight ramifications.
> >> 
> >>  - we will be keeping applymbox after all.  shouldn't this be
> >>    side-ported to it?
> >
> > OK.

Wait, this can't be done - git-applymbox uses git-applypatch
internally and that does not get -CNUM.
So this will have to stay a git-am only option.

> >>  - am is used as a workhorse for rebase.  shouldn't this be
> >>    accessible through its command line as well?
> >
> > How will it be used?
> 
> Although I do not foresee myself using -C<num> that applies to
> the whole series inexactly for "git am" to begin with, I would
> imagine somebody who wants to say "git am -C1" may want to say
> something like "git rebase -C1 origin/master",

Like this then?
BTW, Junio, why is it that git-rebase calls "git am" and not "git-am"?
This wastes some cycles, does it not?


Add -C[NUM] to git-am and git-rebase so that patches can be applied even
if context has changed a bit.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

---

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index aa4ce1d..f7d551e 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -64,6 +64,10 @@ default.   You could use `--no-utf8` to override this.
 	This flag is passed to the `git-apply` program that applies
 	the patch.
 
+-C<n>::
+	This flag is passed to the `git-apply` program that applies
+	the patch.
+
 --interactive::
 	Run interactively, just like git-applymbox.
 
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 977f661..3dff2df 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -7,7 +7,7 @@ git-rebase - Forward-port local commits to the updated upstream head
 
 SYNOPSIS
 --------
-'git-rebase' [-v] [--merge] [--onto <newbase>] <upstream> [<branch>]
+'git-rebase' [-v] [--merge] [-CNUM] [--onto <newbase>] <upstream> [<branch>]
 
 'git-rebase' --continue | --skip | --abort
 
@@ -196,6 +196,12 @@ OPTIONS
 -v, \--verbose::
 	Display a diffstat of what changed upstream since the last rebase.
 
+-C<n>::
+	Ensure at least <n> lines of surrounding context match before
+	and after each change.  When fewer lines of surrounding
+	context exist they all must match.  By default no context is
+	ever ignored.
+
 include::merge-strategies.txt[]
 
 NOTES
diff --git a/git-am.sh b/git-am.sh
index 1252f26..9a61234 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005, 2006 Junio C Hamano
 
 USAGE='[--signoff] [--dotest=<dir>] [--utf8 | --no-utf8] [--binary] [--3way]
-  [--interactive] [--whitespace=<option>] <mbox>...
+  [--interactive] [--whitespace=<option>] [-CNUM] <mbox>...
   or, when resuming [--skip | --resolved]'
 . git-sh-setup
 set_reflog_action am
@@ -106,7 +106,8 @@ It does not apply to blobs recorded in its index."
 }
 
 prec=4
-dotest=.dotest sign= utf8=t keep= skip= interactive= resolved= binary= ws= resolvemsg=
+dotest=.dotest sign= utf8=t keep= skip= interactive= resolved= binary= resolvemsg=
+git_apply_opt=
 
 while case "$#" in 0) break;; esac
 do
@@ -142,7 +143,10 @@ do
 	skip=t; shift ;;
 
 	--whitespace=*)
-	ws=$1; shift ;;
+	git_apply_opt="$git_apply_opt $1"; shift ;;
+
+	-C*)
+	git_apply_opt="$git_apply_opt $1"; shift ;;
 
 	--resolvemsg=*)
 	resolvemsg=$(echo "$1" | sed -e "s/^--resolvemsg=//"); shift ;;
@@ -394,7 +398,7 @@ do
 
 	case "$resolved" in
 	'')
-		git-apply $binary --index $ws "$dotest/patch"
+		git-apply $git_apply_opt $binary --index "$dotest/patch"
 		apply_status=$?
 		;;
 	t)
diff --git a/git-rebase.sh b/git-rebase.sh
index 9d2f71d..b51d19d 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -45,6 +45,7 @@ do_merge=
 dotest=$GIT_DIR/.dotest-merge
 prec=4
 verbose=
+git_am_opt=
 
 continue_merge () {
 	test -n "$prev_head" || die "prev_head must be defined"
@@ -213,6 +214,10 @@ do
 	-v|--verbose)
 		verbose=t
 		;;
+	-C*)
+		git_am_opt=$1
+		shift
+		;;
 	-*)
 		usage
 		;;
@@ -322,7 +327,7 @@ fi
 if test -z "$do_merge"
 then
 	git-format-patch -k --stdout --full-index --ignore-if-in-upstream "$upstream"..ORIG_HEAD |
-	git am --binary -3 -k --resolvemsg="$RESOLVEMSG"
+	git am $git_am_opt --binary -3 -k --resolvemsg="$RESOLVEMSG"
 	exit $?
 fi
 
	
-- 
MST
