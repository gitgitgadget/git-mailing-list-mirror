Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D32781FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 13:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679AbcHQNm5 (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 09:42:57 -0400
Received: from us-hpatc-esg-01.alcatel-lucent.com ([135.245.18.27]:38832 "EHLO
	smtp-us.alcatel-lucent.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751495AbcHQNm4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Aug 2016 09:42:56 -0400
Received: from us70tumx1.dmz.alcatel-lucent.com (unknown [135.245.18.13])
	by Websense Email Security Gateway with ESMTPS id 5E7F39B19282D;
	Wed, 17 Aug 2016 13:42:52 +0000 (GMT)
Received: from us70tusmtp1.zam.alcatel-lucent.com (us70tusmtp1.zam.alcatel-lucent.com [135.5.2.63])
	by us70tumx1.dmz.alcatel-lucent.com (GMO) with ESMTP id u7HDgsKO012220
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 17 Aug 2016 13:42:54 GMT
Received: from US70TWXCHHUB04.zam.alcatel-lucent.com (us70twxchhub04.zam.alcatel-lucent.com [135.5.2.36])
	by us70tusmtp1.zam.alcatel-lucent.com (GMO) with ESMTP id u7HDgrIR007431
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 17 Aug 2016 13:42:53 GMT
Received: from [135.121.197.20] (135.5.27.16) by
 US70TWXCHHUB04.zam.alcatel-lucent.com (135.5.2.36) with Microsoft SMTP Server
 (TLS) id 14.3.195.1; Wed, 17 Aug 2016 09:42:53 -0400
Subject: Re: git cherry-pick conflict error message is deceptive when
 cherry-picking multiple commits
To:	Christian Couder <christian.couder@gmail.com>
References: <09d485df-7d14-97f8-9db9-e3db7512bd68@nokia.com>
 <CAP8UFD04Z7JpoAA1kXkYFk5LD-GngbUDkbnpCEc3DNDXUgetEA@mail.gmail.com>
CC:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
From:	Stephen Morton <stephen.morton@nokia.com>
Organization: Nokia ION
Message-ID: <f58933df-352a-9d2b-a35a-9c48cb2d958e@nokia.com>
Date:	Wed, 17 Aug 2016 09:42:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <CAP8UFD04Z7JpoAA1kXkYFk5LD-GngbUDkbnpCEc3DNDXUgetEA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [135.5.27.16]
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Responding to a few comments...

On 2016-08-14 7:44 AM, Christian Couder wrote:
> multiple_commits)
> ... but here multiple_commits is the last argument.
> It would be better if it was more consistent.
(Johannes made the same comment.)
Yes. Will do.


>
> multiple_commits = (todo_list->next) != NULL;
> Why not "last_commit" instead of "multiple_commits"?
>

Because it *isn't*. You can see that in pick_commits(), I set 
multiple_commits outside of the `for todo_list` loop. It is not 
re-evaluated at every iteration of the loop. As per my comment when 
emailing the patch "I intentionally print the '--continue' hint even in 
the case where it's last of n commits that fails. " I think it makes 
much more sense that "this is the message you always get when 
cherry-picking multiple commits as opposed to "this is the message you 
sometimes get, except when it's the last one". (Yes, the careful 
observer will realize that if when cherry-picking multiple commits, 
there are conflicts in the second-last and last then the --continue  
from the second-last will result in multiple_commits being set to 0. I 
can live with that.)


On 2016-08-16 4:44 AM, Remi Galan Alfonso wrote:
> Hi Stephen,
>
> Stephen Morton <stephen.morton@nokia.com> writes:
>> +                        if  (multiple_commits)
>> +                               advise(_("after resolving the conflicts,
>> mark the corrected paths with 'git add <paths>' or 'git rm <paths>'\n"
>> +                                        "then continue with 'git %s
>> --continue'\n"
>> +                                        "or cancel with 'git %s
>> --abort'" ), action_name(opts), action_name(opts));
>> +                        else
>> +                                advise(_("after resolving the
>> conflicts, mark the corrected paths\n"
>> +                                        "with 'git add <paths>' or 'git
>> rm <paths>'\n"
>> +                                        "and commit the result with
>> 'git commit'"));
> In both cases (multiple_commits or not), the beginning of the advise
> is nearly the same, with only a '\n' in the middle being the
> difference:
>
> multiple_commits:
>   "after resolving the conflicts, mark the corrected paths with 'git
>   add <paths>' or 'git rm <paths>'\n"
>
> !multiple_commits:
>   "after resolving the conflicts, mark the corrected paths\n with 'git
>   add <paths>' or 'git rm <paths>'\n"
>                                                    ~~~~~~~^
>
> In 'multiple_commits' case the advise is more than 80 characters long,
> did you forget the '\n' in that case?
A previous comment had indicated that having 4 lines was too many. And I 
tend to agree. So I tried to squash it into 3. Back in xterm days, 80 
characters was sacrosanct, but is it really a big deal to exceed it now?


On 2016-08-14 7:44 AM, Christian Couder wrote:
> ...but please try to send a real patch.
>
> There is https://github.com/git/git/blob/master/Documentation/SubmittingPatches
> and also SubmitGit that can help you do that.
Agreed. I just want to send a patch that stands a reasonable chance of 
getting accepted.

Stephen


-- 
Stephen Morton, 7750 SR Product Group, SW Development Tools/DevOps
w: +1-613-784-6026 (int: 2-825-6026) m: +1-613-302-2589 | EST Time Zone

