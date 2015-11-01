From: Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCHv2 8/8] clone: allow an explicit argument for parallel
 submodule clones
Date: Sun, 1 Nov 2015 03:58:38 -0500
Message-ID: <CAPig+cRLQeiHcP=fseT0r-Ata6FE-EjAzFpKdtex-_NH4WMBdQ@mail.gmail.com>
References: <xmqqfv0wp1l1.fsf@gitster.mtv.corp.google.com>
	<1446074504-6014-1-git-send-email-sbeller@google.com>
	<1446074504-6014-9-git-send-email-sbeller@google.com>
Reply-To: Eric Sunshine <sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 09:59:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsoTp-000758-9R
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 09:59:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbbKAI6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 03:58:39 -0500
Received: from mail-vk0-f50.google.com ([209.85.213.50]:35077 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbbKAI6j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 03:58:39 -0500
Received: by vkfw189 with SMTP id w189so69912073vkf.2
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 01:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=csinStzNURtRYTKzb7/Zcr+ZwHCMwaUCEDR7aU7BFWQ=;
        b=oC+0oJXvRnWeSwGiX3ydYy9XCa0P4fH1tUnE2gD3v884JCZgFMkNqzz2++pVJLj3Hy
         A+Ancc41zOvBwSgY2R3kaa3PkzYLNHNuhxZHGx1NyILKhjL0SV77cHSJsZGcD8VNev59
         n9tIcRqJqHOj5hPp9QEEQ4qCrp0LO/iWIO1f24qU5nPRJKxT9WjszTAU9p+Rh4jz7vE3
         QWDbDuH0QmU44JzpuONpSkJXwlnavpbPUTbdNZmRKladjDFiLrOgupb3b/gnmy5EaJgV
         FN7p29xp4ZpNaT97qy2hJhoCl9yVlEaeXCljqO7DwX44qNomRrdNCifZNo2TTq2C1DkX
         jLkw==
X-Received: by 10.31.163.85 with SMTP id m82mr10082964vke.19.1446368318198;
 Sun, 01 Nov 2015 01:58:38 -0700 (PDT)
Received: by 10.31.159.204 with HTTP; Sun, 1 Nov 2015 01:58:38 -0700 (PDT)
In-Reply-To: <1446074504-6014-9-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280615>

On Wed, Oct 28, 2015 at 7:21 PM, Stefan Beller <sbeller@google.com> wrote:
> Just pass it along to "git submodule update", which may pick reasonable
> defaults if you don't specify an explicit number.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> @@ -724,8 +723,20 @@ static int checkout(void)
>         err |= run_hook_le(NULL, "post-checkout", sha1_to_hex(null_sha1),
>                            sha1_to_hex(sha1), "1", NULL);
>
> -       if (!err && option_recursive)
> -               err = run_command_v_opt(argv_submodule, RUN_GIT_CMD);
> +       if (!err && option_recursive) {
> +               struct argv_array args = ARGV_ARRAY_INIT;
> +               argv_array_pushl(&args, "submodule", "update", "--init", "--recursive", NULL);
> +
> +               if (max_jobs != -1) {
> +                       struct strbuf sb = STRBUF_INIT;
> +                       strbuf_addf(&sb, "--jobs=%d", max_jobs);
> +                       argv_array_push(&args, sb.buf);
> +                       strbuf_release(&sb);

The above four lines can be collapsed to:

    argv_array_pushf(&args, "--jobs=%d", max_jobs);

> +               }
> +
> +               err = run_command_v_opt(args.argv, RUN_GIT_CMD);
> +               argv_array_clear(&args);
> +       }
>
>         return err;
>  }
