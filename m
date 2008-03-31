From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH v2] mktag.c: improve verification of tagger field and
 tests
Date: Mon, 31 Mar 2008 11:04:05 -0500
Message-ID: <47F10B75.8060901@nrlssc.navy.mil>
References: <47EABA21.90708@nrlssc.navy.mil> <47EBC844.3020602@nrlssc.navy.mil> <7vr6drl215.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Carlos Rica <jasampler@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 18:05:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgMVU-0006DB-Fq
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 18:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402AbYCaQEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 12:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbYCaQEY
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 12:04:24 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:46810 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbYCaQEX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 12:04:23 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m2VG468u015267;
	Mon, 31 Mar 2008 11:04:06 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 31 Mar 2008 11:04:05 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <7vr6drl215.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 31 Mar 2008 16:04:05.0914 (UTC) FILETIME=[D87E3FA0:01C89348]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15820001
X-TM-AS-Result: : Yes--12.846500-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTgzMzUxOC03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwMDE2MC03MDM3MzEtNzA2MjkwLTcwMDM3My03?=
	=?us-ascii?B?MDAyNjQtNzAxNDU1LTEwNTcwMC03MDM3ODgtNzAwOTcwLTcwMDE1?=
	=?us-ascii?B?MS03MDQwNDktMTg4MTk5LTcwOTI1MS03MDA0NzYtMTA1MjUwLTcw?=
	=?us-ascii?B?MDg0Ni03MDA2MTgtNzA5NTg0LTcwNzM2MS03MDAzMjQtNzAwMTA0?=
	=?us-ascii?B?LTcwMjExMy03MDQ0MjEtNzAwMzAwLTcwMTMxNy03MDIwMjAtNzA0?=
	=?us-ascii?B?MjU3LTcwODc5Ny03MDgzMzktMTA1NjQwLTcwMzk2OS03MDEyMDIt?=
	=?us-ascii?B?NzA3MDY2LTcwMzY1Ny03MDgzMjUtNzAyMDQ0LTcwMzkxMi03MDEw?=
	=?us-ascii?B?MDUtNzA1NDUwLTcwMjE1Ny03MDIxODctNzAxNjA0LTcwMTczOC03?=
	=?us-ascii?B?MDY5ODQtNzAyMzU4LTcwNTI2OS03MDA4MzktNzAwMDc0LTcwNTE2?=
	=?us-ascii?B?Ny03MDM0OTEtNzA1MTc4LTcxMDA3OC0xNDgwMzktMTQ4MDUxLTEw?=
	=?us-ascii?B?MDAzLTIwMDQzLTI5OTk3?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78588>

Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>> @@ -97,11 +98,53 @@ static int verify_tag(char *buffer, unsigned long size)
>>  	/* Verify the tagger line */
>>  	tagger_line = tag_line;
>>  
>> -	if (memcmp(tagger_line, "tagger", 6) || (tagger_line[6] == '\n'))
>> -		return error("char" PD_FMT ": could not find \"tagger\"", tagger_line - buffer);
>> +	if (memcmp(tagger_line, "tagger ", 7) || (tagger_line[7] == '\n'))
>> +		return error("char" PD_FMT ": could not find \"tagger \"",
>> +			tagger_line - buffer);
> 
> You increment tagger_line by 7 after this step, so it might be a good idea
> to make sure [7] != '\0', but does it make sense to compare it with '\n'
> here?  I can see the original compared [6] with '\n', but I do not think
> it makes sense to inherit it when you are "improving" the validation.

The test for '\n' was just carried on from the original version and is
unnecessary like you said.

I think a test against '\0' is also unnecessary. If tagger_line+7 equals '\0',
then it is still a valid string, and the first strstr() below, searching for " <",
will fail and give an appropriate error message.

>> +	/*
>> +	 * Check for correct form for name and email
>> +	 * i.e. " <" followed by "> " on _this_ line
>> +	 */
>> +	tagger_line += 7;
>> +	if (!(lb = strstr(tagger_line, " <")) || !(rb = strstr(lb+2, "> ")) ||
>> +		strchr(tagger_line, '\n') < rb)
>> +		return error("char" PD_FMT ": malformed tagger",
>> +			tagger_line - buffer);
> 
> The intention is 'on the line there must be " <" followed by something
> followed by "> " before the end of line.'.  That's fine, but can the last
> strchr() ever return NULL?

Yes, I thought of that. Wouldn't NULL always compare less than non-null?
Oh I see, maybe I should add a comment, I took advantage of the fact that a
newline is mandatory in order to simplify the testing. So, I expected NULL
to always cause failure here.

I expect that strchr() to disappear when your outline is followed for making
mktag a builtin and verify_tag() a function also used by builtin-tag. I think
this section testing the tagger field would make a nice generic function for
validating committer, author, and tagger fields and should probably go into
ident.c

>> +	if (lb == tagger_line)
>> +		return error("char" PD_FMT ": missing tagger name",
>> +			tagger_line - buffer);
>> +
>> +	/* timestamp */
>> +	tagger_line = rb + 2;
>> +	if (*tagger_line == ' ')
>> +		return error("char" PD_FMT ": malformed tag timestamp",
>> +			tagger_line - buffer);
> 
> 'After "> ", there has to be the timestamp'.
> 
>> +	for (;;) {
>> +		unsigned char c = *tagger_line++;
>> +		if (c == ' ')
>> +			break;
>> +		if (isdigit(c))
>> +			continue;
>> +		return error("char" PD_FMT ": malformed tag timestamp",
>> +			tagger_line - buffer);
>> +	}
> 
> If the char immediately after "> " is ' ', it definitely is bogus, and you
> want to make sure one or more digits, so the validation is correct but
> feels a bit roundabout.

I reused the form just above which was testing for control characters. Yeah,
I probably wouldn't have done it this way if I wasn't looking at the control
character code. Maybe using strspn() would be more straight forward.

>> +	/* timezone, 5 digits [+-]hhmm, max. 1400 */
>> +	if (!((tagger_line[0] == '+' || tagger_line[0] == '-') &&
>> +	      isdigit(tagger_line[1]) && isdigit(tagger_line[2]) &&
>> +	      isdigit(tagger_line[3]) && isdigit(tagger_line[4]) &&
>> +	      tagger_line[5] == '\n' && atoi(tagger_line+1) <= 1400))
>> +		return error("char" PD_FMT ": malformed tag timezone",
>> +			tagger_line - buffer);
>> +	tagger_line += 6;
> 
> The open-coded strtoul() bothers me a bit, but it is not much longer nor
> less readable than:
> 
>         (*tagger_line == '+' || *tagger_line == '-')
>         && strtoul(tagger_line + 1, &ep, 10) <= 1400
>         && ep - (tagger_line + 1) == 4
>         && *ep == '\n'
> 
> so it probably is fine.

But strtoul() allows leading spaces, so '+ 300' would be parsed as valid.

I was a little reluctant to use isdigit() and atoi() for fear of some
locale danger?

>> +	/* Verify the blank line separating the header from the body */
>> +	if (*tagger_line != '\n')
>> +		return error("char" PD_FMT ": trailing garbage in tag header",
>> +			tagger_line - buffer);
> 
> Having said all that, I'll queue this in 'next'; perhaps we can fix it up
> real quick and merge it in 1.5.5.

Sounds good.

-brandon
