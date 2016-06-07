From: Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>
Subject: Re: [RFC/PATCH v2] pull: add --set-upstream
Date: Tue, 7 Jun 2016 14:43:06 +0200
Message-ID: <8c74e096-f573-66b1-5f00-e4bb771720ee@grenoble-inp.org>
References: <20160525152528.22202-1-erwan.mathoniere@grenoble-inp.org>
 <20160606093437.1992-1-erwan.mathoniere@grenoble-inp.org>
 <vpqvb1mgvn5.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jordan.de-gea@grenoble-inp.org,
	samuel.groot@grenoble-inp.org, tom.russello@grenoble-inp.org,
	gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 07 14:44:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAGLm-00051w-QT
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 14:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755183AbcFGMnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 08:43:12 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:60966 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412AbcFGMnK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 08:43:10 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 753162561;
	Tue,  7 Jun 2016 14:43:06 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5nAqqtaEQzFJ; Tue,  7 Jun 2016 14:43:06 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 638B224F3;
	Tue,  7 Jun 2016 14:43:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 5CB1E2066;
	Tue,  7 Jun 2016 14:43:06 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RhXITYKOBFSq; Tue,  7 Jun 2016 14:43:06 +0200 (CEST)
Received: from [130.190.32.141] (eduroam-032141.grenet.fr [130.190.32.141])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 462CF2064;
	Tue,  7 Jun 2016 14:43:06 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
In-Reply-To: <vpqvb1mgvn5.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296668>



On 06/06/2016 17:54, Matthieu Moy wrote:
> Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org> writes:
>
>> @@ -497,6 +504,10 @@ static void NORETURN die_no_merge_candidates(const char *repo, const char **refs
>>  		fprintf(stderr, "\n");
>>  		fprintf_ln(stderr, _("If you wish to set tracking information for this branch you can do so with:"));
>>  		fprintf(stderr, "\n");
>> +		fprintf_ln(stderr, "    git pull -u %s %s", _("<remote>"), _("<branch>"));
>
> I'd rather use the long syntax "--set-upstream" in the advice. It gives
> a hint to the user about what the command is actually going to do.

You're right, I'll change it.

>> +static void set_pull_upstream(const char *repo, const char **refspecs_name)
>> +{
>> +	unsigned char sha1[GIT_SHA1_RAWSZ];
>
> The trend in the codebase is to use object_id instead of these char
> sha1[] arrays. See the output of "git log --grep object_id" for details.

I'll dig into it, thanks.

>> +	strbuf_init(&buf, 0);
>> +	refspec = parse_fetch_refspec(nr_refspec, refspecs_name);
>> +
>> +	for (i = 0; i < nr_refspec; i++) {
>> +		if (refspec[i].pattern) {
>> +			warning(_("upstream cannot be set for patterns"));
>> +			continue;
>> +		}
>> +
>> +		branch = branch_get(refspec[i].dst);
>> +		if (!branch || !ref_exists(branch->refname)) {
>> +			if (!refspec[i].dst || !*refspec[i].dst)
>> +				warning(_("could not set upstream of HEAD when "
>> +					"it does not point to any branch."));
>> +			else
>> +				warning(_("cannot set upstream: "
>> +					"'%s' is not a branch"), refspec[i].dst);
>
> Inconsistent message: "could not"/"cannot".

I copied/pasted the first warning from another portion of code in order 
to avoid useless translation work, but it isn't really relevant in that 
case.

> For this kind of code, it greatly helps to have comments refering to the
> input syntax for each branch of each conditionals. I'm not familiar with
> this part of the code, but if I understood correctly, the above would be
>
> if ()
> 	/* refspec: <branch>: */
>         warning(...);
> else
> 	/* refspec: <branch>:<no-such-branch> */
>         warning(...);

Good idea, some part aren't so easy to link to the input.

> I think it would make sense to actually raise an error (i.e. set the
> exit status of the "git pull" process to a non-zero value) when such
> issue occur. OTOH, "git push --set-upstream" does not even issue a
> warning when trying to --set-upstream to a tag for example, so not
> raising an error is consistant.

Since the idea is to have a similar behavior to `git push 
--set-upstream`, I think it's not relevant to raise an error when `git 
push` doesn't. And for a minor feature, it seems disproportionate to 
consider a `git pull -u ...` as a failure when the entire process 
succeeded except for the upstream part.

>>  int cmd_pull(int argc, const char **argv, const char *prefix)
>>  {
>> +	int ret;
>>  	const char *repo, **refspecs;
>>  	struct sha1_array merge_heads = SHA1_ARRAY_INIT;
>>  	unsigned char orig_head[GIT_SHA1_RAWSZ], curr_head[GIT_SHA1_RAWSZ];
>> @@ -918,11 +1013,16 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>>  	if (is_null_sha1(orig_head)) {
>>  		if (merge_heads.nr > 1)
>>  			die(_("Cannot merge multiple branches into empty head."));
>> -		return pull_into_void(*merge_heads.sha1, curr_head);
>> +		ret = pull_into_void(*merge_heads.sha1, curr_head);
>>  	} else if (opt_rebase) {
>>  		if (merge_heads.nr > 1)
>>  			die(_("Cannot rebase onto multiple branches."));
>> -		return run_rebase(curr_head, *merge_heads.sha1, rebase_fork_point);
>> +		ret = run_rebase(curr_head, *merge_heads.sha1, rebase_fork_point);
>>  	} else
>> -		return run_merge();
>> +		ret = run_merge();
>> +
>> +	if (opt_set_upstream && ret < 128)
>
> Shouldn't this be "ret == 0"?

The feature activates after rebasing/merging. When there are merge 
conflicts, `run_merge` doesn't return a non-null error code and we want 
to set upstream even in that case.
On the other hand, when merge fails (e.g. histories aren't related) it 
stops itself by invoking `die` and returning a >= 128 error code. We 
don't want to proceed in that case.

>> +check_config () {
>
> Perhaps "check_upstream" is more expressive.

I took this procedure from t5523-push-upstream, but you're right it's 
more relevant.

>> +	(echo "$2"; echo "$3") >expect
>
> What happened to Junio's suggestion with test_write_lines?

Oups,  small oversight.

>> +test_expect_success 'setup repos' '
>> +	git init parent &&
>> +	(
>> +		cd parent &&
>> +		echo content >file &&
>> +		git add file &&
>> +		git commit -am one &&
>
> test_commit can make this code simpler.
>
>> +		echo content_modified >file &&
>> +		git commit -am "file modification"
>
> Likewise.
>

Thanks, I'll take a look at it.

>> +test_expect_success 'pull -u with a tag should not work' '
>> +	git checkout master &&
>> +	test_config_unchanged git pull -u upstream initial_tag
>> +'
>> +
>> +test_expect_success 'pull -u on detached head should not work' '
>> +	git checkout HEAD^0 &&
>> +	test_config_unchanged git pull -u upstream master2 &&
>> +	git checkout -
>> +'
>
> For all these "test_config_unchanged", it would be nice to check that
> the error message is the right one too.

Ok, I'll add checks on that.
