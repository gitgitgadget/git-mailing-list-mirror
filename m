From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] http: use curl's tcp keepalive if available
Date: Tue, 15 Oct 2013 04:58:14 +0000
Message-ID: <20131015045814.GA12312@dcvr.yhbt.net>
References: <20131012222939.GA24255@dcvr.yhbt.net>
 <alpine.DEB.2.00.1310131142080.22193@tvnag.unkk.fr>
 <20131014052739.GA16129@dcvr.yhbt.net>
 <20131014214035.GB7007@sigill.intra.peff.net>
 <20131014233839.GA26323@dcvr.yhbt.net>
 <20131015000614.GA10905@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Stenberg <daniel@haxx.se>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 15 06:58:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVwi4-00082E-7x
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 06:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258Ab3JOE6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 00:58:16 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:33981 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134Ab3JOE6P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 00:58:15 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C1FA1F464;
	Tue, 15 Oct 2013 04:58:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20131015000614.GA10905@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236163>

Jeff King <peff@peff.net> wrote:
> On Mon, Oct 14, 2013 at 11:38:39PM +0000, Eric Wong wrote:
> 
> > I wanted it to work as older curl first (since I noticed this
> > on an old server).  But your patch on top of mine looks reasonable,
> > thanks.
> 
> Makes sense. Here it is with a real commit message (on top of the
> ew/keepalive topic).
> 
> -- >8 --
> Subject: http: use curl's tcp keepalive if available
> 
> Commit a15d069 taught git to use curl's SOCKOPTFUNCTION hook
> to turn on TCP keepalives. However, modern versions of curl
> have a TCP_KEEPALIVE option, which can do this for us. As an
> added bonus, the curl code knows how to turn on keepalive
> for a much wider variety of platforms. The only downside to
> using this option is that not everybody has a new enough curl.
> Let's split our keepalive options into three conditionals:
> 
>   1. With curl 7.25.0 and newer, we rely on curl to do it
>      right.
> 
>   2. With older curl that still knows SOCKOPTFUNCTION, we
>      use the code from a15d069.
> 
>   3. Otherwise, we are out of luck, and the call is a no-op.
> 
> Signed-off-by: Jeff King <peff@peff.net>

Thanks.
Tested-by: Eric Wong <normalperson@yhbt.net>
on curl 7.21.0 and 7.26.0, confirmed via strace:

	setsockopt(fd, SOL_SOCKET, SO_KEEPALIVE, [1], 4) = 0

I can also confirm 7.26.0 adds:

	setsockopt(fd, SOL_TCP, TCP_KEEPIDLE, [60], 4) = 0
	setsockopt(fd, SOL_TCP, TCP_KEEPINTVL, [60], 4) = 0

to the strace on Linux.

> ---
> Given the #ifdefs in curl's keepalive code, I suspect we may see build
> problems for people in case 2 on some systems, with or without my patch.
> I think this patch is a strict improvement, though; if they have a new
> enough curl, they will not even look at the case 2 code. And if they do
> not, our previous options were:
> 
>   a. Add platform-specific code for them.
>   
>   b. Tell them they are out of luck, and add an #ifdef to push them into
>      case 3.

Case 2 works fine on my Debian Squeeze system.

> Now we have an extra option:
> 
>   c. Tell them to upgrade curl. :)

Yes, I keep forgetting I still have a Debian Squeeze machine :x
