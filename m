From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git tag --contains : avoid stack overflow
Date: Thu, 17 Apr 2014 19:31:54 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1404171902010.14982@s15462909.onlinehome-server.info>
References: <20140416141519.GA9684@camelia.ucw.cz> <20140416154653.GB4691@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Stepan Kasal <kasal@ucw.cz>,
	Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 17 19:32:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaqAc-0002sT-7C
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 19:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbaDQRcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 13:32:12 -0400
Received: from mout.gmx.net ([212.227.15.18]:57152 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751076AbaDQRcG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 13:32:06 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0MKYsh-1WclyO0Dmp-001z5f;
 Thu, 17 Apr 2014 19:31:55 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20140416154653.GB4691@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:XzaKSfyCvOyX2QUAtIVxTs5fLz5FXV6FkF1KdXV9DK4gxMh6yMh
 h1Q4Bcp6NSRVgdJv8IHA/ItvNRuud2RwD8mn8nlWWtJHHGSNuudoL/E+lQLL0xmX0TqaxKk
 dgowkxzkOWTLIzbsh3d1lEiWhrGRMDB6t2qL03cAHk/7fpaYwHrrPe6OvfxR6cD2LXV/pgT
 Q/zR0R3DEjCUNrmgAmzxQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246427>

Hi Peff,

On Wed, 16 Apr 2014, Jeff King wrote:

> On Wed, Apr 16, 2014 at 04:15:19PM +0200, Stepan Kasal wrote:
> 
> > From: Jean-Jacques Lafay at Sat, 10 Nov 2012 18:36:10 +0100
> > 
> > In large repos, the recursion implementation of contains(commit,
> > commit_list) may result in a stack overflow. Replace the recursion
> > with a loop to fix it.
> > 
> > This problem is more apparent on Windows than on Linux, where the
> > stack is more limited by default.
> 
> I think this is a good thing to be doing, and it looks mostly good to
> me. A few comments:
> 
> > -static int contains_recurse(struct commit *candidate,
> > +/*
> > + * Test whether the candidate or one of its parents is contained in the list.
> > + * Do not recurse to find out, though, but return -1 if inconclusive.
> > + */
> > +static int contains_test(struct commit *candidate,
> >  			    const struct commit_list *want)
> 
> Can we turn this return value into
> 
>   enum {
> 	CONTAINS_UNKNOWN = -1,
> 	CONTAINS_NO = 0,
> 	CONTAINS_YES = 1,
>   } contains_result;
> 
> to make the code a little more self-documenting?

Good idea!

> [... detailed instructions what changes are implied by the enum ...]
> 
> > +>expect
> > +# ulimit is a bash builtin; we can rely on that in MinGW, but nowhere else
> > +test_expect_success MINGW '--contains works in a deep repo' '
> > +	ulimit -s 64
> 
> It would be nice to test this on Linux.
> 
> Can we do something like:
> 
>   test_lazy_prereq BASH 'bash --version'
> 
>   test_expect_success BASH '--contains works in a deep repo' '
> 	... setup repo ...
> 	bash -c "ulimit -s 64 && git tag --contains HEAD" >actual &&
> 	test_cmp expect actual
>   '
> 
> As a bonus, then our "ulimit" call does not pollute the environment of
> subsequent tests.

That's a very good idea! We mulled it over a bit and did not come up with
this excellent solution.

Please see https://github.com/msysgit/git/c63d196 for the fixup, and
https://github.com/msysgit/git/compare/tag-contains%5E...tag-contains for
the updated patch.

Thanks,
Dscho
