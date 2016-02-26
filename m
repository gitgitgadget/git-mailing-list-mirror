From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] upload-pack: use argv_array for pack_objects
Date: Thu, 25 Feb 2016 21:14:01 -0500
Message-ID: <CAPig+cRSKFsO+ygnQGxj+HjO+9Y_7YdubvqscNH7X1A6gM8OtQ@mail.gmail.com>
References: <1456402406-13617-1-git-send-email-michael@procter.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Michael Procter <michael@procter.org.uk>
X-From: git-owner@vger.kernel.org Fri Feb 26 03:14:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ7uy-0003sF-Pj
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 03:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826AbcBZCOE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 21:14:04 -0500
Received: from mail-vk0-f44.google.com ([209.85.213.44]:33686 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbcBZCOD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 21:14:03 -0500
Received: by mail-vk0-f44.google.com with SMTP id k196so66070419vka.0
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 18:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=EXBZ8BzfYXW6GUc66OActDuv9wzeR5hMnGkN4U1r7Mg=;
        b=d/vqcExcpPHLYWXmXMUUDCILM5xZTM6dSg2YGg7JvtRPcm/L2WzttYOHIYFYspL9Cs
         AVJax4cUo0qnuFkpnA/Bz/zReuh7TL1/SdBnIETE+OhGGW30PgMThBadr8h+jr5eewrR
         pIuZWSf837ydY6owiGFDdlCsNdHNwwty/ooTBHJI2J8LXdZemWKfTfCB+XFniu87rCVL
         dW9BNLkm4XmhO+480u2pDsZhDlCDi87NoLTMcZiPYO0xh8V0BiUlOWiEud2ryuSG4+WU
         nIHb6YAzZ4COCpkUWyyldpwRO48lawpjIaYG8YVZUh0z4ILW95YIuW7111S6FWh3wH5F
         9lYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=EXBZ8BzfYXW6GUc66OActDuv9wzeR5hMnGkN4U1r7Mg=;
        b=T3YNteT48c0veJ3qa6J4rGEWOQnTk/TKDQImEifHQODOaXdBQy/zi/hiEET494hhhb
         tdpP90S0ZgfcXuqd4jP/E0nW8KTtAJLlcuOkd7h02vCxwOWTplpB93ZJ01+NbW0wdYXN
         t78nhvCZTofVXtJ7axg/PQcskJuIsuvSom+JtwgXsPx5k83TiMD04KPC/XeFiHiSRKeY
         J/sGMPaVMPHrZioqCX3OUbF6sw8Ea9MWfIbLd/myMwsPoxBHlppt2yPfPsAYgluZjP4U
         kLtVTDGO52+Sj1KLlnZvHrmP4JNSx0/j8WBQ+yvQ3O4+IT8oT+t4lufMInqs5wA1rC51
         07lQ==
X-Gm-Message-State: AG10YOROZw+25QQ7kqTtEIeLpqIWZNk5fo2yDPn/6PWLuJMK7z3Ge7sRJJN9MsJXrYossGOXH6DBkn4JjEldyw==
X-Received: by 10.31.182.143 with SMTP id g137mr39029602vkf.45.1456452841375;
 Thu, 25 Feb 2016 18:14:01 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 25 Feb 2016 18:14:01 -0800 (PST)
In-Reply-To: <1456402406-13617-1-git-send-email-michael@procter.org.uk>
X-Google-Sender-Auth: NHTX5_j3uACC4fjYDmaZkKy08SI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287530>

On Thu, Feb 25, 2016 at 7:13 AM, Michael Procter <michael@procter.org.uk> wrote:
> Use the argv_array in the child_process structure, to avoid having to
> manually maintain an array size.
>
> Signed-off-by: Michael Procter <michael@procter.org.uk>
> ---
> diff --git a/upload-pack.c b/upload-pack.c
> @@ -90,35 +90,32 @@ static void create_pack_file(void)
>                 "corruption on the remote side.";
>         int buffered = -1;
>         ssize_t sz;
> -       const char *argv[13];
> -       int i, arg = 0;
> +       int i;
>         FILE *pipe_fd;
>
>         if (shallow_nr) {
> -               argv[arg++] = "--shallow-file";
> -               argv[arg++] = "";
> +               argv_array_push(&pack_objects.args, "--shallow-file");
> +               argv_array_push(&pack_objects.args, "");
>         }

Not worth a re-roll, but:

    if (shallow_nr)
        argv_array_pushv(..., "--shallow-file", "", NULL);

would have made it clearer that the two arguments are related (and
allowed you to drop the braces).

> -       argv[arg++] = "pack-objects";
> -       argv[arg++] = "--revs";
> +       argv_array_push(&pack_objects.args, "pack-objects");
> +       argv_array_push(&pack_objects.args, "--revs");
>         if (use_thin_pack)
> -               argv[arg++] = "--thin";
> +               argv_array_push(&pack_objects.args, "--thin");
>
> -       argv[arg++] = "--stdout";
> +       argv_array_push(&pack_objects.args, "--stdout");
>         if (shallow_nr)
> -               argv[arg++] = "--shallow";
> +               argv_array_push(&pack_objects.args, "--shallow");
>         if (!no_progress)
> -               argv[arg++] = "--progress";
> +               argv_array_push(&pack_objects.args, "--progress");
>         if (use_ofs_delta)
> -               argv[arg++] = "--delta-base-offset";
> +               argv_array_push(&pack_objects.args, "--delta-base-offset");
>         if (use_include_tag)
> -               argv[arg++] = "--include-tag";
> -       argv[arg++] = NULL;
> +               argv_array_push(&pack_objects.args, "--include-tag");
>
>         pack_objects.in = -1;
>         pack_objects.out = -1;
>         pack_objects.err = -1;
>         pack_objects.git_cmd = 1;
> -       pack_objects.argv = argv;
>
>         if (start_command(&pack_objects))
>                 die("git upload-pack: unable to fork git-pack-objects");
> --
> 2.7.2.368.g02f4152
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
