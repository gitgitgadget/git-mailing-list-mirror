From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/4] update-index: migrate to parse-options API
Date: Mon, 29 Nov 2010 20:34:16 -0600
Message-ID: <20101130023416.GB19191@burratino>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
 <1287544320-8499-4-git-send-email-pclouds@gmail.com>
 <20101022063837.GA6081@burratino>
 <20101022064258.GB6081@burratino>
 <7v8w1qnkr1.fsf@alter.siamese.dyndns.org>
 <20101024072032.GA23455@burratino>
 <20101024081316.GA29630@burratino>
 <20101024081844.GE29630@burratino>
 <4CC55C4F.5020004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 30 03:34:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNG38-0002SY-E5
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 03:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973Ab0K3Ce2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 21:34:28 -0500
Received: from mail-vw0-f66.google.com ([209.85.212.66]:47034 "EHLO
	mail-vw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490Ab0K3Ce1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 21:34:27 -0500
Received: by vws15 with SMTP id 15so462207vws.1
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 18:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=PxUgkjAhx6ltawA9M3ffrUQKh7U5lsdZ3Oaa+vdE35g=;
        b=DE8aAlhMe8clBCIhctoMgHiq5E8/IwovrCFOZSv0ipxZvspZWUyPGpxstXPNXcHPM0
         2laXufRMqLEfiaWPWHvZYVFfHMPh7JOSJcSUnV2uy0gVXIaJFk8pNPtlYxmloz9+IlB7
         xeMMTFE4TtD3eeuUZw1CH6HpNTaWGGWaMVhXc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=k1OM27tnnmMHFFrDawpMKsRxQhCBQ+IiRdvJCLczSEJSDYrnwvnP8MmiFkodZMw3gz
         eyHQuBJyNcKScnmsLBFwfpLcvzRgKf8sO4Ar0eC+e7Y7zZOnwzcwQYBL1/5lVeQHpFqJ
         huC3osPSmn7LcxhHYS52skna1sotc640NnI3c=
Received: by 10.220.86.134 with SMTP id s6mr4859vcl.24.1291084466899;
        Mon, 29 Nov 2010 18:34:26 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id c40sm891225vcs.25.2010.11.29.18.34.24
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 18:34:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CC55C4F.5020004@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162462>

Hi,

Stephen Boyd wrote:
> On 10/24/10 01:18, Jonathan Nieder wrote:

>>  builtin/update-index.c |  389 +++++++++++++++++++++++++++++------------------
>>  1 files changed, 240 insertions(+), 149 deletions(-)
>
> I would suspect that the code would get smaller. Too many callbacks?

That and added option descriptions.

>> +"git update-index [-q] [--add] [--replace] [--remove] [--unmerged] [--refresh] [--really-refresh] [--cacheinfo] [--chmod=(+|-)x] [--assume-unchanged] [--skip-worktree|--no-skip-worktree] [--info-only] [--force-remove] [--stdin] [--index-info] [--unresolve] [--again | -g] [--ignore-missing] [-z] [--verbose] [--] [<file>...]",
>> +	NULL
>> +};
>
> Please drop all this extraneous option stuff since it's already shown in
> the -h output.

Good idea.  I put

	git update-index [options] [--] [<file>...]

even though that doesn't explain the actual syntax (especially
oddities like --stdin and --unresolve) at all. :)

> This shouldn't be possible right? I thought parse options made sure
> NONEG options couldn't be negated... <goes and looks at patch 1>. Oh.

Fixed.

[...]
>> +static int last_arg_cb(struct parse_opt_ctx_t *ctx, const struct option *opt,
>> +		       int flags)
>> +{
>> +	int *read_from_stdin = opt->value;
>> +	if (ctx->argc != 1)
>> +		return error("--%s must be at the end", opt->long_name);
>
> Thinking out loud, this might be better served as an option flag
> (PARSE_OPT_LAST_ARG?) to make it a bit more generic. Especially since
> you use it twice.

Agreed but I'm not doing it now, since I don't want to encourage other
commands.  Will reconsider.

>> +static int reupdate_cb(struct parse_opt_ctx_t *ctx, const struct option *opt,
>> +		       int flags)
>> +{
>> +	int *has_errors = opt->value;
>> +	const char *prefix = startup_info->prefix;
>
> Doesn't the context also contain this? I know this is why you included
> patch 3, but it doesn't seem strictly necessary to use startup_info over
> ctx.

I figure patch 3 is inevitable anyway.  It didn't seem right to
peek at the context, which only includes it as an implementation
detail of OPTION_FILENAME support.

Maybe eliminating ctx->prefix would be a good follow-up patch.

>> +	setup_work_tree();
>> +	*has_errors = do_reupdate(ctx->argc, ctx->argv,
>> +				  prefix, !prefix ? 0 : strlen(prefix));
>> +	ctx->argv += ctx->argc - 1;
>> +	ctx->argc = 1;
>
> At first I thought you forgot to make this a -= here.

Yep, needs a comment.

>> +	struct option options[] = {
>> +		OPT_BIT('q', NULL, &refresh_args.flags,
>> +			"continue refresh even when index needs update",
>> +			REFRESH_QUIET),
> [snip]
>> +		OPT_SET_INT(0, "verbose", &verbose,
>> +			"report actions to standard output", 1),
>> +		{OPTION_CALLBACK, 0, "clear-resolve-undo", NULL, NULL,
>> +			"(for porcelains) forget saved unresolved conflicts",
>> +			PARSE_OPT_NOARG | PARSE_OPT_NONEG, resolve_undo_clear_cb},
>> +		OPT_END()
>> +	};
>
> Any reason for OPT_SET_INT over OPT_BOOLEAN? Just curious.

OPT_BOOLEAN means OPT_INCR and there is only one level of verbosity
here.

>> +			trace_printf("trace: update-index %s\n", path);
[...]
>               Debugging stuff?

Yes, good catch.

Thanks again for all the comments, and sorry to take so long to get
back to this.

Regards,
Jonathan
