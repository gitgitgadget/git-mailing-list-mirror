From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 10/38] pack v4: commit object encoding
Date: Sat, 07 Sep 2013 00:41:29 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309070036450.20709@syhkavp.arg>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378362001-1738-11-git-send-email-nico@fluxnic.net>
 <xmqqvc2ezbbi.fsf@gitster.dls.corp.google.com>
 <alpine.LFD.2.03.1309061720330.20709@syhkavp.arg>
 <xmqq61udwqlz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 07 06:41:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIALJ-0001sw-7Q
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 06:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812Ab3IGElg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 00:41:36 -0400
Received: from relais.videotron.ca ([24.201.245.36]:17447 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791Ab3IGElg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 00:41:36 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR002.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSQ00D89NPBPXA0@VL-VM-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 07 Sep 2013 00:41:35 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id 8F6592DA0547; Sat, 07 Sep 2013 00:41:34 -0400 (EDT)
In-reply-to: <xmqq61udwqlz.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234112>

On Fri, 6 Sep 2013, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > OK.  If I understand correctly, the committer time stamp is more 
> > important than the author's, right?
> 
> Yeah, it matters a lot more when doing timestamp based traversal
> without the reachability bitmaps.
> 
> > ... may I suggest keeping the tree reference first.  That 
> > is easy to skip over if you don't need it,...
> > ... Whereas, for a checkout where only the tree info is needed, if it is 
> > located after the list of parents, then the above needs to be done for 
> > all those parents and the committer time.
> 
> Hmm.  I wonder if that is a really good trade-off.
> 
> "checkout" is to parse a single commit object and grab the "tree"
> field, while "log" is to parse millions of commit objects to grab
> their "parents" and "committer timestamp" fields ("log path/spec"
> needs to grab "tree", too, so that does not make "tree" extremely
> uncommon compared to the other two fields, though).
> 
> I dunno.

I've therefore settled in the middle.  The patch description now looks 
like:

|    This goes as follows:
|
|    - Tree reference: either variable length encoding of the index
|      into the SHA1 table or the literal SHA1 prefixed by 0 (see
|      encode_sha1ref()).
|
|    - Parent count: variable length encoding of the number of parents.
|      This is normally going to occupy a single byte but doesn't have to.
|
|    - List of parent references: a list of encode_sha1ref() encoded
|      references, or nothing if the parent count was zero.
|
|    - Committer time stamp: variable length encoded.  Year 2038 ready!
|      Unlike the canonical representation, this is stored close to the
|      list of parents so the important data for history traversal can be
|      retrieved without parsing the rest of the object.
|
|    - Committer reference: variable length encoding of an index into the
|      ident dictionary table which also covers the time zone.  To make
|      the overall encoding efficient, the ident table is sorted by usage
|      frequency so the most used entries are first and require the shortest
|      index encoding.
|
|    - Author time stamp: encoded as a difference against the committer
|      time stamp, with the LSB used to indicate commit time is behind
|      author time.
|
|    - Author reference: same as committer reference.
|
|    The remainder of the canonical commit object content is then zlib
|    compressed and appended to the above.

I also updated the documentation patch accordingly in my tree.


Nicolas
