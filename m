From: Michael Grubb <devel@dailyvoid.com>
Subject: Re: [PATCH v3] Add default merge options for all branches
Date: Tue, 03 May 2011 11:46:58 -0500
Message-ID: <4DC03182.505@dailyvoid.com>
References: <4DBF04C5.1080608@dailyvoid.com> <4DBF94E9.2010502@dailyvoid.com> <20110503090351.GA27862@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	vmiklos@frugalware.org, deskinm@umich.edu
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 03 18:47:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHIkl-0006jS-64
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 18:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753870Ab1ECQrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 12:47:08 -0400
Received: from 75.98.162.166.static.a2webhosting.com ([75.98.162.166]:44830
	"EHLO dailyvoid.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1753867Ab1ECQrH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 12:47:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=dailyvoid.com;
	h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Source:X-Source-Args:X-Source-Dir;
	b=fKN06cQvLa9o7ijn7vBe4acgel7ySPUKWIqliUPzf3dt++lpDpGIK4Fls9fkDT+aTkBpeu1XptyqNXAupKCQ1OyRe314cnYnrIbMLs3GuCmoGTHlJCQxhK2VL5ftz35r;
Received: from [99.59.251.170] (helo=macbook.local)
	by a2s24.a2hosting.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <devel@dailyvoid.com>)
	id 1QHIkW-0001Q0-8U; Tue, 03 May 2011 12:47:00 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <20110503090351.GA27862@elie>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - a2s24.a2hosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - dailyvoid.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172671>



On 5/3/11 4:03 AM, Jonathan Nieder wrote:
> Hi,
> 
> Michael Grubb wrote:
> 
>> Add support for branch.*.mergeoptions for setting default options for
>> all branches.  This new value shares semantics with the existing
>> branch.<name>.mergeoptions variable. If a branch specific value is
>> found, that value will be used.
> 
> So in the future one might be able to do things like
> 
> 	[branch "git-gui/*"]
> 		mergeoptions = -s subtree
> 
> Interesting.
> 
>> The need for this arises from the fact that there is currently not an
>> easy way to set merge options for all branches.
> 
> I'm curious: what merge options/workflows does this tend to be useful
> for?  The above explanation seems a bit abstract (though already
> convincing).
For myself I've adopted Vincent Driessen's branching model
(http://nvie.com/posts/a-successful-git-branching-model/)
Which specifically recommends using --no-ff when merging to preserve
the history of the existence of a topic branch once those branches are
removed.  But it would equally be beneficial for folks that want the
--log, etc option turned on for every merge.

> 
>> The approach taken is to make note of whether a branch specific
>> mergeoptions key has been seen and only apply the global value if it
>> hasn't.
> 
> What happens if the global value is seen first?
I will code a test for this, but if the global option is seen first then
those options are used, unless/until a branch specific option is seen which will
override the globals.  If the branch specific option is seen first then the global
options are ignored.  (I did test this btw, but I didn't add it in the unit tests, bad me).

> 
> On to the code.  Warning: nitpicks ahead.
> 
> [...]
>> +++ b/builtin/merge.c
>> @@ -32,6 +32,13 @@
>>  #define NO_FAST_FORWARD (1<<2)
>>  #define NO_TRIVIAL      (1<<3)
>>  
>> +#define MERGEOPTIONS_DEFAULT (1<<0)
>> +#define MERGEOPTIONS_BRANCH (1<<1)
> 
> Are these bitflags?
I had been using literals in the git_merge_config function but thought better of it and added
these defines.  I'm not really using them as bitflags right now.  Perhaps an enum, or just plain
literals are better.  I'm not clear what the best practice is in this case, so I'm certainly open
to a better/more clear way of doing this.

> 
>> @@ -505,24 +512,42 @@ cleanup:
>>  
>>  static int git_merge_config(const char *k, const char *v, void *cb)
>>  {
>> +	int merge_option_mode = 0;
>> +	struct merge_options_cb *merge_options =
>> +		(struct merge_options_cb *)cb;
> 
> This cast should not needed, I'd think.
Indeed.  It has been removed.

> 
> [...]
>> -	if (branch && !prefixcmp(k, "branch.") &&
>> -		!prefixcmp(k + 7, branch) &&
>> -		!strcmp(k + 7 + strlen(branch), ".mergeoptions")) {
>> +	if (!strcmp(k, "branch.*.mergeoptions"))
>> +		merge_option_mode = MERGEOPTIONS_DEFAULT;
>> +	else if (branch && !prefixcmp(k, "branch.") &&
>> +			 !prefixcmp(k + 7, branch) &&
>> +			 !strcmp(k + 7 + strlen(branch), ".mergeoptions"))
>> +		merge_option_mode = MERGEOPTIONS_BRANCH;
>> +
>> +	if ((merge_option_mode == MERGEOPTIONS_DEFAULT &&
>> +		!merge_options->override_default) ||
>> +		merge_option_mode == MERGEOPTIONS_BRANCH) {
>>  		const char **argv;
> 
> It is hard to see at a glance where the "if" condition ends and
> the body begins.  Why not
I completely agree, though believe it or not, this was what the original code looked like
so I was following it's lead.  Here is what the original looks like:

	if (branch && !prefixcmp(k, "branch.") &&
		!prefixcmp(k + 7, branch) &&
		!strcmp(k + 7 + strlen(branch), ".mergeoptions")) {
		const char **argv;
		int argc;
		char *buf;

I would, of course, be happy to clear this up.
> 
> 	if ((merge_option_mode == MERGEOPTIONS_DEFAULT &&
> 	     !merge_options->override_default) ||
> 	    merge_option_mode == MERGEOPTIONS_BRANCH) {
> 		const char **argv;
> 		...
> 
> or
> 
> 	if (merge_option_mode == MERGEOPTIONS_BRANCH ? 1 :
> 	    merge_option_mode == MERGEOPTIONS_DEFAULT ?
> 			!merge_options->override_default : 0) {
> 		const char **argv;
> 		...
> 
> or even
> 
> 	if (merge_option_mode == MERGEOPTIONS_DEFAULT &&
> 	    merge_options->override_default)
> 		merge_option_mode = 0;
> 
> 	if (merge_option_mode) {
> 		const char **argv;
> 		...
> 
> ?
> 	    
>>  		int argc;
>>  		char *buf;
>>  
>>  		buf = xstrdup(v);
>>  		argc = split_cmdline(buf, &argv);
>> -		if (argc < 0)
>> -			die(_("Bad branch.%s.mergeoptions string: %s"), branch,
>> -			    split_cmdline_strerror(argc));
>> +		if (argc < 0) {
>> +			if (merge_option_mode == 1)
>> +				die(_("Bad merge.mergeoptions string: %s"), 
>> +					split_cmdline_strerror(argc));
> 
> merge.*.mergeoptions, no?
> 
>> +			else
>> +				die(_("Bad branch.%s.mergeoptions string: %s"), branch,
>> +					split_cmdline_strerror(argc));
>> +		}
>>  		argv = xrealloc(argv, sizeof(*argv) * (argc + 2));
>>  		memmove(argv + 1, argv, sizeof(*argv) * (argc + 1));
>>  		argc++;
>>  		parse_options(argc, argv, NULL, builtin_merge_options,
>>  			      builtin_merge_usage, 0);
>>  		free(buf);
>> +		if (merge_option_mode == MERGEOPTIONS_BRANCH)
>> +			merge_options->override_default = 1;
> 
> Could be clearer to put this next to the code that checks
> override_default.
Yes. I had put this there originally so that it would only be set if there were no errors in parsing the options
but after chasing the rabbit down the whole, if there are errors parse_options won't return, so I'll move this
up closer to the override_default check.
> 
> [...]
>> --- a/t/t7600-merge.sh
>> +++ b/t/t7600-merge.sh
>> @@ -415,6 +415,33 @@ test_expect_success 'merge c0 with c1 (no-ff)' '
>>  
>>  test_debug 'git log --graph --decorate --oneline --all'
>>  
>> +test_expect_success 'merge c0 with c1 (global no-ff)' '
>> +	git reset --hard c0 &&
>> +	git config --unset branch.master.mergeoptions &&
> 
> Better to make that
> 
> 	test_might_fail git config --unset ...
> 
> so it will still work if earlier tests stop setting that
> variable.
> 
>> +	git config "branch.*.mergeoptions" "--no-ff" &&
>> +	test_tick &&
>> +	git merge c1 &&
>> +	git config --remove-section "branch.*" &&
>> +	verify_merge file result.1 &&
>> +	verify_parents $c0 $c1
>> +'
>> +
>> +test_debug 'git log --graph --decorate --oneline --all'
> 
> Yuck.  Did anything come of the idea of a --between-tests option to
> use an arbitrary command here automatically?  (Not your fault.)  
> 
>> +
>> +test_expect_success 'combine merge.mergeoptions with branch.x.mergeoptions' '
>> +	git reset --hard c0 &&
>> +	git config --remove-section branch.master &&
> 
> Could make sense to use test_might_fail for this one, too.
> 
>> +	git config "branch.*.mergeoptions" "--no-ff" &&
>> +	git config branch.master.mergeoptions "--ff" &&
>> +	test_tick &&
>> +	git merge c1 &&
>> +	git config --remove-section "branch.*" &&
>> +	verify_merge file result.1 &&
>> +	verify_parents "$c0"
>> +'
>> +
>> +test_debug 'git log --graph --decorate --oneline --all'
> 
> Nice, a clean patch with a few reasonable tests.
Thanks for all the constructive criticism, Jonathan.
I will make the recommended changes and post a new patch.

> 
> With whichever of the changes below make sense,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> 
> Thanks.
> ---
>  builtin/merge.c  |   37 ++++++++++++++++++++-----------------
>  t/t7600-merge.sh |    4 ++--
>  2 files changed, 22 insertions(+), 19 deletions(-)
> 
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 9fe129f..7156e92 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -32,8 +32,8 @@
>  #define NO_FAST_FORWARD (1<<2)
>  #define NO_TRIVIAL      (1<<3)
>  
> -#define MERGEOPTIONS_DEFAULT (1<<0)
> -#define MERGEOPTIONS_BRANCH (1<<1)
> +#define MERGEOPTIONS_DEFAULT 1
> +#define MERGEOPTIONS_BRANCH 2
>  
>  struct merge_options_cb {
>  	int override_default;
> @@ -513,8 +513,7 @@ cleanup:
>  static int git_merge_config(const char *k, const char *v, void *cb)
>  {
>  	int merge_option_mode = 0;
> -	struct merge_options_cb *merge_options =
> -		(struct merge_options_cb *)cb;
> +	struct merge_options_cb *merge_options = cb;
>  
>  	if (!strcmp(k, "branch.*.mergeoptions"))
>  		merge_option_mode = MERGEOPTIONS_DEFAULT;
> @@ -523,31 +522,35 @@ static int git_merge_config(const char *k, const char *v, void *cb)
>  			 !strcmp(k + 7 + strlen(branch), ".mergeoptions"))
>  		merge_option_mode = MERGEOPTIONS_BRANCH;
>  
> -	if ((merge_option_mode == MERGEOPTIONS_DEFAULT &&
> -		!merge_options->override_default) ||
> -		merge_option_mode == MERGEOPTIONS_BRANCH) {
> +	/*
> +	 * If an applicable [branch "foo"] mergeoptions setting was
> +	 * seen already, let it mask the [branch "*"] defaults.
> +	 */
> +	if (merge_options->override_default &&
> +	    merge_option_mode == MERGEOPTIONS_DEFAULT)
> +		merge_option_mode = 0;
> +
> +	if (merge_option_mode == MERGEOPTIONS_BRANCH)
> +		merge_options->override_default = 1;
> +
> +	if (merge_option_mode) {
>  		const char **argv;
>  		int argc;
>  		char *buf;
>  
>  		buf = xstrdup(v);
>  		argc = split_cmdline(buf, &argv);
> -		if (argc < 0) {
> -			if (merge_option_mode == 1)
> -				die(_("Bad merge.mergeoptions string: %s"), 
> -					split_cmdline_strerror(argc));
> -			else
> -				die(_("Bad branch.%s.mergeoptions string: %s"), branch,
> -					split_cmdline_strerror(argc));
> -		}
> +		if (argc < 0)
> +			die(_("Bad merge.%s.mergeoptions string: %s"), 
> +			    merge_option_mode == MERGEOPTIONS_DEFAULT ?
> +							"*" : branch,
> +			    split_cmdline_strerror(argc));
>  		argv = xrealloc(argv, sizeof(*argv) * (argc + 2));
>  		memmove(argv + 1, argv, sizeof(*argv) * (argc + 1));
>  		argc++;
>  		parse_options(argc, argv, NULL, builtin_merge_options,
>  			      builtin_merge_usage, 0);
>  		free(buf);
> -		if (merge_option_mode == MERGEOPTIONS_BRANCH)
> -			merge_options->override_default = 1;
>  	}
>  
>  	if (!strcmp(k, "merge.diffstat") || !strcmp(k, "merge.stat"))
> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> index cea2b31..ff807f4 100755
> --- a/t/t7600-merge.sh
> +++ b/t/t7600-merge.sh
> @@ -417,7 +417,7 @@ test_debug 'git log --graph --decorate --oneline --all'
>  
>  test_expect_success 'merge c0 with c1 (global no-ff)' '
>  	git reset --hard c0 &&
> -	git config --unset branch.master.mergeoptions &&
> +	test_might_fail git config --unset branch.master.mergeoptions &&
>  	git config "branch.*.mergeoptions" "--no-ff" &&
>  	test_tick &&
>  	git merge c1 &&
> @@ -430,7 +430,7 @@ test_debug 'git log --graph --decorate --oneline --all'
>  
>  test_expect_success 'combine merge.mergeoptions with branch.x.mergeoptions' '
>  	git reset --hard c0 &&
> -	git config --remove-section branch.master &&
> +	test_might_fail git config --remove-section branch.master &&
>  	git config "branch.*.mergeoptions" "--no-ff" &&
>  	git config branch.master.mergeoptions "--ff" &&
>  	test_tick &&
