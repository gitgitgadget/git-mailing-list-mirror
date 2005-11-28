From: Junio C Hamano <junkio@cox.net>
Subject: Re: rebase problems
Date: Mon, 28 Nov 2005 13:02:07 -0800
Message-ID: <7vhd9wscz4.fsf@assigned-by-dhcp.cox.net>
References: <20051128145814.GW8383MdfPADPa@greensroom.kotnet.org>
	<7v4q5wttib.fsf@assigned-by-dhcp.cox.net>
	<20051128202428.GA8383MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 28 22:05:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Egq8f-0004Cv-1C
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 22:02:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbVK1VCM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 16:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbVK1VCL
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 16:02:11 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:6350 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751300AbVK1VCJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 16:02:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051128210038.PIBS20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 28 Nov 2005 16:00:38 -0500
To: skimo@liacs.nl
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12904>

Sven Verdoolaege <skimo@kotnet.org> writes:

> On Mon, Nov 28, 2005 at 12:19:40PM -0800, Junio C Hamano wrote:
>> The output seems very inconsistent I am not sure why the first
>> message says "Applying HEAD~2", not HEAD~6.    What patches do
>> you see in .dotest/ directory, and are they numbered in the
>> right order?  HEAD~6 should be numbered 0001 and that should be
>> the first one that was applied.
>
> Ah!  It seems .dotest still contained some stuff from a previous
> (expectedly) failed rebase.
>
> Rebase worked after rm -rf'ing .dotest
>
> Maybe rebase should clean up .dotest or at least warn about
> an existing .dotest ?

Thanks, you are right.  I was coming to the same conclusion.

There are a few more problems in the current rebase.

 - If the branch being rebased is fully in sync with the master
   (i.e. there is no patch to apply), it fails with a mysterious
   message "fatal: cannot read mbox".

 - If the branch being rebased is already a proper descendant of
   the master, it still goes ahead and rebases.  This is
   unnecessary.

I think something like this is necessary.

-- >8 --
[PATCH] rebase: one safety net, one bugfix and one optimization.

When a .dotest from a previously failed rebase or patch
application exists, rebase got confused and tried to apply
mixture of what was already there and what is being rebased.
Check the existence of the directory and barf.

It failed with an mysterious "fatal: cannot read mbox" message
if the branch being rebased is fully in sync with the base.
Also if the branch is a proper descendant of the base, there is
no need to run rebase logic.  Prevent these from happening by
checking where the merge-base is.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-rebase.sh |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

applies-to: fe523a4df93cce3e5c5b0266b9d3f1cbea009afa
7f4bd5d831ea838668d1de5f5af022f763230eee
diff --git a/git-rebase.sh b/git-rebase.sh
index 2bc3a12..638ff0d 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -5,9 +5,25 @@
 
 . git-sh-setup
 
-# The other head is given
+# Make sure we do not have .dotest
+if mkdir .dotest
+then
+	rmdir .dotest
+else
+	echo >&2 '
+It seems that I cannot create a .dotest directory, and I wonder if you
+are in the middle of patch application or another rebase.  If that is not
+the case, please rm -fr .dotest and run me again.  I am stopping in case
+you still have something valuable there.'
+	exit 1
+fi
+
+# The other head is given.  Make sure it is valid.
 other=$(git-rev-parse --verify "$1^0") || exit
 
+# Make sure we have HEAD that is valid.
+head=$(git-rev-parse --verify "HEAD^0") || exit
+
 # The tree must be really really clean.
 git-update-index --refresh || exit
 diff=$(git-diff-index --cached --name-status -r HEAD)
@@ -23,6 +39,16 @@ case "$#" in
 	git-checkout "$2" || exit
 esac
 
+# If the HEAD is a proper descendant of $other, we do not even need
+# to rebase.  Make sure we do not do needless rebase.  In such a
+# case, merge-base should be the same as "$other".
+mb=$(git-merge-base "$other" "$head")
+if test "$mb" = "$other"
+then
+	echo >&2 "Current branch `git-symbolic-ref HEAD` is up to date."
+	exit 0
+fi
+
 # Rewind the head to "$other"
 git-reset --hard "$other"
 git-format-patch -k --stdout --full-index "$other" ORIG_HEAD |
---
0.99.9.GIT
