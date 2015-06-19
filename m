From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] format-patch: introduce format.outputDirectory configuration
Date: Fri, 19 Jun 2015 16:34:47 -0400
Message-ID: <CAPig+cTOG7QP25TyJbbm70NBXN6Z0nZPJyjxFp1y147WQmKEDg@mail.gmail.com>
References: <1434738519-28093-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 22:35:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6301-0006ie-MO
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 22:34:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753623AbbFSUeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 16:34:50 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:34712 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235AbbFSUes (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 16:34:48 -0400
Received: by ykfl8 with SMTP id l8so99791584ykf.1
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 13:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=glT3SMutgj6JMjOJbw507XTeNAQVGSHycM04zImwDcc=;
        b=dJiIgQwqWPx0XkDPUlaDVvvMP0BRP0P8bJft3q0nLOy9K8sahwEIg0XzN7xnfKP77z
         d+lzgDsEzOdsdrP9U7xP3hW8tIXbiZhbKov3ktDafyooV6YjC5/oFjvid8hZ1DpWd6Le
         SBvS/i0SGb8rCdb0seQUou7izrCUMCqHAFfWl+k1NspwhJl/LQuFf1Vps3U6OqGtkBNk
         5UfF1s2Qb8XFFS5FhiZyB+1y0/HY+bgqRIc9NtSzhHI888bt8osUycVQExRwe+P7KfG1
         oOPkE4+PeoV9mjqwdhvca5hcy7x0XKlLS/x6tkTVMsl5RGpIk4oGiEu7vA/iPbP8hrlK
         Tl2w==
X-Received: by 10.170.75.194 with SMTP id r185mr22159336ykr.69.1434746087780;
 Fri, 19 Jun 2015 13:34:47 -0700 (PDT)
Received: by 10.37.36.214 with HTTP; Fri, 19 Jun 2015 13:34:47 -0700 (PDT)
In-Reply-To: <1434738519-28093-1-git-send-email-kuleshovmail@gmail.com>
X-Google-Sender-Auth: rH4b350gWM0TQtiJgPUtC_iL5vU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272199>

On Fri, Jun 19, 2015 at 2:28 PM, Alexander Kuleshov
<kuleshovmail@gmail.com> wrote:
> We can pass -o/--output-directory to the format-patch command to
> store patches not in the working directory. This patch introduces
> format.outputDirectory configuration option for same purpose.
>
> The case of usage of this configuration option can be convinience

s/convinience/convenience/

> to not pass everytime -o/--output-directory if an user has pattern

s/everytime/every time/

> to store all patches in the /patches directory for example.
>
> The format.outputDirectory has lower priority than command line
> option, so if user will set format.outputDirectory and pass the
> command line option, a result will be stored in a directory that
> passed to command line option.
>
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index 0dac4e9..38ddd76 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -57,7 +57,11 @@ The names of the output files are printed to standard
>  output, unless the `--stdout` option is specified.
>
>  If `-o` is specified, output files are created in <dir>.  Otherwise
> -they are created in the current working directory.
> +they are created in the current working directory. The default path
> +can be set with the seting 'format.outputDirectory' configuration option.

s/seting/setting/ or s/seting//

> +If `-o` is specified and 'format.outputDirectory' is set, output files
> +will be stored in a <dir> that passed to `-o`. When 'format.outputDirectory'
> +is set to get default behaviour back is to pass './' to the `-o`.

s/set/set,/

>  By default, the subject of a single patch is "[PATCH] " followed by
>  the concatenation of lines from the commit message up to the first blank
> diff --git a/builtin/log.c b/builtin/log.c
> index 78b3e2c..fc26360 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -688,6 +688,8 @@ enum {
>         COVER_AUTO
>  };
>
> +static const char *config_output_directory = NULL;
> +
>  static int git_format_config(const char *var, const char *value, void *cb)
>  {
>         if (!strcmp(var, "format.headers")) {
> @@ -758,6 +760,9 @@ static int git_format_config(const char *var, const char *value, void *cb)
>                 config_cover_letter = git_config_bool(var, value) ? COVER_ON : COVER_OFF;
>                 return 0;
>         }
> +       if (!strcmp(var, "format.outputdirectory")) {
> +               return git_config_string(&config_output_directory, var, value);
> +       }

Style: Unnecessary braces.

>         return git_log_config(var, value, cb);
>  }
> @@ -1368,6 +1373,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>         if (rev.show_notes)
>                 init_display_notes(&rev.notes_opt);
>
> +       if (!output_directory && !use_stdout)
> +               output_directory = config_output_directory;
> +
>         if (!use_stdout)
>                 output_directory = set_outdir(prefix, output_directory);
>         else
> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 890db11..613e2cc 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -40,6 +40,24 @@ test_expect_success setup '
>
>  '
>
> +test_expect_success "format-patch format.outputDirectory option" '
> +       git config format.outputDirectory "patches/" &&

If you're using test_config (which you do below), then drop the above
line and replace it with the test_config line.

> +       git format-patch master..side &&
> +       cnt=$(ls | wc -l) &&
> +       test $cnt = 3 &&
> +       test_config format.outputDirectory "patches/" &&
> +       git config --unset format.outputDirectory

Move the test_config line to the top of the test and get rid of the
'git config --unset' line since test_config will unset the
configuration automatically.

> +'
> +
> +test_expect_success "format-patch format.outputDirectory overwritten with -o" '
> +       rm -rf "patches" &&
> +       git config format.outputDirectory "patches/" &&

Ditto: Place test_config line here and get rid of above line.

> +       git format-patch master..side -o "." &&
> +       test_must_fail ls patches/ &&

Don't use test_must_fail for non-git commands. Instead, use '!'.
However, in this case, using:

    test_path_is_missing patches &&

would make the intent more clear.

> +       test_config format.outputDirectory "patches/" &&
> +       git config --unset format.outputDirectory

Ditto: Move test_config higher and drop 'git config --unset'.

> +'
> +
>  test_expect_success "format-patch --ignore-if-in-upstream" '
>
>         git format-patch --stdout master..side >patch0 &&
> --
> 2.4.4.727.g5c3049e.dirty
