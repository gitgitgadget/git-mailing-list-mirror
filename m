From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: Re: [PATCH 3/3] test-lib: '--run' to run only specific tests
Date: Wed, 30 Apr 2014 02:40:31 -0700
Message-ID: <5360C50F.7070505@gmail.com>
References: <1398154767-1276-1-git-send-email-ilya.bobyr@gmail.com>	<1398154767-1276-4-git-send-email-ilya.bobyr@gmail.com> <xmqqlhuvzy6r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 11:40:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfR0P-0006yd-HN
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 11:40:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758454AbaD3Jkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 05:40:41 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:59701 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757271AbaD3Jkk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 05:40:40 -0400
Received: by mail-ig0-f182.google.com with SMTP id l13so1422391iga.15
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 02:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=XhUvHBT7URkaK18A3coGuJrK0Q7xCz4PcabzxS7cTt0=;
        b=Tl8/ohGsFp+/o+zwJ6HDiCVebIiYhfgeu7CI5oqvZ+gp/WPuFlr2k4lRUL6P26ihmg
         0DDRMQSKN881AwGhznpN/5VHM3WnnptFtJY4v9BN8YL0Zxyb1lGsTesNsXJ+2h+L+gcA
         Un/MY1ey2E12mQk6+iqd8vBhCDWpjjo6apI+vyvZWNtKPPWJMJN72MciW6gMFjSCWYPa
         jl1a5d128W4tBxEoSrtl1B+U0gqk8CD6PFlKCpyhhhwVxQxPBijnmkjxGVerLfzoMWU3
         U2j6b4ndeFFAVAh0J3cRBA991DmuKlJE+K7JB87Hw96Pawq5QbGVa/DidCXDDJMD5eNA
         aGKg==
X-Received: by 10.50.153.72 with SMTP id ve8mr36802220igb.16.1398850840026;
        Wed, 30 Apr 2014 02:40:40 -0700 (PDT)
Received: from [192.168.1.2] (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id d10sm4319585igc.8.2014.04.30.02.40.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Apr 2014 02:40:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:29.0) Gecko/20100101 Thunderbird/29.0
In-Reply-To: <xmqqlhuvzy6r.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247689>

On 4/23/2014 11:40 AM, Junio C Hamano wrote:
> Ilya Bobyr <ilya.bobyr@gmail.com> writes:
>
>> @@ -187,10 +192,70 @@ and either can match the "t[0-9]{4}" part to skip the whole
>>  test, or t[0-9]{4} followed by ".$number" to say which
>>  particular test to skip.
>>  
>> -Note that some tests in the existing test suite rely on previous
>> -test item, so you cannot arbitrarily disable one and expect the
>> -remainder of test to check what the test originally was intended
>> -to check.
>> +For an individual test suite --run could be used to specify that
>> +only some tests should be run or that some tests should be
>> +excluded from a run.
>> +
>> +The argument for --run is a list of individual test numbers or
>> +ranges with an optional negation prefix that define what tests in
>> +a test suite to include in the run.  A range is two numbers
>> +separated with a dash and matches a range of tests with both ends
>> +been included.  You may omit the first or the second number to
>> +mean "from the first test" or "up to the very last test"
>> +respectively.
>> +
>> +Optional prefix of '!' means that the test or a range of tests
>> +should be excluded from the run.
>> +
>> +If --run starts with an unprefixed number or range the initial
>> +set of tests to run is empty. If the first item starts with '!'
>> +all the tests are added to the initial set.  After initial set is
>> +determined every test number or range is added or excluded from
>> +the set one by one, from left to right.
>> +
>> +Individual numbers or ranges could be separated either by a space
>> +or a comma.
>> +
>> +For example, common case is to run several setup tests (1, 2, 3)
>> +and then a specific test (21) that relies on that setup:
>> +
>> +    $ sh ./t9200-git-cvsexport-commit.sh --run='1 2 3 21'
>> +
>> +or:
>> +
>> +    $ sh ./t9200-git-cvsexport-commit.sh --run=1,2,3,21
>> +
>> +or:
>> +
>> +    $ sh ./t9200-git-cvsexport-commit.sh --run='-3 21'
> Good and easily understandable examples. 
>
>> +To run only tests up to a specific test (21), one could do this:
>> +
>> +    $ sh ./t9200-git-cvsexport-commit.sh --run='1-21'
>> +
>> +or this:
>> +
>> +    $ sh ./t9200-git-cvsexport-commit.sh --run='-21'
> These may be redundant, given that the reader would have to have
> grokked the earlier "-3 21" already at this point.

The original idea was to show two most common use cases in the examples,
so that one could just copy/paste it.
I guess you are right that the second is a bit redundant now from the
standpoint of a person who is reading all of it.

I have reordered the examples.  Single range is simpler, it comes first
and then a more complicated example.

>> +As noted above, the test set is built going though items left to
>> +right, so this:
>> +
>> +    $ sh ./t9200-git-cvsexport-commit.sh --run='1-4 !3'
>> +
>> +will run tests 1, 2, and 4.
> I do not quite understand what you mean by "left to right"; is that
> implementation detail necessary for the user of the feature, or is
> it talking about some limitation coming from the implementation?
> e.g. perhaps "!3 1-4" would not work as people would expect "do not
> run 3, but run tests from 1 thru 4 otherwise", and warning against
> having such an expectation that cannot be fulfilled?

I thought that it is something that you may want to understand if you
are going to build something complicated.  As I do not have a specific
use case, this is kind of a made up example.
The idea is that what is on the right overwrites what is on the left. 
I've added that sentence as an additional clarification, and your example.

>> +You may use negation with ranges.  The following will run all
>> +test as a test suite except from 7 upto 11:
>> +
>> +    $ sh ./t9200-git-cvsexport-commit.sh --run='!7-11'
> Hmm, that is somewhat counter-intuitive or at least ambiguous.  I
> first thought you would be running everything but skipping 7 thru
> 11, but your explanation is that it is equivalent to "-6,8-11" (that
> is, to intersect set "-11" and set "!7").

Your expectation is correct.
A space or a comma is needed in order for "!7" and "-11" to be treated
separately.
I am not sure why did you read the description as "-6,8-11".  There is a
typo in the sentence: s/as a/in the/.
I've changed that, but I would not object a better explanation of cause :)

> The above two illustrate the reason rather well why I said it would
> be better to avoid negation because it would complicate the mental
> model the user needs to form when using the feature.

I think that you do not have to use it if you do not need it.
It adds some expressiveness, is rather easy to implement and is already
there :)
I can remove it, of cause, but is it really necessary?

>> +Some tests in a test suite rely on the previous tests performing
>> +certain actions, specifically some tests are designated as
>> +"setup" test, so you cannot _arbitrarily_ disable one test and
>> +expect the rest to function correctly.
> What this text (moved from the top of this hunk) tells the reader
> applies to both the traditional t0123.4 and the new "--run=1-3,5-"
> syntaxes, but the new placement of it make it sound as if it is only
> for skipping with "--run", especially because the text before this
> paragraph and also after this paragraph both apply only to "--run".

True, but there is another paragraph at the beginning of the section
that talks why would you want to use GIT_SKIP_TESTS:

> In some environments, certain tests have no way of succeeding
> due to platform limitation, such as lack of 'unzip' program, or
> filesystem that do not allow arbitrary sequence of non-NUL bytes
> as pathnames.

I was thinking that if you would be working with individual test suits
you would use '--run'.
And this is where you more likely to think about setup tests.
I could move that paragraph just after the GIT_SKIP_TESTS description. 
Then it would apply more to both.
I am not sure it is needed.  Let me know if you think otherwise.

>> +--run is mostly useful when you want to focus on a specific test
>> +and know what you are doing.  Or when you want to run up to a
>> +certain test.
> Likewise for "and know what you are doing" part.  I'd suggest
> dropping that phrase from here, and/or make it part of the "you
> cannot randomly omit and expect later ones to work" that covers both
> ways to skip tests.

I've made this part a bit less wage.

Thank you for reviewing it :)
