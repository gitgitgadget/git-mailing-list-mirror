From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 3/4] notes: add notes.merge option to select default strategy
Date: Thu, 6 Aug 2015 18:37:04 -0400
Message-ID: <CAPig+cR==VEdBPoraqQAb_dp+3rd_NoZZidthDRn2Zd9BYJRCw@mail.gmail.com>
References: <1438510226-1163-1-git-send-email-jacob.e.keller@intel.com>
	<1438510226-1163-4-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 00:37:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNTmq-0003i2-RK
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 00:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755958AbbHFWhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 18:37:09 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:34343 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755935AbbHFWhF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 18:37:05 -0400
Received: by ykax123 with SMTP id x123so75459758yka.1
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 15:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/Rgt1eR+ocmKChRicXNkt7k2ABvdC939TRsw3U6Cock=;
        b=SEgh2E+99o9usroOMC5/v3A3UFPqPXqyXYlteor344NbXhKQBNQPQh38tcjFdpibrb
         3mlc3XeIhQxW8No8wWH+GGhdTrO0xeoMtryWhzCDKSi0vZpmoklC0kdymCpvV7z7X2My
         gAlvW3w8D73fQVfS/o/XQe81Lh+6R6SnR9i1hCeuyB+SNfJ/Wr6MoOXMStsU+X+gGGt7
         58vy5rvixSfkZkOg2Se7x6dtMZXsxGqVwWHhRvAsBbDzSDjaVMK5ezDoAMv3bdVkacOY
         fEwsxzAMgeAFlfCInRGNRO7Tztpo+otBqt8B4zV+LYbCaRUv4Kpsq8Tegh790UcINzWR
         JxFw==
X-Received: by 10.129.91.87 with SMTP id p84mr4651501ywb.95.1438900624183;
 Thu, 06 Aug 2015 15:37:04 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Thu, 6 Aug 2015 15:37:04 -0700 (PDT)
In-Reply-To: <1438510226-1163-4-git-send-email-jacob.e.keller@intel.com>
X-Google-Sender-Auth: vZ9jlUjS1vc8ohbRTs552xykCPo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275450>

On Sun, Aug 2, 2015 at 6:10 AM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> Teach git-notes about a new configuration option "notes.merge" for
> selecting the default notes merge strategy. Document the option in
> config.txt and git-notes.txt
>
> Add tests for use of the configuration option. Include a test to ensure
> that --strategy correctly overrides the configured setting.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
> index 674682b34b83..9c4f8536182f 100644
> --- a/Documentation/git-notes.txt
> +++ b/Documentation/git-notes.txt
> @@ -101,7 +101,7 @@ merge::
>  If conflicts arise and a strategy for automatically resolving
> -conflicting notes (see the -s/--strategy option) is not given,
> +conflicting notes (see the "NOTES MERGE STRATEGIES" section) is not given,
>  the "manual" resolver is used. This resolver checks out the
>  conflicting notes in a special worktree (`.git/NOTES_MERGE_WORKTREE`),
>  and instructs the user to manually resolve the conflicts there.
> @@ -183,6 +183,7 @@ OPTIONS
>         When merging notes, resolve notes conflicts using the given
>         strategy. The following strategies are recognized: "manual"
>         (default), "ours", "theirs", "union" and "cat_sort_uniq".
> +       This option overrides the "notes.merge" configuration setting.
>         See the "NOTES MERGE STRATEGIES" section below for more
>         information on each notes merge strategy.

These two documentation updates are much easier to digest than the
noisy-diff versions of the previous attempt; and the patch overall is
a more pleasant read than v1.

> diff --git a/builtin/notes.c b/builtin/notes.c
> index 63f95fc55439..de0caa00df1b 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -945,6 +955,20 @@ static int get_ref(int argc, const char **argv, const char *prefix)
>         return 0;
>  }
>
> +static int git_notes_config(const char *var, const char *value, void *cb)
> +{
> +       if (!strcmp(var, "notes.merge")) {
> +               if (!value)
> +                       return config_error_nonbool(var);
> +               if (parse_notes_strategy(value, &merge_strategy))
> +                       return error("Unknown notes merge strategy: %s", value);
> +               else
> +                       return 0;

A purely subjective stylistic suggestion, which you can freely ignore
if your preference differs:

    if (!value)
        return ...;
    if (parse_notes_strategy(...))
        return ...;
    return 0;

> +       }
> +
> +       return git_default_config(var, value, cb);
> +}
> +
