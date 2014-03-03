From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] test-lib: GIT_TEST_ONLY to run only specific tests
Date: Mon, 03 Mar 2014 15:26:13 -0800
Message-ID: <xmqqob1mn9t6.fsf@gitster.dls.corp.google.com>
References: <1393842298-5944-1-git-send-email-ilya.bobyr@gmail.com>
	<1393842298-5944-2-git-send-email-ilya.bobyr@gmail.com>
	<CAPig+cT46ekT87TuoTtwvt0G+DraB9cdgW1wd6NsodjJ5FmJrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilya Bobyr <ilya.bobyr@gmail.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <tr@thomasrast.ch>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 00:26:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKcFa-0005Zt-Hm
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 00:26:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755730AbaCCX0S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 18:26:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63810 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755713AbaCCX0R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 18:26:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA3876BE63;
	Mon,  3 Mar 2014 18:26:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q4PYpTECpzeVzQzS9ok2ynWO++M=; b=vHUeNb
	xRh69reqBmRgBo8dwvmDdD9e7h3KMfbxJF7IPLvXDIm0NdfGRW+kwzOmnwnZ3G20
	F5SuhmUZSUcVaIare1zNCv7ezH3/xDnkfkkvDOcrxmAIAygJz5AAqBGUA+GT/o48
	OHkeU1YbmmPEaUVYbgNg32Fi0Pe0TBZE2UCMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jgO8lVFuDX8eynLABREIvYkOTqy8OEBv
	8JlLsCGbDALA2leLL2OmrqFPgJNZ/GQZ9xKMLVnEiARVN2GzDoM2YsHWCszz9pFl
	AF8tG+V//RPH3O3VEA1gyEricItofsM1BaYJHU240LL2Htw+3ZJ6xYmLKymjDaQm
	X3A4FMvOrag=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B79CB6BE62;
	Mon,  3 Mar 2014 18:26:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D99BB6BE5F;
	Mon,  3 Mar 2014 18:26:14 -0500 (EST)
In-Reply-To: <CAPig+cT46ekT87TuoTtwvt0G+DraB9cdgW1wd6NsodjJ5FmJrA@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 3 Mar 2014 18:03:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 36C4B104-A32B-11E3-9EB0-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243309>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Mar 3, 2014 at 5:24 AM, Ilya Bobyr <ilya.bobyr@gmail.com> wrote:
>> This is a counterpart to GIT_SKIP_TESTS.  Mostly useful when debugging.
>
> To be grammatically similar to GIT_SKIP_TESTS, perhaps name it GIT_RUN_TESTS?

I actually do not like the interface to use two variables very much.
Can't we just allow negative entries on "to be skipped" list?

That is

	GIT_SKIP_TESTS='t9??? !t91??'

would skip nine-thousand series, but would run 91xx series, and all
the others are not excluded.

Simple rules to consider:

 - If the list consists of _only_ negated patterns, pretend that
   there is "unless otherwise specified with negatives, skip all
   tests", i.e. treat GIT_SKIP_TESTS='!t91??' just the same way you
   would treat GIT_SKIP_TESTS='* !t91??'.

 - The orders should not matter for simplicity of the semantics;
   before running each test, check if it matches any negative (and
   run it if it matches, without looking at any positives), and
   otherwise check if it matches any positive (and skip it if it
   does not).

Hmm?

>> ---
>>  t/README      |   15 +++++++++++++++
>>  t/test-lib.sh |    8 ++++++++
>>  2 files changed, 23 insertions(+), 0 deletions(-)
>>
>> diff --git a/t/README b/t/README
>> index caeeb9d..f939987 100644
>> --- a/t/README
>> +++ b/t/README
>> @@ -187,6 +187,21 @@ and either can match the "t[0-9]{4}" part to skip the whole
>>  test, or t[0-9]{4} followed by ".$number" to say which
>>  particular test to skip.
>>
>> +Sometimes the opposite is desired - ability to execute only one or
>> +several tests.  Mostly while debugging tests.  For that you can say
>> +
>> +    $ GIT_TEST_ONLY=t9200.8 sh ./t9200-git-cvsexport-commit.sh
>> +
>> +or, similrary to GIT_SKIP_TESTS
>> +
>> +    $ GIT_TEST_ONLY='t[0-4]??? t91?? t9200.8' make
>> +
>> +In additiona to matching against "<test suite number>.<test number>"
>
> s/additiona/addition/
>
> Plus the other typos already mentioned by Philip...
>
>> +GIT_TEST_ONLY is matched against just the test numbes.  This comes
>> +handy when you are running only one test:
>> +
>> +    $ GIT_TEST_ONLY='[0-8]' sh ./t9200-git-cvsexport-commit.sh
>> +
>>  Note that some tests in the existing test suite rely on previous
>>  test item, so you cannot arbitrarily disable one and expect the
>>  remainder of test to check what the test originally was intended
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index 89a405b..12bf436 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -464,6 +464,14 @@ test_skip () {
>>                 fi
>>                 skipped_reason="missing $missing_prereq${of_prereq}"
>>         fi
>> +       if test -z "$to_skip" && test -n "$GIT_TEST_ONLY" &&
>> +               ! match_pattern_list $this_test.$test_count $GIT_TEST_ONLY &&
>> +               ! match_pattern_list $test_count $GIT_TEST_ONLY
>> +       then
>> +               to_skip=t
>> +               skipped_reason="not in GIT_TEST_ONLY"
>> +       fi
>> +
>>         case "$to_skip" in
>>         t)
>>                 say_color skip >&3 "skipping test: $@"
>> --
>> 1.7.9
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
