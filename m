From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 3/6] note: extract parse_notes_merge_strategy to notes-utils
Date: Mon, 17 Aug 2015 15:38:12 -0700
Message-ID: <xmqqbne5bkx7.fsf@gitster.dls.corp.google.com>
References: <1439847214-2980-1-git-send-email-jacob.e.keller@intel.com>
	<1439847214-2980-4-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 00:38:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRT2o-0004Vp-R1
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 00:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbbHQWiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 18:38:14 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36117 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbbHQWiO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 18:38:14 -0400
Received: by pawq9 with SMTP id q9so19866763paw.3
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 15:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=44t8mxktYge9NEuasH0Ej0NzhdDaNwxQ/wQG0lPNcWA=;
        b=aEks7iKVCmIVPDGsCiaC3HcE2baH90NmSMJV6/jSKM2rrNcMg5JX0M/xIRVS1T6dYN
         SCYyXAWVl+a0Qr7mOFgtz6jTG6fu+mB//7Va3PVWvyIQUJFouOQMlPUen7PNv1GxxvIf
         UZN8j9rUvb5Ht0dEViIpPVLkjiK15+U4p6tUj34U26fqMZ0Gfzhhv6VgDBu5qiUgCxda
         r1/KHdHDSuYKUqG68mbnzBgB4X6AEA69pN1gpPNFRzxDCQENWwLnWzf6SosGwcAQ4Krb
         tp7gSmGyjBHllbPYXQ0FyOKujCeJIf7w0eXnB21RxGBKCCy3MBwgYpFe6cI8gdj3Gqt+
         +crw==
X-Received: by 10.66.154.167 with SMTP id vp7mr6654591pab.147.1439851093622;
        Mon, 17 Aug 2015 15:38:13 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d4db:7e94:b576:3da])
        by smtp.gmail.com with ESMTPSA id v6sm15815153pdp.18.2015.08.17.15.38.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Aug 2015 15:38:12 -0700 (PDT)
In-Reply-To: <1439847214-2980-4-git-send-email-jacob.e.keller@intel.com>
	(Jacob Keller's message of "Mon, 17 Aug 2015 14:33:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276103>

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> Combining rewrite and notes-merge functionality has been left as an
> exercise for a future contributor.

This comment is probably unnecessary; we haven't even established if
such a combination is desirable AFAICT in the discussion.

The patch itself looks very straightforward and obviously good.

Thanks.

>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
>  builtin/notes.c | 12 +-----------
>  notes-utils.c   | 18 ++++++++++++++++++
>  notes-utils.h   |  1 +
>  3 files changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 042348082709..0e7aba98f4d7 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -797,17 +797,7 @@ static int merge(int argc, const char **argv, const char *prefix)
>  	o.remote_ref = remote_ref.buf;
>  
>  	if (strategy) {
> -		if (!strcmp(strategy, "manual"))
> -			o.strategy = NOTES_MERGE_RESOLVE_MANUAL;
> -		else if (!strcmp(strategy, "ours"))
> -			o.strategy = NOTES_MERGE_RESOLVE_OURS;
> -		else if (!strcmp(strategy, "theirs"))
> -			o.strategy = NOTES_MERGE_RESOLVE_THEIRS;
> -		else if (!strcmp(strategy, "union"))
> -			o.strategy = NOTES_MERGE_RESOLVE_UNION;
> -		else if (!strcmp(strategy, "cat_sort_uniq"))
> -			o.strategy = NOTES_MERGE_RESOLVE_CAT_SORT_UNIQ;
> -		else {
> +		if (parse_notes_merge_strategy(strategy, &o.strategy)) {
>  			error("Unknown -s/--strategy: %s", strategy);
>  			usage_with_options(git_notes_merge_usage, options);
>  		}
> diff --git a/notes-utils.c b/notes-utils.c
> index ccbf0737a34e..299e34bccc58 100644
> --- a/notes-utils.c
> +++ b/notes-utils.c
> @@ -54,6 +54,24 @@ void commit_notes(struct notes_tree *t, const char *msg)
>  	strbuf_release(&buf);
>  }
>  
> +int parse_notes_merge_strategy(const char *v, enum notes_merge_strategy *s)
> +{
> +	if (!strcmp(v, "manual"))
> +		*s = NOTES_MERGE_RESOLVE_MANUAL;
> +	else if (!strcmp(v, "ours"))
> +		*s = NOTES_MERGE_RESOLVE_OURS;
> +	else if (!strcmp(v, "theirs"))
> +		*s = NOTES_MERGE_RESOLVE_THEIRS;
> +	else if (!strcmp(v, "union"))
> +		*s = NOTES_MERGE_RESOLVE_UNION;
> +	else if (!strcmp(v, "cat_sort_uniq"))
> +		*s = NOTES_MERGE_RESOLVE_CAT_SORT_UNIQ;
> +	else
> +		return -1;
> +
> +	return 0;
> +}
> +
>  static combine_notes_fn parse_combine_notes_fn(const char *v)
>  {
>  	if (!strcasecmp(v, "overwrite"))
> diff --git a/notes-utils.h b/notes-utils.h
> index db5811e3f718..fa538e1d9502 100644
> --- a/notes-utils.h
> +++ b/notes-utils.h
> @@ -37,6 +37,7 @@ struct notes_rewrite_cfg {
>  	int mode_from_env;
>  };
>  
> +int parse_notes_merge_strategy(const char *v, enum notes_merge_strategy *s);
>  struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd);
>  int copy_note_for_rewrite(struct notes_rewrite_cfg *c,
>  			  const unsigned char *from_obj, const unsigned char *to_obj);
