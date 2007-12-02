From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Corrupted (?) commit 6e6db85e confusing gitk
Date: Sun, 02 Dec 2007 14:14:39 -0800
Message-ID: <7vfxyku4kw.fsf@gitster.siamese.dyndns.org>
References: <5F1A20CC-7427-4E7A-AB95-E89C9FA17951@zib.de>
	<7vir3hx70y.fsf@gitster.siamese.dyndns.org>
	<20071202193918.GQ6212@lavos.net>
	<Pine.LNX.4.64.0712022132060.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Downing <bdowning@lavos.net>,
	Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 02 23:15:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iyx5g-0007zv-JU
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 23:15:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbXLBWOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 17:14:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbXLBWOs
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 17:14:48 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:47218 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718AbXLBWOr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 17:14:47 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id C0FBF2EF;
	Sun,  2 Dec 2007 17:15:08 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 470819C35A;
	Sun,  2 Dec 2007 17:15:03 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0712022132060.27959@racer.site> (Johannes
	Schindelin's message of "Sun, 2 Dec 2007 21:34:06 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66826>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> With the above, something like:
>> 
>> echo msg | GIT_AUTHOR_DATE='' git commit-tree sha1
>
> Darn.  But when can "GIT_AUTHOR_DATE" be set to the empty string?  I mean, 
> I understand unset'ing it.  But setting it to ""?

Maybe something like this would catch such a breakage earlier, but with
the re-fix for --signoff I just sent to make fmt_ident() safer, I think
this patch would fall into belt-and-suspender category.

---

 git-am.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 4126f0e..bab6f68 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -307,9 +307,11 @@ do
 	GIT_AUTHOR_EMAIL="$(sed -n '/^Email/ s/Email: //p' "$dotest/info")"
 	GIT_AUTHOR_DATE="$(sed -n '/^Date/ s/Date: //p' "$dotest/info")"
 
-	if test -z "$GIT_AUTHOR_EMAIL"
+	if test -z "$GIT_AUTHOR_EMAIL" ||
+	   test -z "$GIT_AUTHOR_NAME" ||
+	   test -z "$GIT_AUTHOR_DATE"
 	then
-		echo "Patch does not have a valid e-mail address."
+		echo "Patch does not have a valid authorship information."
 		stop_here $this
 	fi
 
