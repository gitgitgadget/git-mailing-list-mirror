From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v3 4/8] combine-diff: do not pass revs->dense_combined_merges
 redundantly
Date: Thu, 11 Sep 2014 21:37:45 +0200
Message-ID: <5411FA09.3050303@web.de>
References: <cover.1409860234.git.tr@thomasrast.ch>	<33951a1d4be8ec15eec569e1a36c0a620b9edaa6.1409860234.git.tr@thomasrast.ch> <xmqqvboynhq2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Fredrik Gustafsson <iveqy@iveqy.com>
To: Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Thu Sep 11 21:38:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSABu-000447-BU
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 21:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756090AbaIKThz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 15:37:55 -0400
Received: from mout.web.de ([212.227.17.11]:55764 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752886AbaIKThy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 15:37:54 -0400
Received: from [192.168.178.41] ([79.193.78.148]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0Lh6UN-1Y6x012VDb-00oaT9; Thu, 11 Sep 2014 21:37:46
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <xmqqvboynhq2.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:n9pay3bJh8JcNJeoTUyHCo4/1CK2jX8FPINV/lVgZu6LD43c61K
 fuM5r0nEamavxktczTXMXNGYjbVgEp/76XiNAoxxBn7UYKMNgDtnSFOV/s6bjfvEKJeRHt4
 bKCwEGPjJd5FJzaqPa6o7h3AXXJGMin5GSWFiEPMRaWrIAictb26B50mnIiYhI6LgGYizwB
 HAXD4wla00WIi1xSehHMw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256869>

Am 08.09.2014 um 19:29 schrieb Junio C Hamano:
> Thomas Rast <tr@thomasrast.ch> writes:
>
>> The existing code passed revs->dense_combined_merges along revs itself
>> into the combine-diff functions, which is rather redundant.  Remove
>> the 'dense' argument until much further down the callchain to simplify
>> callers.
>
> It was not apparent that the changes to diff_tree_combined_merge()
> was correct without looking at both of its callsites, but one passes
> the .dense_combined_merges member, and the other in submodules
> always gives true, which you covered here:
>
>> Note that while the caller in submodule.c needs to do extra work now,
>> the next commit will simplify this to a single setting again.
>
>> diff --git a/submodule.c b/submodule.c
>> index c3a61e7..0499de6 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -482,10 +482,13 @@ static void find_unpushed_submodule_commits(struct commit *commit,
>>   	struct rev_info rev;
>>
>>   	init_revisions(&rev, NULL);
>> +	rev.ignore_merges = 0;
>> +	rev.combined_merges = 1;
>> +	rev.dense_combined_merges = 1;
>>   	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
>>   	rev.diffopt.format_callback = collect_submodules_from_diff;
>>   	rev.diffopt.format_callback_data = needs_pushing;
>> -	diff_tree_combined_merge(commit, 1, &rev);
>> +	diff_tree_combined_merge(commit, &rev);
>>   }
>
> I briefly wondered if there can be any unwanted side effects in this
> particular codepath that is caused by setting rev.combined_merges
> which was not set in the original code, but seeing that this &rev is
> not used for anything other than diff_tree_combined_merge(), it
> should be OK.
>
> Also I wondered if this is leaking whatever in the &rev structure,
> but in this call I think rev is used only for its embedded diffopt
> in a way that does not leak anything, so it seems to be OK, but I'd
> appreciate if submodule folks can double check.

The only thing the collect_submodules_from_diff() callback does
is to collect the to-be-pushed submodules in the needs_pushing
string_list initialized with STRING_LIST_INIT_DUP which is cleared
at the end of push_unpushed_submodules(), so I think we should be
ok here.
