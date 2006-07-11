From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/3] sha1_file: add the ability to parse objects in "pack
 file format"
Date: Tue, 11 Jul 2006 11:58:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607111153170.5623@g5.osdl.org>
References: <20060710230132.GA11132@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607101623230.5623@g5.osdl.org> <20060711145527.GA32468@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0607111004360.5623@g5.osdl.org> <Pine.LNX.4.64.0607111010320.5623@g5.osdl.org>
 <Pine.LNX.4.63.0607112031150.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Carl Baldwin <cnb@fc.hp.com>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 11 21:06:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0NY8-0006QZ-Eh
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 21:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbWGKTFd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 15:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWGKTFd
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 15:05:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14804 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751183AbWGKTFd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 15:05:33 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k6BIwPnW018274
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 11 Jul 2006 11:58:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k6BIwOFP001539;
	Tue, 11 Jul 2006 11:58:25 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607112031150.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.85__
X-MIMEDefang-Filter: osdl$Revision: 1.140 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23727>



On Tue, 11 Jul 2006, Johannes Schindelin wrote:
> 
> Why not just say
> 
> 	return *hdr ? -1 : bytes;

Hey, whatever works. I rewrote more, and edited some of my changes down 
again..

> You might want to add a comment saying "since the type is lowercase in 
> ascii format, object_type must be 6 or 7, which is an invalid object 
> type." It took me a little to figure that out...

It's not even correct in my version - I check the ASCII header _first_, so 
by the time it looks at the binary one, it already knows it's not ascii.

The problematic case is actually the other way around: my 
"parse_ascii_sha1_header()" isn't strict enough.

Or, more likely, the parse_sha1_header() function should just be changed 
to check the binary format first (and then add your comment about why that 
is safe).

> > +	bits = 4;
> > +	while (!(c & 0x80)) {
> > +		if (bits >= 8*sizeof(unsigned long))
> > +			return -1;
> > +		c = *hdr++;
> > +		size += (unsigned long) (c & 0x7f) << bits;
> > +		bytes++;
> > +		bits += 7;
> > +	}
> 
> Are you not losing the last byte by putting the "while" _before_ instead 
> of _after_ the loop?

No. The very first byte can have the 0x80 end marker, when the size was 
between 0..15.

> >  int sha1_object_info(const unsigned char *sha1, char *type, unsigned long *sizep)
> >  {
> > -	int status;
> > +	int status, hdrlen;
> >  	unsigned long mapsize, size;
> >  	void *map;
> >  	z_stream stream;
> 
> This hunk is unnecessary, right?

Yeah, never mind. That function didn't actually need the hdrlen, it only 
cared about the SHA1.

		Linus
