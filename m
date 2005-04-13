From: Darren Williams <dsw@gelato.unsw.edu.au>
Subject: Re: Git usage and resource usage
Date: Thu, 14 Apr 2005 09:18:38 +1000
Message-ID: <20050413231838.GB10385@cse.unsw.EDU.AU>
References: <20050413130622.GA23982@cse.unsw.EDU.AU> <20050413152948.D2442@banaan.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Apr 14 01:16:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLr55-0004Zj-Dn
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 01:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVDMXSv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Apr 2005 19:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVDMXSv
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Apr 2005 19:18:51 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:8877 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261221AbVDMXSr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2005 19:18:47 -0400
Received: From wagner With LocalMail ; Thu, 14 Apr 2005 09:18:38 +1000 
To: Erik van Konijnenburg <ekonijn@xs4all.nl>
Mail-Followup-To: Erik van Konijnenburg <ekonijn@xs4all.nl>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050413152948.D2442@banaan.localdomain>
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Erik

On Wed, 13 Apr 2005, Erik van Konijnenburg wrote:

> On Wed, Apr 13, 2005 at 11:06:22PM +1000, Darren Williams wrote:
> >   Git(pasky) requires an excessive quantity of file
> > descriptors, more than 1024 in a simple case and
> > more than 16384 in a high workload case.
> 
> Does this help?  Posted earlier today to the list,
> but since there are no archives yet its hard to find.
> 
Yes that fixes it.

% ulimit -n
1024 

% quilt pop -a
% time git commit
...
Enter commit message, terminated by ctrl-D on a separate line:

real    0m7.762s
user    0m7.282s
sys     0m0.459s

> Regards,
> Erik
> 
> tree 70189060273990e945015845a1d97c03eac2346a
> parent 97c9a63e76bf667c21f24a5cfa8172aff0dd1294
> author Erik van Konijnenburg,,, <konijn@framboos> Wed Apr 13 13:32:13 2005
> committer Erik van Konijnenburg,,, <konijn@framboos> Wed Apr 13 13:32:13 2005
> 
> avoid fd leak.
> .
> Index: read-cache.c
> ===================================================================
> --- 833bb44b8e49daf0424f44cf300748da17945859/read-cache.c  (mode:100644 sha1:7cdd0f82992789e64f6ea272e43ee4af8cdf7f2a)
> +++ 70189060273990e945015845a1d97c03eac2346a/read-cache.c  (mode:100644 sha1:7957377f2ddd107aa686f3ca4da51b74e6679baf)
> @@ -251,11 +251,15 @@
>  		if (fd < 0)
>  			return -1;
>  		map = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
> -		if (map == MAP_FAILED)
> +		if (map == MAP_FAILED) {
> +			close(fd);
>  			return -1;
> +		}
>  		if (memcmp(buf, map, size))
>  			return error("SHA1 collision detected!"
>  					" This is bad, bad, BAD!\a\n");
> +		munmap(map, size);
> +		close(fd);
>  #endif
>  		return 0;
>  	}
--------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------
