From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase [--onto O] A B: omit needless checkout
Date: Sat, 15 Mar 2008 20:56:03 -0700
Message-ID: <7vmyozl3u4.fsf@gitster.siamese.dyndns.org>
References: <20080312191041.GF3198@ins.uni-bonn.de>
 <47D8D5B8.70809@viscovery.net> <20080315103954.GD14769@ins.uni-bonn.de>
 <7vk5k3n2ho.fsf_-_@gitster.siamese.dyndns.org>
 <20080315222140.GE24845@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 16 04:56:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JajzV-0000Yg-C4
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 04:56:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373AbYCPD4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2008 23:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752325AbYCPD4O
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 23:56:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45525 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbYCPD4N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2008 23:56:13 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 34FDA1A0E;
	Sat, 15 Mar 2008 23:56:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 01D201A0B; Sat, 15 Mar 2008 23:56:08 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77349>

Ralf Wildenhues <Ralf.Wildenhues@gmx.de> writes:

> Hello Junio,
>
> * Junio C Hamano wrote on Sat, Mar 15, 2008 at 09:42:11PM CET:
>> This teaches "git rebase [--onto O] A B" to omit an unnecessary checkout
>> of branch B before it goes on.
>
>>  * Almost untested as I do not use this form very often.  Feedback would
>>    be good.
>
> Nice, and seems to do exactly what I meant.  Actually the more important
> speedup gained from this change is that files that have changed in the
> non-common history of A but not in that of B, preserve their old time
> stamps, so the rebuild of my bugfix topic B after having built master
> is really quick now.

Actually, you would need this on top.  Otherwise

	$ git rebase master my-topic~3

would misbehave.

---

 git-rebase.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 9273852..bd55ef6 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -320,7 +320,8 @@ case "$#" in
 	branch_name="$2"
 	switch_to="$2"
 
-	if branch=$(git rev-parse --verify "refs/heads/$2" 2>/dev/null)
+	if git show-ref --verify --quiet -- "refs/heads/$2" &&
+	   branch=$(git rev-parse --verify "refs/heads/$2" 2>/dev/null)
 	then
 		head_name="refs/heads/$2"
 	elif branch=$(git rev-parse --verify "$2" 2>/dev/null)
