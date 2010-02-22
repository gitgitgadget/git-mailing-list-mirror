From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] sha1_file: don't malloc the whole compressed result when
 writing out objects
Date: Mon, 22 Feb 2010 12:36:39 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002221233000.1946@xanadu.home>
References: <alpine.LFD.2.00.1002202323500.1946@xanadu.home>
 <7vd3zys79d.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002211522120.1946@xanadu.home>
 <7v3a0umdb8.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002211950250.1946@xanadu.home>
 <7v635p4z26.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1002220034540.1946@xanadu.home>
 <7v8walyesu.fsf@alter.siamese.dyndns.org>
 <7v4ol9vl0l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 18:36:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjcD7-0002JV-Ps
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 18:36:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633Ab0BVRgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 12:36:41 -0500
Received: from relais.videotron.ca ([24.201.245.36]:49290 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297Ab0BVRgk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 12:36:40 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KY9009HN7L33BA0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 22 Feb 2010 12:36:39 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v4ol9vl0l.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140699>

On Sun, 21 Feb 2010, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Nicolas Pitre <nico@fluxnic.net> writes:
> >
> >> And what real life case would trigger this?  Given the size of the 
> >> window for this to happen, what are your chances?
> >
> >> Of course the odds for me to be struck by lightning also exist.  And if 
> >> I work really really hard at it then I might be able to trigger that 
> >> pathological case above even before the next thunderstorm.  But in 
> >> practice I'm hardly concerned by either of those possibilities.
> >
> > The real life case for any of this triggers for me is zero, as I won't be
> > mistreating git as a continuous & asynchronous back-up tool.
> >
> > But then that would make the whole discussion moot.  There are people who
> > file "bug reports" with an artificial reproduction recipe built around a
> > loop that runs dd continuously overwriting a file while "git add" is asked
> > to add it.
> 
> Having said all that, I like your approach better.  It is not worth paying
> the price of unnecessary memcpy(3) that would _only_ help catching the
> insanely artificial test case, but your patch strikes a good balance of
> small overhead to catch the easier-to-trigger (either by stupidity, malice
> or mistake) cases.

I think it also catches the bad RAM case which is probably more common 
too.

> So I am tempted to discard the "paranoia" patch, and replace with your two
> patches, with the following caveats in the log message.
> 
> --- /var/tmp/2	2010-02-21 22:23:30.000000000 -0800
> +++ /var/tmp/1	2010-02-21 22:23:22.000000000 -0800
> @@ -21,7 +21,9 @@
>      deflate operation has consumed that data, and make sure it matches
>      with the expected SHA1.  This way we can rely on the CRC32 checked by
>      the inflate operation to provide a good indication that the data is still
> -    coherent with its SHA1 hash.
> +    coherent with its SHA1 hash.  One pathological case we ignore is when
> +    the data is modified before (or during) deflate call, but changed back
> +    before it is hashed.

ACK.


Nicolas
