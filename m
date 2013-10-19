From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: pack corruption post-mortem
Date: Sat, 19 Oct 2013 10:41:08 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1310191024000.1951@syhkavp.arg>
References: <20131016083400.GA31266@sigill.intra.peff.net>
 <CACsJy8ABdE8mZMVFZkqYMC4ZeN_baWw=XcYOZYBCZytWP97rRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 19 16:41:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXXid-0008Sc-0S
	for gcvg-git-2@plane.gmane.org; Sat, 19 Oct 2013 16:41:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005Ab3JSOlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Oct 2013 10:41:24 -0400
Received: from relais.videotron.ca ([24.201.245.36]:24669 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753993Ab3JSOlV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Oct 2013 10:41:21 -0400
Received: from yoda.home ([66.130.143.177]) by VL-VM-MR001.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MUX008ZG7GWQO50@VL-VM-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 19 Oct 2013 10:41:20 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 3261A2DA0586; Sat, 19 Oct 2013 10:41:20 -0400 (EDT)
In-reply-to: <CACsJy8ABdE8mZMVFZkqYMC4ZeN_baWw=XcYOZYBCZytWP97rRw@mail.gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236401>

On Sat, 19 Oct 2013, Duy Nguyen wrote:

> On Wed, Oct 16, 2013 at 3:34 PM, Jeff King <peff@peff.net> wrote:
> > I was recently presented with a repository with a corrupted packfile,
> > and was asked if the data was recoverable. This post-mortem describes
> > the steps I took to investigate and fix the problem. I thought others
> > might find the process interesting, and it might help somebody in the
> > same situation.
> >
> > I started with an fsck, which found a problem with exactly one object
> > (I've used $pack and $obj below to keep the output readable, and also
> > because I'll refer to them later):
> >
> >     $ git fsck
> >     error: $pack SHA1 checksum mismatch
> >     error: index CRC mismatch for object $obj from $pack at offset 51653873
> >     error: inflate: data stream error (incorrect data check)
> >     error: cannot unpack $obj from $pack at offset 51653873
> 
> I wonder if we should protect the sha-1 and pathname tables in packv4
> with CRC too. A bit flipped in there could cause stream of corrupt
> objects and make it hard to pinpoint the corrupt location..

It turns out that we already have this covered.

The SHA1 used in the name of the pack file is actually the SHA1 checksum 
of the SHA1 table.

The path and ident tables are already protected by the CRC32 in the zlib 
deflated stream.

Normal objects are also zlib deflated (except for their header) but you 
need to inflate them in order to have this CRC verified, which the pack 
data copy tries to avoid.  Hence the separate CRC32 in the index file in 
that case.

However the pack v4 tables are very unlikely to be reused as is from one 
pack to another.


Nicolas
