From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 09/23] pack v4: commit object encoding
Date: Tue, 27 Aug 2013 12:50:45 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1308271249280.14472@syhkavp.arg>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
 <1377577567-27655-10-git-send-email-nico@fluxnic.net>
 <xmqqy57ndtxb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 18:50:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEMTo-0004Mi-JP
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 18:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753663Ab3H0Qur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 12:50:47 -0400
Received: from relais.videotron.ca ([24.201.245.36]:61251 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753633Ab3H0Quq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 12:50:46 -0400
Received: from yoda.home ([70.83.209.44]) by VL-VM-MR001.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MS700AZC84M4NA0@VL-VM-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Aug 2013 12:50:46 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])	by yoda.home (Postfix)
 with ESMTPSA id D2DA52DA052D; Tue, 27 Aug 2013 12:50:45 -0400 (EDT)
In-reply-to: <xmqqy57ndtxb.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233114>

On Tue, 27 Aug 2013, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > This goes as follows:
> >
> > - Tree reference: either variable length encoding of the index
> >   into the SHA1 table or the literal SHA1 prefixed by 0 (see
> >   add_sha1_ref()).
> >
> > - Parent count: variable length encoding of the number of parents.
> >   This is normally going to occupy a single byte but doesn't have to.
> >
> > - List of parent references: a list of add_sha1_ref() encoded references,
> >   or nothing if the parent count was zero.
> >
> > - Author reference: variable length encoding of an index into the author
> >   string dictionary table which also covers the time zone.  To make the
> >   overall encoding efficient, the author table is already sorted by usage
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
> > requiring no zlib inflate processing, and all SHA1 references are most
> > likely to be direct indices into the pack index file requiring no SHA1
> > search into the pack index file.
> >
> > Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> > ---
> >  packv4-create.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 119 insertions(+)
> >
> > diff --git a/packv4-create.c b/packv4-create.c
> > index bf33d15..cedbbd9 100644
> > --- a/packv4-create.c
> > +++ b/packv4-create.c
> > @@ -13,6 +13,9 @@
> >  #include "tree-walk.h"
> >  #include "pack.h"
> >  
> > +
> > +static int pack_compression_level = Z_DEFAULT_COMPRESSION;
> > +
> >  struct data_entry {
> >  	unsigned offset;
> >  	unsigned size;
> > @@ -289,6 +292,122 @@ static unsigned char *add_sha1_ref(unsigned char *dst, const unsigned char *sha1
> >  	return dst + 20;
> >  }
> >  
> > +/*
> > + * This converts a canonical commit object buffer into its
> > + * tightly packed representation using the already populated
> > + * and sorted commit_name_table dictionary.  The parsing is
> > + * strict so to ensure the canonical version may always be
> > + * regenerated and produce the same hash.
> > + */
> > +void * conv_to_dict_commit(void *buffer, unsigned long *psize)
> 
> Drop SP between asterisk and "conv_"?
> 
> > +{
> > +	unsigned long size = *psize;
> > +	char *in, *tail, *end;
> > +	unsigned char *out;
> > +	unsigned char sha1[20];
> > +	int nb_parents, index, tz_val;
> > +	unsigned long time;
> > +	z_stream stream;
> > +	int status;
> > +
> > +	/*
> > +	 * It is guaranteed that the output is always going to be smaller
> > +	 * than the input.  We could even do this conversion in place.
> > +	 */
> > +	in = buffer;
> > +	tail = in + size;
> > +	buffer = xmalloc(size);
> > +	out = buffer;
> > +
> > +	/* parse the "tree" line */
> > +	if (in + 46 >= tail || memcmp(in, "tree ", 5) || in[45] != '\n')
> > +		goto bad_data;
> > +	if (get_sha1_hex(in + 5, sha1) < 0)
> > +		goto bad_data;
> 
> Is this strict enough to guarantee roundtrip hash identity?  Because
> get_sha1_hex() accepts hexadecimal represented with uppercase A-F,
> you need to reject such a "broken" commit object, no?

Indeed, yes.  Same concern as with split_ident_line() I mentioned 
before.

> Same for parent commit object names below that are parsed with the
> same helper.

Exact.


Nicolas
