Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=2.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_NXDOMAIN,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,
	T_DKIM_INVALID shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: (qmail 10357 invoked by uid 107); 10 Mar 2009 12:30:14 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Tue, 10 Mar 2009 08:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592AbZCJMaF (ORCPT <rfc822;peff@peff.net>);
	Tue, 10 Mar 2009 08:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752255AbZCJMaE
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 08:30:04 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:30604 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbZCJMaB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2009 08:30:01 -0400
Received: by yw-out-2324.google.com with SMTP id 5so9047ywh.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2009 05:29:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=PYFyW+mqtQv92gkjEPqE2ktiN1l7upUWWeOKbgrXC0U=;
        b=u380lrHaLd1S2vQGhjefrnJHIKai/Pofz0wjbSOWdjXZ4drieYWfvbmIRsgXA+dJct
         AgL4ZlqN5BwZzxkP6t6ezHuLl9M1NnP758Y6JcxcMifFg4xUQPq+GQmNyjUlePEheNzx
         CN52n8jID+fPmFN+GTDahGDP8LMvVE0dP7k5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=CXx/T/BS3J54fsTi926VLxPLAUAIpGpBVjfPTmr1wBM8b6zBkLUd+yl2VFs4G5JWkP
         YGOetaaQEYuTLCwonuKumXmlPAYdddlVhyzi6jrAmNaoxtQFCzJF39QHt1nyPyg2Vtip
         kUS7bGNv7/0iVpIdjvGLMaklnSoTwVMgVA9+Q=
MIME-Version: 1.0
Received: by 10.90.90.4 with SMTP id n4mr1380102agb.22.1236688199051; Tue, 10 
	Mar 2009 05:29:59 -0700 (PDT)
In-Reply-To: <e2b19f6c7c50e5b0a652c40b0d8e4947134ed669.1236639280u.git.johannes.schindelin@gmx.de>
References: <cover.1236639280u.git.johannes.schindelin@gmx.de>
	 <e2b19f6c7c50e5b0a652c40b0d8e4947134ed669.1236639280u.git.johannes.schindelin@gmx.de>
Date:	Tue, 10 Mar 2009 08:29:58 -0400
X-Google-Sender-Auth: ab44a9bf79d3a779
Message-ID: <eaa105840903100529lc29664hd6e6fde29e06844a@mail.gmail.com>
Subject: Re: [PATCH] winansi: support ESC [ K (erase in line)
From:	Peter Harris <git@peter.is-a-geek.org>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, gitster@pobox.com,
	Johannes Sixt <j6t@kdbg.org>,
	Sebastian Schuberth <sschuberth@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Mar 9, 2009 at 8:41 PM, Johannes Schindelin wrote:
> To make use of it during a fetch, write() needs to be overridden, too.

Thanks for looking at this.

Sorry for leaving this part TODO for so long. Your version is
considerably less hacky than the version I had in my head, too.

> +int winansi_write(int fd, const void *buf, size_t len)
> +{
> +       if (isatty(fd)) {
> +               init();
> +               if (console)
> +                       return ansi_emulate((const char *)buf, len,
> +                                       fd == 2 ? stderr : stdout);
> +       }
> +       return write(fd, buf, len);
> +}

Switching an unbuffered write to a buffered fwrite makes me a little
nervous. In practice, all writes probably go through this function, so
it doesn't matter. And if the write is going somewhere it matters, it
likely fails isatty anyway. But I would still be less nervous with an
fflush() after ansi_emulate.

Peter Harris
