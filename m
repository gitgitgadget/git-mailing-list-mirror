From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [FIXED PATCH] Make rebase save ORIG_HEAD if changing current
 branch
Date: Mon, 07 Jul 2008 00:16:38 -0700
Message-ID: <7vvdzi5fl5.fsf@gitster.siamese.dyndns.org>
References: <7v7iby9ucx.fsf@gitster.siamese.dyndns.org>
 <1215379370-34265-1-git-send-email-benji@silverinsanity.com>
 <20080707151401.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Git List <git@vger.kernel.org>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 09:17:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFkym-0006OP-PQ
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 09:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbYGGHQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 03:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbYGGHQq
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 03:16:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53502 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbYGGHQq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 03:16:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 006C611119;
	Mon,  7 Jul 2008 03:16:45 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 01AE911115; Mon,  7 Jul 2008 03:16:40 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A7C68FC4-4BF4-11DD-8862-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87590>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>:
> ...
>> Having said that, thanks to updates to git-rebase, rebased_branch@{1} has
>> useful information these days, so I do not see much practical upside, even
>> though I _will_ apply this patch, just for the sake of consistency.
>
> Are you really aiming for consistency, Junio?
>
> Doesn't this make the behavior of the command inconsistent between
> "git-rebase" and "git-rebase -m"?

Hmm, it makes "rebase -i" different, too.  Luckily, I haven't pushed
anything out, so I can rewind and all I lose is just a few dozens of
minutes.

The one from Brian has another serious issue.  That patch does not allow
you to refer to ORIG_HEAD during conflict resolution, which is quite
different from how "merge" lets you use ORIG_HEAD.  We need to set
ORIG_HEAD upfront if we want to tell user that ORIG_HEAD can be reliably
used across workflows the same way to name where we were before.

When we correctly update "rebase" to do this, because one codepath of it
uses "am" as its backend, we cannot use the patch I sent out earlier.  We
probably need to do something like this (minimally tested).

-- >8 --
Teach "am" and "rebase" to mark the original position with ORIG_HEAD

"merge" and "reset" leave the original point in history in ORIG_HEAD,
which makes it easy to go back to where you were before you inflict a
major damage to your history and realize that you do not like the result
at all.  These days with reflog, we technically do not need to use
ORIG_HEAD, but it is a handy way nevertheless.

This teaches "am" and "rebase" (all forms --- the vanilla one that uses
"am" as its backend, "-m" variant that cherry-picks, and "--interactive")
to do the same.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-am.sh                  |    1 +
 git-rebase--interactive.sh |    1 +
 git-rebase.sh              |    2 +-
 3 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 2c517ed..fe53608 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -241,6 +241,7 @@ else
 		: >"$dotest/rebasing"
 	else
 		: >"$dotest/applying"
+		git update-ref ORIG_HEAD HEAD
 	fi
 fi
 
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a64d9d5..02d7e3c 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -549,6 +549,7 @@ EOF
 		has_action "$TODO" ||
 			die_abort "Nothing to do"
 
+		git update-ref ORIG_HEAD $HEAD
 		output git checkout $ONTO && do_rest
 		;;
 	esac
diff --git a/git-rebase.sh b/git-rebase.sh
index e2d85ee..2597d77 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -378,7 +378,7 @@ fi
 echo "First, rewinding head to replay your work on top of it..."
 git checkout "$onto^0" >/dev/null 2>&1 ||
 	die "could not detach HEAD"
-# git reset --hard "$onto^0"
+git update-ref ORIG_HEAD $branch
 
 # If the $onto is a proper descendant of the tip of the branch, then
 # we just fast forwarded.
