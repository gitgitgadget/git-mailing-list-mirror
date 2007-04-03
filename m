From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 03 Apr 2007 12:40:14 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704031235490.28181@xanadu.home>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704030913060.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 03 18:40:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYm3S-0008RO-Ig
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 18:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934012AbXDCQkS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 12:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934015AbXDCQkR
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 12:40:17 -0400
Received: from relais.videotron.ca ([24.201.245.36]:48535 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934012AbXDCQkP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 12:40:15 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JFX0030KKZ29O20@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 03 Apr 2007 12:40:15 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0704030913060.6730@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43629>

On Tue, 3 Apr 2007, Linus Torvalds wrote:

> 
> 
> On Tue, 3 Apr 2007, Linus Torvalds wrote:
> > 
> > and it uses 52s of CPU-time, and on my 4GB machine it actually started 
> > doing IO and swapping, because git-index-pack grew to 4.8GB in size.
> 
> Ahh. False alarm.
> 
> The problem is actually largely a really stupid memory leak in the SHA1 
> collision checking (which wouldn't trigger on a normal pull, but obviously 
> does trigger for every single object when testing!)

Damn!

Please don't report those things when I'm out for lunch so I could have 
a chance to fix my own stupidities myself in time!  :-)

> This trivial patch fixes most of it. git-index-pack still uses too much 
> memory, but it does a *lot* better.
> 
> Junio, please get this into 1.5.1 (I *think* the SHA1 checking is new, but 
> if it exists in 1.5.0 too, it obviously needs the same fix).

No, it is new to 1.5.1.

> It still grows, but it grew to just 287M in size now for the 170M kernel 
> object:
> 
> 	41.59user 1.39system 0:43.64elapsed
> 	0major+73552minor
> 
> which is quite a lot better.
> 
> Duh.

Indeed.

Acked-by: Nicolas Pitre <nico@cam.org>

>  index-pack.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/index-pack.c b/index-pack.c
> index 6284fe3..3c768fb 100644
> --- a/index-pack.c
> +++ b/index-pack.c
> @@ -358,6 +358,7 @@ static void sha1_object(const void *data, unsigned long size,
>  		if (size != has_size || type != has_type ||
>  		    memcmp(data, has_data, size) != 0)
>  			die("SHA1 COLLISION FOUND WITH %s !", sha1_to_hex(sha1));
> +		free(has_data);
>  	}
>  }
>  
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


Nicolas
