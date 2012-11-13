From: karsten.blees@dcon.de
Subject: Re: [PATCH] update-index/diff-index: use core.preloadindex to improve
 performance
Date: Tue, 13 Nov 2012 16:33:43 +0100
Message-ID: <OF88D51EE0.C9BFCE98-ONC1257AB5.005493C9-C1257AB5.00557CDD@dcon.de>
References: <20121102152616.GD11170@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	pro-logic@optusnet.com.au
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 16:34:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYIUx-0004JI-Ek
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 16:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746Ab2KMPdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 10:33:46 -0500
Received: from mail.dcon.de ([77.244.111.98]:24615 "EHLO MAIL.DCON.DE"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751662Ab2KMPdp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 10:33:45 -0500
In-Reply-To: <20121102152616.GD11170@sigill.intra.peff.net>
X-Mailer: Lotus Notes Release 7.0.3 September 26, 2007
X-MIMETrack: Serialize by Router on DCON14/DCon(Release 7.0.3FP1|February 24, 2008) at
 13.11.2012 16:33:45,
	Serialize complete at 13.11.2012 16:33:45
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209617>

Jeff King <peff@peff.net> wrote on 02.11.2012 16:26:16:

> On Tue, Oct 30, 2012 at 10:50:42AM +0100, karsten.blees@dcon.de wrote:
> 
> > 'update-index --refresh' and 'diff-index' (without --cached) don't 
honor
> > the core.preloadindex setting yet. Porcelain commands using these 
(such as
> > git [svn] rebase) suffer from this, especially on Windows.
> > 
> > Use read_cache_preload to improve performance.
> > 
> > Additionally, in builtin/diff.c, don't preload index status if we 
don't
> > access the working copy (--cached).
> > 
> > Results with msysgit on WebKit repo (2GB in 200k files):
> > 
> >                 | update-index | diff-index | rebase
> > ----------------+--------------+------------+---------
> > msysgit-v1.8.0  |       9.157s |    10.536s | 42.791s
> > + preloadindex  |       9.157s |    10.536s | 28.725s
> > + this patch    |       2.329s |     2.752s | 15.152s
> > + fscache [1]   |       0.731s |     1.171s |  8.877s
> 
> Cool numbers. On my quad-core SSD Linux box, I saw a few speedups, too.
> Here are the numbers for "update-index --refresh" on the WebKit repo
> (all are wall clock time, best-of-five):
> 
>              | before | after
>   -----------+--------+--------
>   cold cache | 4.513s | 2.059s
>   warm cache | 0.252s | 0.164s
>

Great, and thanks for testing on Linux (I only have Linux VMs for testing, 
and I couldn't get meaningful performance data from those).
 
> Not as dramatic, but still nice. I wonder how a spinning disk would fare
> on the cold-cache case, though.  I also tried it with all but one CPU
> disabled, and the warm cache case was a little bit slower.
> 

Unfortunately, with a 'real' disk, cold cache times increase with the 
number of threads. I've played around with '#define MAX_PARALLEL 20' in 
preload-index.c, with the following results ('git update-index --refresh' 
on WebKit repo, Win7 x64, Core i7 860 (2.8GHz 4 Core HT), WD VelociRaptor 
(300G 10krpm 8ms), msysgit 1.8.0 + preload-index patch + fscache patch):

MAX_PARALLEL | cold cache | warm cache
-------------+------------+------------
no preload   |     49.938 |     9.204 (*)
           1 |     45.412 |     1.622
           2 |     55.334 |     1.123
           3 |     65.973 |     0.982
           4 |     67.579 |     0.889
           5 |     76.159 |     0.827
           6 |     81.510 |     0.811
           7 |     86.269 |     0.858
           8 |     85.862 |     0.827
        ...
          10 |     87.953 |     0.717
        ...
          20 |    176.251 |     0.749

(*) core.preloadindex currently also disables fscache, thus the 9s

With more threads, Windows resource monitor also shows increasing disk 
queue length and response times.

It seems clear that more concurrent disk seeks hurt cold cache performance 
pretty badly. On the other hand, warm cache improvements for #threads > 
#cores are only about 10 - 20%.

I don't know if Linux is better at caching / prefetching directory 
listings (might depend on file system, too), but perhaps MAX_PARALLEL 
should be set to a more reasonable value, or be made configurable (e.g. 
core.preloadIndexThreads)?

Karsten
