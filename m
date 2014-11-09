From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 4/5] trailer: reuse ignore_non_trailer() to ignore
 conflict lines
Date: Sun, 09 Nov 2014 11:35:09 +0100 (CET)
Message-ID: <20141109.113509.1363113947439404678.chriscool@tuxfamily.org>
References: <20141107184148.16854.63825.chriscool@tuxfamily.org>
	<20141107185053.16854.5660.chriscool@tuxfamily.org>
	<xmqqzjc2eoyw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, johan@herland.net, josh@joshtriplett.org,
	tr@thomasrast.ch, mhagger@alum.mit.edu, dan.carpenter@oracle.com,
	greg@kroah.com, peff@peff.net, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk, jrnieder@gmail.com,
	marcnarc@xiplink.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Nov 09 11:35:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnPqL-0002qy-Te
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 11:35:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbaKIKfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 05:35:33 -0500
Received: from [194.158.98.14] ([194.158.98.14]:40043 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751506AbaKIKfc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2014 05:35:32 -0500
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 6D4668A;
	Sun,  9 Nov 2014 11:35:09 +0100 (CET)
In-Reply-To: <xmqqzjc2eoyw.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] trailer: reuse ignore_non_trailer() to ignore conflict lines
Date: Fri, 07 Nov 2014 12:27:03 -0800

> Christian Couder <chriscool@tuxfamily.org> writes:
> 
>>   * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
>> @@ -791,14 +792,24 @@ static int process_input_file(struct strbuf **lines,
>>  			      struct trailer_item **in_tok_last)
>>  {
>>  	int count = 0;
>> -	int patch_start, trailer_start, i;
>> +	int trailer_start, trailer_end, patch_start, ignore_bytes, i;
>> +	struct strbuf sb;
>>  
>>  	/* Get the line count */
>>  	while (lines[count])
>>  		count++;
>>  
>>  	patch_start = find_patch_start(lines, count);
>> -	trailer_start = find_trailer_start(lines, patch_start);
>> +
>> +	/* Get the index of the end of the trailers */
>> +	for (i = 0; i < patch_start; i++)
>> +		strbuf_addbuf(&sb, lines[i]);
>> +	ignore_bytes = ignore_non_trailer(&sb);
>> +	for (i = patch_start - 1; i >= 0 && ignore_bytes > 0; i--)
>> +		ignore_bytes -= lines[i]->len;
>> +	trailer_end = i + 1;
> 
> Looks like there is an impedance mismatch between the caller and the
> callee here.  I can sort of understand why you might want to have an
> array of trailer items, one element per line in the trailer block,
> as that would make it easier on your brain when you have to reorder
> them, insert a new one or a remove an existing one, but you seem to
> be keeping _everything_ in that format, an array of strbuf with one
> strbuf per line, which sounds really wasteful.  The data structure
> might need to be rethoughtbefore this code becomes ready for
> production.
> 
> I would have expected it to be more like (1) slurp everything in a
> single strbuf, (2) find the trailer block inside that single strbuf,
> splitting what you read in the previous step into one strbuf for
> stuff before the trailer block, another strbuf for stuff after the
> trailer block and an array of lines in the tailer block, (3) do
> whatever your trailer flipping logic inside that array without
> having to worry about stuff before or after the trailer block and
> then finally (4) spit the whole thing out by concatenating the stuff
> before the trailer block, the stuff in the trailer block and the
> stuff after the trailer block.
> 
> Oh well...

I hope it is better now, as I encapsulated the call to
ignore_non_trailer() into a new find_trailer_end() function. There
were already find_trailer_start() and find_patch_start(), and I think
this way we could have a nice high level line oriented API.

Yeah, it won't be as efficient as using only one strbuf and only byte
oriented functions, and it looks much less manly too :-) But over time in
Git we have developed a number of less efficient but quite clean
abstractions like strbuf, argv_array, sha1_array and so on, that we
are quite happy with.

So yeah, with old age we might have lost some manliness and lament the
time when men were really men, and ... Well, let's wait for the
hopefully big party^W conference next year to do that together :-)

Thanks,
Christian.
