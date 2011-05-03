From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Add default merge options for all branches
Date: Tue, 03 May 2011 11:16:12 -0700
Message-ID: <7vk4e7ir9v.fsf@alter.siamese.dyndns.org>
References: <4DBF04C5.1080608@dailyvoid.com> <4DBF94E9.2010502@dailyvoid.com>
 <20110503090351.GA27862@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Grubb <devel@dailyvoid.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, vmiklos@frugalware.org,
	deskinm@umich.edu
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 03 20:16:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHK9E-0002D2-8c
	for gcvg-git-2@lo.gmane.org; Tue, 03 May 2011 20:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754128Ab1ECSQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2011 14:16:31 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34644 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160Ab1ECSQa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2011 14:16:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4E83C3867;
	Tue,  3 May 2011 14:18:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yRkFiaVFOGYrtFRKiUey++rFIfM=; b=KVqfF4
	ViN7LucXI04Wkv9i5rtVWDTLaCyjY5eGgfZ0MIUifjBeZr78DUwfLT0suvr7S5bm
	kvfYkLM7JGzEjiV8B5XOEq0oyVCHcwi7ftQDZ5MX1t9u8YqTGgWd6kr6GMs0RaYN
	I26ol8/V0pBDGf4qArCiUa83ErNdZcxVSB3Rs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h/hhqxjvOKBW3OWkjaI3xOVOGYU2IlUA
	waoKPIflKChte9+l1oreYFLRKHmqY2pfkHo4O1/MsUFZrh6OxI9/CUeFZ/Aq9o54
	ZvU4+7S6j4fI+GBY602gB+oL0IJZOAtjPhtpWBk/qYeO5AD7byh+qKGKiAJEuoi+
	61j7MMrfFUc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F0A6B3866;
	Tue,  3 May 2011 14:18:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 21097383E; Tue,  3 May 2011
 14:18:16 -0400 (EDT)
In-Reply-To: <20110503090351.GA27862@elie> (Jonathan Nieder's message of
 "Tue, 3 May 2011 04:03:52 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BCD61792-75B1-11E0-BD16-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172681>

Jonathan Nieder <jrnieder@gmail.com> writes:

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
> for?

I actually am curious myself, too.  I want to see a real-life example.

The "git-gui/*" example you gave is unfortunately not it. It specifies the
branch at the wrong end. Whether I am merging into "master" or "next", I
would want "-s subtree" when I am merging "git-gui/*" project, but all my
merges to "master" or "next" do not necessarily want to use "-s subtree".

It might turn out to be that "branch.<name>.mergeoptions" is a
ill-conceived idea to begin with.

>> The approach taken is to make note of whether a branch specific
>> mergeoptions key has been seen and only apply the global value if it
>> hasn't.
>
> What happens if the global value is seen first?

If implemented correctly, it should use the specific one and fall back to
the wildcard one.  Another issue is if the values should be cumulative or
overriding, but in the remainder I'd assume we want overriding.

>> @@ -505,24 +512,42 @@ cleanup:
>>  
>>  static int git_merge_config(const char *k, const char *v, void *cb)
>>  {
>> +	int merge_option_mode = 0;
>> +	struct merge_options_cb *merge_options =
>> +		(struct merge_options_cb *)cb;
>
> This cast should not needed, I'd think.

Correct.  That is the whole point of using (void *) as a parameter, so
that it can be assigned to the real expected type easily without cast.

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
> ...
> or even
> ...
> ?

Why not have two string pointers in merge_options_cb structure that are
initialized to NULL and holds the matched config key and the value?

When we are looking at a (k, v) pair in this function, if there is no
previous key in cb, we store (k, v) in cb and return.  If there already is
a previous key, we see if k is more specific than that key, and replace
(k, v) in cb with what we currently have.  Otherwise we do not do
anything.

When git_config() returns, the caller will find the final value in cb.

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

I actually think test_debug should go inside the previous test.  Why not
have it immediately after "git merge c1" above?
