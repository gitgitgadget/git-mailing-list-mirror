From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 6/6] New --dirstat=lines mode,
 doing dirstat analysis based on diffstat
Date: Wed, 27 Apr 2011 04:02:47 +0200
Message-ID: <201104270402.47106.johan@herland.net>
References: <BANLkTim9U4cOnV+5=Mp-2g_M6+JOiM5e7A@mail.gmail.com>
 <1303776102-9085-7-git-send-email-johan@herland.net>
 <7vliyxeynz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 04:03:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEu5o-0006aO-VZ
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 04:03:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756644Ab1D0CCt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 22:02:49 -0400
Received: from smtp.getmail.no ([84.208.15.66]:39716 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756426Ab1D0CCt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 22:02:49 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LKA00ABHGCNMS50@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Apr 2011 04:02:47 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id D1EB51EEEF22_DB77947B	for <git@vger.kernel.org>; Wed,
 27 Apr 2011 02:02:47 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 9B5AC1EEEEFA_DB77947F	for <git@vger.kernel.org>; Wed,
 27 Apr 2011 02:02:47 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LKA002MCGCNY610@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 27 Apr 2011 04:02:47 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.38-ARCH; KDE/4.6.2; x86_64; ; )
In-reply-to: <7vliyxeynz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172149>

On Tuesday 26 April 2011, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
>
> [...]
> It needs to document and also mention in the proposed commit log message
> how binary files are accounted for.

Will do.

> [...]
> > +		if (damage && file->is_binary)
> > +			/*
> > +			 * binary files counts bytes, not lines. Must find some
> > +			 * way to normalize binary bytes vs. textual lines.
> > +			 * The following heuristic is cheap, but beyond ugly...
> > +			 */
> > +			damage = damage < 52 ? 1 : damage / 52;
> 
> If 52 is just as good as any number around 50-70 range, I would prefer to
> see 64, just because I am superstitious and dividing by a power of two
> feels nicer.

Will do.

> > +cat <<EOF >expect_diff_dirstat_CC
> > +  16.7% changed/
> > +  16.7% dst/copy/changed/
> > +  16.7% dst/copy/rearranged/
> > +  16.7% dst/move/changed/
> > +  16.7% dst/move/rearranged/
> > +  16.7% rearranged/
> > +EOF
> 
> I really wish you can come up with a way to express expected results in
> much less strict way in the test vector (not limited to the test vectors
> for this patch but for the entire series).  The underlying count-damages
> (for the purpose of rename detection) implementation may improve over
> time and the textual diff generation may too.  Here what we want to
> preserve is that these six entries show more-or-less the same amount of
> contribution, not precisely 16.666666% each.

Yeah, that does make sense, although I haven't yet thought of a good way to 
do this without losing important details. I thought of assigning letters to 
each percentage value, so that instead of

	cat <<EOF >expect_diff_dirstat_M
	   5.3% changed/
	  26.3% dst/copy/changed/
	  26.3% dst/copy/rearranged/
	  26.3% dst/copy/unchanged/
	   5.3% dst/move/changed/
	   5.3% dst/move/rearranged/
	   5.3% rearranged/
	EOF

	cat <<EOF >expect_diff_dirstat_CC
	  16.7% changed/
	  16.7% dst/copy/changed/
	  16.7% dst/copy/rearranged/
	  16.7% dst/move/changed/
	  16.7% dst/move/rearranged/
	  16.7% rearranged/
	EOF

you'd have

	cat <<EOF >expect_diff_dirstat_M
	     A% changed/
	     B% dst/copy/changed/
	     B% dst/copy/rearranged/
	     B% dst/copy/unchanged/
	     A% dst/move/changed/
	     A% dst/move/rearranged/
	     A% rearranged/
	EOF

	cat <<EOF >expect_diff_dirstat_CC
	     A% changed/
	     A% dst/copy/changed/
	     A% dst/copy/rearranged/
	     A% dst/move/changed/
	     A% dst/move/rearranged/
	     A% rearranged/
	EOF

but that would lose too much detail in many cases...

Also, I partly like the fact that we test the output strictly. That way, 
when someone _does_ change the underlying details, they get an immediate 
test failure telling them exactly _how_ the numbers changed. They can then 
use that to verify that their changes produce the expected results, before 
finally updating the test in accordance with their new numbers.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
