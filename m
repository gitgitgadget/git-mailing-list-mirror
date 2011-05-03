From: Michael Grubb <devel@dailyvoid.com>
Subject: Re: [PATCH v3] Add default merge options for all branches
Date: Tue, 03 May 2011 15:22:53 -0500
Message-ID: <4DC0641D.5070403@dailyvoid.com>
References: <4DBF04C5.1080608@dailyvoid.com> <4DBF94E9.2010502@dailyvoid.com> <20110503090351.GA27862@elie> <7vk4e7ir9v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	vmiklos@frugalware.org, deskinm@umich.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 03 22:23:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHM7c-0001oa-UQ
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 22:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755107Ab1ECUW7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 16:22:59 -0400
Received: from 75.98.162.166.static.a2webhosting.com ([75.98.162.166]:33513
	"EHLO dailyvoid.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1754668Ab1ECUW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 16:22:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=dailyvoid.com;
	h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Source:X-Source-Args:X-Source-Dir;
	b=CDhrIqhHSreY9FEmVQ+x1RzonzxkNpJJkZhC0tHuA4z5l4M/6xfGgLLBS/AJrksA6yfeKrzXkV14jAEnk+JROQzcyb4kOsJa3GtiABusHc5vN0JQsVEGnogWlT60N3rU;
Received: from adsl-99-59-251-170.dsl.ltrkar.sbcglobal.net ([99.59.251.170] helo=macbook.local)
	by a2s24.a2hosting.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <devel@dailyvoid.com>)
	id 1QHM7S-0006Pq-Hs; Tue, 03 May 2011 16:22:54 -0400
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <7vk4e7ir9v.fsf@alter.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172688>



On 5/3/11 1:16 PM, Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
>> So in the future one might be able to do things like
>>
>> 	[branch "git-gui/*"]
>> 		mergeoptions = -s subtree
>>
>> Interesting.
>>
>>> The need for this arises from the fact that there is currently not an
>>> easy way to set merge options for all branches.
>>
>> I'm curious: what merge options/workflows does this tend to be useful
>> for?
> 
> I actually am curious myself, too.  I want to see a real-life example.
> 
In my reply to Jonathan I gave the example of turning off fast forward merges
globally for all branches (and then perhaps turning them back on for specific branches).
The same could be done with --log or any other option that might make since to turn on
for all branches without having to specifically name each branch in the config file.

Also as previously cited in my earlier reply to Jonathan, a good real life example can be
found in Vincent Driessen's branching model where he creates ephemeral feature/topic branches
for development then deletes them when they get merged back into the mainline development tree.
However, he wants to keep the history that there was a merge from a branch instead of it just looking
like a straight line.  The link to his work is here: http://nvie.com/posts/a-successful-git-branching-model/


> The "git-gui/*" example you gave is unfortunately not it. It specifies the
> branch at the wrong end. Whether I am merging into "master" or "next", I
> would want "-s subtree" when I am merging "git-gui/*" project, but all my
> merges to "master" or "next" do not necessarily want to use "-s subtree".
> 
> It might turn out to be that "branch.<name>.mergeoptions" is a
> ill-conceived idea to begin with.
> 
>>> The approach taken is to make note of whether a branch specific
>>> mergeoptions key has been seen and only apply the global value if it
>>> hasn't.
>>
>> What happens if the global value is seen first?
> 
> If implemented correctly, it should use the specific one and fall back to
> the wildcard one.  Another issue is if the values should be cumulative or
> overriding, but in the remainder I'd assume we want overriding.
> 
There is now a unit test for this scenario.

>>> @@ -505,24 +512,42 @@ cleanup:
>>>  
>>>  static int git_merge_config(const char *k, const char *v, void *cb)
>>>  {
>>> +	int merge_option_mode = 0;
>>> +	struct merge_options_cb *merge_options =
>>> +		(struct merge_options_cb *)cb;
>>
>> This cast should not needed, I'd think.
> 
> Correct.  That is the whole point of using (void *) as a parameter, so
> that it can be assigned to the real expected type easily without cast.
> 
This has been corrected in the latest version of the patch.

>>> +	if (!strcmp(k, "branch.*.mergeoptions"))
>>> +		merge_option_mode = MERGEOPTIONS_DEFAULT;
>>> +	else if (branch && !prefixcmp(k, "branch.") &&
>>> +			 !prefixcmp(k + 7, branch) &&
>>> +			 !strcmp(k + 7 + strlen(branch), ".mergeoptions"))
>>> +		merge_option_mode = MERGEOPTIONS_BRANCH;
>>> +
>>> +	if ((merge_option_mode == MERGEOPTIONS_DEFAULT &&
>>> +		!merge_options->override_default) ||
>>> +		merge_option_mode == MERGEOPTIONS_BRANCH) {
>>>  		const char **argv;
>>
>> It is hard to see at a glance where the "if" condition ends and
>> the body begins.  Why not
>> ...
>> or even
>> ...
>> ?
> 
> Why not have two string pointers in merge_options_cb structure that are
> initialized to NULL and holds the matched config key and the value?
> 
That was a great idea.  I've reworked things around this and also moved
to a voting type method for determining priority of the keys.  So no more
defines needed.  I think keeping all that state in the struct is much better
and scales better as well.

> When we are looking at a (k, v) pair in this function, if there is no
> previous key in cb, we store (k, v) in cb and return.  If there already is
> a previous key, we see if k is more specific than that key, and replace
> (k, v) in cb with what we currently have.  Otherwise we do not do
> anything.
> 
> When git_config() returns, the caller will find the final value in cb.
> 
>>> +	git config "branch.*.mergeoptions" "--no-ff" &&
>>> +	test_tick &&
>>> +	git merge c1 &&
>>> +	git config --remove-section "branch.*" &&
>>> +	verify_merge file result.1 &&
>>> +	verify_parents $c0 $c1
>>> +'
>>> +
>>> +test_debug 'git log --graph --decorate --oneline --all'
>>
>> Yuck.  Did anything come of the idea of a --between-tests option to
>> use an arbitrary command here automatically?  (Not your fault.)  
> 
> I actually think test_debug should go inside the previous test.  Why not
> have it immediately after "git merge c1" above?

Again I followed the existing pattern here. I didn't want to be the odd man out.
Do you want me to make that change?
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
