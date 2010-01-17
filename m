From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sample pre-commit hook: don't trigger when recording a
 merge
Date: Sun, 17 Jan 2010 14:24:49 -0800
Message-ID: <7vd418xtce.fsf@alter.siamese.dyndns.org>
References: <20100109081652.6117@nanako3.lavabit.com>
 <20100118061636.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Jan 17 23:25:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWdYv-0000JB-Id
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jan 2010 23:25:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754325Ab0AQWY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2010 17:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753033Ab0AQWY5
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jan 2010 17:24:57 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54151 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752857Ab0AQWY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2010 17:24:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ECA5491034;
	Sun, 17 Jan 2010 17:24:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Gy66m+J9nqDixJcEsowfesE9cXY=; b=w1vjHf
	wMOdoBaT9AObiI8vdxDjkK0WXOT0Hn2GA33ezVMArzJkl6t+Fug1+nQw1m16SjY8
	VuqMyAhbYQZcei+DgAL4Km+hKlNeaYm/TgOeQlXpyZbivs3UKJTfuauFOAFYIxPF
	2WNoI4O0BXKmQlBCSBdssfNcAQSLN4OuwdTcE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FfzwXl9ZMUakwqSuQUtR5na+K+T5RVoQ
	IX2DNjQ61Ffhkile9WM1Tzb3FhAm4HA6xwoNeh3Rh9vWpssEXxYYv2BUUBUIWhus
	TaTVernwT2xd8YvzyYEWs0g9Wxp2W5oPaycWX8+M/1nvKK7c78nNFtTmzajNELMZ
	559QhI/bN+o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C9E2A91033;
	Sun, 17 Jan 2010 17:24:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1BB0091031; Sun, 17 Jan
 2010 17:24:50 -0500 (EST)
In-Reply-To: <20100118061636.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Mon\, 18 Jan 2010 06\:16\:36 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 228D0604-03B7-11DF-A427-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137346>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> I sent this patch but didn't receive any feedback. Is it a bad idea?

I think the behaviour might make sense for some workflows but not always,
and it also depends on what is checked by the hook, and the extent of
damage detected by the check for a particular merge.

The sample hook checks whitespace breakage, and in the context of merging
other people's branch to obtain a change that is huge enough that neither
I nor the original author may be inclined to fix it up, it _might_ sense
to say that (1) the other branch is already borked and (2) it is too late
to fix it up.

But these two are different from (3) there is not much point complaining.

> It may be better if 'git-commit' didn't call this hook when recording a merge,

I doubt it.  I think it largely depends on where you are merging to as
well.  I may respond to a pull request by others by merging to 'pu', to
give the topic wider visibility, and in such a case I may wish to disable
the check.  On the other hand, when I redo the merge to advance the same
topic to 'next', I may want to notice the breakage so that I can tell the
person to clean up the branch before asking me to pull for real.

So I am slightly negative on this change; it would be better to reject
committing the merge and let the user decide if it is too much to bother
fixing up the other branch (in which case you would reset the merge away),
or let small breakages pass by running "git commit --no-verify" to bypass
the hook explicitly.

>> When recording a merge, even if there are problematic whitespace errors,
>> let them pass, because the damage has already been done in the history. If
>> this hook triggers, it will invite a novice to fix such errors in a merge
>> commit but such a change is not related to the merge. Don't encourage it.
>>
>> Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
>> ---
>>  templates/hooks--pre-commit.sample |    5 +++++
>>  1 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
>> index 439eefd..66e56bb 100755
>> --- a/templates/hooks--pre-commit.sample
>> +++ b/templates/hooks--pre-commit.sample
>> @@ -7,6 +7,11 @@
>>  #
>>  # To enable this hook, rename this file to "pre-commit".
>>  
>> +if test -f "${GIT_DIR-.git}"/MERGE_HEAD
>> +then
>> +	exit 0
>> +fi
>> +
>>  if git-rev-parse --verify HEAD >/dev/null 2>&1
>>  then
>>  	against=HEAD
>> -- 
>> 1.6.6
>>
>> -- 
>> Nanako Shiraishi
>> http://ivory.ap.teacup.com/nanako3/
>
> -- 
> Nanako Shiraishi
> http://ivory.ap.teacup.com/nanako3/
