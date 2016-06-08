From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/5] attr.c: add push_stack() helper
Date: Wed, 8 Jun 2016 16:43:44 -0700
Message-ID: <CAGZ79ka+BXOAMr7JxJXmhsmXTwTcdidJ72=9mbCkHiycj-t6AQ@mail.gmail.com>
References: <20160608225818.726-1-gitster@pobox.com> <20160608225818.726-2-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 01:43:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAn8Y-0007uu-9m
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jun 2016 01:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753595AbcFHXnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 19:43:46 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:36298 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753302AbcFHXnp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 19:43:45 -0400
Received: by mail-qg0-f48.google.com with SMTP id q32so12505539qgq.3
        for <git@vger.kernel.org>; Wed, 08 Jun 2016 16:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gqSKYtZL5iHeOSJiY6xtbKWyPxbvMHndrkEIFGtSZQo=;
        b=MrtK9BE2Nc3S/RIR4X0N7lmkdqJNTY7J/bKi831vXFhc5s/plZRr9hG3AkcGQsSqBx
         EJshUmR6Qe8S6Tm+K83Zjk35PBp0FAVT/hYDhuQzvSt4PhVt+8bVQOaYgNr5CQOG06Sw
         pk9WPfslbL131Jq9rKnEHlGmF0RoEA+8E08Qo33AubjBYe1ea4AlpY1ufuPsBNBW9vhy
         WkD/rDMML/VYMDmiuwxPHnX67zrTrP9CdYfteGHbIFNW7PEH2pQyXpKRzxcnRrQwaZyT
         P8e8DyePqKvU/zEANEox8epRE8uughHxiGT4zN8bieNE7noulYeR2c9b/INRjs0tXaOl
         xl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gqSKYtZL5iHeOSJiY6xtbKWyPxbvMHndrkEIFGtSZQo=;
        b=YmU7Daysq2HYxkj31G9S6DJstS41KAzWcy1jVp/XUb3qZ+6IrOt9115xUgB7azyhrl
         5KVY/M0fZlN0dyFDE5uVOpwmNhR6Brwh0ZoyPs6+Sec0ym03HEBHUD3iLZNgwQjYiAiJ
         s1DBDRuGDprsZJ7YO2tM8PrxUo5zpQkgiABHcZ5/zQwFvJm82l1Pb3nuihHVXGM6dDbk
         xsBU8rkaNM9yskgDoXUFqVfVT30NuphC6wHA0cfqn2ky7MbeXs2R9l+gTGJciaJ6VxNt
         3lgoqpde3Dvf9xqt3/d4d6gpTl5n6y8WFENtlu9UTOuH5N5ATHKyQgbLzTPflfokDfyA
         i1bg==
X-Gm-Message-State: ALyK8tLtv/puLSUocta5s0Qfgdfpyv09lXRFTdLrBrhz23UTFyO/QJf5RKPbnrcjIpSvW/nppfLXBGxMXpqgeTkK
X-Received: by 10.140.221.135 with SMTP id r129mr7259578qhb.59.1465429424564;
 Wed, 08 Jun 2016 16:43:44 -0700 (PDT)
Received: by 10.237.42.226 with HTTP; Wed, 8 Jun 2016 16:43:44 -0700 (PDT)
In-Reply-To: <20160608225818.726-2-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296859>

On Wed, Jun 8, 2016 at 3:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> +static void push_stack(struct attr_stack **attr_stack_p,
> +                      struct attr_stack *elem, char *origin, size_t originlen)
> +{
> +       if (elem) {
> +               elem->origin = origin;
> +               if (origin)
> +                       elem->originlen = originlen;

Why do we need to be conditional on origin for setting the originlen,
in all occurrences below, we pass in a reasonable number (0),
so I would leave out the condition here.

We make use of the `originlen` in `fill` only, so maybe we can
even get rid of the length and when we need it compute
it with strlen? (I am unsure on this tradeoff)


>
>         if (!is_bare_repository() || direction == GIT_ATTR_INDEX) {
>                 elem = read_attr(GITATTRIBUTES_FILE, 1);
> -               elem->origin = xstrdup("");
> -               elem->originlen = 0;
> -               elem->prev = attr_stack;
> -               attr_stack = elem;
> +               push_stack(&attr_stack, elem, xstrdup(""), 0);

I wonder why we need to pass an empty-but-not-null string here?
In `fill` we use

  const char *base = stk->origin ? stk->origin : "";

so there it would be the same. In prepare_stack we have
       /*
        * Pop the ones from directories that are not the prefix of
        * the path we are checking. Break out of the loop when we see
        * the root one (whose origin is an empty string "") or the builtin
        * one (whose origin is NULL) without popping it.
        */
        while (attr_stack->origin) {

which seems to answer my question  that we make a difference between
empty and null `origin`. However I wonder if that could be made more clear?
(By a well named bit flag in the attr_stack?)

> -                       strbuf_add(&pathbuf, path, cp - path);
> -                       strbuf_addch(&pathbuf, '/');
> -                       strbuf_addstr(&pathbuf, GITATTRIBUTES_FILE);
> +                       strbuf_addf(&pathbuf,
> +                                   "%.*s/%s", (int)(cp - path), path,

This is neat way of handling strings that are not null terminated!
I have the suspicion I could have used this before.

As this is meant as a refactoring patch, which doesn't want to change
semantics, it looks good to me, the questions are rather meant for followups.

Thanks,
Stefan
