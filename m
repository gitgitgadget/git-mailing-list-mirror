From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 08/23] pack v4: basic references encoding
Date: Tue, 27 Aug 2013 11:53:18 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1308271151570.14472@syhkavp.arg>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
 <1377577567-27655-9-git-send-email-nico@fluxnic.net>
 <xmqq38pvf8yo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 17:53:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VELaK-0003nX-BU
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 17:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753656Ab3H0Pxc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 11:53:32 -0400
Received: from relais.videotron.ca ([24.201.245.36]:36451 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753384Ab3H0Pxb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 11:53:31 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR004.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MS700MQK5GUQPS0@VL-VM-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Aug 2013 11:53:19 -0400 (EDT)
In-reply-to: <xmqq38pvf8yo.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233106>

On Tue, 27 Aug 2013, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > Add variable length number encoding.  Let's apply the same encoding
> > currently used for the offset to base of OBJ_OFS_DELTA objects which
> > is the most efficient way to do this, and apply it to everything with
> > pack version 4.
> >
> > Also add SHA1 reference encoding.  This one is either an index into a
> > SHA1 table encoded using the variable length number encoding, or the
> > literal 20 bytes SHA1 prefixed with a 0.
> >
> > The index 0 discriminates between an actual index value or the literal
> > SHA1.  Therefore when the index is used its value must be increased by 1.
> >
> > Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> > ---
> >  packv4-create.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >
> > diff --git a/packv4-create.c b/packv4-create.c
> > index 012129b..bf33d15 100644
> > --- a/packv4-create.c
> > +++ b/packv4-create.c
> > @@ -245,6 +245,50 @@ static void dict_dump(void)
> >  	dump_dict_table(tree_path_table);
> >  }
> >  
> > +/*
> > + * Encode a numerical value with variable length into the destination buffer
> > + */
> > +static unsigned char *add_number(unsigned char *dst, uint64_t value)
> > +{
> > +	unsigned char buf[20];
> > +	unsigned pos = sizeof(buf) - 1;
> > +	buf[pos] = value & 127;
> > +	while (value >>= 7)
> > +		buf[--pos] = 128 | (--value & 127);
> > +	do {
> > +		*dst++ = buf[pos++];
> > +	} while (pos < sizeof(buf));
> > +	return dst;
> > +}
> 
> This may want to reuse (or enhance-then-reuse) varint.[ch].

Goodie!  I didn't notice this had happened.


Nicolas
