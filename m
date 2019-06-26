Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68A731F461
	for <e@80x24.org>; Wed, 26 Jun 2019 20:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfFZUCU (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jun 2019 16:02:20 -0400
Received: from siwi.pair.com ([209.68.5.199]:42078 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbfFZUCU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jun 2019 16:02:20 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 863BB3F48D1;
        Wed, 26 Jun 2019 16:02:18 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:6539:9c95:c83:2e4f] (unknown [IPv6:2001:4898:a800:1010:166f:9c95:c83:2e4f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 2CA243F48CF;
        Wed, 26 Jun 2019 16:02:18 -0400 (EDT)
Subject: Re: [PATCH 1/3] status: add status.aheadbehind setting
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.272.git.gitgitgadget@gmail.com>
 <2f0f2a2df9410947b985d83a924d2549d62bb65f.1560889284.git.gitgitgadget@gmail.com>
 <xmqqzhmakidw.fsf@gitster-ct.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <c2b26b9d-827f-58b7-1938-023c246b7d9b@jeffhostetler.com>
Date:   Wed, 26 Jun 2019 16:02:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <xmqqzhmakidw.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/21/2019 12:33 PM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> The --[no-]ahead-behind option was introduced in fd9b544a
>> (status: add --[no-]ahead-behind to status and commit for V2
>> format, 2018-01-09). This is a necessary change of behavior
>> in repos where the remote tracking branches can move very
>> quickly ahead of the local branches. However, users need to
>> remember to provide the command-line argument every time.
>>
>> Add a new "status.aheadBehind" config setting to change the
>> default behavior of all git status formats.
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   Documentation/config/status.txt |  5 +++++
>>   builtin/commit.c                | 17 ++++++++++++++++-
>>   t/t6040-tracking-info.sh        | 31 +++++++++++++++++++++++++++++++
>>   t/t7064-wtstatus-pv2.sh         |  4 ++++
>>   4 files changed, 56 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/config/status.txt b/Documentation/config/status.txt
>> index ed72fa7dae..0fc704ab80 100644
>> --- a/Documentation/config/status.txt
>> +++ b/Documentation/config/status.txt
>> @@ -12,6 +12,11 @@ status.branch::
>>   	Set to true to enable --branch by default in linkgit:git-status[1].
>>   	The option --no-branch takes precedence over this variable.
>>   
>> +status.aheadBehind::
>> +	Set to true to enable `--ahead-behind` and false to enable
>> +	`--no-ahead-behind` by default in linkgit:git-status[1] for
>> +	non-porcelain status formats.  Defaults to true.
> 
> Sensible.
> 
>> @@ -1078,9 +1078,11 @@ static const char *read_commit_message(const char *name)
>>   static struct status_deferred_config {
>>   	enum wt_status_format status_format;
>>   	int show_branch;
>> +	enum ahead_behind_flags ahead_behind;
>>   } status_deferred_config = {
>>   	STATUS_FORMAT_UNSPECIFIED,
>> -	-1 /* unspecified */
>> +	-1, /* unspecified */
>> +	AHEAD_BEHIND_UNSPECIFIED,
> 
> This obviously is not a problem introduced by this patch, but is
> there a plan to extend this beyond a boolean?
> 
> Otherwise, a separate enum is way overkill.  Naming the field so
> that it is clear it is either true or false (e.g.  perhaps call it
> "ahead_behind_detailed" as the current "QUICK" is merely "are they
> equal?" which corresponds to "false", and "FULL" is to show the
> detailed info), and then use the usual "-1 is unspecified, 0 and 1
> are usual bools" convention would be more appropriate.
> 

At one point[1] we talked about having an intermediate option
to try N or less commits before giving up.  The enum would let
us add that case if we wanted it.

So far, I've not heard any complaints with just having QUICK or FULL
from our Windows developers, so adding a 3rd mode hasn't been a
priority.  But the enum is here if we do decide to do so.

Jeff

[1] 
https://public-inbox.org/git/20180111093943.GC9190@sigill.intra.peff.net/
