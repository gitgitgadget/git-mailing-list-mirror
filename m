From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv5 00/14] git notes
Date: Tue, 08 Sep 2009 23:40:05 +0200
Message-ID: <200909082340.05318.johan@herland.net>
References: <1252376822-6138-1-git-send-email-johan@herland.net>
 <alpine.DEB.1.00.0909081100020.4330@intel-tinevez-2-302>
 <7vocplxjov.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 23:40:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml8Qf-0000HU-Dd
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 23:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395AbZIHVkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 17:40:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752392AbZIHVkH
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 17:40:07 -0400
Received: from smtp.getmail.no ([84.208.15.66]:34256 "EHLO
	get-mta-out03.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752279AbZIHVkF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Sep 2009 17:40:05 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPO00DW99IUOVA0@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Sep 2009 23:40:06 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KPO002YR9ITVK50@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 08 Sep 2009 23:40:06 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.9.8.212416
User-Agent: KMail/1.12.1 (Linux/2.6.30-ARCH; KDE/4.3.1; x86_64; ; )
In-reply-to: <7vocplxjov.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128041>

On Tuesday 08 September 2009, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > On Tue, 8 Sep 2009, Johan Herland wrote:
> >> Algorithm / Notes tree   git log -n10 (x100)   git log --all
> >> ------------------------------------------------------------
> >> next / no-notes                4.77s              63.84s
> >>
> >> before / no-notes              4.78s              63.90s
> >> before / no-fanout            56.85s              65.69s
> >>
> >> 16tree / no-notes              4.77s              64.18s
> >> 16tree / no-fanout            30.35s              65.39s
> >> 16tree / 2_38                  5.57s              65.42s
> >> 16tree / 2_2_36                5.19s              65.76s
> >>
> >> flexible / no-notes            4.78s              63.91s
> >> flexible / no-fanout          30.34s              65.57s
> >> flexible / 2_38                5.57s              65.46s
> >> flexible / 2_2_36              5.18s              65.72s
> >> flexible / ym                  5.13s              65.66s
> >> flexible / ym_2_38             5.08s              65.63s
> >> flexible / ymd                 5.30s              65.45s
> >> flexible / ymd_2_38            5.29s              65.90s
> >> flexible / y_m                 5.11s              65.72s
> >> flexible / y_m_2_38            5.08s              65.67s
> >> flexible / y_m_d               5.06s              65.50s
> >> flexible / y_m_d_2_38          5.07s              65.79s
> >
> > I can see that some people may think that date-based fan-out is the
> > cat's ass,
> 
> Actually, my knee-jerk reaction was that 4.77 (next) vs 5.57 (16tree with
> 2_38) is already a good enough performance/simplicity tradeoff, and 5.57
> vs 5.08 (16tree with ym_2_38) probably does not justify the risk of worst
> case behaviour that can come from possible mismatch between the access
> pattern and the date-optimized tree layout.

Yes, 16tree / 2_38 looks like a reasonable tradeoff when you look at the 
absolute numbers, but it's also interesting to highlight the actual cost of 
doing the notes lookup. In that case, we see that 16tree / 2_38 costs 0.80s, 
whereas flexible / ym_2_38 only costs 0.31s, i.e. less than half the cost of 
the former...

> But that only argues against supporting _only_ date-optimized layout.
> 
> Support of "flexible layout" is not that flexible as its name suggests;
> one single note tree needs to have a uniform fanout strategy.

Actually, the uniform strategy is only required at each separate level. You 
are free to vary the strategy within independent subtrees. I.e. in the case 
where you have 1 note from 2007, and 1000 notes from 2008, you are free to 
use a mix of date-based and SHA1-based structures, like this:

  y2007/1234567...
  y2008/m01/d01/2345678...
  y2008/m01/d01/3456789...
  y2008/m01/d02/45/67890...
  y2008/m01/d02/56/78901...
  y2008/m01/d02/67/89012...
  ...

> > - I find the restriction to commits rather limiting.
> 
> Yeah, we would not want to be surprised to find many people want to
> annotate non-commits with this mechanism.

We could arbitrarily set the "commit date" for non-commit objects to the 
epoch, so that they can still be represented in a date-based fanout. (Of 
course, the notes code should be smart enough to choose a more optimal 
fanout if the number of non-commit notes is significant).

> > - most of the performance difference between the date-based and the
> > SHA-1 based fan-out looks to me as if the issue was the top-level tree.
> > Basically, this tree has to be read _every_ time _anybody_ wants to
> > read a note.
> 
> A comparison between 'next' and another algorithm that opens the
>  top-level notes tree object and returns "I did not find any note"
>  without doing anything else would reveal that cost.  But when you are
>  doing "log -n10" (or "log --all"), you would read the notes top-level
>  tree once, and it is likely to be cached in the obj_hash[] (or in
>  delta_base cache) already for the remaining invocations, even if notes
>  mechanism does not do its own cache, which I think it does, no?

Yes it does, since Dscho's original hash_map based implementation, in fact.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
