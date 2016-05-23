From: Johannes Sixt <j6t@kdbg.org>
Subject: Small rerere in rebase regression
Date: Mon, 23 May 2016 20:01:22 +0200
Message-ID: <57434572.6030306@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 23 20:01:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4uAk-0007oY-Qu
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 20:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753659AbcEWSB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 14:01:27 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:35005 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753544AbcEWSB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 14:01:26 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3rD5vR4XKdz5tlB;
	Mon, 23 May 2016 20:01:23 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id C4F2A5294;
	Mon, 23 May 2016 20:01:22 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295343>

Even though I operate with jc/rerere-multi for some time now,
I noticed this regression only recently. Watch out for the
duplicated "Recorded preimage" message:

gittest@side:1078> strace -f -o /tmp/git-rebase-conflict.strace git rebase -i master 
error: could not apply 59f92e0... side

When you have resolved this problem, run "git rebase --continue".
If you prefer to skip this patch, run "git rebase --skip" instead.
To check out the original branch and stop rebasing, run "git rebase --abort".

Recorded preimage for 'a'
Recorded preimage for 'a'
Could not apply 59f92e09c890c08442eb1df91eaecec3d1656c86... side

According to the strace, the first "Recorded preimage" is from
git cherry-pick, the second is from "git rerere" in this section
in git-rebase--interactive.sh:

die_with_patch () {
	echo "$1" > "$state_dir"/stopped-sha
	make_patch "$1"
	git rerere
	die "$2"
}

The buglet bisects to

629716d256a792179325c2cc7945bb2d81dda8c2 is the first bad commit
commit 629716d256a792179325c2cc7945bb2d81dda8c2
Author: Junio C Hamano <gitster@pobox.com>
Date:   Thu Jul 30 15:49:18 2015 -0700

    rerere: do use multiple variants
    
    This enables the multiple-variant support for real.  Multiple
    conflicts of the same shape can have differences in contexts where
    they appear, interfering the replaying of recorded resolution of one
    conflict to another, and in such a case, their resolutions are
    recorded as different variants under the same conflict ID.
    
    We still need to adjust garbage collection codepaths for this
    change, but the basic "replay" functionality is functional with
    this change.
    
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

I'm not sure whether the new behavior is a defect in rerere.c or a
consequence of the extra rerere call in interactive rebase...

-- Hannes
