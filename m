From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] transport-helper: report errors properly
Date: Thu, 11 Apr 2013 08:22:26 -0500
Message-ID: <CAMP44s02K5ydKLNi0umMkuAicoVTWyCdVfjs0yssCa2oyFShGQ@mail.gmail.com>
References: <20130410211311.GA24277@sigill.intra.peff.net>
	<20130410211552.GA3256@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 11 15:22:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQHST-0003mu-3m
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 15:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932861Ab3DKNW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 09:22:29 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:48850 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471Ab3DKNW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 09:22:28 -0400
Received: by mail-la0-f53.google.com with SMTP id fp13so1478262lab.12
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 06:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=OzqM5Fo9qjBfKgNmQIhCtz+GCKrN1JwW1PKv7mPeUyg=;
        b=E1+w0qBd0ITtUbKDnpWAFII4E4NDsWg+Vhid8cYeInNeyzDQxgSrjnnRIwwh+JbmVy
         SQXbcLDi4AmcmZBdWyua1pJpSyKhwQ02fi9/CnIiDsWSo529wThtnonjljHwTp5ydPNe
         /Xs4j5qZdxdeM7dOO+kdOBSXgX1PhwCPF1YpF5YgAvPghQXlyVPdSBeTG0jW0K/eWeNs
         Jnx18usiKStJjrMFujM4/Fv5MIzXUlPvFz0U76f5jvGvA8vZeHxW5qQArp1W8K6+zs5v
         80pjg+7Vv8Q6APCJVTlZnt+HHnT0Rbv9/fKSfOaF733ylBEpBrk6VYp9ExKCNxjU/1VW
         l73g==
X-Received: by 10.112.133.198 with SMTP id pe6mr3274528lbb.103.1365686546310;
 Thu, 11 Apr 2013 06:22:26 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Thu, 11 Apr 2013 06:22:26 -0700 (PDT)
In-Reply-To: <20130410211552.GA3256@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220877>

On Wed, Apr 10, 2013 at 4:15 PM, Jeff King <peff@peff.net> wrote:
> From: Felipe Contreras <felipe.contreras@gmail.com>
>
> If a push fails because the remote-helper died (with
> fast-export), the user does not see any error message. We do
> correctly die with a failed exit code, as we notice that the
> helper has died while reading back the ref status from the
> helper. However, we don't print any message.  This is OK if
> the helper itself printed a useful error message, but we
> cannot count on that; let's let the user know that the
> helper failed.

This explained the same thing:
> If a push fails because the remote-helper died (with fast-export), the user won't see any error message. So let's add one.

Granted, depending on the way the remote-helper died, an error might
or might not been printed, so s/won't/might not/.

The fact that an exit code was returned before is not relevant,
neither is how the exit was returned, and for that matter neither is
all the other things that are happening in this code. It's just noise.

The only thing that is relevant is this:

-               exit(128);
+               die("Reading from remote helper failed");

It's a simple change, and simple to explain.

> In the long run, it may make more sense to propagate the
> error back up to push, so that it can present the usual
> status table and give a nicer message. But this is a much
> simpler fix that can help immediately.

Yes it might, and it might make sense to rewrite much of this code,
but that's not relevant.

> While we're adding tests, let's also confirm that the
> remote-helper dying is also detect when importing refs.

That is enough explanation.

> We
> currently do so robustly when the helper uses the "done"
> feature (and that is what we test).  We cannot do so
> reliably when the helper does not use the "done" feature,
> but it is not even worth testing; the right solution is for
> the helper to start using "done".

This doesn't help anyone, and it's not even accurate. I think it might
be possible enforce remote-helpers to implement the "done" feature,
and we might want to do that later. But of course, discussing what bad
things remote-helpers could do, and how we should test and babysit
them is not relevant here.

If it was important to explain the subtleties and reasoning behind
this change, it should be a separate patch.

> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>

I would add:

[jk: rewrote every piece of text]

>         export)
> +               if test -n "$GIT_REMOTE_TESTGIT_FAILURE"
> +               then
> +                       # consume input so fast-export doesn't get SIGPIPE;

I think this is explanation enough.

> +                       # git would also notice that case, but we want
> +                       # to make sure we are exercising the later
> +                       # error checks

I don't understand what is being said here. What is "that case"?

> +                       while read line; do
> +                               test "done" = "$line" && break
> +                       done
> +                       exit

LGTM.

Cheers.

--
Felipe Contreras
