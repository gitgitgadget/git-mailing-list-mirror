From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 04/12] remote.c: provide per-branch pushremote name
Date: Sun, 3 May 2015 00:51:13 -0400
Message-ID: <CAPig+cT7pSxZahd1hmcwCW8ifZfvQ4YW6L7xXUrD7dTJt76srQ@mail.gmail.com>
References: <20150501224414.GA25551@peff.net>
	<20150501224644.GD1534@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 03 06:51:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YolsH-0007oW-RC
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 06:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbbECEvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2015 00:51:16 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:37449 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752AbbECEvO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2015 00:51:14 -0400
Received: by igblo3 with SMTP id lo3so62119724igb.0
        for <git@vger.kernel.org>; Sat, 02 May 2015 21:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=tOAk2k4/DBnZRDdmZbr5lixbEurF0LSpT70TQxgbaVk=;
        b=JpF936NjR1GFkeu4XWBXRKz6jKJFAbC8qBZUuX7vgfuGBYAAm1Im6TqmHpDs+kp2Su
         xP14T6PHP3TjTp6yNELjqCJR6k1VvCAeh2J/1lyxM+DRvyoAyD1cwkqQPg0+NGZgNxXJ
         cohKqUxOGn6yjtHhIlsHsZP3Gx1jo2nuuw1857yeThGkfKdgVnQYKnU06Q8VDtpAOVU4
         kRik4LTUGykOB5caYW5N8qsa9rMi5MiRt2R9grGCN1hIBjvumpmIwlMa4LBCs9/fyp6M
         g529LKYgga3iKQ+PMUR+y54drz4/Pqg2foTPuMH9nbeNJ1PUbV1PKcAm2HSO+G9T8GuK
         GNrA==
X-Received: by 10.42.250.70 with SMTP id mn6mr22509213icb.78.1430628673784;
 Sat, 02 May 2015 21:51:13 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Sat, 2 May 2015 21:51:13 -0700 (PDT)
In-Reply-To: <20150501224644.GD1534@peff.net>
X-Google-Sender-Auth: NGdtcPhiB0ciyERQpDvqZvrVO7s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268259>

On Fri, May 1, 2015 at 6:46 PM, Jeff King <peff@peff.net> wrote:
> When remote.c loads its config, it records the
> branch.*.pushremote for the current branch along with the
> global remote.pushDefault value, and then binds them into a
> single value: the default push for the current branch. We
> then pass this value (which may be NULL) to remote_get_1
> when looking up a remote for push.
>
> This has a few downsides:
>
>   1. It's confusing. The early-binding of the "current
>      value" led to bugs like the one fixed by 98b406f
>      (remote: handle pushremote config in any order,
>      2014-02-24). And the fact that pushremotes fall back to
>      ordinary remotes is not explicit at all; it happens
>      because remote_get_1 cannot tell the difference between
>      "we are not asking for the push remote" and "there is
>      no push remote configured".
>
>   2. It throws away intermediate data. After read_config()
>      finishes, we have no idea what the value of
>      remote.pushDefault was, because the string has been
>      overwritten by the current branch's
>      branch.*.pushremote.
>
>   3. It doesn't record other data. We don't note the
>      branch.*.pushremote value for anything but the current
>      branch.
>
> Let's make this more like the fetch-remote config. We'll
> record the pushremote for each branch, and then explicitly
> compute the correct remote for the current branch at the
> time of reading.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Versus v1, I did something a little clever by passing a function pointer
> around (versus a flag and letting the caller do a conditional based on
> the flag). Too clever?

FWIW: I found this "clever" version easy enough to follow.

However, if you push a tiny bit of the work into the callers of
remote_get_1(), then you can do away with the "cleverness" altogether,
can't you? Something like this:

    static struct remote_get_1(const char *name, int explicit)
    {
        struct remote *ret = make_remote(name, 0);
        ...
        if (explicit && valid_remote(ret))
            ...
        ...
    }

    struct remote *remote_get(const char *name)
    {
        int explicit = !!name;
        read_config();
        if (!name)
            name = remote_for_branch(current_branch, &explicit);
        return remote_get_1(name, explicit);
    }

    struct remote *pushremote_get(const char *name)
    {
        int explicit = !!name;
        read_config();
        if (!name)
            name = pushremote_for_branch(current_branch, &explicit);
        return remote_get_1(name, explicit);
    }

> diff --git a/remote.c b/remote.c
> index a27f795..9f84ea3 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -704,20 +697,31 @@ const char *remote_for_branch(struct branch *branch, int *explicit)
>         return "origin";
>  }
>
> -static struct remote *remote_get_1(const char *name, const char *pushremote_name)
> +const char *pushremote_for_branch(struct branch *branch, int *explicit)
> +{
> +       if (branch && branch->pushremote_name) {
> +               if (explicit)
> +                       *explicit = 1;
> +               return branch->pushremote_name;
> +       }
> +       if (pushremote_name) {
> +               if (explicit)
> +                       *explicit = 1;
> +               return pushremote_name;
> +       }
> +       return remote_for_branch(branch, explicit);
> +}
> +
> +static struct remote *remote_get_1(const char *name,
> +                                  const char *(*get_default)(struct branch *, int *))
>  {
>         struct remote *ret;
>         int name_given = 0;
>
>         if (name)
>                 name_given = 1;
> -       else {
> -               if (pushremote_name) {
> -                       name = pushremote_name;
> -                       name_given = 1;
> -               } else
> -                       name = remote_for_branch(current_branch, &name_given);
> -       }
> +       else
> +               name = get_default(current_branch, &name_given);
>
>         ret = make_remote(name, 0);
>         if (valid_remote_nick(name)) {
> @@ -738,13 +742,13 @@ static struct remote *remote_get_1(const char *name, const char *pushremote_name
>  struct remote *remote_get(const char *name)
>  {
>         read_config();
> -       return remote_get_1(name, NULL);
> +       return remote_get_1(name, remote_for_branch);
>  }
>
>  struct remote *pushremote_get(const char *name)
>  {
>         read_config();
> -       return remote_get_1(name, pushremote_name);
> +       return remote_get_1(name, pushremote_for_branch);
>  }
>
>  int remote_is_configured(const char *name)
