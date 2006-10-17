From: Nicolas Pitre <nico@cam.org>
Subject: Re: heads-up: git-index-pack in "next" is broken
Date: Tue, 17 Oct 2006 16:25:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610171624130.1971@xanadu.home>
References: <7vy7rfsfqa.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171134130.1971@xanadu.home>
 <7vslhnj58e.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171251210.1971@xanadu.home>
 <7vbqoake1v.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171437250.1971@xanadu.home>
 <20061017233630.72a0aae5.vsu@altlinux.ru>
 <7vy7reitzm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Sergey Vlasov <vsu@altlinux.ru>
X-From: git-owner@vger.kernel.org Tue Oct 17 22:25:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZvVH-00041f-5y
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 22:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWJQUZc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 16:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWJQUZb
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 16:25:31 -0400
Received: from relais.videotron.ca ([24.201.245.36]:46966 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751241AbWJQUZb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 16:25:31 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J7A001AVREIX1D0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 17 Oct 2006 16:25:30 -0400 (EDT)
In-reply-to: <7vy7reitzm.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29113>

On Tue, 17 Oct 2006, Junio C Hamano wrote:

> Sergey Vlasov <vsu@altlinux.ru> writes:
> 
> > On Tue, 17 Oct 2006 14:47:16 -0400 (EDT) Nicolas Pitre wrote:
> >
> >> Is it possible that sizeof(union delta_base) might not be equal to 20 
> >> for you?
> >
> > Yes, on x86_64 this is 24 because of 8-byte alignment for longs:
> 
> Enough eyeballs made this bug shallow ;-)  Thanks.
> 
> diff --git a/index-pack.c b/index-pack.c
> index fffddd2..49b6efe 100644
> --- a/index-pack.c
> +++ b/index-pack.c
> @@ -166,6 +166,7 @@ static void *unpack_raw_entry(unsigned l
>  	case OBJ_REF_DELTA:
>  		if (pos + 20 >= pack_limit)
>  			bad_object(offset, "object extends past end of pack");
> +		memset(delta_base, 0, sizeof(*delta_base));
>  		hashcpy(delta_base->sha1, pack_base + pos);

Yeah.... but this is a bit wasteful since (especially on 32-bit archs) 
you just write to the same memory twice in a row.


Nicolas
