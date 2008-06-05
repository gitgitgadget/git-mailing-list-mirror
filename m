From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] "git rebase --interactive" forces me to edit message.
Date: Wed, 04 Jun 2008 21:14:02 -0700
Message-ID: <7v3ans5xit.fsf@gitster.siamese.dyndns.org>
References: <200806050358.m553wgK9013230@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org
To: =?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 06:15:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K46sR-0005MS-IA
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 06:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbYFEEOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 00:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbYFEEOL
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 00:14:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37280 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbYFEEOK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 00:14:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CD9882B78;
	Thu,  5 Jun 2008 00:14:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 759AE2B76; Thu,  5 Jun 2008 00:14:05 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D82D342C-32B5-11DD-8B9A-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83853>

しらいしななこ <nanako3@bluebottle.com> writes:

> When an interactive rebase stops because of conflicts in a commit marked
> with pick, the user must edit the file to resolve them, run "git add",
> and run "git rebase --continue".  It then opens vi and asks the user to
> edit the message.  If I told the command to edit, I think it is OK to
> start vi, but when I am just picking the commit, I should be able to use
> the message from the original commit without having to view nor edit nor
> save it first. Is this a bug?
>
> To reproduce this,...

[jc: I rewrapped your message above, but could you set your MUA to wrap
lines at reasonable length on your end please?]

It is debatable if this is a "bug".  In the simplified example you
presented as the reproduction recipe, updating the second and the third
lines are truly independent and the reason of the conflict is merely that
the commits unfortunately touched an area physically near-by, and I
sympathize with you that it is irritating to see the editor, because in
such a case it feels that there is absolutely no reason to change the log
message.

However, the edit you had to make during the conflict resolution may have
involved more than just the simplest textual merge in the real life.

Suppose your "replace 2 with two" were some bugfix, and your "replace 3
with three" were some infrastructure change.  When hoisting the latter
change up so that it comes early in the series, you may not have to update
its log message.  But the other patch (bugfix) might have to be done
differently on top of the updated infrastructure, exactly because the code
it touched now works differently --- a different fix may be needed, and
that will be how the result of conflict resolution would look like.

Now, the original "bugfix" commit might have said "When X is asked, it was
shown twice because Y did Z without taking into account that W and V in
the earlier codepath already have duplicated the data".

But the infrastructure change may have changed the codepath in such a way
that W does not happen (but V still does), and you may need a different
message.  So you do want to review and fix the message in such a case.

For that matter, the original "infrastructure change" commit may well have
said "With this change, because W does not happen anymore, half of the fix
of the previous commit becomes unnecessary, but that is a separate topic
and I did not touch that part.  Leaving that fix in does not hurt, at
least for now".  You would want to reword that if that commit comes first
and then fix comes next.

Having said that, this patch should "fix" it, I think.

 git-rebase--interactive.sh |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0ca986f..a6b6c9e 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -390,11 +390,14 @@ do
 				die "Cannot find the author identity"
 			if test -f "$DOTEST"/amend
 			then
+				do_edit=-e
 				git reset --soft HEAD^ ||
 				die "Cannot rewind the HEAD"
+			else
+				do_edit=
 			fi
 			export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
-			git commit --no-verify -F "$DOTEST"/message -e ||
+			git commit --no-verify -F "$DOTEST"/message $do_edit ||
 			die "Could not commit staged changes."
 		fi
 
