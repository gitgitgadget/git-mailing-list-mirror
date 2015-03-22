From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/7] strbuf: introduce strbuf_read_cmd helper
Date: Sun, 22 Mar 2015 15:36:01 -0400
Message-ID: <CAPig+cR5Ur4xOKZ6K=bOwOVM8bHHjJJXHxzCbvYBhqOTtD6dXg@mail.gmail.com>
References: <20150322095924.GA24651@peff.net>
	<20150322100724.GC11615@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Wincent Colaiuta <win@wincent.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 22 20:36:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZlfN-0007g5-MB
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 20:36:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbbCVTgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 15:36:05 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:33664 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900AbbCVTgC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 15:36:02 -0400
Received: by ykek76 with SMTP id k76so63401820yke.0
        for <git@vger.kernel.org>; Sun, 22 Mar 2015 12:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=EvhPzIIoGZiCFWjj5N4se8ROyeKi5G4V1VVFD8Qy2dQ=;
        b=vz9UtS14wNqXSJWD1iU8EMzfu9FJVEDQqQfI/LFjErH6Uc0VlBzeCM780dqAvOajQl
         bLFafBzvdUJq/GS+3GzvCxlhE0a6LWG0Wa80DKeMOtivnYsDxGkJyPEpjXVqkqV+JxZW
         LKtOZmqJQYXe4G/l+Rn5k4LuWYM5DaRC8vlgBPo1d9nRQa0WorvFl+khv1K9Efd52LXh
         OJ4vcUUAy5XLlb0q6QI6dQEC4KviSA0q3+os6wPId2AVk3gkP4ZdD7ya5LJTus3nOmd9
         u5eBOlmJi9o9tfC/7B6I4es78GPxjiAU/j6mFdCf0aa3uLt3ZL7kOQtG0Lhw7U4/n99T
         fj7w==
X-Received: by 10.236.63.6 with SMTP id z6mr92441461yhc.65.1427052961284; Sun,
 22 Mar 2015 12:36:01 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Sun, 22 Mar 2015 12:36:01 -0700 (PDT)
In-Reply-To: <20150322100724.GC11615@peff.net>
X-Google-Sender-Auth: 9FcPA8JsfLgoflTvx6bDO4-5tbk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266086>

On Sun, Mar 22, 2015 at 6:07 AM, Jeff King <peff@peff.net> wrote:
> Something as simple as reading the stdout from a command
> turns out to be rather hard to do right. Doing:
>
>   if (!run_command(&cmd))
>         strbuf_read(&buf, cmd.out, 0);
>
> can result in deadlock if the child process produces a large
> amount of output. [...]
>
> Let's introduce a strbuf helper that can make this a bit
> simpler for callers to do right.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This is really at the intersection of the strbuf and
> run-command APIs, so you could argue for it being part of
> either It is logically quite like the strbuf_read_file()
> function, so I put it there.

It does feel like a layering violation. If moved to the run-command
API, it could given one of the following names or something better:

    run_command_capture()
    capture_command()
    command_capture()
    run_command_with_output()
    capture_output()

> diff --git a/strbuf.h b/strbuf.h
> index 1883494..93a50da 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -1,6 +1,8 @@
>  #ifndef STRBUF_H
>  #define STRBUF_H
>
> +struct child_process;
> +
>  /**
>   * strbuf's are meant to be used with all the usual C string and memory
>   * APIs. Given that the length of the buffer is known, it's often better to
> @@ -373,6 +375,14 @@ extern int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint);
>  extern int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint);
>
>  /**
> + * Execute the given command, capturing its stdout in the given strbuf.
> + * Returns -1 if starting the command fails or reading fails, and otherwise
> + * returns the exit code of the command. The output collected in the
> + * buffer is kept even if the command returns a non-zero exit.
> + */
> +int strbuf_read_cmd(struct strbuf *sb, struct child_process *cmd, size_t hint);
> +
> +/**
>   * Read a line from a FILE *, overwriting the existing contents
>   * of the strbuf. The second argument specifies the line
>   * terminator character, typically `'\n'`.
> --
> 2.3.3.618.ga041503
