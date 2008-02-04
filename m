From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH v7] safecrlf: Add mechanism to warn about irreversible crlf conversions
Date: Mon, 4 Feb 2008 05:35:53 +0100
Message-ID: <86F2B863-6FE8-407E-B535-3F49782DA5F9@zib.de>
References: <4C024D67-9FA5-451D-BB91-CE9464C6F50D@zib.de> <1202053379677-git-send-email-prohaska@zib.de> <alpine.LSU.1.00.0802032222380.7372@racer.site>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 04 05:35:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLt3X-0007Ww-Ox
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 05:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562AbYBDEfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 23:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752464AbYBDEfK
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 23:35:10 -0500
Received: from mailer.zib.de ([130.73.108.11]:47421 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751443AbYBDEfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 23:35:09 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m144Ys34005687;
	Mon, 4 Feb 2008 05:34:54 +0100 (CET)
Received: from [192.168.178.21] (brln-4db91676.pool.einsundeins.de [77.185.22.118])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m144Yr48020487
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 4 Feb 2008 05:34:53 +0100 (MET)
In-Reply-To: <alpine.LSU.1.00.0802032222380.7372@racer.site>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72459>


On Feb 3, 2008, at 11:29 PM, Johannes Schindelin wrote:

> On Sun, 3 Feb 2008, Steffen Prohaska wrote:
>
>> diff --git a/convert.c b/convert.c
>> index 80f114b..d580a62 100644
>> --- a/convert.c
>> +++ b/convert.c
>> @@ -95,9 +95,6 @@ static int crlf_to_git(const char *path, const  
>> char *src, size_t len,
>>  		return 0;
>>
>>  	gather_stats(src, len, &stats);
>> -	/* No CR? Nothing to convert, regardless. */
>> -	if (!stats.cr)
>> -		return 0;
>
> Yes, you add it later, but would this not be "more correct" if you
> prepended a "!checksafe &&" and kept the if here?  Of course, you'd  
> _also_
> need it later, but then _inside_ the "if (checksafe)" clause.

Strictly speaking we would not need it at all, because it's an
optimization.  By moving the optimization a bit down in the
code we don't loose much because all the code that is executed
between the old location and the new one only compares a few
numbers.

The expensive part (scanning the buffer) is still avoided.

So I don't think it would be "more correct" to duplicate the
optimization to safe a few cycles if checksafe == false.

Or do you mean that your proposed "!checksafe &&" would be
easier to understand by a human?


>> @@ -115,6 +112,30 @@ static int crlf_to_git(const char *path,  
>> const char *src, size_t len,
>>  			return 0;
>>  	}
>>
>> +	if (checksafe) {
>> +		if (action == CRLF_INPUT || auto_crlf <= 0) {
>> +			/* CRLFs would not be restored by checkout: check if we'd  
>> remove CRLFs */
>
> There are lines in your patch that are substantially longer than 80
> characters / line.  Please fix.

I refactored the code.


>> diff --git a/environment.c b/environment.c
>> index 18a1c4e..e351e99 100644
>> --- a/environment.c
>> +++ b/environment.c
>> @@ -35,6 +35,7 @@ int pager_use_color = 1;
>>  char *editor_program;
>>  char *excludes_file;
>>  int auto_crlf = 0;	/* 1: both ways, -1: only when adding git  
>> objects */
>> +enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
>
> I think this choice needs some defending.  At first I thought: "no way
> that this will be the default; it affects too many users it should  
> _not_
> affect".  The thing is, Unix users should not need to suffer, only  
> because
> other users are cursed by insane choices of their OS developers.
>
> However, safe_crlf != SAFE_CRLF_FALSE does not affect people who  
> did not
> set core.crlf = input or core.crlf = true.  And for those who set
> core.crlf, the default makes sense, absolutely.

I add a comment to the commit message.

However, I don't fully agree with your comment.  If your Unix
environment is as sane as you assume and you never exchange any
data with the "cursed" people, you can safely set
core.autocrlf=input and core.safecrlf=warn and still should
never see any warning.  Well you'd spent some CPU cycles on
verifying that your assumptions hold.  But those cycles would be
well spent if you accidentally received data from the underworld
that contained the insane line endings; because in this case git
would immediately warn you and would keep your repository sane.
If you had not activated autocrlf/safecrlf as proposed, the
insane line endings would pollute your repository for all eternity.
Even if you recognized them later, they would most likely already
be part of your history.

That said, the next logical step is to set core.autocrlf=input
as the default on Unix.  But this can be discussed later, after
we have the core.safecrlf mechanism in place.

	Steffen
