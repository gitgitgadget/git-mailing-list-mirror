Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AB801FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 20:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932719AbcFQUDV (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 16:03:21 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35050 "EHLO
	mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755570AbcFQUDT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 16:03:19 -0400
Received: by mail-it0-f65.google.com with SMTP id e5so216203ith.2
        for <git@vger.kernel.org>; Fri, 17 Jun 2016 13:03:19 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=1NSTbu0S82icxl/GgtWn9OhJV5f03eU8fCxkuJTf89o=;
        b=tJehCXZRCXF2hQxdBEI8PzTvB8TxS+yAcaWcUqgFC3gHd0hmNAU0RQLN0ODSLRMxm/
         7LVznQLUAWQI/qzwdOSQrGH1ti5mNx+NdjI2cc71yymoD2atjv6/RTVk24Yh6Ez/5lOJ
         J0W8C9WlXZu6zpYUNXGc8+wtHAo2apS/Un5K/pMhAp5LMo4uZ0O1YqA0a/CKq2wS8RQM
         e0AyW3TyHMkytW+RnL1unx30wf6UVrqfYFt3TtN13qxKf22aaSU4dfjgJ3zTMz2F3YMU
         EPmzgzf3BYPhgKt/GxWnpMKhEN8XI4LkVoj8qbmbbBPGQqfFnjeCpAAvcH7LtHDpDO4N
         0KNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=1NSTbu0S82icxl/GgtWn9OhJV5f03eU8fCxkuJTf89o=;
        b=c5e7cbI2lGkxvVJQoJKpOt0BezUi49ntCLtU2jnC6KPlfAvwDl0gWWwV/OPZpVzVCW
         MiSznZoklVE6pjLocTIpvqVKBza4RrJZwTIpuRMlLAagZLgVeuoTcIkIqDH9Y8fPVUg7
         t4XfPEMvJG6OJqIGtutIY7NjMlsxGqnxmqiwUSelhJzqUxE8mLtaV9F7dGRiXBLUsHAb
         oO5xTW/RuThL6m5ZRU8Q66+9PhIzpJnBAOLw9IecArqX/USEVIioRwZIuEehpSr6QQ48
         dRKdOppbCmgGfjer5zLW8ekIZbYY+rz7WjQE5jS6256SZqZGjqx2qhOBjSYi0VyiN9rg
         CkmQ==
X-Gm-Message-State: ALyK8tK/DyiXsKGxm6EwhAD4CARUiFgrUAdxWbvCfEsan1Egr6HQUMoGkByAHogii8qypxPh7blgID5tcrGfnA==
X-Received: by 10.36.158.70 with SMTP id p67mr530147itd.84.1466193798490; Fri,
 17 Jun 2016 13:03:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.0.30 with HTTP; Fri, 17 Jun 2016 13:03:18 -0700 (PDT)
In-Reply-To: <20160616093745.GD15851@sigill.intra.peff.net>
References: <20160616093248.GA15130@sigill.intra.peff.net> <20160616093745.GD15851@sigill.intra.peff.net>
From:	Eric Sunshine <sunshine@sunshineco.com>
Date:	Fri, 17 Jun 2016 16:03:18 -0400
X-Google-Sender-Auth: 8q7NovKM6P2eDz17883b28bmDK4
Message-ID: <CAPig+cR-Z+dpKN0dG_BG7JWRBZeo4Xtpa1HQAU1Tt3WRunsrXg@mail.gmail.com>
Subject: Re: [PATCH 4/7] run-command: add pipe_command helper
To:	Jeff King <peff@peff.net>
Cc:	Git List <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 16, 2016 at 5:37 AM, Jeff King <peff@peff.net> wrote:
> We already have capture_command(), which captures the stdout
> of a command in a way that avoids deadlocks. But sometimes
> we need to do more I/O, like capturing stderr as well, or
> sending data to stdin. It's easy to write code that
> deadlocks racily in these situations depending on how fast
> the command reads its input, or in which order it writes its
> output.
>
> Let's give callers an easy interface for doing this the
> right way, similar to what capture_command() did for the
> simple case.
>
> The whole thing is backed by a generic poll() loop that can
> feed an arbitrary number of buffers to descriptors, and fill
> an arbitrary number of strbufs from other descriptors. This
> seems like overkill, but the resulting code is actually a
> bit cleaner than just handling the three descriptors
> (because the output code for stdout/stderr is effectively
> duplicated, so being able to loop is a benefit).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/run-command.h b/run-command.h
> @@ -79,17 +79,34 @@ int run_command_v_opt(const char **argv, int opt);
>  /**
> - * Execute the given command, capturing its stdout in the given strbuf.
> + * Execute the given command, sending "in" to its stdin, and capturing its
> + * stdout and stderr in the "out" and "err" strbufs. Any of the three may
> + * be NULL to skip processing.
> + *
>   * Returns -1 if starting the command fails or reading fails, and otherwise
> - * returns the exit code of the command. The output collected in the
> - * buffer is kept even if the command returns a non-zero exit. The hint field
> - * gives a starting size for the strbuf allocation.
> + * returns the exit code of the command. Any output collected in the

Did you mean s/returns/Returns/ ?

> + * buffers is kept even if the command returns a non-zero exit. The hint fields
> + * gives starting sizes for the strbuf allocations.
>   *
>   * The fields of "cmd" should be set up as they would for a normal run_command
> - * invocation. But note that there is no need to set cmd->out; the function
> - * sets it up for the caller.
> + * invocation. But note that there is no need to set the in, out, or err
> + * fields; capture_command handles that automatically.

s/capture_command/pipe_command/

> + */
> +int pipe_command(struct child_process *cmd,
> +                const char *in, size_t in_len,
> +                struct strbuf *out, size_t out_hint,
> +                struct strbuf *err, size_t err_hint);
> +
