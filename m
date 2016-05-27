From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: Small rerere in rebase regression
Date: Fri, 27 May 2016 18:28:21 +0200
Message-ID: <574875A5.9040303@kdbg.org>
References: <57434572.6030306@kdbg.org>
 <xmqqy4708ss0.fsf@gitster.mtv.corp.google.com> <57437693.3030106@kdbg.org>
 <xmqqk2ik77cr.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1605241510370.4449@virtualbox> <5744B00D.4020006@kdbg.org>
 <alpine.DEB.2.20.1605250710340.4449@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 27 18:28:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b6Kcg-0007wc-Kg
	for gcvg-git-2@plane.gmane.org; Fri, 27 May 2016 18:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754823AbcE0Q20 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2016 12:28:26 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:46862 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750914AbcE0Q2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2016 12:28:25 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3rGWfG5MHjz5tlC;
	Fri, 27 May 2016 18:28:22 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 05A835291;
	Fri, 27 May 2016 18:28:21 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <alpine.DEB.2.20.1605250710340.4449@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295766>

Am 25.05.2016 um 07:38 schrieb Johannes Schindelin:
> In short: yes, the explicit `git rerere` call can be dropped, that is
> essentially what I did in the rebase--helper branch.

Here's a patch to do that.

--- 8< ---
Subject: [PATCH] rebase -i: remove an unnecessary 'rerere' invocation

Interactive rebase uses 'git cherry-pick' and 'git merge' to replay
commits. Both invoke the 'rerere' machinery when they fail due to merge
conflicts. Note that all code paths with these two commands also invoke
the shell function die_with_patch when the commands fail.

Since commit 629716d2 ("rerere: do use multiple variants") the second
operation of the rerere machinery can be observed by a duplicated
message "Recorded preimage for 'file'". This second operation records
the same preimage as the first one and, hence, only wastes cycles.
Remove the 'git rerere' invocation from die_with_patch.

Shell function die_with_patch can be called after the failure of
"git commit", too, which also calls into the rerere machinery, but it
does so only after a successful commit to record the resolution.
Therefore, it is wrong to call 'git rerere' from die_with_patch after
"git commit" fails.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 git-rebase--interactive.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 9d2bfb7..6e96abc 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -192,7 +192,6 @@ make_patch () {
 die_with_patch () {
 	echo "$1" > "$state_dir"/stopped-sha
 	make_patch "$1"
-	git rerere
 	die "$2"
 }
 
-- 
2.9.0.rc0.40.gb3c1388
