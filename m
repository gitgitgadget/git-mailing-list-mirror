From: Noam Postavsky <npostavs@users.sourceforge.net>
Subject: Re: git-credential-cache--daemon quits on SIGHUP, can we change it to
 ignore instead?
Date: Mon, 26 Oct 2015 20:50:10 -0400
Message-ID: <CAM-tV--80xt_Ro_vQdgRmRxfy+2k2Ca13gVsjDHK+1pdsB_hqQ@mail.gmail.com>
References: <CAM-tV-_JPazYxeDYogtQTRfBxONpSZwb3u5pPanB=F9XnLnZyg@mail.gmail.com>
	<CAM-tV-_eOgnhqsTFN6kKW=tcS7gAPYaxskBaxnJZo3bsx02HZg@mail.gmail.com>
	<xmqqfv18awj4.fsf@gitster.mtv.corp.google.com>
	<CAM-tV-8VXtB5uRgqP9dFpww6AaLzasPV46tCiquz=nz=ksBNng@mail.gmail.com>
	<CAM-tV-9sNgHncsWRPh36tEY3YFORUJBA-Q6W5R=mvX_KhSmWEQ@mail.gmail.com>
	<xmqqfv0ylwa7.fsf@gitster.mtv.corp.google.com>
	<20151026215016.GA17419@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 27 01:50:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqsSx-0007ti-TJ
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 01:50:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307AbbJ0AuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 20:50:13 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:32826 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013AbbJ0AuL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 20:50:11 -0400
Received: by wijp11 with SMTP id p11so190793633wij.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2015 17:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=HJtsEBL3xiDJXQumjNq8omlcXW4ghWmBsHcOTC7e5iI=;
        b=PCaL79hzw67jFNWm3O/FCiS2LvzXngebLSbVTffnKszRDOhu3TrEhXrTKCMAheS2nQ
         cUENISOq2JpxrQdW0zQGiidhx+pNSJqlNd/39R6sXQ7aNWr8QWF4s273n49MCodqorVK
         BnhbCZNrpvJKE1xoZw83pNjNrvsxkan0UguAbw4p/zkbVqYB9XoRmYW77+d3UnXFVhUP
         eMrneh4oDjN9Se+HOMp6Z6RVo9XFfX/BT8wT0CL/q2Om6vuyOVv9GRgEI1I5FSA887zT
         PzH2pKrHTXh8gs7ZquH+dIOr1VAqQJbh+69aHPFiT51cvkZrSLtk5WxULhfFmcW36A1Z
         D0iw==
X-Received: by 10.180.24.1 with SMTP id q1mr25130977wif.53.1445907010448; Mon,
 26 Oct 2015 17:50:10 -0700 (PDT)
Received: by 10.28.29.87 with HTTP; Mon, 26 Oct 2015 17:50:10 -0700 (PDT)
In-Reply-To: <20151026215016.GA17419@sigill.intra.peff.net>
X-Google-Sender-Auth: zzPU2hv8yFeUF2oSH2B7SPiqCtM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280237>

On Mon, Oct 26, 2015 at 5:50 PM, Jeff King wrote:
> But these days, people often have several simultaneous sessions open.
> They may have multiple ssh sessions to a single machine, or they may
> have a bunch of terminal windows open, each of which has a login shell
> and will send HUP to its children when it exits.

Yes, except that as far as I can tell the shell never sends HUP.

> This is all further complicated by bash's huponexit option, which I
> think is off by default. So I, for example, have never noticed this
> behavior even with multiple xterms, because my cache never actually gets
> SIGHUP.

Interesting, I was not aware of this option. I tried enabling it, but
I see no difference, the daemon still receives no SIGHUP. Could it be
a bug in my version of bash?

GNU bash, version 4.3.42(1)-release (x86_64-pc-linux-gnu)

Ah, it seems I'm not the only one: (Raphael Ahrens at
http://unix.stackexchange.com/a/85296/47926)

    Bash seems to send the SIGHUP only if it self received a SIGHUP[...]
    So if you type exit or press Ctrl+D all background process will
remain, since this does not send a hang up signal to the Bash.
    [...]
    There is an option to send the SIGHUP on exit, but it does not
work on my Bash 4.2.25. Maybe it works for you

> I don't know what shell Noam is using, but I wonder if tweaking
> that option (or a similar one if not bash) might be helpful to signal
> "let this stuff keep running even after I exit".

My normal login shell is zsh, but I've been testing with bash and I
see the same behaviour with both. But the original reason for this
whole thread is that when running from Emacs (not via shell), the
daemon *always* get a SIGHUP as soon as "git push" finishes, which
makes the caching thing not so useful. We do have a workaround for
this by now though (start the daemon independently before calling "git
push").
