From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 2/2] Let deny.currentBranch=updateInstead ignore submodules
Date: Sun, 09 Nov 2014 17:42:56 +0100
Message-ID: <545F9990.9050505@web.de>
References: <cover.1415368490.git.johannes.schindelin@gmx.de>	<84dba8872922da96e99953eea0ccff5f5af9dd4a.1415368490.git.johannes.schindelin@gmx.de> <xmqqh9yag6mt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 09 17:43:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnVZz-0005mH-0X
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 17:43:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbaKIQnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 11:43:01 -0500
Received: from mout.web.de ([212.227.17.12]:53826 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751726AbaKIQnB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 11:43:01 -0500
Received: from [192.168.178.41] ([79.211.122.101]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0M3T1Y-1Y52Qb2BqC-00qyqm; Sun, 09 Nov 2014 17:42:57
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <xmqqh9yag6mt.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:B1kdDPsdx9gyzu2KAAWCRrpMhQIzYPV0PuQ5jtUDwmT+CVdWJBw
 omP3S+zCXKOBcZGeRwpzUVxutE8s+wENEGfzDpMrSQi1MFh5IGUehy6WKQGJVvR73tyytkL
 VLr/K0/v50xk5Zn8MPxpskzYHd8uDRcYCF1vD7AnXmA6Lmt9yyrbMIQXEkUywwXzkh5NUfV
 XP2jefniYq3Peu3D/wpVw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.11.2014 um 20:20 schrieb Junio C Hamano:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>
>> They are not affected by the update anyway.
>>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>>   builtin/receive-pack.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
>> index be4172f..4ba51df 100644
>> --- a/builtin/receive-pack.c
>> +++ b/builtin/receive-pack.c
>> @@ -740,7 +740,7 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
>>   static void merge_worktree(unsigned char *sha1)
>>   {
>>   	const char *update_refresh[] = {
>> -		"update-index", "--refresh", NULL
>> +		"update-index", "--ignore-submodules", "--refresh", NULL
>>   	};
>>   	const char *read_tree[] = {
>>   		"read-tree", "-u", "-m", sha1_to_hex(sha1), NULL
>
> I suspect that you did not squash this into 1/2 on purpose, and I am
> guessing the reason is because you were unsure what should happen
> when there were differences in submodules' working trees (otherwise,
> you would have simply squashed without "oops it was a thinko to
> forget passing this option" as a separate patch).  I am not sure
> either.

I think --ignore-submodules is currently the right thing to do here
and would rather squash this into the first commit.

> By the way, if the expected use case of updateInstead is what I
> outlined in the previous message, would it make more sense not to
> fail with "update-index --refresh" failure (i.e. the working tree
> files have no changes since the index)?
>
> Thinking about it a bit more, checking with "update-index --refresh"
> feels doubly wrong.  You not just want the working tree files to be
> pristine with respect to the index, but also you do not want to see
> any change between the index and the original HEAD, i.e.
>
> 	$ git reset --hard && echo >>Makefile ; git add Makefile
>          $ git update-index --refresh ; echo $?
>          0
>
> this is not a good state from which you would want to update the
> working tree.
>
> Wouldn't the two-tree form "read-tree -u -m" that is the equivalent
> to branch switching do a sufficient check?
>
> Also, regarding the new calls to die() in the main patch, shouldn't
> they just be returning the error reason in string form, just like
> DENY_REFUSE returns "branch is currently checked out" to signal a
> push failure to the caller?
>
>
