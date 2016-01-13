From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] submodule: Port resolve_relative_url from shell to C
Date: Wed, 13 Jan 2016 17:03:27 -0500
Message-ID: <CAPig+cTpghLgRdCCHu6CdM0v4TzytsOFFuE5p9=Z0myZ7+5xLQ@mail.gmail.com>
References: <1452708927-9401-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	Jens Lehmann <jens.lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 23:03:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJTVt-0008QZ-BJ
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 23:03:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754640AbcAMWD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 17:03:29 -0500
Received: from mail-vk0-f44.google.com ([209.85.213.44]:35814 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752989AbcAMWD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 17:03:27 -0500
Received: by mail-vk0-f44.google.com with SMTP id k1so269720995vkb.2
        for <git@vger.kernel.org>; Wed, 13 Jan 2016 14:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=vYL35yTYSNA1a8GOVaS3eWm8Nsi4NHBaW6udWlFLkEs=;
        b=K0gLhEs3PSMPTZB+mDx4O83VClZhoU80n2WFGb5T0Ai6U2treWgljQwlAnQwE5mjOv
         9+Pt+37+Vv+32KWItdoA7BK/1E9a9B/uGF4dUI4ge6YjXFRKEI5/QrbhebUtYQcwhSH6
         twkElqeOaEOTEkAhROQBCQgi2yJ1rblxQEb7Vdg8z7acOVj7zaNcXzPAlEV4Rnl0TI/4
         z3nkJBUk61gITt+kQzulbXdzx33uTYn0xREIrFzu0eVPblVB+pODDQDMpDvaztlc9b1C
         mImWh7aEY0PFVwWJ+QMPGTbISE8DyyPdwnLPWvT4FTs9MC9/QObBCuYGCK45bmGpmoRm
         2qVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=vYL35yTYSNA1a8GOVaS3eWm8Nsi4NHBaW6udWlFLkEs=;
        b=BOVwV3KnwRBN5lAG4cmyD/3nEx3NfzEJr71ZKPh/r6xaXQ054pnPBl2diQ+GKXZ9BS
         upfLpCs4BdQNFGrizxeUjoy1q73fFL9gKWvyFsqvVR0MHdsLuGHYACr3/rTHZ6+ekBVV
         xwMVPkwRYjteuaVV4sF+NyG+nXhi99ttFL5HkJG5SNRKJMEzztunKXC6cNQtyr5Fqmx3
         2F4Tmg1BOU18GpAfMkHcok5dg8I2E1DMtndDcF4+PQfyfpNrL0gdTYSXXNS5Hu+M8XzA
         IXLbFvwd3ov9sPLHVofqAyylEl7VkuaqfXjziqgRB6Xy2mG44WW0dV1VBXv5byL8Jie5
         L4xw==
X-Gm-Message-State: ALoCoQlAkH+Wd2WrRMDUgn6TcE+DcQruYrvWbu9rGhi5md6QG4MMdPkra6yf8BZM44HeA7AJ/3FEukTH7g0p9+Il4rpr3L143w==
X-Received: by 10.31.58.74 with SMTP id h71mr340912vka.151.1452722607103; Wed,
 13 Jan 2016 14:03:27 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Wed, 13 Jan 2016 14:03:27 -0800 (PST)
In-Reply-To: <1452708927-9401-1-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: lZO-qqtr2BHRGtP_K3Ji5XBgZ4U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283991>

On Wed, Jan 13, 2016 at 1:15 PM, Stefan Beller <sbeller@google.com> wrote:
> Later on we want to deprecate the `git submodule init` command and make
> it implicit in other submodule commands. As these other commands are
> written in C already, we'd need the init functionality in C, too.
> The `resolve_relative_url` function is a rather large part of that init
> functionality, so start by porting this function to C.
>
> As I was porting the functionality I noticed some odds with the inputs.
> To fully understand the situation I added some logging to the function
> temporarily to capture all calls to the function throughout the test
> suite. Duplicates have been removed and all unique testing inputs have
> been recorded into t0060.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

No time presently for a proper review, so just a few superficial comments...

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> @@ -9,6 +9,193 @@
> +static int resolve_relative_url(int argc, const char **argv, const char *prefix)
> +{
> +       char *remoteurl = NULL;
> +       char *remote = get_default_remote();
> +       const char *up_path = NULL;
> +       char *res;
> +       const char *url;
> +       struct strbuf sb = STRBUF_INIT;
> +
> +       if (argc != 2 && argc != 3)
> +               die("BUG: resolve_relative_url only accepts one or two arguments");

This is diagnosing incorrect arguments, so:
s/resolve_relative_url/resolve-relative-url/

Also, I'm not convinced that this deserves a "BUG:" prefix, as this is
now a user-accessible command (even though it's plumbing).

> +       url = argv[1];
> +       strbuf_addf(&sb, "remote.%s.url", remote);
> +       free(remote);
> +
> +       if (git_config_get_string(sb.buf, &remoteurl))
> +               /* the repository is its own authoritative upstream */
> +               remoteurl = xgetcwd();
> +
> +       if (argc == 3)
> +               up_path = argv[2];
> +
> +       res = relative_url(remoteurl, url, up_path);
> +       printf("%s\n", res);
> +
> +       free(res);
> +       return 0;
> +}
> +
> +static int resolve_relative_url_test(int argc, const char **argv, const char *prefix)
> +{
> +       char *remoteurl, *res;
> +       const char *up_path, *url;
> +
> +       if (argc != 4)
> +               die("BUG: resolve_relative_url only accepts three arguments: <up_path> <remoteurl> <url>");

s/resolve_relative_url/resolve-relative-url/

Ditto observation about "BUG:" prefix.

> +       up_path = argv[1];
> +       remoteurl = xstrdup(argv[2]);
> +       url = argv[3];
> +
> +       if (!strcmp(up_path, "(null)"))
> +               up_path = NULL;
> +
> +       res = relative_url(remoteurl, url, up_path);
> +       printf("%s\n", res);

This could be:

     puts(res);

though I don't care strongly.

> +       free(res);
> +       return 0;
> +}
