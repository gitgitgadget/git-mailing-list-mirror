From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC] add test cases for the --repo option to git push
Date: Thu, 26 Feb 2009 10:26:47 +0100
Message-ID: <49A66057.1050501@drmicha.warpmail.net>
References: <76718490902210132w2577c093tf8c2a5e7da8bc0e8@mail.gmail.com> <1235497240-20677-1-git-send-email-git@drmicha.warpmail.net> <7vhc2iyy9y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 26 10:28:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LccXy-0005CV-Cj
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 10:28:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752975AbZBZJ1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 04:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752883AbZBZJ1A
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 04:27:00 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44032 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754797AbZBZJ06 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Feb 2009 04:26:58 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id C06702A3A58;
	Thu, 26 Feb 2009 04:26:55 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 26 Feb 2009 04:26:55 -0500
X-Sasl-enc: TG9XA53le+nva66cYcIinYJfVX9maeoksPWaX8BhW9Ng 1235640415
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E340538102;
	Thu, 26 Feb 2009 04:26:54 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090226 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <7vhc2iyy9y.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111545>

Junio C Hamano venit, vidit, dixit 25.02.2009 22:58:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> @@ -419,6 +419,41 @@ test_expect_success 'push with config remote.*.push = HEAD' '
>>  git config --remove-section remote.there
>>  git config --remove-section branch.master
>>  
>> +test_expect_success 'push with --repo=repourl from non-tracking branch' '
>> +
>> +	mk_test heads/master &&
>> +	git push --repo=testrepo &&
>> +	check_push_result $the_commit heads/master
>> +'
>> +
>> +# set up fake remote config
>> +test_expect_success 'push with --repo=remoterepo from non-tracking branch' '
>> +
>> +	mk_test heads/master &&
>> +	git config remote.testremote.url testrepo &&
>> +	git push --repo=testremote &&
>> +	check_push_result $the_commit heads/master
>> +'
>> +
>> +# set up fake tracking info; testrepo exists, origin does not.
>> +test_expect_failure 'push with --repo=repo from tracking branch with bad config' '
>> +
>> +	mk_test heads/master &&
>> +	git config branch.master.remote origin &&
>> +	test_must_fail git push --repo=testrepo
>> +'
> 
> At this point, you have:
> 
> 	branch.master.remote = origin
>         remote.testremote.url = testrepo
> 
> and nothing else related to push.  And you are asking a "git push but
> instead of origin please default to testrepo".
> 
> In response to that request, in order to figure out what refs to push by
> default, remote.testremote.push instead of remote.origin.push will be
> consulted, and we won't even have to notice nor complain the missing
> remote.origin.  remote.testremote.push is missing, so the push defaults to
> the "matching ref" behaviour.
> 
> I do not understand why you expect the above to fail.

First of all: I define good/bad as matching the documentation. Current
behaviour does not match the doc: "git push--repo=repo" is equivalent to
"git push repo" with the current code. One could simply document it as
such, of course. I took the other approach: Test for documented
behaviour and adjust the code.

Now for the test above:
I expect:
git push looks whether the branch tracks a remote.
It finds "origin" due to branch.master.remote=origin
It looks for a push refspec.
It finds none thus uses the default.
It pushes to origin with the default refspec and fails because there is
no remote origin.
This is why I have test_must_fail

I get with current behaviour:
git takes the --repo=testrepo argument instead of the tracking info.
push succeeds accordingly.
This is why I have test_expect_failure.

After the fix in PATCH 2/2, the behaviour matches exactly what I
described under expect. Note that I did not change the handling of
tracking info etc. at all in the PATCH, I only changed the treatment of
the --repo option and produced the expected behaviour.

>> +test_expect_failure 'push with --repo=repo from tracking branch with good config' '
>> +
>> +	mk_test heads/master &&
>> +	git config branch.master.remote testrepo &&
>> +	git push --repo=origin &&
>> +	check_push_result $the_commit heads/master
>> +'
> 
> Likewise.

Uhm, yes, likewise ;)
Expect:
git push looks whether the branch tracks a remote.
It finds "testrepo" due to branch.master.remote=testrepo
It looks for a push refspec.
It finds none thus uses the default.
It pushes to testrepo with the default refspec and succeeds (exists, has
matching refs).
For extra safety, I check that the push produced the correct ref on the
remote side.
This is why I expect it to succeed.

I get with current behaviour:
git takes the --repo=origin argument instead of the tracking info.
push fails because there is no remote origin.
This is why I have test_expect_failure.

Note that according to the doc, "git push --repo=origin" is equivalent
to "git push", but this test shows that it is not currently.

After PATCH 2/2 the test succeeds as expected.

> I think the "good/bad config" labels given to your two test scripts are
> swapped and there is no bug or misfeature here.

Well, there's a discrepancy between doc and behaviour, as reported by
Jay. The proposed patch brings them in line the hard way
(fixing/adjusting the code).

Michael
