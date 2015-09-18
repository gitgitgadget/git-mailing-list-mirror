From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 53/67] drop strcpy in favor of raw sha1_to_hex
Date: Fri, 18 Sep 2015 15:24:37 -0400
Message-ID: <CAPig+cRaPu0_WdLwE_O3UddP5LEvqqB7gOkyg5ne9YkXu_JJ9w@mail.gmail.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915160605.GA29753@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 18 21:24:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zd1H2-00045f-C1
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 21:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697AbbIRTYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 15:24:40 -0400
Received: from mail-vk0-f47.google.com ([209.85.213.47]:34265 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678AbbIRTYi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 15:24:38 -0400
Received: by vkhf67 with SMTP id f67so35899963vkh.1
        for <git@vger.kernel.org>; Fri, 18 Sep 2015 12:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=fCBFdA2C8Bs3ztcdGvXLH+iJbCADGw/WWddDaK/wprY=;
        b=nl3XgvnudU+wy8cBZWMEhibMRbAzNvBUxON888YiOjj/RaCKHaAVpyT/U8ARIxUhMK
         ZTxWaNAzHNmDP7Ye9UySZPXtXVNQwgZK7Gv5mwk5RgNd8W64pTnptZCzMt0x0e1lLBMq
         3IFn6D0gMZ0LuH/3pdMbXAspa/w2jKvp21K6kEt6F4K3zPCJ3oowzM1/tv0hICAY4gwS
         vLtgRH3mK350gC7vI3zZw6nAnbJBIbU4g7ePQM4CEN8Hr9c19pAprHuT0ijWpln/NVBY
         aZGTC2JYZ+05ioir3lu51TX0FP0JFMyqi6pAF7F/4AXAJ2Kngb/Lgzh13DMu+e8INLHr
         NVZg==
X-Received: by 10.31.151.84 with SMTP id z81mr4589491vkd.14.1442604277799;
 Fri, 18 Sep 2015 12:24:37 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Fri, 18 Sep 2015 12:24:37 -0700 (PDT)
In-Reply-To: <20150915160605.GA29753@sigill.intra.peff.net>
X-Google-Sender-Auth: Nx0aNFYyqWP0i-MbOue8PCqY7wo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278219>

On Tue, Sep 15, 2015 at 12:06 PM, Jeff King <peff@peff.net> wrote:
> In some cases where we strcpy() the result of sha1_to_hex(),
> there's no need; the result goes directly into a printf
> statement, and we can simply pass the return value from
> sha1_to_hex() directly.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/http-push.c b/http-push.c
> index 43a9036..48f39b7 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -1856,7 +1856,6 @@ int main(int argc, char **argv)
>
>         new_refs = 0;
>         for (ref = remote_refs; ref; ref = ref->next) {
> -               char old_hex[60], *new_hex;
>                 struct argv_array commit_argv = ARGV_ARRAY_INIT;
>
>                 if (!ref->peer_ref)
> @@ -1911,13 +1910,12 @@ int main(int argc, char **argv)
>                 }
>                 hashcpy(ref->new_sha1, ref->peer_ref->new_sha1);
>                 new_refs++;
> -               strcpy(old_hex, sha1_to_hex(ref->old_sha1));
> -               new_hex = sha1_to_hex(ref->new_sha1);
>
>                 fprintf(stderr, "updating '%s'", ref->name);
>                 if (strcmp(ref->name, ref->peer_ref->name))
>                         fprintf(stderr, " using '%s'", ref->peer_ref->name);
> -               fprintf(stderr, "\n  from %s\n  to   %s\n", old_hex, new_hex);
> +               fprintf(stderr, "\n  from %s\n  to   %s\n",
> +                       sha1_to_hex(ref->old_sha1), sha1_to_hex(ref->new_sha1));

Would it make sense for the commit message can mention that when this
code was written originally, it was not safe to call sha1_to_hex()
twice like this within a single expression, but became safe as of
dcb3450 (sha1_to_hex() usage cleanup, 2006-05-03)?

>                 if (dry_run) {
>                         if (helper_status)
>                                 printf("ok %s\n", ref->name);
