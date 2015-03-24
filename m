From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/RFC/GSOC] make git-pull a builtin
Date: Tue, 24 Mar 2015 23:58:06 +0800
Message-ID: <CACRoPnQZwVq2ssqKYsK1vKu3kVCcc0wqkf2-2soEb1vP34Td2g@mail.gmail.com>
References: <1426600662-32276-1-git-send-email-pyokagan@gmail.com>
	<vpqwq2eyyzl.fsf@anie.imag.fr>
	<CACRoPnQp-3RGAPmoo1aM2KUA-phi138J2o82FwP9annM+xvOXA@mail.gmail.com>
	<CACsJy8AP7Q9tNNDuQ2aLpCWpBwuD39qPSfip54pmDP58roztEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 16:58:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaRDa-00048I-Qr
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 16:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596AbbCXP6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 11:58:10 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:36327 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381AbbCXP6H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 11:58:07 -0400
Received: by labe2 with SMTP id e2so87770576lab.3
        for <git@vger.kernel.org>; Tue, 24 Mar 2015 08:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9d2Hgkjf1L9r761E5RKc5L/EpCzECtm/nNLTf1UqpDM=;
        b=Y8shdXvPYAo9IAFR9RAOEzuH827RIrYQdoXZmYzu8mTdOLbq1CYgKHPX9glfkJZFIU
         nPy8yNx/x2JjSznPzXYXV5AjErjcUCCszuXo2E1DICqmmjCbOg3hCTtgNyq35awhEsbB
         2eu6M0W7XejOaGhB11jbjLKIBIjGJGUIyK91linhc5EQfs+ki2rTTvhyUKqm9zfax/SY
         UQOux21shiLxxfehHLeGW94FRsKNps9hEJVxvUHq7TQDvlZZJ/uGAHjck7IXtvqxRnWl
         y753bmK7tjpUt9Va9l16VkYYQs6uFm7CYosFqP/dMwouM/w0zvUBjYkur6/ARCnCb4Sm
         mLtA==
X-Received: by 10.152.19.199 with SMTP id h7mr4572568lae.32.1427212686324;
 Tue, 24 Mar 2015 08:58:06 -0700 (PDT)
Received: by 10.112.130.228 with HTTP; Tue, 24 Mar 2015 08:58:06 -0700 (PDT)
In-Reply-To: <CACsJy8AP7Q9tNNDuQ2aLpCWpBwuD39qPSfip54pmDP58roztEw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266192>

On Mon, Mar 23, 2015 at 6:18 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> Could you share these changes? I'm just wondering if we can add kcov
> support to the test suite.

In this case it's more of an embarrassing hack, as I just needed a way
to make git run "kcov outdir git-pull.sh" whenever git pull is called
since kcov will not instrument any spawned subprocesses. I modified
execv_dashed_external() in git.c to prepend kcov to argv (diff
probably munged by gmail):

diff --git a/git.c b/git.c
index 8c7ee9c..0f8e7d4 100644
--- a/git.c
+++ b/git.c
@@ -536,6 +536,8 @@ static void execv_dashed_external(const char **argv)
        struct strbuf cmd = STRBUF_INIT;
        const char *tmp;
        int status;
+       struct argv_array args = ARGV_ARRAY_INIT;
+       int i;

        if (use_pager == -1)
                use_pager = check_pager_config(argv[0]);
@@ -551,6 +553,11 @@ static void execv_dashed_external(const char **argv)
         */
        tmp = argv[0];
        argv[0] = cmd.buf;
+       argv_array_push(&args, "kcov");
+       argv_array_push(&args, "/home/pyokagan/pyk/git/kcov");
+       argv_array_push(&args, cmd.buf);
+       for (i = 1; argv[i]; i++)
+               argv_array_push(&args, argv[i]);

        trace_argv_printf(argv, "trace: exec:");

@@ -558,7 +565,7 @@ static void execv_dashed_external(const char **argv)
         * if we fail because the command is not found, it is
         * OK to return. Otherwise, we just pass along the status code.
         */
-       status = run_command_v_opt(argv, RUN_SILENT_EXEC_FAILURE |
RUN_CLEAN_ON_EXIT);
+       status = run_command_v_opt(args.argv, RUN_SILENT_EXEC_FAILURE
| RUN_CLEAN_ON_EXIT);
        if (status >= 0 || errno != ENOENT)
                exit(status);

I'm guessing a real solution is to follow what the test suite does for
the --valgrind option, though I haven't looked into it in detail.
