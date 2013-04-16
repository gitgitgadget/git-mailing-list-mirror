From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 1/3] usage: refactor die-recursion checks
Date: Mon, 15 Apr 2013 17:11:36 -0700
Message-ID: <CA+sFfMes99EepY4FCW32s1L3ywv_gyFb76=Y=35rvPbc2K1BWA@mail.gmail.com>
References: <20130415230651.GA16670@sigill.intra.peff.net>
	<20130415230802.GA11267@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 16 02:11:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URtUs-0005Ez-L5
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 02:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934975Ab3DPALi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 20:11:38 -0400
Received: from mail-we0-f181.google.com ([74.125.82.181]:59233 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933533Ab3DPALh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 20:11:37 -0400
Received: by mail-we0-f181.google.com with SMTP id r6so2398773wey.40
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 17:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=4FVfh5hp28FijboEsWzERPjl3YeDabaXyFbO/rMHH5w=;
        b=E02Kexs333ZCa1uoETpPTGmpB/gznEv4Jh6QbfcpMkbUQfmFsbqo7a99SeZSjlaEE+
         wpWOevUEUlXobZTT35MmpjSSSBa5mJGBGf+l4zWdjqt9l+7d9Ln5FK49vYrn4Aq7Zy1L
         NTdg+fc+klQPLFUdlrkSHQchRiSIBTr5kv2LG/aAiRR8Fp4Ore+1gfCKImqpU7JuqK+A
         e5csC7qFBVR3YMt3IVzZqD5nnb3dTJNqRQ8SLvTiSQwJgXhX7UU72MwkdSk9YqlwTzfl
         KBQn5wHty2P73eoJFfUnNNCjBqnXzNbYCY4JrEBnzoQqaEqYYEQUknrhrIMbvvSKgNfY
         YFzQ==
X-Received: by 10.180.24.65 with SMTP id s1mr88625wif.0.1366071096207; Mon, 15
 Apr 2013 17:11:36 -0700 (PDT)
Received: by 10.194.249.69 with HTTP; Mon, 15 Apr 2013 17:11:36 -0700 (PDT)
In-Reply-To: <20130415230802.GA11267@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221335>

On Mon, Apr 15, 2013 at 4:08 PM, Jeff King <peff@peff.net> wrote:
> When any git code calls die(), we chain to a custom
> die_routine, which we expect to print a message and exit the
> program. To avoid infinite loops, we detect a recursive call
> to die() with a simple counter, and break out of the loop by
> printing a message and exiting ourselves, without chaining
> to the die_routine.
>
> But the user does not get to see the message that would have
> been fed to the die_routine, which makes debugging harder.
> The user does not know if it was a true infinite loop, or
> simply a single re-entrant call, since they cannot compare
> the messages. Furthermore, if we are wrong about detecting
> the recursion, we have blocked the user from seeing the
> original message, which is probably the more useful one.
>
> This patch teaches die() to print the original die message
> to stderr before reporting the recursion. The custom
> die_routine may or may not have put it the message to
> stderr, but this is the best we can do (it is what most
> handlers will do anyway, and it is where our recursion error
> will go).
>
> While we're at it, let's mark the "recursion detected"
> message as a "BUG:", since it should never happen in
> practice. And let's factor out the repeated code in die and
> die_errno. This loses the information of which function was
> called to cause the recursion, but it's important; knowing
> the actual message fed to the function (which we now do) is
> much more useful, as it can generally pin-point the actual
> call-site that caused the recursion.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This helped me debug the current problem. And factoring it out helps
> with patch 3. :)
>
>  usage.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/usage.c b/usage.c
> index 40b3de5..c6b7ac5 100644
> --- a/usage.c
> +++ b/usage.c

> @@ -80,17 +78,24 @@ void NORETURN die(const char *err, ...)
>         usagef("%s", err);
>  }
>
> +static void check_die_recursion(const char *fmt, va_list ap)
> +{
> +       static int dying;
> +
> +       if (!dying++)
> +               return;
> +
> +       vreportf("fatal: ", fmt, ap);

How do you know it's safe to call vreportf() ?

If the bug is in the vreportf code path, we will recurse infinitely
(at least until the stack is used up). An implementation of vsnprintf
exists in compat/snprintf.c for example.

It's nice to print out the error message here, but I think doing so
defeats the purpose of this "dying" check.  Better to get the stack
trace from a core dump.

> +       fputs("BUG: recursion detected in die handler\n", stderr);
> +       exit(128);
> +}
> +

-Brandon
