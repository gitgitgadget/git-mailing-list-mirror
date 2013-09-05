From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v2] Document pack v4 format
Date: Thu, 05 Sep 2013 00:12:53 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309042350560.14472@syhkavp.arg>
References: <1377602225-30439-1-git-send-email-pclouds@gmail.com>
 <1377917393-28460-1-git-send-email-pclouds@gmail.com>
 <alpine.LFD.2.03.1309030156410.14472@syhkavp.arg>
 <alpine.LFD.2.03.1309030231350.14472@syhkavp.arg>
 <CACsJy8CZP+55nhfEbgRGa9=y0PyExyHt_seiSc23kB31-_c1Hg@mail.gmail.com>
 <CACsJy8CzpW_xsoxU=+OE6ssbnPu9tyAqRten0=Q5cxPUZ4aeMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 05 06:12:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHQwE-0006jj-Ld
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 06:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753227Ab3IEEMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 00:12:54 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39500 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971Ab3IEEMx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 00:12:53 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR005.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSM00GENX1HXYB0@VL-VM-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 05 Sep 2013 00:12:53 -0400 (EDT)
In-reply-to: <CACsJy8CzpW_xsoxU=+OE6ssbnPu9tyAqRten0=Q5cxPUZ4aeMw@mail.gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233889>

On Tue, 3 Sep 2013, Duy Nguyen wrote:

> On Tue, Sep 3, 2013 at 6:49 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> > On Tue, Sep 3, 2013 at 1:46 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> >> So... looks like pack v4 is now "functional".
> >>
> >> However something is still wrong as it operates about 6 times slower
> >> than pack v3.
> >>
> >> Anyone wishes to investigate?
> >
> > You recurse in decode_entries too deep.I check the first 10000
> > decode_entries() calls in pv4_get_tree(). The deepest level is 3491.
> 
> And I was wrong, the call depth is not that deep, but the number of
> decode_entries calls triggered by one pv4_get_tree() is that many.
> This is on git.git and the tree being processed is "t", which has 672
> entries.. There are funny access patterns. This is the output of
> 
>    fprintf(stderr, "[%d] %d - %d %u\n", call_depth, copy_start,
> copy_count, copy_objoffset);
> 
> [1] 0 - 1 48838573
> [2] 0 - 1 48826699
> [3] 0 - 1 48820760
> [4] 0 - 1 48814812
> [5] 0 - 1 48805904
> [6] 0 - 1 48797000
> [7] 0 - 1 48794034
> [8] 0 - 1 48791067
> [9] 0 - 1 48788100
> [10] 0 - 1 48785134
> [11] 0 - 1 48776221
> [12] 0 - 1 48764321
> [13] 0 - 1 48503227
> [14] 0 - 1 48485415
> [15] 0 - 1 48473512
> [16] 0 - 1 48443621
> [17] 0 - 1 48401788
> [18] 0 - 1 48377834
> [19] 0 - 1 48371841
> [20] 0 - 1 48341809
> [21] 0 - 1 48260734
> [22] 0 - 1 48236635
> [23] 0 - 1 46845105
> [24] 0 - 1 14603061
> [25] 2 - 1 48838573
> [2] 0 - 1 48826699
> 
> It goes through 20+ base trees just to get one tree entry, I think..

Yeah... that's true.  The encoding should refer to the deepest tree 
directly in that case.  Better delta heuristics will have to be worked 
out here.  The code as it is now can't do that.

There was also a bug that prevented larger copy sequences to be created 
which is now fixed.

I added to packv4-create the ability to specify the minimum range of 
consecutive entries that can be represented by a copy sequence to allow 
experiments.  However, even when the tree deltas are completely disabled 
(using --min-tree-copy=0 achieves that) the CPU usage is still much 
higher which is rather unexpected.  In theory this shouldn't be the 
case.

Many other bugs have now been fixed.  A git.git repository with packs 
version 4 appears to be functional and passes git-fsck --full --strict.


Nicolas
