From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Tue, 17 Jun 2008 10:05:24 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806171000400.6439@racer>
References: <612BAE20-8DF3-4323-8AEF-527B92122A7A@wincent.com> <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil> <20080611213648.GA13362@glandium.org> <alpine.DEB.1.00.0806112242370.1783@racer>
 <20080611230344.GD19474@sigill.intra.peff.net> <alpine.LFD.1.10.0806111918300.23110@xanadu.home> <loom.20080612T042942-698@post.gmane.org> <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com> <7vzlpqza0t.fsf@gitster.siamese.dyndns.org>
 <279b37b20806121335p90a6d40qb39b73f71dae990b@mail.gmail.com> <7vlk1az8aa.fsf@gitster.siamese.dyndns.org> <279b37b20806121436w4f09c8f7n1009ef2f77b66f87@mail.gmail.com> <alpine.DEB.1.00.0806130551200.6439@racer> <0F87000C-B51E-45B8-A21D-1DA184BD603F@wincent.com>
 <alpine.DEB.1.00.0806132239490.6439@racer> <612BAE20-8DF3-4323-8AEF-527B92122A7A@wincent.com> <200806142359.m5ENxsBI028758 @mi0.bluebottle.com> <7vabhne15k.fsf@gitster.siamese.dyndns.org> <7vy755c0b2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-2022-JP?Q?=1B$B$7$i$$$7$J$J$3=1B=28J?= 
	<nanako3@bluebottle.com>, Wincent Colaiuta <win@wincent.com>,
	Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 17 11:08:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8XAZ-0002pq-SZ
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 11:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754194AbYFQJHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 05:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754098AbYFQJHG
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 05:07:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:51158 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753730AbYFQJHD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 05:07:03 -0400
Received: (qmail invoked by alias); 17 Jun 2008 09:07:01 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp058) with SMTP; 17 Jun 2008 11:07:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19OBKot2KlObLa7wKGIF+0vPRO83XvQShW+/XkPkk
	r3mF7Iblg7gJHe
X-X-Sender: gene099@racer
In-Reply-To: <7vy755c0b2.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85276>

Hi,

On Mon, 16 Jun 2008, Junio C Hamano wrote:

> From: Junio C Hamano <gitster@pobox.com>
> Date: Sun, 15 Jun 2008 23:48:46 -0700
> Subject: [PATCH] Per-ref reflog expiry configuration
> 
> In addition to gc.reflogexpireunreachable and gc.reflogexpire, this lets
> you set gc.<pattern>.reflogexpireunreachable and gc.<pattern>.reflogexpire
> variables.
> 
> When "git reflog expire" expires reflog entry for $ref, the expiry timers
> are taken from the first <pattern> that matches $ref (and if there isn't
> the global default value is used).
> 
> For example, you could:
> 
> 	[gc "refs/stash"]
> 		reflogexpire = never
> 		reflogexpireunreachable = never
> 
> 	[gc "refs/remotes/*"]
> 		reflogexpire = 7 days
> 		reflogexpireunreachable = 3 days
> 
> 	[gc]
> 		reflogexpire = 90 days
> 		reflogexpireunreachable = 30 days

Isn't this overkill?  I mean, we could just change git-stash to output a 
warning:

	Note: your changes have been stored temporarily.  If you need to 
	keep them permanently, consider putting them into a branch:

		git branch stashed-longer stash

Don't get me wrong: I think per-ref reflog expiry is nifty, but it may be 
_too_ nifty, i.e. so complicated only power-users will use it.

Ciao,
Dscho
