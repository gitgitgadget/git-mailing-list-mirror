From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 23/23] initial pack index v3 support on the read side
Date: Tue, 03 Sep 2013 02:09:10 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309030201230.14472@syhkavp.arg>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
 <1377577567-27655-24-git-send-email-nico@fluxnic.net>
 <CACsJy8CzvQSYRkH+FNuNhzicX9CLC7bRxKgq2RDmOuxh1Q-=5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 08:09:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGjnh-0000kP-Dy
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 08:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754765Ab3ICGJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 02:09:12 -0400
Received: from relais.videotron.ca ([24.201.245.36]:62109 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753613Ab3ICGJL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 02:09:11 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSJ003N7D3ARG80@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 03 Sep 2013 02:09:10 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 6760E2DA0547; Tue, 03 Sep 2013 02:09:10 -0400 (EDT)
In-reply-to: <CACsJy8CzvQSYRkH+FNuNhzicX9CLC7bRxKgq2RDmOuxh1Q-=5Q@mail.gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233681>

On Sat, 31 Aug 2013, Duy Nguyen wrote:

> On Tue, Aug 27, 2013 at 11:26 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > A bit crud but good enough for now.
> 
> I wonder if we should keep a short SHA-1 table in .idx. An entry in
> the original .idx v1 table is <SHA-1>+<offset> then offset moved out
> to make the table more compact for binary search. I observe that we
> don't always need 20 byte SHA-1 to uniquely identify an entry in a
> pack, so the SHA-1 table could be split in two: one table contain the
> first part of SHA-1, long enough to identify any entry in the pack;
> the second table contains either full SHA-1 or the remaining part.
> Binary search is done on the first table, if matched, full sha-1 from
> the second table is compared. We already have the second sha-1 table
> in .pack v4. We could add the first table in .idx v3.
> 
> On linux-2.6 even in one-pack configuration, we only need the first 6
> bytes of sha-1 to identify an object. That would cut the bsearch sha-1
> table to 1/4 full sha-1 table size.

I don't see the point though.

Why having two tables when only one suffice?

If the argument is about making the SHA1 binary search more efficient 
given a smaller memory footprint, that comes with extra complexity 
coming from the variable length SHA1 strings in the second table.  So 
I'm not sure there is much to gain.

Furthermore, one of the design of pack v4 is to avoid the SHA1 binary 
search entirely.  You will need the binary search only once to locate 
the top commit object, but from there the entire object tree can be 
walked simply by using the sha1ref index and looking up the 
corresponding offset into the pack index file to locate the next object.  

Same thing for walking tree objects: the pack v4 tree deltas are meant 
to be walked inline without having to _apply_ any delta.


Nicolas
