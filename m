From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] commit: fix ending newline for template files
Date: Thu, 28 May 2015 10:29:18 -0400
Message-ID: <CAPig+cTt5sQ=49qS2+8ZOtiX61kHjAisAvpP7K3XPhtNtCatOg@mail.gmail.com>
References: <1432620908-16071-1-git-send-email-patryk.obara@gmail.com>
	<1432620908-16071-3-git-send-email-patryk.obara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Patryk Obara <patryk.obara@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 28 16:29:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxyoG-0005ZL-G6
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 16:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932288AbbE1O3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 10:29:21 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:33397 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932162AbbE1O3T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 10:29:19 -0400
Received: by iebgx4 with SMTP id gx4so39579209ieb.0
        for <git@vger.kernel.org>; Thu, 28 May 2015 07:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=p8L5/LUBooUASg8B9BODcFbUizPkgs+lF2mG5W3F7b4=;
        b=KpYVu66TG2G1F0n6PvVvbRgiT/mywKeggMibWBIXbE0FIeJJDt+cp5DKXEfwcPUe1/
         JjpPTUHSU2TdPCF4L6LlHYkVAIj4a1Y1lJBIQWCAGiKtbGXRQkpU15z/dbw/iIaXV8XZ
         kdmtbfIZEQ1NVf/n/3jgDQACPyT5YOZMuTuRygJVyyDki1qTn+99pw9mKdpp6gZNtm7T
         BvaK/UmPpiNh95vPvoT2Dx1scewDyZ4tcVXamq3za7TzYZTMaKOpH1gF/i/PMtaFf7HZ
         A+Tmtn7FtsGRIm2ZZF4ynzHqMV7/yj5x8M9EfMPS70462eO6W8MyLYI1Qkn6/GbxCgqQ
         ka/A==
X-Received: by 10.50.66.234 with SMTP id i10mr11742830igt.22.1432823358490;
 Thu, 28 May 2015 07:29:18 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 28 May 2015 07:29:18 -0700 (PDT)
In-Reply-To: <1432620908-16071-3-git-send-email-patryk.obara@gmail.com>
X-Google-Sender-Auth: hs-nWx4OLGXWf4uL_C9PsbC65SU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270152>

On Tue, May 26, 2015 at 2:15 AM, Patryk Obara <patryk.obara@gmail.com> wrote:
> git-commit with -t or -F -e uses content of user-supplied file as
> initial value for commit msg in editor. There is no guarantee, that this
> file ends with newline - it depends on file content and editor used to
> create file (some editors append and hide last newline from user while
> others do not).
>
> When --status (default) is supplied, additional comment is placed after
> template content. If template file ended with newline this results in
> additional line being appended (which may be unexpected e.g. when last
> line of template is a comment). On the other hand, first line of status
> should never be concatenated to last line of template file.
>
> Append newline before status _only_ if template/logfile didn't end with
> one already. This way content of template is exactly the way user intended
> and there's no chance, that line of status will merge with last line of
> template.

There is also interaction with --signoff (which does its own handling
of present or missing newline)...

> Remove unnecessary premature cleanup of commit message, which was
> implemented for -F, but not for -t.

Is this change distinct from the rest of the patch? If so, it may
deserve its own patch.

Moreover, it lacks justification and explanation of why you consider
the cleanup unnecessary. History [1] indicates that its application to
-F but not -t was intentional.

[1]: bc92377 (commit: fix ending newline for template files, 2015-05-26)

> Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
> ---
> diff --git a/builtin/commit.c b/builtin/commit.c
> index da79ac4..eb41e05 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -666,8 +666,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>         struct strbuf sb = STRBUF_INIT;
>         const char *hook_arg1 = NULL;
>         const char *hook_arg2 = NULL;
> -       int clean_message_contents = (cleanup_mode != CLEANUP_NONE);
>         int old_display_comment_prefix;
> +       int sb_ends_with_newline = 0;

What does 'sb' mean in sb_ends_with_newline? Is it a reference to
strbuf? If so, it doesn't make the variable name any more meaningful.

>         /* This checks and barfs if author is badly specified */
>         determine_author_info(author_ident);
> @@ -786,6 +782,9 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>
>         if (auto_comment_line_char)
>                 adjust_comment_line_char(&sb);
> +
> +       sb_ends_with_newline = ends_with(sb.buf, "\n");
> +
>         strbuf_release(&sb);
>
>         /* This checks if committer ident is explicitly given */
> @@ -794,6 +793,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>                 int ident_shown = 0;
>                 int saved_color_setting;
>                 struct ident_split ci, ai;
> +               int append_newline = (template_file || logfile) ? !sb_ends_with_newline : 1;
> +
> +               if (append_newline)
> +                       fprintf(s->fp, "\n");

Did you consider the alternate approach of handling newline processing
immediately upon loading 'logfile' and 'template_file', rather than
delaying processing until this point? Doing it that way would involve
a bit of code repetition but might be easier to reason about since it
would occur before possible interactions in following code (such as
--signoff handling).

>                 if (whence != FROM_COMMIT) {
>                         if (cleanup_mode == CLEANUP_SCISSORS)
> @@ -815,7 +818,6 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>                                          : "CHERRY_PICK_HEAD"));
>                 }
>
> -               fprintf(s->fp, "\n");
>                 if (cleanup_mode == CLEANUP_ALL)
>                         status_printf(s, GIT_COLOR_NORMAL,
>                                 _("Please enter the commit message for your changes."
> --
> 2.4.1
