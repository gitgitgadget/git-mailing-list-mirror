From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv9 3/6] fetching submodules: respect `submodule.fetchJobs`
 config option
Date: Tue, 9 Feb 2016 14:34:00 -0800
Message-ID: <20160209223400.GI28749@google.com>
References: <1455051274-15256-1-git-send-email-sbeller@google.com>
 <1455051274-15256-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 23:34:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTGrK-0007aE-O4
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 23:34:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933077AbcBIWeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 17:34:06 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36563 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932719AbcBIWeE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 17:34:04 -0500
Received: by mail-pf0-f180.google.com with SMTP id e127so879282pfe.3
        for <git@vger.kernel.org>; Tue, 09 Feb 2016 14:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=sJ6yRSeVEoFkzZddzU9d9ZctH1AwsBuWSwZlExKKq7A=;
        b=VRq1qRwQ8vn9m/Y+p3zRWHcwsntSyXRtCQ6djIWA+o83QFsZ3T4pEfS9kJnIqtcaVg
         o59/m8RzXV55xqOOBdCuTkrH7f7IAiu2/yGFx82DF8ch4XRf37ihEaAYZfxprLqPTOGJ
         dCTDXsjm0v8j/P6BTQfrqwHgRiqMQSmJpRvtqqb1z2uzzcwL/br5TRlwjaIHBT2WxIbx
         +yGYn/Wuih+dOrHR8hg8eKBtUnK8LNwIaYdjgUY9uAbw5d4O/SJAK5uwsxjZgJGr0+ko
         cptwL5lDkZSW92GImTaRXyKChy0dHu+w8Dcn+SJpj7KxP/C0QuCo2dMrV3oouBFET/2v
         NZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=sJ6yRSeVEoFkzZddzU9d9ZctH1AwsBuWSwZlExKKq7A=;
        b=FWHd2jw6T54VQLbHwr+5e8zDnQf7GUBy14PCkdUxz6Gwv5qOW3tHUzI89wAQYKLeK+
         Uu8o2wvD1d0DBMQ44RnwMYABbKCPGEjeCR4SP4ptwrTETZH+rj7eAwjPplN2gS+fMvCt
         CKqphY8/J2rzyi+3r8ixZJtzIGMC17RS45uTkae4/BokF6Tpcbi8TbSvLvKYJ8Dy9Mc7
         GzES2AuUqqSK2pzBJyvtsRmJLCWLdJ6zKLga9MLXSaqq9weyLjrDegx6BO9vqVZpQois
         x5kzFgxmri3HWAL/rK5Ro7CwBq3yEG6Cs3mbwJcJMVZbUtw+b8Sdga1kuCasENX+po9L
         k4hg==
X-Gm-Message-State: AG10YOQjcTJH4AJi1vSmvBuP1Lx8KViOL3/n85+KvkShoYIDPyAwGBsY2g5MKv/kbgn8yA==
X-Received: by 10.98.74.93 with SMTP id x90mr33894329pfa.80.1455057243530;
        Tue, 09 Feb 2016 14:34:03 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:609c:fa:6497:fd10])
        by smtp.gmail.com with ESMTPSA id w89sm158072pfi.13.2016.02.09.14.34.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 09 Feb 2016 14:34:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1455051274-15256-4-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285880>

Hi,

Stefan Beller wrote:

> +++ b/submodule.c
[...]
> @@ -169,7 +170,13 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
>  
>  int submodule_config(const char *var, const char *value, void *cb)
>  {
> -	if (starts_with(var, "submodule."))
> +	if (!strcmp(var, "submodule.fetchjobs")) {
> +		unsigned long val;
> +		if (!git_parse_ulong(value, &val) || 0 > val || val >= INT_MAX)
> +			die(_("Error parsing submodule.fetchJobs %s"), value);

'val < 0' would be more idiomatic than '0 > val'.  More importantly,
val is an unsigned long.  How could it be negative?

Is it intended that val == INT_MAX is not permitted?  I would have
expected something like the following to work:

		unsigned long val = git_config_ulong(var, value);
		if (val > INT_MAX) {
			errno = ERANGE;
			die_bad_number(var, value);
		}

(using die_bad_number from config.c).  Or config.c could gain a
git_config_nonnegative_int helper:

	static int git_parse_nonnegative_int(const char *value, int *ret)
	{
		uintmax_t tmp;
		if (!git_parse_unsigned(value, &tmp, maximum_signed_value_of_type(int)))
			return 0;
		*ret = tmp;
		return 1;
	}

	int git_config_nonnegative_int(const char *name, const char *value)
	{
		int ret;
		if (!git_parse_nonnegative_int(value, &ret))
			die_bad_number(name, value);
		return ret;
	}

allowing

		parallel_jobs = git_config_nonnegative_int(var, val);
		return 0;

[...]
> @@ -751,6 +758,9 @@ int fetch_populated_submodules(const struct argv_array *options,
>  	argv_array_push(&spf.args, "--recurse-submodules-default");
>  	/* default value, "--submodule-prefix" and its value are added later */
>  
> +	if (max_parallel_jobs < 0)
> +		max_parallel_jobs = parallel_jobs;

Makes sense.

[...]
> @@ -1097,3 +1107,8 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
>  	strbuf_release(&rel_path);
>  	free((void *)real_work_tree);
>  }
> +
> +int parallel_submodules(void)
> +{
> +	return parallel_jobs;
> +}

Is this helper used?

[...]
> +++ b/submodule.h
> @@ -41,5 +41,6 @@ int find_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_nam
>  		struct string_list *needs_pushing);
>  int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name);
>  void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
> +int parallel_submodules(void);

optional trick: one way to avoid merge conflicts is to add each function
at some logical place in the file instead of at the end.  Another nice
side-effect is that it makes it easier to read through the header since
functions appear in some appropriate order.

E.g. this method could go near the config functions, I suppose.

> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -471,4 +471,18 @@ test_expect_success "don't fetch submodule when newly recorded commits are alrea
>  	test_i18ncmp expect.err actual.err
>  '
>  
> +test_expect_success 'fetching submodules respects parallel settings' '

Makes sense.  Same trick about inserting in some appropriate place in
the middle of the file applies here, too.  In tests it also ends up
being useful for finding when tests overlap or when there's a gap in
coverage.

The documentation says that '0' does something appropriate (DWIM or
something?  I didn't understand it).  Perhaps a test for that behavior
would be useful, too.

Thanks,
Jonathan
