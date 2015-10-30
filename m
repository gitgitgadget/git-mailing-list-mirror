From: Noam Postavsky <npostavs@users.sourceforge.net>
Subject: Re: git-credential-cache--daemon quits on SIGHUP, can we change it to
 ignore instead?
Date: Thu, 29 Oct 2015 21:20:01 -0400
Message-ID: <CAM-tV-8qSVJFOxLQt9SaYK_WqpxixzPArJnAK=3tHU9inM9Law@mail.gmail.com>
References: <xmqqfv18awj4.fsf@gitster.mtv.corp.google.com>
	<CAM-tV-8VXtB5uRgqP9dFpww6AaLzasPV46tCiquz=nz=ksBNng@mail.gmail.com>
	<CAM-tV-9sNgHncsWRPh36tEY3YFORUJBA-Q6W5R=mvX_KhSmWEQ@mail.gmail.com>
	<xmqqfv0ylwa7.fsf@gitster.mtv.corp.google.com>
	<20151026215016.GA17419@sigill.intra.peff.net>
	<xmqqoafkci6j.fsf@gitster.mtv.corp.google.com>
	<20151027184702.GB12717@sigill.intra.peff.net>
	<CAM-tV--B3HaC1DcORfnx9bWW9-quyk0=pQDxmvonc=6dgrMOxA@mail.gmail.com>
	<20151030001000.GA2123@sigill.intra.peff.net>
	<CAM-tV-_dc_YEE0Dh2T=8+_DcBiq_rvynOw2cFi+8QizkeGTusw@mail.gmail.com>
	<20151030005057.GA23251@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 30 02:20:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZryMT-0003G5-Rb
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 02:20:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757187AbbJ3BUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2015 21:20:04 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33386 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbbJ3BUC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2015 21:20:02 -0400
Received: by wijp11 with SMTP id p11so1269972wij.0
        for <git@vger.kernel.org>; Thu, 29 Oct 2015 18:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=RV/zDBTmmaDEd9dOCNswU+Q219Iij42cs64JhGJ+94M=;
        b=shBUKtUqXtKcfclgL5fm7S30mW7AKQ6ybKL55B9Nzv71ahGnjeXw+Cl7FfmtyTs4Re
         XsAX+sK5OBukJOAZjeA4aDDfIO4+P6+ooj89DpaA28CbUWVGLdaBQmhUMhO8W2CTDh44
         7wutOztWzHZhF9Kt3Mw0hpvvVDu4pK9qKGa31tSAEQyz8WCPKB9etyJehN1GEVuWISb4
         gw33Y/crLGXXExbkH9EVGfip1Ltm6nyj3Y+6joYZUGsAdI73jyXTkEWj+el4Whb6dx2G
         KvCL7iwYJwCtZ0427MYL/yfW3RGUL72caOc2efK6qoXktyCZ6iP5gCLVXKl8bd6tR0R7
         5QVg==
X-Received: by 10.194.62.112 with SMTP id x16mr6425351wjr.132.1446168001509;
 Thu, 29 Oct 2015 18:20:01 -0700 (PDT)
Received: by 10.28.29.87 with HTTP; Thu, 29 Oct 2015 18:20:01 -0700 (PDT)
In-Reply-To: <20151030005057.GA23251@sigill.intra.peff.net>
X-Google-Sender-Auth: nlrTEUjU3na30hlQklUd38KhT2c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280470>

On Thu, Oct 29, 2015 at 8:50 PM, Jeff King <peff@peff.net> wrote:
> workaround (the real inelegance is that you are assuming that "foo"
> needs run in the first place).

Well, we currently check the output from "git config
credential.helpers" to determine what's needed, so the inelegance here
is that we reimplement git's checking of this option.

> I'm still not sure how the pre-helper would work. What git command kicks
> off the pre-helper command? Wouldn't it also be subject to the SIGHUP
> problem?

Ah, maybe the missing piece I forgot to mention is that we could make
our pre/1st-helper be an emacsclient command, which would tell Emacs
to startup the daemon. So the daemon would be a subprocess of Emacs,
not "git push", thereby avoiding the SIGHUP. In our current workaround
we startup the daemon (if it's not running) before git commands that
we think are going to run credential helpers (i.e. "push", "pull",
"fetch"), hence my thought that it would be nicer if we only did that
before git is *actually* going to run the helpers.
