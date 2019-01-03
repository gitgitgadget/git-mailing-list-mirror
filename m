Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E302A1F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 02:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbfACCgS (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Jan 2019 21:36:18 -0500
Received: from fed1rmfepo102.cox.net ([68.230.241.144]:37601 "EHLO
        fed1rmfepo102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbfACCgS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jan 2019 21:36:18 -0500
Received: from fed1rmimpo306.cox.net ([68.230.241.174])
          by fed1rmfepo102.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20190103023617.MBTT12708.fed1rmfepo102.cox.net@fed1rmimpo306.cox.net>
          for <git@vger.kernel.org>; Wed, 2 Jan 2019 21:36:17 -0500
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id F06DFB82FAF;
        Wed,  2 Jan 2019 19:36:16 -0700 (MST)
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090209.5C2D7521.0032,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=Y4NMTSWN c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=kj9zAlcOel0A:10 a=3JhidrIBZZsA:10 a=kviXuzpPAAAA:8 a=ib3_6P4H19Zwoj-5UV0A:9
 a=CjuIK1q_8ugA:10 a=qrIFiuKZe2vaD64auk6j:22
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
From:   Stephen & Linda Smith <ischis2@cox.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 3/3] t0006-date.sh: add `human` date format tests.
Date:   Wed, 02 Jan 2019 19:36:16 -0700
Message-ID: <2832897.SWEsZI4Xea@thunderbird>
Organization: Personal
In-Reply-To: <xmqqva37j595.fsf@gitster-ct.c.googlers.com>
References: <20181231003150.8031-1-ischis2@cox.net> <20181231003150.8031-4-ischis2@cox.net> <xmqqva37j595.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, January 2, 2019 11:15:02 AM MST Junio C Hamano wrote:
> 'date +%s' is used everywhere in this patch but has never been used
> in our test suite before.  It is not portable.
So I don't make this mistake again, Is there a reference somewhere for that is 
and is not portable?

> 
> We perhaps can use "test-tool date timestamp", like so
> 
> 	check_human_date $(test-tool date timestamp "18000 seconds ago") ...
> 
> or moving the part that munges 18000 into the above form inside
> check_human_date helper function, e.g.
> 
> 	check_human_date () {
> 		commit_date=$(test-tool date timestamp "$1 seconds ago")
> 		commit_date="$commit_date +0200"
>                 expect=$2
> 		...
> 	}
> 
> which would let us write
> 
> 	check_human_date 432000" $THIS_YEAR_REGEX  # 5 days ago
Thanks

>
> > +check_human_date() {
> > +	commit_date=$1
> > +	expect=$2
> > +	test_expect_success "$commit_date" "
> > +		echo $expect $commit_date >dates &&
> > +		git add dates &&
> > +		git commit -m 'Expect String' --date=\"$commit_date\" dates &&
> > +		git log -1 --date=human | grep \"^Date:\" >actual &&
> > +		grep \"$expect\" actual
> > +"
> 
> As the body of the test_expect_success helper is eval'ed, variables
> $commit_date and $expect should be visible to it, without turning
> them into values before executing test_expect_success function,
> i.e.
> 
> 	test_expect_success "$commit_date" '
> 		echo "$expect $commit_date" >dates &&
> 		...
> 		git commit -m "Expect String" --date="$commit_date" dates &&
> 		git show -s --date=human | grep '^Date:" >actual &&
> 		grep "$expect" actual
> 	'
> 
> which would reduce the need for unreadable backslashes.
I was worried about embedded spaces that might not be parsed correctly by the 
called function.  I will update

> 
> Instead of duplicating, perhaps move this to a more common place?
> Would it make sense to make it "check_date_format ()" helper by
> passing another argument to parameterize --date=human part
I had considered that, but then noted that for the other formats specific 
strings were being used.  The use of specific strings was possible since the 
other formats were always guarenteed to have the same string literal due to a 
singe unvarying input.

I don't mind parameterize the format and it would make the solution more 
general.


> > "Stephen P. Smith" <ischis2@cox.net> writes:
> > +# Subtract some known constant time and look for expected field format
> > +TODAY_REGEX='5 hours ago'
> > +THIS_YEAR_REGEX='[A-Z][a-z][a-z] [A-Z][a-z][a-z] [0-9]*
> > [012][0-9]:[0-6][0-9]' +MORE_THAN_A_YEAR_REGEX='[A-Z][a-z][a-z]
> > [A-Z][a-z][a-z] [0-9]* [0-9][0-9][0-9][0-9]' +check_human_date "$(($(date
> > +%s)-18000)) +0200" $TODAY_REGEX # 5 hours ago +check_human_date
> > "$(($(date +%s)-432000)) +0200" $THIS_YEAR_REGEX  # 5 days ago
> > +check_human_date() {
> > +	commit_date=$1
> > +	expect=$2
> > +	test_expect_success "$commit_date" "
> > +		echo $expect $commit_date >dates &&
> > +		git add dates &&
> > +		git commit -m 'Expect String' --date=\"$commit_date\" dates &&
> > +		git show --date=human | grep \"^Date:\" >actual &&
> 
> Using "show" here is much better than "log -1" above; using "show
> -s" would be even better.

I was attempting to test both git log and git show.  For get log the `-1` was 
to only get the latest commit.

Are you suggesting that t4202-log.sh not be updated and that only and  t7007-
show.sh and t0006-date.sh updated?  

Side note:  I found when updating that all three scripts that log and show 
returned the same formats, but date returned a different string if the delta 
date was less than 24hours

I just noted that the patch 3/3 should be re-titled since the tests are 
currently for three commands.

Hope you are better.
sps



