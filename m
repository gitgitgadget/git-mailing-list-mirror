From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] run-command.c: Fix unused variables warning with gcc
 4.6
Date: Tue, 26 Apr 2011 15:45:17 +0200
Message-ID: <4DB6CC6D.1030105@op5.se>
References: <4DB6BA5E.3040306@elegosoft.com> <4DB6C501.6000705@drmicha.warpmail.net> <4DB6C83A.4040900@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 15:45:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEiZz-00075c-B1
	for gcvg-git-2@lo.gmane.org; Tue, 26 Apr 2011 15:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755539Ab1DZNpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 09:45:21 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33032 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755273Ab1DZNpV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 09:45:21 -0400
Received: by fxm17 with SMTP id 17so423096fxm.19
        for <git@vger.kernel.org>; Tue, 26 Apr 2011 06:45:19 -0700 (PDT)
Received: by 10.223.74.201 with SMTP id v9mr883834faj.26.1303825519521;
        Tue, 26 Apr 2011 06:45:19 -0700 (PDT)
Received: from vix.int.op5.se (sth-vpn1.op5.com [193.201.96.49])
        by mx.google.com with ESMTPS id o17sm2010435fal.1.2011.04.26.06.45.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Apr 2011 06:45:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.15) Gecko/20110307 Fedora/3.1.9-0.39.b3pre.fc14 Thunderbird/3.1.9 ThunderGit/0.1a
In-Reply-To: <4DB6C83A.4040900@elegosoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172095>

On 04/26/2011 03:27 PM, Michael Schubert wrote:
> On 04/26/2011 03:13 PM, Michael J Gruber wrote:
>> Michael Schubert venit, vidit, dixit 26.04.2011 14:28:
>>> As of gcc 4.6 -Wall includes -Wunused-but-set-variable. Remove all
>>> unused variables to prevent those warnings.
>>>
>>> Signed-off-by: Michael Schubert<mschub@elegosoft.com>
>>> ---
>>>   run-command.c |   10 ++++------
>>>   1 files changed, 4 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/run-command.c b/run-command.c
>>> index f91e446..6e0be54 100644
>>> --- a/run-command.c
>>> +++ b/run-command.c
>>> @@ -67,21 +67,19 @@ static int child_notifier = -1;
>>>
>>>   static void notify_parent(void)
>>>   {
>>> -	ssize_t unused;
>>> -	unused = write(child_notifier, "", 1);
>>> +	write(child_notifier, "", 1);
>>>   }
>>>
>>>   static NORETURN void die_child(const char *err, va_list params)
>>>   {
>>>   	char msg[4096];
>>> -	ssize_t unused;
>>>   	int len = vsnprintf(msg, sizeof(msg), err, params);
>>>   	if (len>  sizeof(msg))
>>>   		len = sizeof(msg);
>>>
>>> -	unused = write(child_err, "fatal: ", 7);
>>> -	unused = write(child_err, msg, len);
>>> -	unused = write(child_err, "\n", 1);
>>> +	write(child_err, "fatal: ", 7);
>>> +	write(child_err, msg, len);
>>> +	write(child_err, "\n", 1);
>>>   	exit(128);
>>>   }
>>>   #endif
>>
>> git log -S"unused" origin/master run-command.c
>>
>> shows that these dummies were introduced for a reason. How do you
>> invalidate that?
> 
> Sorry, just missed that.
> 

A better solution than reverting the prettifying commit
ebec842773932e6f853acac70c80f84209b5f83e would be to rework it to use
logical AND instead of logical OR, as the AND-chain won't short-circuit
the statement chain early and prevent output from being printed when
write() returns non-zero. When it *does* return zero, it's likely due
to problems on the receiving ends, making further writing totally
pointless anyway.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
