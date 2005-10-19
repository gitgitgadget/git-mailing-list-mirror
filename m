From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: cg-clone, tag objects and cg-push/git-push don't play nice
Date: Wed, 19 Oct 2005 22:06:52 +1300
Message-ID: <46a038f90510190206j722faefbl4fe60ed0052b7104@mail.gmail.com>
References: <46a038f90510182338k6d3d52fbyc2057e9b775d5b14@mail.gmail.com>
	 <7vzmp6dlii.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90510190110g53c90c5t419ad6065292269e@mail.gmail.com>
	 <7vbr1ldh30.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 11:08:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES9uT-0007zI-Rm
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 11:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbVJSJGy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 05:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbVJSJGy
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 05:06:54 -0400
Received: from qproxy.gmail.com ([72.14.204.195]:23278 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932464AbVJSJGx convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 05:06:53 -0400
Received: by qproxy.gmail.com with SMTP id v40so38032qbe
        for <git@vger.kernel.org>; Wed, 19 Oct 2005 02:06:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hUKowSnLABBUuyaVphWYDXqFytQnkGXd5frBxSyJMaIeGarI48KdI27+blCfnAS6pmdQ7k+t9ixDN1qVX/Vf1CL17PVrXykgxmb/LqbCJkypgfaEzfa7kVmuUPVDK03ZJc+VOIT/eYbmC5pa8ZDXdOB2xGbEAF0YEMm/1YV09dY=
Received: by 10.65.188.4 with SMTP id q4mr322582qbp;
        Wed, 19 Oct 2005 02:06:52 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Wed, 19 Oct 2005 02:06:52 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbr1ldh30.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10280>

On 10/19/05, Junio C Hamano <junkio@cox.net> wrote:
> Yeah.  But the problem is that the repository on the other end
> claims that it has everything reachable from those incomplete
> tags.

It definitely does.

> Hearing that, git-push (the real name of it is send-pack)
> decides not to send things that are already reachable from the
> refs the other end claims to have.  So if an incomplete tag
> refers to a commit that contains a blob that the remote actually
> does not have, and if that blob is part of the head you are
> pushing, send-pack would not (and should not) send that blob to
> the remote.

*shrug* it's a bit over my head, but I've figured out taht
git-fetch-pack is segfaulting. Perhaps that helps?

> Hmph.  It worries me even more.
>
> This error message:
>
>       error: unpack should have generated
>     482d4b88aa482dfea7f7549470902049a050020a, but I can't find it!
>
> comes from receive-pack that runs on the other repo (i.e. the
> one with incomplete tags you just removed), so it means
> send-pack decided it does not need to send that object --
> meaning the other end claimed it already has it.  What to send
> and what need not to be sent is determined solely based on what
> send-pack hears from receive-pack in the initial handshake,
> which is in receive-pack.c::write_head_info().  It scans
> everything under ".git/refs" directory (not just .git/refs/heads
> or .git/refs/tags; if you had ".git/refs/FOOBAR", it will cause
> the remote end to claim it has everything reachable from it --
> the only exceptions are things that starts with a dot '.', which
> is probably why cg-fetch places a temporary heads in
> refs/*/.$name-fetching) and sends them -- it does not look at
> the object directory and magically claim it has something that
> is not recorded in its .git/refs/ directory.

*Very* strange. The remote repo is packed, but is working well for
everyone else. I think we should follow the segfault and see where it
leads...

cheers,


m
