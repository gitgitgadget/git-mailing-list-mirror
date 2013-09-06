From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 10/38] pack v4: commit object encoding
Date: Fri, 06 Sep 2013 17:28:04 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1309061720330.20709@syhkavp.arg>
References: <1378362001-1738-1-git-send-email-nico@fluxnic.net>
 <1378362001-1738-11-git-send-email-nico@fluxnic.net>
 <xmqqvc2ezbbi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 06 23:28:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI3Zc-0007De-C7
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 23:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900Ab3IFV2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 17:28:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:24615 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715Ab3IFV2G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 17:28:06 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MSQ00JDH3MTWN50@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 06 Sep 2013 17:28:05 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id DB17B2DA0547; Fri, 06 Sep 2013 17:28:04 -0400 (EDT)
In-reply-to: <xmqqvc2ezbbi.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234097>

On Thu, 5 Sep 2013, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > This goes as follows:
> >
> > - Tree reference: either variable length encoding of the index
> >   into the SHA1 table or the literal SHA1 prefixed by 0 (see
> >   encode_sha1ref()).
> >
> > - Parent count: variable length encoding of the number of parents.
> >   This is normally going to occupy a single byte but doesn't have to.
> >
> > - List of parent references: a list of encode_sha1ref() encoded
> >   references, or nothing if the parent count was zero.
> >
> > - Author reference: variable length encoding of an index into the author
> >   identifier dictionary table which also covers the time zone.  To make
> >   the overall encoding efficient, the author table is sorted by usage
> >   frequency so the most used names are first and require the shortest
> >   index encoding.
> >
> > - Author time stamp: variable length encoded.  Year 2038 ready!
> >
> > - Committer reference: same as author reference.
> >
> > - Committer time stamp: same as author time stamp.
> >
> > The remainder of the canonical commit object content is then zlib
> > compressed and appended to the above.
> >
> > Rationale: The most important commit object data is densely encoded while
> > requiring no zlib inflate processing on access, and all SHA1 references
> > are most likely to be direct indices into the pack index file requiring
> > no SHA1 search into the pack index file.
> 
> May I suggest a small change to the above, though.
> 
> Reorder the entries so that Parent count, list of parents and
> committer time stamp come first in this order, and then the rest.
> 
> That way, commit.c::parse_commit() could populate its field lazily
> with parsing only the very minimum set of fields, and then the
> revision walker, revision.c::add_parents_to_list(), can find where
> in the priority queue to add the parents to the list of commits to
> be processed while still keeping the object partially parsed.  If a
> commit is UNINTERESTING, no further parsing needs to be done.

OK.  If I understand correctly, the committer time stamp is more 
important than the author's, right?  Because my latest change in the 
format was to make the former as a difference against the later and that 
would obviously have to be reversed.

Also, to keep some kind of estetic symetry (if such thing may exist in a 
raw byte format) may I suggest keeping the tree reference first.  That 
is easy to skip over if you don't need it, something like:

	if (!*ptr)
		ptr += 1 + 20;
	else
		while (*ptr++ & 128);

Whereas, for a checkout where only the tree info is needed, if it is 
located after the list of parents, then the above needs to be done for 
all those parents and the committer time.


Nicolas
