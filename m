From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 5/4] run-command: implement abort_async for pthreads
Date: Fri, 1 Apr 2011 11:41:12 +0200
Message-ID: <AANLkTikF_xLTdY0BgaXmUXvBJTG3HD3by9zN59KwPii5@mail.gmail.com>
References: <20110331184243.GA12027@sigill.intra.peff.net> <20110331184546.GA16981@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 01 11:41:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5arL-0000xh-Mj
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 11:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755284Ab1DAJle convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Apr 2011 05:41:34 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35414 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114Ab1DAJld convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Apr 2011 05:41:33 -0400
Received: by fxm17 with SMTP id 17so2472542fxm.19
        for <git@vger.kernel.org>; Fri, 01 Apr 2011 02:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Z9Mf9rN6j87Cv7QBqlC6HLAmid9LeIfVT+evbr8vzjU=;
        b=PLDmZn7pt+7QqGjYlcOUIj5t3syXv5XnQn7Wr+Sm8pdU3GT+hgAVXYxn96tw2Ondw0
         AKLYLy3TFPuLQ4A4T9M7PpCugqRa6QqqRrr8dcAeBvVF5fm1ml3joZVEhUN3sJ1L70Ce
         4hF6p7+yCYkBx9CQuJr64h12lNWYHYzoDc1DA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=f8w8Z1CSXG3pdEC0vBkMtDC+JFoysYh4jP+IVNROgMdKpnOmRNAPIgb3/Bons928VN
         Sd2ao8ET6BuHSDqvo9EkFok+RrEY9YhRJ8nAZ3zKDEeavKJaNC71lAvDH+lxumh3rFx7
         Ipo+dtNHpgteHPMBqOXk7GoMsv2HgWTgVfN4w=
Received: by 10.223.42.89 with SMTP id r25mr2636407fae.89.1301650892295; Fri,
 01 Apr 2011 02:41:32 -0700 (PDT)
Received: by 10.223.126.145 with HTTP; Fri, 1 Apr 2011 02:41:12 -0700 (PDT)
In-Reply-To: <20110331184546.GA16981@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170576>

On Thu, Mar 31, 2011 at 8:45 PM, Jeff King <peff@peff.net> wrote:
> We just need to cancel the thread, instead of sending it a
> signal as we do for fork()'d async sections.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This could also just be part of the merge resolution, but I thought i=
t
> would be easier to see what is going on if I put it here.
>
> =A0run-command.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/run-command.c b/run-command.c
> index e31c073..46ea07d 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -607,7 +607,7 @@ void abort_async(struct async *async)
> =A0#ifdef NO_PTHREADS

This context-line doesn't match 3/4... Did you send out the wrong
version of that patch?

> =A0 =A0 =A0 =A0kill(async->pid, 15);
> =A0#else
> - =A0 =A0 =A0 /* no clue */
> + =A0 =A0 =A0 pthread_cancel(async->tid);

My worry about terminating a thread that's currently holding a mutex
(implicitly through the CRT?) still applies though...
