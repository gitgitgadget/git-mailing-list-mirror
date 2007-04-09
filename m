From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 5/8] get-repack --max-pack-size: write_object() takes
 'limit' arg
Date: Mon, 09 Apr 2007 14:59:18 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704091455100.28181@xanadu.home>
References: <46197994.70009@gmail.com>
 <alpine.LFD.0.98.0704082034060.28181@xanadu.home>
 <56b7f5510704091151l70cc74b1la82e0c5a67d6885f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 01:00:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Haz5H-0001Jh-Jd
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 20:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbXDIS7U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 14:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbXDIS7U
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 14:59:20 -0400
Received: from relais.videotron.ca ([24.201.245.36]:58159 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932224AbXDIS7T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 14:59:19 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG8006AAVEUTZH0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Apr 2007 14:59:18 -0400 (EDT)
In-reply-to: <56b7f5510704091151l70cc74b1la82e0c5a67d6885f@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44075>

On Mon, 9 Apr 2007, Dana How wrote:

> On 4/8/07, Nicolas Pitre <nico@cam.org> wrote:
> > > @@ -448,6 +480,12 @@ static off_t write_object(struct sha1file *f,
> > >                       header[pos] = ofs & 127;
> > >                       while (ofs >>= 7)
> > >                               header[--pos] = 128 | (--ofs & 127);
> > > +                     if ( limit && hdrlen + sizeof(header) - pos +
> > datalen + 20 >= limit ) {
> > > +                             free(out);
> > > +                             free(buf);
> > > +                             return 0;
> > > +                     }
> > > +                     sha1write(f, header, hdrlen);
> > >                       sha1write(f, header + pos, sizeof(header) - pos);
> > 
> > The above looks rather buggy to me.
> 
> OK, can you be more specific?

You're writing the content of the array 'header' twice in a row.  Sure 
the second time it is header + pos but it is still the result of an 
operation that used to put data into 'header' after the first content 
was already written out.  Right now it looks like the first write might 
contain clobbered data.


Nicolas
