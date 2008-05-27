From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] lockfile: reset the correct signal
Date: Tue, 27 May 2008 09:49:03 +0200
Message-ID: <20080527074903.GA2403@localhost>
References: <20080522195546.GA29911@localhost> <7vod6wr95y.fsf@gitster.siamese.dyndns.org> <20080523221723.GA4366@localhost> <20080525182650.GA17806@localhost> <alpine.DEB.1.00.0805261031480.30431@racer> <20080526193513.GA9978@localhost> <alpine.DEB.1.00.0805262234210.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 27 09:50:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0twd-0005ek-La
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 09:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563AbYE0HtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 03:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754073AbYE0HtQ
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 03:49:16 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:8513 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754174AbYE0HtP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 03:49:15 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1527039ywe.1
        for <git@vger.kernel.org>; Tue, 27 May 2008 00:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        bh=6mvxrHj4p/wrbV9g6A0WxWjOuY2Z3/hdmfptN5fsq8o=;
        b=S6eS9TfyImCZt8gqMHRJ4PMZt/bqXJQ08XwB7kYSef46tkSBlpKJmkiu7t0z1HdQpIpnnYG+1DwdF169VRF7QxuBPHaS8h+HhLOQL/KO55fmas7hunEzjlrsspFKJ483QHl+zdZP2yWu0+pG6rQWtGzArHKrQRdOopJkIVna8+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=nZUAYrKWDVNnbCaKbhX5/YF04rlkFvK6DisdbkfvdJvmmL/ZGVgVru13CDslirop64kVv9MB5j8bBUNqfco1uZDopwbr+1c60Z9kMkD8lIywuUOtSwu8PqV9zXWyxhYGLj7HOCTc4WVOBe/rnjBPYzRwkaADEK9qJhjAhV9qLwQ=
Received: by 10.103.227.13 with SMTP id e13mr969581mur.49.1211874548705;
        Tue, 27 May 2008 00:49:08 -0700 (PDT)
Received: from darc.dyndns.org ( [84.154.95.54])
        by mx.google.com with ESMTPS id b9sm9442034mug.13.2008.05.27.00.49.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 May 2008 00:49:01 -0700 (PDT)
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1K0tvb-0001GX-GL; Tue, 27 May 2008 09:49:03 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0805262234210.30431@racer>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82985>

Hi,

On Mon, May 26, 2008 at 10:36:45PM +0100, Johannes Schindelin wrote:
> > On Mon, May 26, 2008 at 10:34:11AM +0100, Johannes Schindelin wrote:
> > > Only from the patch did I understand that you actually meant:
> > 
> > Thank you for fixing that.
> 
> Unfortunately, the original patch is already in git.git.

I will be more careful with my commit messages in the future.

> > I also realized that using signals like that can cause races. Shouldn't 
> > we use sigaction() instead of signal()?
> 
> Dunno.  The man page suggests it, but we have plenty of cases where we use 
> signal().  And I think it might be less painful to implement a 
> compat-wrapper for the platforms which differ from Linux' interpretation 
> of signal().

On the other hand, sigaction is used already in two places. What do you
think about replacing all those calls to signal/sigaction with something
like this?

void set_signal(int signo, void (*handler)(int), int sa_flags)
{
	struct sigaction sa;

	memset(&sa, 0, sizeof(sa));
	sa.sa_handler = handler;
	sa.sa_flags = sa_flags;
	sigemptyset(&sa.sa_mask);
	sigaction(signo, &sa, NULL);
}

The behavior won't change, except that handlers cannot be interrupted by
their own signal.

Clemens
