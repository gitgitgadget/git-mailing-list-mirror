From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] cherry-pick: do not segfault without arguments.
Date: Thu, 10 Oct 2013 23:17:47 +0200
Message-ID: <5257197B.6010805@googlemail.com>
References: <1380895752-5286-1-git-send-email-stefanbeller@googlemail.com> <20131010164116.GB21489@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: hiroshige88@gmail.com, gitster@pobox.com, jrnieder@gmail.com,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 10 23:17:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUNc5-0005v1-5I
	for gcvg-git-2@plane.gmane.org; Thu, 10 Oct 2013 23:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757547Ab3JJVRi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Oct 2013 17:17:38 -0400
Received: from mail-ee0-f53.google.com ([74.125.83.53]:50190 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756327Ab3JJVRg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Oct 2013 17:17:36 -0400
Received: by mail-ee0-f53.google.com with SMTP id b15so1459508eek.40
        for <git@vger.kernel.org>; Thu, 10 Oct 2013 14:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=4J4SRC9Es17F23GxvQODcCq7X6kHn1bPedNdxdlv0oc=;
        b=GUUlEuEWcjycOBHcYiO3sBmIyPMlSLYr931m1tcWdd1NI3P+XcSDzHG0RiQ8N7SM1B
         Mqm/CkBETSLyacxDNWAjb2wnI7X7A+jQkjXFJvmhx2oAPHRjw3a+ZaJfC+Qo3juW8Hm4
         N6616ukvh09Mw9JdVPme6RxavzC99q573sMuOKJMtP5Ia4fXT7eLgNc1htc4TpP5KpuI
         9Fvpi5MwObnifN7OGasi3VxbkDf5CwSKWxlLzWQZMjvJdiuofF5TwoamYM/Jq2WJHcVJ
         F0GdtbD+Cr14RIXZYoEgKUeGqRoOFk9cHGoUxU20kIGDBJPwOl+4zdzAy79TMLGL485L
         dSog==
X-Received: by 10.15.36.9 with SMTP id h9mr23853826eev.30.1381439854647;
        Thu, 10 Oct 2013 14:17:34 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id x47sm106186325eea.16.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Oct 2013 14:17:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <20131010164116.GB21489@sigill.intra.peff.net>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235885>

On 10/10/2013 06:41 PM, Jeff King wrote:
> On Fri, Oct 04, 2013 at 04:09:12PM +0200, Stefan Beller wrote:
> 
>> Commit 182d7dc46b (2013-09-05, cherry-pick: allow "-" as abbreviation of
>> '@{-1}') accesses the first argument without checking whether it exists.
> 
> I think this is an obviously correct fix for the immediate segfault,
> but...

Yes my intention was to fix the obvious, as I assumed the discussion
about the exact spec for the '-' has been finished.
Your patch probably makes more sense however.

> 
>> diff --git a/builtin/revert.c b/builtin/revert.c
>> index 52c35e7..f81a48c 100644
>> --- a/builtin/revert.c
>> +++ b/builtin/revert.c
>> @@ -202,7 +202,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
>>  	memset(&opts, 0, sizeof(opts));
>>  	opts.action = REPLAY_PICK;
>>  	git_config(git_default_config, NULL);
>> -	if (!strcmp(argv[1], "-"))
>> +	if (argc > 1 && !strcmp(argv[1], "-"))
>>  		argv[1] = "@{-1}";
>>  	parse_args(argc, argv, &opts);
>>  	res = sequencer_pick_revisions(&opts);
> 
> Why are we looking at argv/argc at all before calling parse_args? We
> would want to allow options to come before the "-", no?
> 
> In other words, I think the right fix is more like this:
> 
> -- >8 --
> Subject: [PATCH] cherry-pick: handle "-" after parsing options
> 
> Currently, we only try converting argv[1] from "-" into
> "@{-1}".  This means we do not notice "-" when used together
> with an option. We can fix this by doing the substitution
> after we know any remaining options must be revisions.
> 
> Since we now also come after the check that there is
> something in argv to cherry-pick, this has the added bonus
> of avoiding a segfault when "git cherry-pick" is run with no
> options.
> 
> Noticed-by: Stefan Beller <stefanbeller@googlemail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I still am unsure if we should be more robust about finding "-" in other
> options. 

There was a discusssion about it recently. - would generally mean the
last thing (kind of an undo), so git checkout - would switch to the last
branch. It's similar to 'cd -'.
So I am not sure if this is generally @{-1}, or if we need to have other
references for other commands.

For example, I think you can cherry-pick multiple commits these
> days. Should we allow something like:
> 
>   git cherry-pick foo~2 - bar~5



> 
> Certainly the convenience of "-" over "@{-1}" is not as big a deal if
> you are cherry-picking more than one item, but it seems like we should
> treat it consistently.
> 
>  builtin/revert.c              |  4 ++--
>  t/t3501-revert-cherry-pick.sh | 12 ++++++++++++
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 52c35e7..87659c9 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -168,6 +168,8 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
>  		opts->revs->no_walk = REVISION_WALK_NO_WALK_UNSORTED;
>  		if (argc < 2)
>  			usage_with_options(usage_str, options);
> +		if (!strcmp(argv[1], "-"))
> +			argv[1] = "@{-1}";
>  		memset(&s_r_opt, 0, sizeof(s_r_opt));
>  		s_r_opt.assume_dashdash = 1;
>  		argc = setup_revisions(argc, argv, opts->revs, &s_r_opt);
> @@ -202,8 +204,6 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
>  	memset(&opts, 0, sizeof(opts));
>  	opts.action = REPLAY_PICK;
>  	git_config(git_default_config, NULL);
> -	if (!strcmp(argv[1], "-"))
> -		argv[1] = "@{-1}";
>  	parse_args(argc, argv, &opts);
>  	res = sequencer_pick_revisions(&opts);
>  	if (res < 0)
> diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
> index bff6ffe..51f3bbb 100755
> --- a/t/t3501-revert-cherry-pick.sh
> +++ b/t/t3501-revert-cherry-pick.sh
> @@ -129,4 +129,16 @@ test_expect_success 'cherry-pick "-" is meaningless without checkout' '
>  	)
>  '
>  
> +test_expect_success 'cherry-pick "-" works with arguments' '
> +	git checkout -b side-branch &&
> +	test_commit change actual change &&
> +	git checkout master &&
> +	git cherry-pick -s - &&
> +	echo "Signed-off-by: C O Mitter <committer@example.com>" >expect &&
> +	git cat-file commit HEAD | grep ^Signed-off-by: >signoff &&
> +	test_cmp expect signoff &&
> +	echo change >expect &&
> +	test_cmp expect actual
> +'
> +
>  test_done
> 
