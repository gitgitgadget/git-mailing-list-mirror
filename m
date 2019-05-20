Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDB061F461
	for <e@80x24.org>; Mon, 20 May 2019 11:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732549AbfETL2W (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 07:28:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46835 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732468AbfETL2W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 07:28:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id r7so14128641wrr.13
        for <git@vger.kernel.org>; Mon, 20 May 2019 04:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xTk/kk/k8oLK/KIGNrCpBgib/GgDn2VEqZEu42ls5R8=;
        b=MGh8waiyz02fpI5z26EkoT6WU7pejtFRek8CHyehhztpWzigZn2vAzVlSIK4GrWhp1
         WWQdqLQtg0AvEjWpLH/8b8g5tKNsLzrzvM1qyzxkKCzcRKOXUe3DkBTcQAPB6i2zmB9x
         cJVgJJnR1fEF4pJxMwo5YbAT6uYxjnZZrx+EQfcMqRyA8IqHkbkYb3qL7u4qWaeY+fy8
         l/k68haOWzXHhUSv8dIh4e/rzc/s7ANWl/vunKczKByTr9H6lpijIwnxY+Zc/U5mk0iO
         TgDhSBiztZXF1xPiIZy1r1WnvsZmQl47o35ApKUrzvx43WQkvyCe19bnI6Kyd99RimmA
         CVMw==
X-Gm-Message-State: APjAAAXeNYIVEiEP/RZeyfGcEBhmtWAjkRFsJEeTY8KjmLxptIEao4YX
        2vQ+Ys1mA6zqxOKr3v5c6H7ACOmJLB+c+2dHvIA=
X-Google-Smtp-Source: APXvYqyIKF1FzVsAzhE5BkxhgE334jtNucwQM+9V6ZxSvIlBJovojFqHPVBcZuLWxVMaL43sQQWpi97jQ26YOEn5bWE=
X-Received: by 2002:adf:e902:: with SMTP id f2mr45270847wrm.301.1558351700541;
 Mon, 20 May 2019 04:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190519050724.GA26179@sigill.intra.peff.net> <20190519051604.GC19434@sigill.intra.peff.net>
In-Reply-To: <20190519051604.GC19434@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 20 May 2019 07:28:08 -0400
Message-ID: <CAPig+cTkjJjuyrDOUh92B16an+wy9OnZgyKY0-bihWnzyWsoKg@mail.gmail.com>
Subject: Re: [PATCH 3/3] clone: auto-enable git-credential-store when necessary
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Martin Langhoff <martin.langhoff@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 19, 2019 at 2:42 PM Jeff King <peff@peff.net> wrote:
> If the user clones with a URL containing a password and has no
> credential helper configured, we're stuck. We don't want to write the
> password into .git/config because that risks accidentally disclosing it.
> But if we don't record it somewhere, subsequent fetches will fail unless
> the user is there to input the password.
>
> But we can actually go a step further and enable the "store" helper for
> them. [...]
>
> The biggest downside is that it's a bit magical from the user's
> perspective, because now the password is off in some other file (usually
> ~/.git-credentials, but sometimes in $XDG_CONFIG_HOME). Which
> complicates things if they want to purge the repo and password, for
> example, because now they can't just delete the repository directory.
>
> The file location is documented, though, and we point people to the
> documentation. So perhaps it will be enough (and better still, may lead
> to them configuring a more secure helper).

I'm trying to decide how I feel about this based upon my own
experience recently of having my password magically stored by Git for
Windows without warning or consent on a computer which was not my own
but on which I needed to access a private GitHub repository. Although
the situation is not perfectly analogous, the concern of having one's
password magically squirreled-away _somewhere_ unexpectedly is the
same. Being unfamiliar with Git for Windows's credential helper or
Windows credential management in general, I experienced more than a
few minutes of consternation and alarm before finally figuring out
where Git for Windows had stored my password and how to remove it. The
sense of alarm and discomfort likely would have not arisen had the
credential helper given me the opportunity to approve or deny the
action.

>  static const char sanitized_url_advice[] = N_(
>  "The URL you provided to Git contains a password. It will be\n"
>  "used to clone the repository, but to avoid accidental disclosure\n"
> +"the password will not be recorded in the repository config.\n"
> +"Since you have no credential helper configured, the \"store\" helper\n"
> +"has been enabled for this repository, and will provide the password\n"
> +"for further fetches.\n"
> +"\n"
> +"Note that the password is still stored in plaintext in the filesystem;\n"
> +"consider configuring a more secure helper. See \"git help gitcredentials\"\n"
> +"and \"git help git-credential-store\" for details.\n"
>  );

Give the above experience, one way to mitigate such feelings of alarm
might, at a minimum, be for this message to say where the password is
being stored (and, possibly, how to remove it) so the user can do so
immediately if desired. Prompting the user to approve or deny the
action might also go a long way toward making this more palatable
(assuming the session is interactive).
