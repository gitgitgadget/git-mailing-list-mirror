From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: pack-object's try_delta fast path for v2 trees?
Date: Mon, 14 Oct 2013 21:45:12 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1310142141200.1873@syhkavp.arg>
References: <CACsJy8Behb7PW=pFjH=wpjfHjUiyCo8n_ER+KyzcBwCzpyG6pg@mail.gmail.com>
 <20131015001926.GC10415@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 15 03:45:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVthc-0003Zk-UN
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 03:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755780Ab3JOBph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 21:45:37 -0400
Received: from relais.videotron.ca ([24.201.245.36]:22470 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754052Ab3JOBpg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 21:45:36 -0400
Received: from yoda.home ([66.130.143.177]) by VL-VM-MR005.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MUO00K24SVTGVG0@VL-VM-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 14 Oct 2013 21:45:29 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id F38452DA03FE; Mon, 14 Oct 2013 21:45:28 -0400 (EDT)
In-reply-to: <20131015001926.GC10415@sigill.intra.peff.net>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236160>

On Mon, 14 Oct 2013, Jeff King wrote:

> On Sat, Oct 12, 2013 at 10:42:17AM +0700, Nguyen Thai Ngoc Duy wrote:
> 
> > Just wondering if this has been considered and dropped before.
> > Currently we use try_delta() for every object including trees. But
> > trees are special. All tree entries must be unique and sorted. That
> > helps simplify diff algorithm, as demonstrated by diff_tree() and
> > pv4_encode_tree(). A quick and dirty test with test-delta shows that
> > tree_diff only needs half the time of diff_delta(). As trees account
> > for like half the objects in a repo, speeding up delta search might
> > help performance, I think.
> 
> No, as far as I know, it is a novel idea. When we were discussing commit
> caching a while back, Shawn suggested slicing trees on boundaries and
> store delta instructions that were pure "change this entry", "add this
> entry", and "delete this entry" chunks. The deltas might end up a little
> bigger, but if the reader knew the writer had sliced in this way, it
> could get a packv4-style cheap tree-diff, while remaining backwards
> compatible with implementations that just blindly reassemble the buffer
> from delta instructions.
> 
> I didn't get far enough to try it, but doing what you propose would be
> the first step. Now that packv4 is more of a reality, it may not be
> worth pursuing, though.

The "easy" way to produce pack v2 tree objects from a pack v4 would be 
exactly that: take the pack v4 tree encoding and do a straight 
translation into delta encoding using the base from which the most 
entries are copied from.


Nicolas
