From: Junio C Hamano <junkio@cox.net>
Subject: Re: qgit idea: interface for cherry-picking
Date: Sun, 02 Jul 2006 23:42:22 -0700
Message-ID: <7vzmfrrxyp.fsf@assigned-by-dhcp.cox.net>
References: <e8954u$srh$1@sea.gmane.org>
	<e5bfff550607021433l1987c32apf4453b52fc2f3e63@mail.gmail.com>
	<e89eqj$npu$1@sea.gmane.org>
	<e5bfff550607021504l6e7fc8b8ja61f20f630c0f3f@mail.gmail.com>
	<e89iql$42a$1@sea.gmane.org>
	<e5bfff550607022245s2ef160fu5ad30a822f06117d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 08:42:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxI8j-0002jG-J1
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 08:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWGCGmY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 02:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWGCGmY
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 02:42:24 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:64959 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750812AbWGCGmX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jul 2006 02:42:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060703064223.MGDH6385.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 3 Jul 2006 02:42:23 -0400
To: "Marco Costalba" <mcostalba@gmail.com>
In-Reply-To: <e5bfff550607022245s2ef160fu5ad30a822f06117d@mail.gmail.com>
	(Marco Costalba's message of "Mon, 3 Jul 2006 07:45:17 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23157>

"Marco Costalba" <mcostalba@gmail.com> writes:

> When I need to modify the patch/revision before to import I usaually
> drag&drop and then I call git-reset --soft, then I edit working
> directory and commit again.

These days, I tend to just let "am" or "pull" do its thing, edit
working tree and retest, and run "commit --amend".  Before we
added "commit --amend", I used to do soft reset and recommit
like you described above.  One advantage of "commit --amend" is
that it can even amend a merge, but I do not think it applies to
what Jakub wants in this thread.

> Perhaps I can automate this in case the user answers "No, apply to
> working dir only" to the message box.
>
> Is it the correct way to go or is better to wait for a --no-commit
> flag in git-am?

Probably your "git-am --no-commit" would stop after applying one
patch (the first one in the sequence) but before writing a
commit.  We already sometimes do that when the patch does not
apply cleanly, so I do not offhand have much objection against
adding such a flag.

I think the workflow to continue after "git-am --no-commit" will
be quite similar to what you would do when "git-am --3way" stops
with conflicts.  In order to continue from there, you would do
whatever is needed to bring the index into the shape you wanted
to have if the patch applied cleanly.  Then "git am --resolved".

Perhaps something like the attached.  If somebody finds it
useful, after testing it out, please kick it back to me, perhaps
with a paragraph or two to properly document it.

-- >8 --
git-am --fail

The new flag prevents a new commit from being made even when the
patch applies cleanly.  This gives you an opportunity to further
fix up the change in your working tree before making the final
commit.

In order to continue, do whatever is needed to bring the index
into the shape you wanted to have if the patch applied cleanly,
and run "git am --resolved".

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff --git a/git-am.sh b/git-am.sh
index 679045a..77d8cd9 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -3,7 +3,7 @@ #
 # Copyright (c) 2005, 2006 Junio C Hamano
 
 USAGE='[--signoff] [--dotest=<dir>] [--utf8] [--binary] [--3way]
-  [--interactive] [--whitespace=<option>] <mbox>...
+  [--fail] [--interactive] [--whitespace=<option>] <mbox>...
   or, when resuming [--skip | --resolved]'
 . git-sh-setup
 
@@ -91,7 +91,7 @@ fall_back_3way () {
 }
 
 prec=4
-dotest=.dotest sign= utf8= keep= skip= interactive= resolved= binary= ws= resolvemsg=
+dotest=.dotest sign= utf8= keep= skip= interactive= resolved= binary= ws= resolvemsg= fail=
 
 while case "$#" in 0) break;; esac
 do
@@ -109,6 +109,9 @@ do
 	-b|--b|--bi|--bin|--bina|--binar|--binary)
 	binary=t; shift ;;
 
+	-f|--f|--fa|--fai|--fail)
+	fail=t; shift ;;
+
 	-3|--3|--3w|--3wa|--3way)
 	threeway=t; shift ;;
 	-s|--s|--si|--sig|--sign|--signo|--signof|--signoff)
@@ -401,6 +404,10 @@ do
 	then
 		echo Patch failed at $msgnum.
 		stop_here_user_resolve $this
+	elif test -n "$fail"
+	then
+		echo Stopped at $msg per user request
+		stop_here_user_resolve $this
 	fi
 
 	if test -x "$GIT_DIR"/hooks/pre-applypatch
