From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 11:37:03 +0200
Message-ID: <20110428093703.GB15349@elte.hu>
References: <20110427225114.GA16765@elte.hu>
 <7voc3r5kzn.fsf@alter.siamese.dyndns.org>
 <20110428062717.GA952@elte.hu>
 <BANLkTik_2sHZ0OTgQeHpRnpmNsAmT=sAcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 11:40:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFNi0-0008TM-C5
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 11:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752575Ab1D1JkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 05:40:23 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:58681 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751131Ab1D1JkW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 05:40:22 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1QFNek-0002F3-RT
	from <mingo@elte.hu>; Thu, 28 Apr 2011 11:37:07 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id C62CA3E236B; Thu, 28 Apr 2011 11:36:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTik_2sHZ0OTgQeHpRnpmNsAmT=sAcA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.3.1
	-2.0 BAYES_00               BODY: Bayes spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172336>


* Erik Faye-Lund <kusmabite@gmail.com> wrote:

> > Secondly, the combined speedup of the cached case with my two patches 
> > appears to be more than 30% on my testbox so it's a very nifty win from two 
> > relatively simple changes.
> 
> That speed-up was on ONE test vector, no? There are a lot of other uses of 
> hash-comparisons in Git, did you measure those?

I picked this hash function because it showed up in the profile (see the 
profile i posted). There's one other hash that mattered as well in the profile, 
see the lookup_object() patch i sent yesterday.

> > I have added some quick debug code and none of the sha1 pointers (in my 
> > admittedly very limited) testing showed misaligned pointers on 64-bit 
> > systems.
> >
> > On 32-bit systems the pointer might be 32-bit aligned only - the patch 
> > below implements the function 32-bit comparisons.
> 
> That's simply wrong. Unsigned char arrays can and will be unaligned, and this 
> causes exceptions on most architectures (x86 is pretty much the exception 
> here). While some systems for these architectures support unaligned reads 
> from the exception handler, others doesn't. So this patch is pretty much 
> guaranteed to cause a crash in some setups.

If unsigned char arrays are allocated unaligned then that's another bug i 
suspect that should be fixed. Unaligned access on x86 is not free either - 
there's cycle penalties.

Alas, i have not seen these sha1 hash buffers being allocated unaligned (in my 
very limited testing). In which spots are they allocated unaligned?

Thanks,

	Ingo
