From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] difftool: Change prompt to display the number of files
 in the diff queue
Date: Tue, 3 Dec 2013 23:34:58 -0500
Message-ID: <CAPig+cTUB=UbY-j8mtz6QsvJKoA2T41u-wiR7Di596pM3t+k=Q@mail.gmail.com>
References: <1386120387-25300-1-git-send-email-zoltan.klinger@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Zoltan Klinger <zoltan.klinger@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 05:35:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vo4B0-0005Q6-1E
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 05:35:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589Ab3LDEfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 23:35:01 -0500
Received: from mail-la0-f52.google.com ([209.85.215.52]:33195 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753489Ab3LDEfA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 23:35:00 -0500
Received: by mail-la0-f52.google.com with SMTP id y1so7741630lam.11
        for <git@vger.kernel.org>; Tue, 03 Dec 2013 20:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=gStO+ns6IcHPkUORpzylAAzo+EsOISw4OaGm7X612Rg=;
        b=fQSlxaZjdpF93gBFSqVmahD7ZfwVP+aFmCH+QLYYrC42RJze5jjw8QO1Tkk39Xz9lV
         bCCThzOMDiAZeymXBIE1UlskhFMU0sF34SmGnNojtx1NibWDVAHRj4rlZkV+NBWzz/B7
         ghdavvhybx5gcqxnlKod5Fh+1IaIWsLt+lPox78N79yHhDNd9Keu0Nv9NqgxN3W70h2S
         FBpLe3t7d0v5il/CzM2xzpbBS1InZ8lOqFoWMHQ9NMn4iISg9jD2zvhW+sbmvVcZbGqW
         Fu0BU26nVbYVbMnv27AA+fTeFCMch03CTlShbSjRNWEkjC1edxdTCKXZMuAfZIeMlteo
         2haQ==
X-Received: by 10.152.21.3 with SMTP id r3mr12083789lae.15.1386131698489; Tue,
 03 Dec 2013 20:34:58 -0800 (PST)
Received: by 10.114.175.130 with HTTP; Tue, 3 Dec 2013 20:34:58 -0800 (PST)
In-Reply-To: <1386120387-25300-1-git-send-email-zoltan.klinger@gmail.com>
X-Google-Sender-Auth: bOd_m8972mwowLmz9JBDxYt4Y-M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238750>

On Tue, Dec 3, 2013 at 8:26 PM, Zoltan Klinger <zoltan.klinger@gmail.com> wrote:
> diff --git a/diff.c b/diff.c
> index e34bf97..c4078af 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2899,11 +2899,18 @@ static void run_external_diff(const char *pgm,
>                               struct diff_filespec *one,
>                               struct diff_filespec *two,
>                               const char *xfrm_msg,
> -                             int complete_rewrite)
> +                             int complete_rewrite,
> +                             struct diff_options *o)
>  {
>         const char *spawn_arg[10];
>         int retval;
>         const char **arg = &spawn_arg[0];
> +       struct diff_queue_struct *q = &diff_queued_diff;
> +
> +       struct strbuf counterstr = STRBUF_INIT;
> +       struct strbuf totalstr = STRBUF_INIT;
> +       strbuf_addf(&counterstr, "%d", ++o->diff_path_counter);
> +       strbuf_addf(&totalstr, "%d", q->nr);
>
>         if (one && two) {
>                 struct diff_tempfile *temp_one, *temp_two;
> @@ -2928,8 +2935,14 @@ static void run_external_diff(const char *pgm,
>         }
>         *arg = NULL;
>         fflush(NULL);
> +
> +       setenv ("GIT_DIFF_PATH_COUNTER", counterstr.buf, 1);
> +       setenv ("GIT_DIFF_PATH_TOTAL", totalstr.buf, 1);
> +
>         retval = run_command_v_opt(spawn_arg, RUN_USING_SHELL);

Would run_command_v_opt_cd_env() be more appropriate than setenv() +
run_command_v_opt() done here?

>         remove_tempfile();
> +       strbuf_release(&counterstr);
> +       strbuf_release(&totalstr);
>         if (retval) {
>                 fprintf(stderr, "external diff died, stopping at %s.\n", name);
>                 exit(1);
> diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
> index 8a30979..4935fc4 100755
> --- a/t/t4020-diff-external.sh
> +++ b/t/t4020-diff-external.sh
> @@ -193,6 +193,22 @@ test_expect_success 'GIT_EXTERNAL_DIFF with more than one changed files' '
>         GIT_EXTERNAL_DIFF=echo git diff
>  '
>
> +echo "#!$SHELL_PATH" >external-diff.sh
> +cat >> external-diff.sh <<\EOF
> +echo $GIT_DIFF_PATH_COUNTER of $GIT_DIFF_PATH_TOTAL >>counter.txt
> +EOF
> +chmod a+x external-diff.sh

Perhaps write_script()?

> +test_expect_success 'GIT_EXTERNAL_DIFF path counter/total' '
> +       GIT_EXTERNAL_DIFF=./external-diff.sh git diff &&
> +       echo "1 of 2" >expect &&
> +       head -n 1 counter.txt >actual &&
> +       test_cmp expect actual &&
> +       echo "2 of 2" >expect &&
> +       tail -n 1 counter.txt >actual &&
> +       test_cmp expect actual
> +'
> +
>  test_expect_success 'GIT_EXTERNAL_DIFF generates pretty paths' '
>         touch file.ext &&
>         git add file.ext &&
> --
> 1.8.4.4
