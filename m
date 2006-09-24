From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 2/6] many cleanups to sha1_file.c
Date: Sun, 24 Sep 2006 00:17:16 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0609240006001.9349@xanadu.home>
References: <Pine.LNX.4.64.0609210004550.2627@xanadu.home>
 <7v7izvug3b.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 06:17:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRLQu-0008Pu-OR
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 06:17:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWIXERS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 00:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751937AbWIXERS
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 00:17:18 -0400
Received: from relais.videotron.ca ([24.201.245.36]:235 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751003AbWIXERS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Sep 2006 00:17:18 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J6200LRIX8S6CC0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 24 Sep 2006 00:17:17 -0400 (EDT)
In-reply-to: <7v7izvug3b.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27646>

On Sat, 23 Sep 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > Those cleanups are mainly to set the table for the support of deltas
> > with base objects referenced by offsets instead of sha1.  This means
> > that many pack lookup functions are converted to take a pack/offset
> > tuple instead of a sha1.
> 
> There still remains some "struct pack_entry" and I wonder if it
> would make sense to get rid of them if only for consistency's
> sake.

Maybe.  But since those are the minimum needed for base offset support 
I'd prefer if the extra cleanup is made separate not to mix too many 
issues at once.

> > diff --git a/sha1_file.c b/sha1_file.c
> > index b89edb9..6fae766 100644
> > --- a/sha1_file.c
> > +++ b/sha1_file.c
> > @@ -926,8 +925,8 @@ static int packed_delta_info(unsigned ch
> >  
> >  		memset(&stream, 0, sizeof(stream));
> >  
> > -		data = stream.next_in = base_sha1 + 20;
> > -		stream.avail_in = left - 20;
> > +		data = stream.next_in = (unsigned char *) p->pack_base + offset;;
> > +		stream.avail_in = p->pack_size - offset;
> >  		stream.next_out = delta_head;
> >  		stream.avail_out = sizeof(delta_head);
> >  
> 
> ";;"?

Typo.

> > @@ -989,75 +988,60 @@ int check_reuse_pack_delta(struct packed
> >  ...
> > +static int packed_object_info(struct packed_git *p, unsigned long offset,
> >  			      char *type, unsigned long *sizep)
> >  {
> > +	unsigned long size;
> >  	enum object_type kind;
> >  
> > -	if (use_packed_git(p))
> > -		die("cannot map packed file");
> > +	offset = unpack_object_header(p, offset, &kind, &size);
> >  
> 
> Do all callers of packed_object_info() call use_packed_git to
> make sure p is mapped?

Easy since the function is static.

> Ah sha1_object_info() is the only one
> except packed_delta_info() that calls itself and it protects it
> with use_packed_git(), so you are safe.

Right.  The only entry point to those functions is sha1_object_info() 
where I moved the use/unuse and all the other call instances are due to 
recursion. >  It seemed to me a bit wasteful to call use() so many times 
to unuse() the same amount afterwards while only once is needed.

> We would need to revamp use/unuse code when we implement the
> partial mapping anyway, but we still need to get this right for
> now.

Probably moving them near the actual pack content access.

May I assume you'll take care of the extra ; typo?


Nicolas
