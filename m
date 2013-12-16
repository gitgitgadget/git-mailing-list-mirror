From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] diff: move no-index detection to builtin/diff.c
Date: Mon, 16 Dec 2013 09:48:10 -0800
Message-ID: <xmqqtxe8pu05.fsf@gitster.dls.corp.google.com>
References: <20131210181655.GB2311@google.com>
	<1386755923-22132-1-git-send-email-t.gummerer@gmail.com>
	<20131214004347.GZ2311@google.com> <87zjo3lnn9.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 16 18:48:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VscHD-0002sh-Kx
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 18:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754657Ab3LPRsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 12:48:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44588 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754536Ab3LPRsO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 12:48:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 60E2E59FBF;
	Mon, 16 Dec 2013 12:48:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SjW3n4aKzrnstKueGR0RUr8dJTI=; b=oedYXC
	cdsFo58dZTjv3v61p6CB3S1JV4u02GD9WBc3cxI4GHj3J+s580BHvr7NMETIybCn
	zMmBhI1fmhL+1BrzaD/b1le8OCpcAWfroOJzs7iVItNnQfKVWpB6r6Bl8cZfCrLx
	95YhckoQImcuR1mtWwPtGtN+oBmBGViVfrwZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E0CTmR4eInCLQN9f+rpAnro8WtqXpqlA
	27/AdOT8PM2mlY5+JThJNyPVfnyq38gA684inD25gX6JdBhJfr8GK9N2CkBvN0Nj
	ADtTxk89VfBoDK96TjJSHAJZrdnA9CZ4nnI9ZHPmsxnEf5naF6ORCcSe8QE9wEog
	YiutNI1nZAU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5142759FB9;
	Mon, 16 Dec 2013 12:48:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 78BF059FB3;
	Mon, 16 Dec 2013 12:48:12 -0500 (EST)
In-Reply-To: <87zjo3lnn9.fsf@gmail.com> (Thomas Gummerer's message of "Sat, 14
	Dec 2013 11:42:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3BC16BAE-667A-11E3-86D3-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239341>

Thomas Gummerer <t.gummerer@gmail.com> writes:

>> What happens if I run 'git diff --no-index /tmp git.c git.c' from
>> within a git repository?  With this, I fear I will get
>
> Thanks, I've missed that one.  It only happens when run outside a git
> repository, but the same  comments still apply.  Will fix and send a
> re-roll.

Please don't, as the last round has already been pushed on 'next'.

An incremental change on top would also illustrate more clearly what
breakage needed to be fixed, which would be another good thing. It
could even come with a new test that makes sure that the above
command line is diagnosed correctly as a mistake ;-).

Thanks.

>
>> 	Not a git repository
>> 	To compare two paths outside a working tree:
>> 	usage: git diff [--no-index] <path> <path>
>>
>> instead of the expected
>>
>> 	usage: git diff --no-index <path> <path>
>>
>> Something like
>>
>> 	if (no_index)
>> 		;
>> 	else if (nongit)
>> 		no_index = DIFF_NO_INDEX_IMPLICIT;
>> 	else if (argc != i + 2)
>> 		;
>> 	else if (!path_inside_repo(prefix, argv[i]) ||
>> 		 !path_inside_repo(prefix, argv[i + 1]))
>> 		no_index = DIFF_NO_INDEX_IMPLICIT;
>>
>> should work.  Or:
>>
>> 	if (!no_index) {
>> 		/*
>> 		 * Treat git diff with ...
>> 		 */
>> 		if (nongit || ...)
>> 			no_index = DIFF_NO_INDEX_IMPLICIT;
>> 	}
>>
>> Or the '!no_index &&' condition inserted some other way.
>>
>>> -	/* If this is a no-index diff, just run it and exit there. */
>>> -	diff_no_index(&rev, argc, argv, nongit, prefix);
>>> +	if (no_index) {
>>> +		if (argc != i + 2) {
>> [...]
>>> +			/* Give the usage message for non-repository usage and exit. */
>>> +			usagef("git diff %s <path> <path>",
>>> +			       no_index == DIFF_NO_INDEX_EXPLICIT ?
>>> +					"--no-index" : "[--no-index]");
>>> +
>>> +		}
>>> +		/* If this is a no-index diff, just run it and exit there. */
>>> +		diff_no_index(&rev, argc, argv, prefix);
>>> +	}
>>
>> Perhaps, to avoid some nesting:
>>
>> 	/* A no-index diff takes exactly two path arguments. */
>> 	if (no_index && argc != i + 2) {
>> 		...
>> 		usagef(...);
>> 	}
>>
>> 	if (no_index)
>> 		/* Just run the diff and exit. */
>> 		diff_no_index(...);
>>
>> Jonathan
>
> Thanks, will change in the re-roll.
>
> --
> Thomas
