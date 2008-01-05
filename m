From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-stash clear: refuse to work with extra parameter for now
Date: Sat, 05 Jan 2008 01:35:54 -0800
Message-ID: <7vy7b4bon9.fsf_-_@gitster.siamese.dyndns.org>
References: <1199495198-26270-1-git-send-email-casey@nrlssc.navy.mil>
	<477EDDD4.5060509@nrlssc.navy.mil>
	<20080105035118.GB26892@coredump.intra.peff.net>
	<871w8woc77.fsf@adler.orangeandbronze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Brandon Casey <casey@nrlssc.navy.mil>,
	Git Mailing List <git@vger.kernel.org>
To: JM Ibanez <jm@orangeandbronze.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 10:36:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JB5SG-00023K-Vf
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 10:36:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753041AbYAEJgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 04:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753060AbYAEJgJ
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 04:36:09 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59586 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753041AbYAEJgI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 04:36:08 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 428317B0D;
	Sat,  5 Jan 2008 04:36:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 951017B09;
	Sat,  5 Jan 2008 04:35:59 -0500 (EST)
In-Reply-To: <871w8woc77.fsf@adler.orangeandbronze.com> (JM Ibanez's message
	of "Sat, 05 Jan 2008 17:26:20 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69659>

Because it is so tempting to expect "git stash clear stash@{4}"
to remove the fourth element in the stash while leaving other
elements intact, we should not blindly throw away everything.

This may change when we start using "git reflog delete" to
selectively nuke a single (or multiple, for that matter) stash
entries when such a command is given.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

JM Ibanez <jm@orangeandbronze.com> writes:

> Jeff King <peff@peff.net> writes:
> ...
>> There was some discussion of a sensible name, but I don't recall seeing
>> a resolution on this: why not "clear stash@{0}" to clear one, and
>> "clear" to clear all? Otherwise, I foresee "git stash clear stash@{0}"
>> followed by "oops, I just deleted all of my stashes."
>
> I actually got hit by this. I didn't know that stash clear affected all
> stashes and lost quite a bit of work that way (I use stash to store
> various test database configs for a tree I work with, and so lost all of
> them when trying to remove one particular stash).

I think something along this line may be necessary to
futureproof our users. 

 git-stash.sh |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 06cb177..80036ef 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -20,6 +20,10 @@ no_changes () {
 }
 
 clear_stash () {
+	if test $# != 0
+	then
+		die "git stash clear with parameters unimplemented $@"
+	fi
 	if current=$(git rev-parse --verify $ref_stash 2>/dev/null)
 	then
 		git update-ref -d $ref_stash $current
@@ -216,7 +220,7 @@ apply)
 	apply_stash "$@"
 	;;
 clear)
-	clear_stash
+	clear_stash "$@"
 	;;
 create)
 	if test $# -gt 0 && test "$1" = create
