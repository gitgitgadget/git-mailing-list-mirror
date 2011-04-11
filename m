From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv2 3/3] Teach --dirstat to not completely ignore rearranged
 lines within a file
Date: Mon, 11 Apr 2011 23:56:07 +0200
Message-ID: <201104112356.09408.johan@herland.net>
References: <7vtye834al.fsf@alter.siamese.dyndns.org>
 <1302475732-741-4-git-send-email-johan@herland.net>
 <7vtye4tqmk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 23:56:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9P5r-0000RF-DS
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 23:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755982Ab1DKV4S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 17:56:18 -0400
Received: from smtp.getmail.no ([84.208.15.66]:39407 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754507Ab1DKV4R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 17:56:17 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LJI00G4JCXRW0C0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 11 Apr 2011 23:56:15 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 0146A1EA5759_DA378FFB	for <git@vger.kernel.org>; Mon,
 11 Apr 2011 21:56:15 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id DA0301EA2EA9_DA378FEF	for <git@vger.kernel.org>; Mon,
 11 Apr 2011 21:56:14 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LJI0017ACXQ7C40@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 11 Apr 2011 23:56:14 +0200 (MEST)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.2; x86_64; ; )
In-reply-to: <7vtye4tqmk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171364>

On Monday 11 April 2011, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > Currently, the --dirstat analysis fails to detect when lines within a
> > file are rearranged, because the "damage" calculated by show_dirstat()
> > is 0. However, if the SHA1 sum has changed, we already now that there
> > should be at least some minimum amount of damage.
> 
> This logic is sensible, modulo that "fails to detect" is actually
> "ignores mere line movements on purpose".

I apologize for my commit message not having caught up with discussion 
around this issue. I came into the discussion from the POV of "--dirstat 
does not pick up what --stat picks up; there must be a bug in --dirstat", 
and my original objective was therefore to "fix" --dirstat to be "more like 
--stat". Obviously, I now know exactly why --dirstat is different, and that 
we don't want to fundamentally change it. My commit message should have been 
rephrased in a more positive light as a result. Feel free to fix before 
applying.

> In any case, if the object names are different, we already know that
> there is _some_ damage, and it is very unintiutive to claim that there
> is _no_ damage.

Agreed.

> > This patch teaches show_dirstat() to assign a minimum amount of damage
> > (== 1) to entries for which the analysis otherwise yields zero damage.
> 
> So it is perfectly in line with the above logic to give a minimum here.
> Zero was simply just unintuitive, and this is a good fix to the problem.
> 
> > Obviously this is not a complete fix, but it's at least better to
> 
> I however do not understand what "a complete fix" means in this context.
> You've fixed the unintuitiveness, and as far as the description in the
> introductory paragraph of the problem goes, I think this already is a
> complete fix.

I still feel that a file with 1000 rearranged lines should somehow count 
"more" than a file with only 1 rearranged line, but it's hard to get there 
without futzing with diffcore_count_changes(), probably making the whole 
thing considerably more expensive... So in that sense, I agree that the 
current solution is probably as complete as we can get.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
