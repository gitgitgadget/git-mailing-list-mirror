From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: pack corruption post-mortem
Date: Sun, 20 Oct 2013 17:08:30 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1310201657210.1951@syhkavp.arg>
References: <20131016083400.GA31266@sigill.intra.peff.net>
 <CACsJy8ABdE8mZMVFZkqYMC4ZeN_baWw=XcYOZYBCZytWP97rRw@mail.gmail.com>
 <alpine.LFD.2.03.1310191024000.1951@syhkavp.arg>
 <CACsJy8AATr9KfFN6x0E8mYsBmWhVmD=kaXgBmnFTiyww3MS8WQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 20 23:08:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VY0El-0000bn-Cv
	for gcvg-git-2@plane.gmane.org; Sun, 20 Oct 2013 23:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835Ab3JTVIc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Oct 2013 17:08:32 -0400
Received: from relais.videotron.ca ([24.201.245.36]:53395 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783Ab3JTVIb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Oct 2013 17:08:31 -0400
Received: from yoda.home ([66.130.143.177]) by VL-VM-MR004.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MUZ004BEK26PW00@VL-VM-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 20 Oct 2013 17:08:30 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 7F96B2DA04B7; Sun, 20 Oct 2013 17:08:30 -0400 (EDT)
In-reply-to: <CACsJy8AATr9KfFN6x0E8mYsBmWhVmD=kaXgBmnFTiyww3MS8WQ@mail.gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236422>

On Sun, 20 Oct 2013, Duy Nguyen wrote:

> On Sat, Oct 19, 2013 at 9:41 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Sat, 19 Oct 2013, Duy Nguyen wrote:
> > The SHA1 used in the name of the pack file is actually the SHA1 checksum
> > of the SHA1 table.
> >
> > The path and ident tables are already protected by the CRC32 in the zlib
> > deflated stream.
> >
> > Normal objects are also zlib deflated (except for their header) but you
> > need to inflate them in order to have this CRC verified, which the pack
> > data copy tries to avoid.  Hence the separate CRC32 in the index file in
> > that case.
> 
> OK slight change in the subject, what about reading code (i.e.
> sha1_file.c)? With v2 crc32 is verified by object inflate code. With
> v4 trees or commits, because we store some (or all) data outside of
> the deflated stream, we will not benefit from crc32 verifcation
> previously done for all trees and commits. Should we perform explict
> crc32 check when reading v4 trees and commits (and maybe verify the
> sha-1 table too)?

I suppose that we should... at some point.

I did the SHA1 table check only for index-pack and unpack-objects in my 
latest patch.  Adding it to check_packed_git_idx() as well should be 
trivial.

I'm not sure about the best way to do systematic checks on tree objects 
though.  We have both the CRC32 recorded in the index file and the 
object SHA1 recorded in the SHA1 table.  But any of them needs to be 
computed as we walk the object and we currently havn't found the best 
way to do that yet.  So I'd suggest postponing this until the tree walk 
is properly implemented to perform well first.


Nicolas
