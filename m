From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] fix some clang warnings
Date: Wed, 16 Jan 2013 18:22:40 +0000
Message-ID: <20130116182240.GC2476@farnsworth.metanate.com>
References: <1358348003-11130-1-git-send-email-max@quendi.de>
 <20130116160410.GC22400@sigill.intra.peff.net>
 <7vk3rdxe5y.fsf@alter.siamese.dyndns.org>
 <CALWbr2z4TiynwOR3Lk4005dbZaLtcHK3J01ZF73wp8Q7Rm6YBA@mail.gmail.com>
 <20130116171809.GA2476@farnsworth.metanate.com>
 <7FDA1B56-731E-4BA2-8FE5-196B965FFFDB@quendi.de>
 <20130116175057.GB27525@sigill.intra.peff.net>
 <20130116180041.GC27525@sigill.intra.peff.net>
 <20130116181203.GB2476@farnsworth.metanate.com>
 <20130116181558.GA4426@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, Max Horn <max@quendi.de>,
	Antoine Pelisse <apelisse@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 16 19:23:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvXdi-00055Z-N5
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 19:23:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176Ab3APSWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 13:22:46 -0500
Received: from dougal.metanate.com ([90.155.101.14]:58474 "EHLO metanate.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753038Ab3APSWp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 13:22:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=metanate.com; s=stronger;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=0oFmsM8e7vFyam2I7xgq4yPzEK7mmRSXv3fW1RKo1SU=;
	b=psq2fVZiE16mpkF/VmGf1Zsnzylvfr0A2jUagLQE6LsW8ijmnOZl6YfFCSpz7n4bm4Utcp7VTbFmpJlyRY3s/7pwcHBKlGJm8uikv86ZnzXF7goXEhzxbZyccG78Wk7INQMh7H5T21aD3O2mEKJBuPVE3rixKYmJDa9xZQy/g/gP/A068eIIM2NClBowEuA4ODfJEjKqpTVmP8nP8Pg+B0idrVG1Q1D43NZxgQtoLfJQBlvsqfEnsCDb84Th4FKkDBgAM+wGwdtszyxF0LTdmMeDatbXUYf74UbnGXtu49lFDi2K0q1wKqJF8IzyVfbCNsNKOiSQRmol9JrKvcKbXw==;
Received: from brian.metanate.com ([192.168.88.1] helo=farnsworth.metanate.com)
	by shrek.metanate.com with esmtps (TLSv1:DHE-RSA-AES128-SHA:128)
	(Exim 4.80.1)
	(envelope-from <john@keeping.me.uk>)
	id 1TvXdI-0004zI-EF; Wed, 16 Jan 2013 18:22:40 +0000
Content-Disposition: inline
In-Reply-To: <20130116181558.GA4426@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213793>

On Wed, Jan 16, 2013 at 10:15:58AM -0800, Jeff King wrote:
> On Wed, Jan 16, 2013 at 06:12:03PM +0000, John Keeping wrote:
> 
> > On Wed, Jan 16, 2013 at 10:00:42AM -0800, Jeff King wrote:
> > > It is not about the macro itself, but rather the callsites that do not
> > > return error, but call it for its printing side effect. It seems that
> > > clang -Wunused-value is OK with unused values from functions being
> > > discarded, but not with constants. So:
> > > 
> > >   int foo();
> > >   void bar()
> > >   {
> > >     foo(); /* ok */
> > >     1; /* not ok */
> > >     (foo(), 1); /* not ok */
> > >   }
> > > 
> > > The first one is OK (I think it would fall under -Wunused-result under
> > > either compiler). The middle one is an obvious error, and caught by both
> > > compilers. The last one is OK by gcc, but clang complains.
> > 
> > I wonder if this would be changed in clang - the change in [1] is
> > superficially similar.
> > 
> > [1] http://llvm.org/bugs/show_bug.cgi?id=13747
> 
> Yeah, I think it is exactly the same issue, and the fix they mention
> there would apply to us, too.
> 
> Is it worth applying this at all, then? Or should we apply it but limit
> it with a clang version macro (they mention r163034, but I do not know
> if it is in a released version yet, nor what macros are available to
> inspect the version)?

That maps to revision 06b3a06007 in their git repository [1], which is
contained in remotes/origin/release_32 so I think that change should be
in release 3.2, where I still see the warning (although that's not using
a clang built from that source), so I don't think that the fix for that
bug removes the warning in this case.

[1] http://llvm.org/git/clang.git
