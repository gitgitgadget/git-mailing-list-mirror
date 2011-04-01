From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 3/4] run-command: allow aborting async code prematurely
Date: Fri, 1 Apr 2011 11:36:53 +0200
Message-ID: <AANLkTinAQiuYjs+pxBVKM2-aQNSDd_-CC_fMahasTB=V@mail.gmail.com>
References: <20110331184243.GA12027@sigill.intra.peff.net> <20110331184421.GC16906@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 01 11:37:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5anC-0007Rs-MB
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 11:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755391Ab1DAJhP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Apr 2011 05:37:15 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41717 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755256Ab1DAJhO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Apr 2011 05:37:14 -0400
Received: by fxm17 with SMTP id 17so2470570fxm.19
        for <git@vger.kernel.org>; Fri, 01 Apr 2011 02:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=tzKZrCZBEqiND8vKhcJYGiQZM5Vpano2QODtOIF5MIk=;
        b=StyZTebXFgWB2og7gUJ2G07D1E35AXcHhT9K6aOum5+74AkEaQhFQVhfdTIAFftexe
         yqN5Wjj3RDh5VR154tNZXG5M0op/Mh0DDej95eHckStt60CEPLIYZWGuSnGaVZJi0ydW
         YqQw+WnA7jH/r7wu8LsECdXwAKgUVxedFiDgI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=Acpkud0WS7FM7RUeOTjZvW1G7jHwDR7crdDjyjlNU2/XGIoQmo7o7OczSk0dvgew0M
         he1xJzNGzjfZ563Z3zTWM+SNi1mVwygciWmB4ZkyivOPLvdNHa9JvkAclwz3/ksoHXdE
         1qSmnxNVSL5rqGpxmy+SAi2XvMWGZXUt0n1mY=
Received: by 10.223.110.81 with SMTP id m17mr640170fap.32.1301650633084; Fri,
 01 Apr 2011 02:37:13 -0700 (PDT)
Received: by 10.223.126.145 with HTTP; Fri, 1 Apr 2011 02:36:53 -0700 (PDT)
In-Reply-To: <20110331184421.GC16906@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170575>

On Thu, Mar 31, 2011 at 8:44 PM, Jeff King <peff@peff.net> wrote:
> We provide only two abstract promitives for async code:
> start and finish. Where "finish" means to wait until the
> async code tells us it is done. However, it may also be
> useful for us to to tell the async code to abort right away,
> because whatever it was doing is no longer useful.
>
> For a separate process, we just kill() it. For Windows, we
> need to do whatever the equivalent to pthread_cancel is.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> =A0run-command.c | =A0 10 ++++++++++
> =A0run-command.h | =A0 =A01 +
> =A02 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/run-command.c b/run-command.c
> index 258c880..f179d2a 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -439,6 +439,16 @@ int finish_async(struct async *async)
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> +void abort_async(struct async *async)
> +{
> +#ifndef WIN32
> + =A0 =A0 =A0 kill(async->pid, 15);

This doesn't compile unless NO_PTHREADS is set, no?

> +#else
> + =A0 =A0 =A0 /* no clue */
> +#endif
> + =A0 =A0 =A0 finish_async(async);
> +}
> +

This should probably be

void abort_async(struct async *async)
{
#ifdef NO_PTHREADS
	kill(async->pid, 15);
#else
	pthread_cancel(async->tid)
#endif
	finish_async(async);
}

=2E.. and then us Windows-guys must implement something like pthread_ca=
ncel().

Or maybe not. Can pthread reliably cancel a thread while making sure
that thread isn't holding a mutex (like some thread-safe malloc
implementations do)? If not, I'm not entirely sure we can even reach
this goal.
