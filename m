X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: VCS comparison table
Date: Thu, 26 Oct 2006 13:03:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610261247420.12418@xanadu.home>
References: <45354AD0.1020107@utoronto.ca>
 <BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE>
 <vpq4ptz2uh8.fsf@ecrins.imag.fr> <453DAC87.8050203@research.canon.com.au>
 <Pine.LNX.4.64.0610232318200.3962@g5.osdl.org>
 <Pine.LNX.4.64N.0610232336010.30334@attu2.cs.washington.edu>
 <Pine.LNX.4.64.0610240812410.3962@g5.osdl.org>
 <Pine.LNX.4.64N.0610241300450.8112@attu4.cs.washington.edu>
 <20061025084810.GA26618@coredump.intra.peff.net>
 <Pine.LNX.4.64N.0610250157470.3467@attu1.cs.washington.edu>
 <20061025094900.GA26989@coredump.intra.peff.net>
 <Pine.LNX.4.64N.0610250954380.31053@attu2.cs.washington.edu>
 <454098EC.8040406@op5.se>
 <Pine.LNX.4.63.0610260929040.2424@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Thu, 26 Oct 2006 17:04:24 +0000 (UTC)
Cc: Andreas Ericsson <ae@op5.se>,
	David Rientjes <rientjes@cs.washington.edu>,
	Jeff King <peff@peff.net>, Linus Torvalds <torvalds@osdl.org>,
	Lachlan Patrick <loki@research.canon.com.au>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <Pine.LNX.4.63.0610260929040.2424@qynat.qvtvafvgr.pbz>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30239>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd8eB-00086D-Jt for gcvg-git@gmane.org; Thu, 26 Oct
 2006 19:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161090AbWJZRDv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 13:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161431AbWJZRDv
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 13:03:51 -0400
Received: from relais.videotron.ca ([24.201.245.36]:17789 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1161090AbWJZRDu
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 13:03:50 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J7R00IQD62DAH50@VL-MH-MR001.ip.videotron.ca> for git@vger.kernel.org; Thu,
 26 Oct 2006 13:03:49 -0400 (EDT)
To: David Lang <dlang@digitalinsight.com>
Sender: git-owner@vger.kernel.org

On Thu, 26 Oct 2006, David Lang wrote:

> On Thu, 26 Oct 2006, Andreas Ericsson wrote:
> 
> > > 
> > > There are _not_ scalability improvements.  There may be some slight
> > > performance improvements, but definitely not scalability.  If you have
> > > ever tried to use git to manage terabytes of data, you will see this
> > > becomes very clear.  And "rebasing with 3-way merge" is not something
> > > often used in industry anyway if you've followed the more common models
> > > for revision control within large companies with thousands of engineers.
> > > Typically they all work off mainline.
> > > 
> >
> > Actually, I don't see why git shouldn't be perfectly capable of handling a
> > repo containing several terabytes of data, provided you don't expect it to
> > turn up the full history for the project in a couple of seconds and you
> > don't actually *change* that amount of data in each revision. If you want a
> > vcs that handles that amount with any kind of speed, I think you'll find
> > rsync and raw rvs a suitable solution.
> 
> actually, there are some real problems in this area. the git pack format can't
> be larger then 4G, and I wouldn't be surprised if there were other issues with
> files larger then 4G (these all boil down to 32 bit limits). once these limits
> are dealt with then you will be right.

There is no such limit on the pack format.  A pack itself can be as 
large as you want.  The 4G limit is in the tool not the format.

The actual pack limits are as follows:

	- a pack can have infinite size

	- a pack cannot have more than 4294967296 objects

	- each non-delta objects can be of infinite size

	- delta objects can be of infinite size themselves but...

	- current delta encoding can use base objects no larger than 4G

The _code_ is currently limited to 4G though, especially on 32-bit 
architectures.  The delta issue could be resolved in a backward 
compatible way but it hasn't been formalized yet.

The pack index is actually limited to 32-bits meaning it can cope with 
packs no larger than 4G.  But the pack index is a local matter and not 
part of the protocol so this is not a big issue to define a new index 
format and automatically convert existing indexes at that point.


