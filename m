From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] merge: Honor prepare-commit-msg return code
Date: Wed, 2 Jan 2013 20:05:26 +0100
Message-ID: <CALWbr2wCe4riywfZ6X3JhsHPvZZQJn8bkdtOakCQK+zJr-5iew@mail.gmail.com>
References: <1357152170-5511-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 02 20:05:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqTdK-0007pQ-MF
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 20:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626Ab3ABTF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 14:05:28 -0500
Received: from mail-ea0-f174.google.com ([209.85.215.174]:50247 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404Ab3ABTF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 14:05:27 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so5854279eaa.5
        for <git@vger.kernel.org>; Wed, 02 Jan 2013 11:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=TZWTL0hic3ZAxVqUZXzvbDAxYPc4ZGD8rOYchInwiTE=;
        b=cvIs5N65aOHBcmMhRQLNgA1byaQPdf7zNrMW+1Vl18H19bc/mA5hixM7s6BgUwBj8G
         0Sd6SnyfDDVTQTau57aPYzma4cpppszbYqvH24ChcsqgXRzg7tp7SaosPZr8FbpDbBGk
         sEMxjVyFy1/Yr1uEEDGJCwunp3VEdzcBKbfOwsTLOW+1T0nY3rVSHAQUdD3BFBwEXiS+
         lXD5dsl/w1EqKS7+DtJjUfmgIDBvJThRepO+gQb0dfQIYoLD1opX6pu0HeNXaq3hACUI
         ZdO+Ikng6GkWwCm4ldppU25kLEI7GZJ+5niV/uWHDqiI5Mq+fuvMyguIgo4w0EndJ0fe
         /s7g==
Received: by 10.14.208.137 with SMTP id q9mr126913278eeo.28.1357153526403;
 Wed, 02 Jan 2013 11:05:26 -0800 (PST)
Received: by 10.14.187.6 with HTTP; Wed, 2 Jan 2013 11:05:26 -0800 (PST)
In-Reply-To: <1357152170-5511-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212533>

On Wed, Jan 2, 2013 at 7:42 PM, Antoine Pelisse <apelisse@gmail.com> wrote:
> prepare-commit-msg hook is run when committing to prepare the log
> message. If the exit-status is non-zero, the commit should be aborted.
>
> While the script is run before committing a successful merge, the
> exit-status is ignored and a non-zero exit doesn't abort the commit.
>
> Abort the commit if prepare-commit-msg returns with a non-zero status
> when committing a successful merge.
>
> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
> ---
>  builtin/merge.c                    |  5 +++--
>  t/t7505-prepare-commit-msg-hook.sh | 13 +++++++++++++
>  2 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index a96e8ea..3a31c4b 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -800,8 +800,9 @@ static void prepare_to_commit(struct commit_list *remoteheads)
>         if (0 < option_edit)
>                 strbuf_add_lines(&msg, "# ", comment, strlen(comment));
>         write_merge_msg(&msg);
> -       run_hook(get_index_file(), "prepare-commit-msg",
> -                git_path("MERGE_MSG"), "merge", NULL, NULL);
> +       if (run_hook(get_index_file(), "prepare-commit-msg",
> +                    git_path("MERGE_MSG"), "merge", NULL, NULL))
> +               abort_commit(remoteheads, NULL);
>         if (0 < option_edit) {
>                 if (launch_editor(git_path("MERGE_MSG"), NULL, NULL))
>                         abort_commit(remoteheads, NULL);
> diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
> index 5b4b694..bc497bc 100755
> --- a/t/t7505-prepare-commit-msg-hook.sh
> +++ b/t/t7505-prepare-commit-msg-hook.sh
> @@ -167,5 +167,18 @@ test_expect_success 'with failing hook (--no-verify)' '
>
>  '
>
> +test_expect_success 'with failing hook (merge)' '
> +
> +       git checkout -B other HEAD@{1} &&
> +       echo "more" >> file &&
> +       git add file &&
> +       chmod -x $HOOK &&
> +       git commit -m other &&
> +       chmod +x $HOOK &&
> +       git checkout - &&
> +       head=`git rev-parse HEAD` &&

The line above is useless ... Sorry about the noise.

> +       test_must_fail git merge other
> +
> +'
>
>  test_done
> --
> 1.8.1.rc3.27.g3b73c7d.dirty
>
