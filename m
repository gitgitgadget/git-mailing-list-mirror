From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 5/9] ref-filter: add option to match literal pattern
Date: Sat, 27 Jun 2015 02:45:23 +0530
Message-ID: <558DC0EB.3050203@gmail.com>
References: <CAOLa=ZSsVqFy4OrSt295qAZdjKTC7z44EVsx3cPEd2jb8Y-sHw@mail.gmail.com>
 <1435232596-27466-1-git-send-email-karthik.188@gmail.com>
 <1435232596-27466-5-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 26 23:15:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8ayF-00081J-JI
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 23:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447AbbFZVPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 17:15:31 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:34495 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbbFZVP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 17:15:28 -0400
Received: by pdbep18 with SMTP id ep18so59579530pdb.1
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 14:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=rlSR2eSQx5ETuslxZ48CYe8UdGAqBo1lbW1mJpnx4YA=;
        b=YOFMdqYBlcHnNTKN6VcFAfYCN9joKg5ITr7a+BGl3aIqGKqe1hC49sLNE+aOBZ5+3M
         tivrdPmqUU3ZZS+w3hYygalai2fmbJEgSnn3y07PBHKtsDOtUQPYNa7MwQHdpkvuSnP1
         l379lAog3ElxBQVJ2gGz26z76e6mjVUxCIXtVh+YIMa8cPIPCZVWe6lytAW0q332S9dt
         oMvt7Spc2Za67hln5A/uGSymNYkGjCqQpleyd6ovNPIjNtt44xqop4enQpkuS1rS+lKn
         7BYaOqG2YfeWoVvr1xFqaOVzeEBgVApmZ4oeJ5IW5WQSgsMvvi2gc0pFvmtAhsTpNFEv
         VPIA==
X-Received: by 10.70.96.139 with SMTP id ds11mr7155454pdb.98.1435353328168;
        Fri, 26 Jun 2015 14:15:28 -0700 (PDT)
Received: from [192.168.0.100] ([106.51.130.23])
        by mx.google.com with ESMTPSA id bi4sm34252049pbc.56.2015.06.26.14.15.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jun 2015 14:15:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.0.1
In-Reply-To: <1435232596-27466-5-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272827>

Just a few things I need to fix, personal note.

On 06/25/2015 05:13 PM, Karthik Nayak wrote:
> Since 'ref-filter' only has an option to match path names.
> Add an option for regular pattern matching.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>   builtin/for-each-ref.c |  1 +
>   ref-filter.c           | 30 ++++++++++++++++++++++++------
>   ref-filter.h           |  3 ++-
>   3 files changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index c318e33..01d5363 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -68,6 +68,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>   	git_config(git_default_config, NULL);
>
>   	filter.name_patterns = argv;
> +	filter.match_as_path = 1;
>   	filter_refs(&array, &filter, FILTER_REFS_ALL | FILTER_REFS_INCLUDE_BROKEN);
>   	ref_array_sort(sorting, &array);
>
> diff --git a/ref-filter.c b/ref-filter.c
> index e307fab..1f97910 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -954,6 +954,20 @@ static int commit_contains(struct ref_filter *filter, struct commit *commit)
>
>   /*
>    * Return 1 if the refname matches one of the patterns, otherwise 0.
> + * A pattern can be a literal prefix (e.g. a refname "refs/heads/master"
> + * matches a pattern "refs/heads/m") or a wildcard (e.g. the same ref
> + * matches "refs/heads/m*",too).
> + */
> +static int match_pattern(const char **patterns, const char *refname)
> +{
> +	for (; *patterns; patterns++)
> +		if (!wildmatch(*patterns, refname, 0, NULL))
> +			return 1;
> +	return 0;
> +}
> +
> +/*
> + * Return 1 if the refname matches one of the patterns, otherwise 0.
>    * A pattern can be path prefix (e.g. a refname "refs/heads/master"
>    * matches a pattern "refs/heads/") or a wildcard (e.g. the same ref
>    * matches "refs/heads/m*",too).
> @@ -977,6 +991,15 @@ static int match_name_as_path(const char **pattern, const char *refname)
>   	return 0;
>   }
>
> +static int filter_pattern_match(struct ref_filter *filter, const char *refname)
> +{
> +	if (!*filter->name_patterns)
> +		return 0;

Should return 1.

> +	if (filter->match_as_path)
> +		return match_name_as_path(filter->name_patterns, refname);
> +	return match_pattern(filter->name_patterns, refname);
> +}
> +
>   /*
>    * Given a ref (sha1, refname) see if it points to one of the sha1s
>    * in a sha1_array.
> @@ -1026,17 +1049,12 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
>   	struct ref_array_item *ref;
>   	struct commit *commit = NULL;
>
> -	if (flag & REF_BAD_NAME) {
> -		  warning("ignoring ref with broken name %s", refname);
> -		  return 0;
> -	}
> -

Undo this merge conflict.

>   	if (flag & REF_ISBROKEN) {
>   		warning("ignoring broken ref %s", refname);
>   		return 0;
>   	}
>
> -	if (*filter->name_patterns && !match_name_as_path(filter->name_patterns, refname))
> +	if (!filter_pattern_match(filter, refname))
>   		return 0;
>
>   	if (!match_points_at(&filter->points_at, oid->hash, refname))
> diff --git a/ref-filter.h b/ref-filter.h
> index 6b6fb96..a4809c8 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -54,7 +54,8 @@ struct ref_filter {
>   	} merge;
>   	struct commit *merge_commit;
>
> -	unsigned int with_commit_tag_algo: 1;
> +	unsigned int with_commit_tag_algo: 1,
> +		match_as_path: 1;
>   	unsigned int lines;
>   };
>
>

I'll add these changes to my local branch.

-- 
Regards,
Karthik
