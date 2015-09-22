From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 07/13] fetch_populated_submodules: use new parallel job processing
Date: Tue, 22 Sep 2015 09:28:48 -0700
Message-ID: <xmqqvbb24dvj.fsf@gitster.mtv.corp.google.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
	<1442875159-13027-8-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jacob.keller@gmail.com, peff@peff.net,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, vlovich@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 18:28:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeQR6-0003Uj-An
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 18:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933491AbbIVQ2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 12:28:51 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34878 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758585AbbIVQ2u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 12:28:50 -0400
Received: by pacfv12 with SMTP id fv12so13682403pac.2
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 09:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Vmzfv4iKb1sMceNwpSFIMGfUByq0ENn2KqELcvpgCrs=;
        b=0KSq0gedf7KK9MB8vQ7oqI9mWp4lWkmWkaAoTtaWLzrd463XuEf83dQpqvlZwjvyGV
         SWBqfe2uwtk6j9nl23UbPtJRgFbhHxk5gJ3Tjvb7SI9pDhpU2URnimab7dJRZFFhJihw
         Vf0D5BmSqkTAje9wb3gB60rgczDGXnWLuESioR2NAcMKphNCohOgVIaiR9LHmrTasXj8
         FtBUPZ/SJNB3lNLYDwDRoYwqsV3frKtCyuuWVnVDI29+rXD1SK+ujl+42Vd7Yhpi2JTq
         MfPnKHWR+78ECmA4PyV09nkIfN0Uhn8iDiK82XaJYgNOeV/82dl3+k0wchlrh76cgpaF
         e4Kg==
X-Received: by 10.68.241.234 with SMTP id wl10mr17773256pbc.27.1442939330272;
        Tue, 22 Sep 2015 09:28:50 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:fd7e:7071:2eda:9c63])
        by smtp.gmail.com with ESMTPSA id yk5sm3174124pab.31.2015.09.22.09.28.49
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 22 Sep 2015 09:28:49 -0700 (PDT)
In-Reply-To: <1442875159-13027-8-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 21 Sep 2015 15:39:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278402>

Stefan Beller <sbeller@google.com> writes:

> In a later patch we enable parallel processing of submodules, this
> only adds the possibility for it. So this change should not change
> any user facing behavior.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/fetch.c |   3 +-
>  submodule.c     | 119 +++++++++++++++++++++++++++++++++++++++-----------------
>  submodule.h     |   2 +-
>  3 files changed, 87 insertions(+), 37 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index ee1f1a9..6620ed0 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1217,7 +1217,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  		result = fetch_populated_submodules(&options,
>  						    submodule_prefix,
>  						    recurse_submodules,
> -						    verbosity < 0);
> +						    verbosity < 0,
> +						    0);

This one...

>  int fetch_populated_submodules(const struct argv_array *options,
>  			       const char *prefix, int command_line_option,
> -			       int quiet)
> +			       int quiet, int max_parallel_jobs)
>  {
> -	int i, result = 0;
> -	struct child_process cp = CHILD_PROCESS_INIT;

... together with this one, could have been made easier to follow if
you didn't add a new parameter to the function.  Instead, you could
define a local variable max_parallel_jobs initialized to 1 in this
function without changing the function signature (and the caller) in
this step, and then did the above two changes in the same commit as
the one that actually enables the feature.

That would be more in line with the stated "only adds the possiblity
for it" goal.

As posted, I suspect that by passing 0 to max_parallel_jobs, you are
telling run_processes_parallel_init() to check online_cpus() and run
that many processes in parallel, no?

> +int get_next_submodule(void *data, struct child_process *cp,
> +		       struct strbuf *err)
> +{
> +	int ret = 0;
> +	struct submodule_parallel_fetch *spf = data;
> ...
> +			child_process_init(cp);
> +			cp->dir = strbuf_detach(&submodule_path, NULL);
> +			cp->git_cmd = 1;
> +			cp->no_stdout = 1;
> +			cp->no_stdin = 1;

In run-commands.c::start_command(), no_stdout triggers
dup_devnull(1) and causes dup2(2, 1) that is triggered by
stdout_to_stderrd to be bypassed.  This looks wrong to me.

> +			cp->stdout_to_stderr = 1;
> +			cp->err = -1;

OK, the original left the standard error stream connected to the
invoker's standard error, but now we are capturing it via a pipe.
