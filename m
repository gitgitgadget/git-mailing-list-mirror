From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] stash: end commit log with a newline
Date: Wed, 04 Jul 2007 22:46:09 -0700
Message-ID: <7vbqere732.fsf@assigned-by-dhcp.cox.net>
References: <200707042324.l64NOp8I019289@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Thu Jul 05 07:46:23 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6KAZ-0000sc-5R
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 07:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755569AbXGEFqN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 5 Jul 2007 01:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755540AbXGEFqM
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 01:46:12 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:44924 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150AbXGEFqM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jul 2007 01:46:12 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070705054610.WKGR1204.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 5 Jul 2007 01:46:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KhmA1X00E1kojtg0000000; Thu, 05 Jul 2007 01:46:11 -0400
In-Reply-To: <200707042324.l64NOp8I019289@mi0.bluebottle.com>
	(nanako3@bluebottle.com's message of "Thu, 05 Jul 2007 08:18:27
	+0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51657>

=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93 <nanako=
3@bluebottle.com> writes:

> I am sorry to join the discussion late, but I think it is much better=
 to let
> the user give a short reminder message from the command line.  For ex=
ample,
>
>   $ git stash add customized message to stash
>
> When I say "git stash list", I want to see which branch I was on when=
 I was
> in the middle of doing something, and what that something was.  It is=
 not
> interesting which commit on that branch I started that change from.  =
After
> creating a stash without a message, and then another stash with a mes=
sage, I
> want to see:
>
>   $ git stash list
>   stash@{0}: On master: add customized message to stash
>   stash@{1}: WIP on master: 36e5e70... Start deprecating "git-command=
" in favor of "git command"

Hmph.  I only recently got interested in "stash", so have not
enough real-life experience to base my judgement on, but I think
I'd agree with your reasoning.

Perhaps something like this?

-- >8 --
[PATCH] git-stash: allow more descriptive reminder message when saving

This allows you to say:

	$ git stash starting to implement X

while creating a stash, and the resulting "stash list entry
would read as:

	$ git stash list
        stash@{0}: On master: starting to implement X

instead of the default message which talks about the commit the
stash happens to be based on (hence does not have much to do
with what the stashed change is trying to do).

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 git-stash.sh |   25 +++++++++++++++++++------
 1 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 9deda44..3d7db4a 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -23,6 +23,8 @@ clear_stash () {
 }
=20
 save_stash () {
+	stash_msg=3D"$1"
+
 	if no_changes
 	then
 		echo >&2 'No local changes to save'
@@ -67,13 +69,19 @@ save_stash () {
 		die "Cannot save the current worktree state"
=20
 	# create the stash
-	w_commit=3D$(printf 'WIP on %s\n' "$msg" |
+	if test -z "$stash_msg"
+	then
+		stash_msg=3D$(printf 'WIP on %s' "$msg")
+	else
+		stash_msg=3D$(printf 'On %s: %s' "$branch" "$stash_msg")
+	fi
+	w_commit=3D$(printf '%s\n' "$stash_msg" |
 		git commit-tree $w_tree -p $b_commit -p $i_commit) ||
 		die "Cannot record working tree state"
=20
-	git update-ref -m "$msg" $ref_stash $w_commit ||
+	git update-ref -m "$stash_msg" $ref_stash $w_commit ||
 		die "Cannot save the current status"
-	printf >&2 'Saved WIP on %s\n' "$msg"
+	printf >&2 'Saved "%s"\n' "$stash_msg"
 }
=20
 have_stash () {
@@ -157,9 +165,14 @@ apply)
 clear)
 	clear_stash
 	;;
-save | '')
-	save_stash && git-reset --hard
+help)
+	usage
 	;;
 *)
-	usage
+	if test $# -gt 0 && test "$1" =3D save
+	then
+		shift
+	fi
+	save_stash "$*" && git-reset --hard
+	;;
 esac


--=20
Junio C Hamano
http://gitster.livejournal.com/

----------------------------------------------------------------------
No advertising message here ;-)
http://www.ohloh.net/projects/278
