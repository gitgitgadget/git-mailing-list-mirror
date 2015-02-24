From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] sequencer: preserve commit messages
Date: Tue, 24 Feb 2015 16:29:01 +0100
Message-ID: <54EC98BD.7060100@drmicha.warpmail.net>
References: <1424540906.15539.22.camel@scientia.net>	<f58ae048d7fd468cfdd7f7d369b3b4fc0a564641.1424697676.git.git@drmicha.warpmail.net> <xmqqsidwtq4i.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Christoph Anton Mitterer <calestyo@scientia.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 16:29:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQHQ6-0005bO-2J
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 16:29:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309AbbBXP3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 10:29:05 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48094 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751175AbbBXP3E (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Feb 2015 10:29:04 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 2F54A20971
	for <git@vger.kernel.org>; Tue, 24 Feb 2015 10:29:02 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 24 Feb 2015 10:29:02 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=4p/bwaLc7BAbys/jvDlH4O
	kKa/Y=; b=kg9TNjtDL4QwcylA7qwJLi067zu3GFBXeTZ019KiJXaRKusLg7pytu
	XiJ3LTZBapioMZ+jHwprB+4AMQp5RGn7nP3vyH5oh82DYegpGVryIZ5ugkQn1ek5
	ot7tn8pTbLPWGEheW433UI9PDngZ9aWzLMjUAXmUlnBB4D9bRAeKc=
X-Sasl-enc: 2bT3ZY2v5lQByz905wm6BPdVBQOGuLmZkpJeK5bqFNv5 1424791742
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 426F1C002A5;
	Tue, 24 Feb 2015 10:29:02 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <xmqqsidwtq4i.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264330>

Junio C Hamano venit, vidit, dixit 23.02.2015 19:54:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> sequencer calls "commit" with default options, which implies
>> "--cleanup=default" unless the user specified something else in their
>> config. This leads to cherry-picked commits getting a cleaned up commit
>> message, which is usually not an intended side-effect.
>>
>> Make the sequencer use "--cleanup=verbatim" so that it preserves commit
>> messages independent of the defaults and user config for "commit".
> 
> Hmm, wouldn't it introduce a grave regression for users who
> explicitly ask to clean crufty messages up (by setting their own
> commit.cleanup configuration) if you unconditionally force
> "--cleanup=verbatim" here?
> 

That's what I meant by possible side-effects below.

There are no side-effects which our tests would catch.

I don't know sequencer.c well enough to know whether run_git_commit()
would be run with a user-edited commit message at all. My (possibly
wrong) understanding is that it is called only when a cherry-pick
succeeds without any conflicts, so that it is called with a commit
message from a pre-existing commit, i.e. a message after cleanup which
is to be preserved as is.

In case of a conflict, resolution is left to be done by the user. But I
guess I'm overlooking --edit and --continue here.

But git cherry-pick without conflict should no re-cleanup the commit
message either, should it?

>> Reported-by: Christoph Anton Mitterer <calestyo@scientia.net>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>>
>> Notes:
>>     All tests run fine with this changed behavior. I don't know
>>     whether this may have any side-effects on other (untested)
>>     uses of the sequencer.
>>
>>  sequencer.c              |  1 +
>>  t/t3511-cherry-pick-x.sh | 28 ++++++++++++++++++++++++++++
>>  2 files changed, 29 insertions(+)
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index 77a1266..35fe9d9 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -377,6 +377,7 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
>>  	argv_array_init(&array);
>>  	argv_array_push(&array, "commit");
>>  	argv_array_push(&array, "-n");
>> +	argv_array_push(&array, "--cleanup=verbatim");
> 
> 
> 
>>  
>>  	if (opts->gpg_sign)
>>  		argv_array_pushf(&array, "-S%s", opts->gpg_sign);
>> diff --git a/t/t3511-cherry-pick-x.sh b/t/t3511-cherry-pick-x.sh
>> index f977279..b7dff09 100755
>> --- a/t/t3511-cherry-pick-x.sh
>> +++ b/t/t3511-cherry-pick-x.sh
>> @@ -36,6 +36,20 @@ mesg_with_cherry_footer="$mesg_with_footer_sob
>>  (cherry picked from commit da39a3ee5e6b4b0d3255bfef95601890afd80709)
>>  Tested-by: C.U. Thor <cuthor@example.com>"
>>  
>> +mesg_unclean="$mesg_one_line
>> +
>> +
>> +leading empty lines
>> +
>> +
>> +consecutive empty lines
>> +
>> +# hash tag comment
>> +
>> +trailing empty lines
>> +
>> +
>> +"
>>  
>>  test_expect_success setup '
>>  	git config advice.detachedhead false &&
>> @@ -53,6 +67,10 @@ test_expect_success setup '
>>  	test_commit "$mesg_with_footer_sob" foo b mesg-with-footer-sob &&
>>  	git reset --hard initial &&
>>  	test_commit "$mesg_with_cherry_footer" foo b mesg-with-cherry-footer &&
>> +	git reset --hard initial &&
>> +	test_config commit.cleanup verbatim &&
>> +	test_commit "$mesg_unclean" foo b mesg-unclean &&
>> +	test_unconfig commit.cleanup &&
>>  	pristine_detach initial &&
>>  	test_commit conflicting unrelated
>>  '
>> @@ -216,4 +234,14 @@ test_expect_success 'cherry-pick -x -s treats "(cherry picked from..." line as p
>>  	test_cmp expect actual
>>  '
>>  
>> +test_expect_success 'cherry-pick preserves commit message' '
>> +	pristine_detach initial &&
>> +	printf "$mesg_unclean" >expect &&
>> +	git log -1 --pretty=format:%B mesg-unclean >actual &&
>> +	test_cmp expect actual &&
>> +	git cherry-pick mesg-unclean &&
>> +	git log -1 --pretty=format:%B >actual &&
>> +	test_cmp expect actual
>> +'
>> +
>>  test_done
