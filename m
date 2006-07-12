From: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Subject: Re: [PATCH 2/3] sha1_file: add the ability to parse objects in "pack file format"
Date: Wed, 12 Jul 2006 10:28:33 +0200
Message-ID: <20060712082833.GA6842@xp.machine.xx>
References: <Pine.LNX.4.64.0607101623230.5623@g5.osdl.org> <20060711145527.GA32468@hpsvcnb.fc.hp.com> <Pine.LNX.4.64.0607111004360.5623@g5.osdl.org> <Pine.LNX.4.64.0607111010320.5623@g5.osdl.org> <44B4172B.3070503@stephan-feder.de> <Pine.LNX.4.64.0607111449190.5623@g5.osdl.org> <7vejwr3ftl.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0607111656250.5623@g5.osdl.org> <slrneb96rd.dma.Peter.B.Baumann@xp.machine.xx> <7vveq3z41v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Baumann <Peter.B.Baumann@informatik.stud.uni-erlangen.de>,
	git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Jul 12 10:28:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0a5H-0002eo-C4
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 10:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWGLI2g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 04:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWGLI2g
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 04:28:36 -0400
Received: from matlock.hofmann.stw.uni-erlangen.de ([131.188.24.35]:50600 "HELO
	mail.hofmann.stw.uni-erlangen.de") by vger.kernel.org with SMTP
	id S1750938AbWGLI2g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jul 2006 04:28:36 -0400
Received: (qmail 13446 invoked by uid 0); 12 Jul 2006 08:28:34 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 12 Jul 2006 08:28:34 -0000
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>,
	Peter Baumann <Peter.B.Baumann@informatik.stud.uni-erlangen.de>,
	git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <7vveq3z41v.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23770>

On Wed, Jul 12, 2006 at 12:16:12AM -0700, Junio C Hamano wrote:
> >> +	bits = 4;
> >> +	size = c & 0xf;
> >> +	while (!(c & 0x80)) {
> >> +		if (bits >= 8*sizeof(long))
> >> +			return -1;
> >> +		c = *map++;
> >> +		size += (c & 0x7f) << bits;
> >> +		bits += 7;
> >> +		mapsize--;
> >> +	}
> >
> > This doesn't match the logic used in unpack_object_header, which is used
> > in the packs:
> > ...
> >> +	c = (type << 4) | (len & 15);
> >> +	len >>= 4;
> >> +	hdr_len = 1;
> >> +	while (len) {
> >> +		*hdr++ = c;
> >> +		hdr_len++;
> >> +		c = (len & 0x7f);
> >> +		len >>= 7;
> >> +	}
> >> +	*hdr = c | 0x80;
> >> +	return hdr_len;
> >> +}
> >> +
> >
> > Dito, but in this case see pack-objects.c
> 
> Well, while these are not strictly needed to match, there is no
> good reason to make them inconsistent.  Very well spotted.
> 

During packing one could simply copy the existing object into the generated
pack in the non delta case, so I think this _is_ necessary/usefull.

-Peter Baumann
