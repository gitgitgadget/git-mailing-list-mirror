From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/3] sha1_file: add the ability to parse objects in "pack
 file format"
Date: Tue, 11 Jul 2006 20:42:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607112040050.5623@g5.osdl.org>
References: <20060710230132.GA11132@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607101623230.5623@g5.osdl.org> <20060711145527.GA32468@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607111004360.5623@g5.osdl.org> <Pine.LNX.4.64.0607111010320.5623@g5.osdl.org>
 <44B4172B.3070503@stephan-feder.de> <Pine.LNX.4.64.0607111449190.5623@g5.osdl.org>
 <7vejwr3ftl.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0607111656250.5623@g5.osdl.org>
 <7vveq31wgo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: sf <sf-gmane@stephan-feder.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 12 05:43:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0Vcw-0001PU-1o
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 05:43:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWGLDnB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 23:43:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbWGLDnB
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 23:43:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4744 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932379AbWGLDnA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 23:43:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6C3gonW016057
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 11 Jul 2006 20:42:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6C3gnDr022551;
	Tue, 11 Jul 2006 20:42:50 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vveq31wgo.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23754>



On Tue, 11 Jul 2006, Junio C Hamano wrote:
> >  	unsigned char *buf = xmalloc(1+size);
> > +	unsigned long n;
> >  
> > -	memcpy(buf, (char *) buffer + bytes, stream->total_out - bytes);
> > -	bytes = stream->total_out - bytes;
> > +	n = stream->total_out - bytes;
> > +	if (n > size)
> > +		n = size;
> > +	memcpy(buf, (char *) buffer + bytes, n);
> > +	bytes = n;
> >  	if (bytes < size) {
> >  		stream->next_out = buf + bytes;
> >  		stream->avail_out = size - bytes;
> 
> This one looks like an independent fix for a well spotted bug.

Yeah, well, the "bug" only happens if you screw something up (which I 
triggered both times I tried to rewrite this ;)

Or possibly it the object is corrupt.

But yes, it's independent.

> > -	size = deflateBound(&stream, len+hdrlen);
> > +	size = 8 + deflateBound(&stream, len+hdrlen);
> >  	compressed = xmalloc(size);
> >  
> >  	/* Compress it */
> 
> I am wondring what this eight is.  You would pack 7 7-bit length
> plus 4-bit totalling 49+4 = 53-bit length (plus 4-bit type).  Is
> it an unwritten decision that the format would not deal with
> objects larger than 2^53 (which is probably fine but looks
> magic)?

8 was just "obviously enough".

The "hdrlen" part should already give us _way_ more padding than we need 
(the old-fashioned header will deflate to something bigger than the new 
header, so deflateBound() even _without_ the extra space should be 
plenty).

But I decided to add a few bytes just because it won't hurt.

		Linus
