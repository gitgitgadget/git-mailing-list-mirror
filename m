From: Junio C Hamano <gitster@pobox.com>
Subject: Re: unmerging feature branches
Date: Tue, 23 Oct 2007 12:33:29 -0700
Message-ID: <7vir4x7hiu.fsf@gitster.siamese.dyndns.org>
References: <20071023152445.GA10070@piper.oerlikon.madduck.net>
	<alpine.LFD.0.999.0710230922240.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: martin f krafft <madduck@madduck.net>,
	git discussion list <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Oct 23 21:33:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkPVc-0008Fm-Rd
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 21:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbXJWTdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 15:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbXJWTdg
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 15:33:36 -0400
Received: from rune.pobox.com ([208.210.124.79]:43276 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751574AbXJWTdf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 15:33:35 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id AF8F814E951;
	Tue, 23 Oct 2007 15:33:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id DFFD114EA7A;
	Tue, 23 Oct 2007 15:33:52 -0400 (EDT)
In-Reply-To: <alpine.LFD.0.999.0710230922240.30120@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 23 Oct 2007 09:50:59 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62151>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Now, that said, reverting the data is not that hard. There is not any 
> single-command "revert this arm of a merge", but on the other hand, git 
> can certainly help you.
>
> The way to do it is:
>
> 	# go back to just before the merge, create a "fixup" branch
> 	#
> 	git branch -b fixup M^
>
> 	# merge all of it again, *except* the branch you didn't want to 
> 	# merge (this example assumes that you had a four-way octopus 
> 	# merge, and you now want to turn it into a three-way with the
> 	# next-to-last parent skipped):
> ...

Desire to revert an octopus would, as you demonstrated, often be
to revert only one arm, but I think allowing to revert a twohead
merge should be trivial.  If we define "reverting a merge" to
always revert all arms, then this should suffice.

diff --git a/builtin-revert.c b/builtin-revert.c
index a655c8e..719e293 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -269,8 +269,8 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 
 	if (!commit->parents)
 		die ("Cannot %s a root commit", me);
-	if (commit->parents->next)
-		die ("Cannot %s a multi-parent commit.", me);
+	if (action != REVERT && commit->parents->next)
+		die ("Cannot %s a merge commit.", me);
 	if (!(message = commit->buffer))
 		die ("Cannot get commit message for %s",
 				sha1_to_hex(commit->object.sha1));

Note that allowing cherry-pick by removing the above two lines
allow replaying the data of a merge similar to a squash merge.
