From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 3/3] pretty=format: Avoid some expensive calculations
 when not needed
Date: Mon, 05 Nov 2007 21:21:03 +0100
Message-ID: <472F7B2F.4050608@lsrfire.ath.cx>
References: <Pine.LNX.4.64.0711041912190.4362@racer.site>	<Pine.LNX.4.64.0711041915290.4362@racer.site> <7v8x5cqxn0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 21:21:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip8S1-0005wP-PA
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 21:21:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700AbXKEUVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 15:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752576AbXKEUVX
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 15:21:23 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:40674
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752467AbXKEUVX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Nov 2007 15:21:23 -0500
Received: from [10.0.1.201] (p57B7D49E.dip.t-dialin.net [87.183.212.158])
	by neapel230.server4you.de (Postfix) with ESMTP id 9F3E6873BA;
	Mon,  5 Nov 2007 21:21:20 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7v8x5cqxn0.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63546>

Junio C Hamano schrieb:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> Unfortunately, we cannot reuse the result of that function, which
>> would be cleaner: there are more users than just git log.  Most
>> notably, git-archive with "$Format:...$" substitution.
> 
> That makes sense.
> 
> 
>> diff --git a/pretty.c b/pretty.c
>> index 490cede..241e91c 100644
>> --- a/pretty.c
>> +++ b/pretty.c
>> @@ -393,6 +393,7 @@ void format_commit_message(const struct commit *commit,
>>  	int i;
>>  	enum { HEADER, SUBJECT, BODY } state;
>>  	const char *msg = commit->buffer;
>> +	char *active = interp_find_active(format, table, ARRAY_SIZE(table));
>> ...
>> +	if (active[IHASH])
>> +		interp_set_entry(table, IHASH,
>> +				sha1_to_hex(commit->object.sha1));
>> +	if (active[IHASH_ABBREV])
>> +		interp_set_entry(table, IHASH_ABBREV,
>>  			find_unique_abbrev(commit->object.sha1,
>>  				DEFAULT_ABBREV));
> 
> Instead of allocating a separate array and freeing at the end,
> wouldn't it make more sense to have a bitfield that records what
> is used by the format string inside the array elements?

How about (ab)using the value field?  Let interp_find_active() mark
unneeded entries with NULL, and the rest with some cookie.  All table
entries with non-NULL values need to be initialized.  interp_set_entry()
needs to be aware of this cookie, as it mustn't free() it.  The cookie
could be the address of a static char* in interpolate.c.
