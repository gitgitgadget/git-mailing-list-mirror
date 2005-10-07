From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: [PATCH] Add support for parallel HTTP transfers
Date: Thu, 6 Oct 2005 17:00:41 -0700
Message-ID: <20051007000041.GH15593@reactrix.com>
References: <20051005214447.GF15593@reactrix.com> <Pine.LNX.4.63.0510061550510.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 07 02:02:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENffU-0006yY-3H
	for gcvg-git@gmane.org; Fri, 07 Oct 2005 02:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbVJGAAv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Oct 2005 20:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbVJGAAv
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Oct 2005 20:00:51 -0400
Received: from 193.37.26.69.virtela.com ([69.26.37.193]:19304 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S932097AbVJGAAt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2005 20:00:49 -0400
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id j9700god016051;
	Thu, 6 Oct 2005 17:00:42 -0700
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id j9700fAD016049;
	Thu, 6 Oct 2005 17:00:41 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0510061550510.23242@iabervon.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9791>

On Thu, Oct 06, 2005 at 04:07:07PM -0400, Daniel Barkalow wrote:

> Somewhat weirdly, the version of curl on my desktop doesn't actually have 
> an implementation of curl_multi_info_read, although it's in the header 
> file and documentation. So you'll want a version check somewhere, I think, 
> which should probably just disable parallel transfers.

I was afraid that was going to happen...  From the archived versions on the
CURL download site, it looks as though multi support was added in 7.9.8 -
which version do you have installed on your desktop?

I'll follow this up with a patch that works as you describe to disable
building with parallel transfer support on versions < 7.9.8.

> It should be fine to download objects and a pack that contains them at the 
> same time, although there's currently a check in fetch.c which should be 
> removed, so that it will call fetch() for an object if the object appears 
> between the prefetch() and the fetch().

Can you provide a patch, or point me toward the right place to make that
change?

> I should be able to review this over the weekend. What sort of performance 
> are you getting at this point (in terms of bandwidth utilization)?

I've done limited testing by using the time command to track real/user/sys
taken to run 'git fetch http://kernel.org/pub/scm/git/git.git master',
and have seen performance improve by a factor of ~2-10:

0.99.8:
     real 2m48.800s,  user 0m2.540s, sys 0m0.470s
     real 2m40.316s,  user 0m2.850s, sys 0m0.500s
     real 2m8.543s,   user 0m2.910s, sys 0m0.600s
     real 2m18.009s,  user 0m2.440s, sys 0m0.580s
     real 1m55.354s,  user 0m2.520s, sys 0m0.430s

Parallel: -r 5 (default)
     real 0m49.499s,  user 0m3.220s, sys 0m0.370s
     real 1m0.177s,   user 0m3.310s, sys 0m0.740s
     real 0m52.936s,  user 0m2.680s, sys 0m0.230s
     real 1m0.158s,   user 0m2.870s, sys 0m0.770s
     real 0m52.780s,  user 0m2.970s, sys 0m0.600s

Parallel: -r 10
     real 0m28.338s,  user 0m2.940s, sys 0m0.630s
     real 0m35.944s,  user 0m3.030s, sys 0m0.570s
     real 0m18.019s,  user 0m3.050s, sys 0m0.530s
     real 0m21.539s,  user 0m2.960s, sys 0m0.520s
     real 0m31.405s,  user 0m3.080s, sys 0m0.610s

Parallel: -r 20
     real 0m25.810s,  user 0m3.070s, sys 0m0.490s
     real 0m16.265s,  user 0m2.880s, sys 0m0.370s
     real 0m28.536s,  user 0m2.890s, sys 0m0.650s
     real 0m16.889s,  user 0m2.770s, sys 0m0.460s
     real 0m23.125s,  user 0m2.800s, sys 0m0.450s

Parallel: multi disabled
     real 3m3.833s,  user 0m12.080s, sys 0m3.240s
     real 2m15.454s, user 0m12.130s, sys 0m2.820s
     real 2m23.011s, user 0m12.690s, sys 0m3.030s
     real 2m38.720s, user 0m12.300s, sys 0m2.850s
     real 2m42.025s, usre 0m12.310s, sys 0m2.880s

That's all running on a CentOS 3.5 desktop with CURL 7.10.6.

About that "-r" arg - seems like it should be something else as -r is
used elsewhere in git to enable recursion.  "-c" was my first thought,
but that's used to fetch commit objects.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
