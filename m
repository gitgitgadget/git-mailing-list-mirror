From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 05/23] pack v4: add commit object parsing
Date: Tue, 27 Aug 2013 12:47:20 -0400 (EDT)
Message-ID: <alpine.LFD.2.03.1308271238270.14472@syhkavp.arg>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
 <1377577567-27655-6-git-send-email-nico@fluxnic.net>
 <xmqq7gf7f94f.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 27 18:47:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEMQQ-0001qm-0H
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 18:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753270Ab3H0QrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 12:47:22 -0400
Received: from relais.videotron.ca ([24.201.245.36]:37249 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719Ab3H0QrV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 12:47:21 -0400
Received: from xanadu.home ([70.83.209.44]) by VL-VM-MR004.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0MS700J1Q7YWJIZ0@VL-VM-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 27 Aug 2013 12:47:20 -0400 (EDT)
In-reply-to: <xmqq7gf7f94f.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233113>

On Tue, 27 Aug 2013, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > Let's create another dictionary table to hold the author and committer
> > entries.  We use the same table format used for tree entries where the
> > 16 bit data prefix is conveniently used to store the timezone value.
> >
> > In order to copy straight from a commit object buffer, dict_add_entry()
> > is modified to get the string length as the provided string pointer is
> > not always be null terminated.
> >
> > Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> > ---
> > @@ -135,8 +136,73 @@ static void sort_dict_entries_by_hits(struct dict_table *t)
> >  	rehash_entries(t);
> >  }
> >  
> > +static struct dict_table *commit_name_table;
> >  static struct dict_table *tree_path_table;
> >  
> > +/*
> > + * Parse the author/committer line from a canonical commit object.
> > + * The 'from' argument points right after the "author " or "committer "
> > + * string.  The time zone is parsed and stored in *tz_val.  The returned
> > + * pointer is right after the end of the email address which is also just
> > + * before the time value, or NULL if a parsing error is encountered.
> > + */
> > +static char *get_nameend_and_tz(char *from, int *tz_val)
> > +{
> > +	char *end, *tz;
> > +
> > +	tz = strchr(from, '\n');
> > +	/* let's assume the smallest possible string to be "x <x> 0 +0000\n" */
> > +	if (!tz || tz - from < 13)
> > +		return NULL;
> > +	tz -= 4;
> > +	end = tz - 4;
> > +	while (end - from > 5 && *end != ' ')
> > +		end--;
> > +	if (end[-1] != '>' || end[0] != ' ' || tz[-2] != ' ')
> > +		return NULL;
> > +	*tz_val = (tz[0] - '0') * 1000 +
> > +		  (tz[1] - '0') * 100 +
> > +		  (tz[2] - '0') * 10 +
> > +		  (tz[3] - '0');
> > +	switch (tz[-1]) {
> > +	default:	return NULL;
> > +	case '+':	break;
> > +	case '-':	*tz_val = -*tz_val;
> > +	}
> > +	return end;
> > +}
> 
> This may want to share code with ident.c::split_ident_line(), as we
> have been trying to reduce the number of ident-line parsers.

Hmmm....  The problem I have with split_ident_line() right now is about 
the fact that it is too liberal with whitespaces.  Here I must be sure I 
can deconstruct a commit object and be sure I still can regenerate it 
byte for byte in order to match its SHA1 signature.

So there _must_ always be only one space between the email closing 
bracket and the time stamp, only one space between the time stamp and 
the time zone value, and no space after the time zone.

Is there a reason why split_ident_line() is not stricter in that regard?


Nicolas
