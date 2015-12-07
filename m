From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] revision.c: fix possible null pointer access
Date: Mon, 7 Dec 2015 22:54:23 +0100
Message-ID: <5666000F.8050306@kdbg.org>
References: <xmqqlh9bthyb.fsf@gitster.mtv.corp.google.com>
 <1449329244-4585-1-git-send-email-stefan.naewe@gmail.com>
 <xmqqegeym25s.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Stefan Naewe <stefan.naewe@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 22:54:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a63jw-0004S6-U7
	for gcvg-git-2@plane.gmane.org; Mon, 07 Dec 2015 22:54:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756319AbbLGVyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 16:54:31 -0500
Received: from bsmtp5.bon.at ([195.3.86.187]:3933 "EHLO bsmtp5.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755999AbbLGVya (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2015 16:54:30 -0500
Received: from bsmtp8.bon.at (unknown [192.168.181.101])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 3pDz1w3Gl4z5ttg
	for <git@vger.kernel.org>; Mon,  7 Dec 2015 22:54:28 +0100 (CET)
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3pDz1s41ZXz5tlH;
	Mon,  7 Dec 2015 22:54:25 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 1A12C438;
	Mon,  7 Dec 2015 22:54:24 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <xmqqegeym25s.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282132>

Am 07.12.2015 um 21:31 schrieb Junio C Hamano:
> Stefan Naewe <stefan.naewe@gmail.com> writes:
>
>> mark_tree_uninteresting dereferences a tree pointer before checking
>> if the pointer is valid. Fix that by doing the check first.
>>
>> Signed-off-by: Stefan Naewe <stefan.naewe@gmail.com>
>> ---
>
> I still have a problem with "dereferences", as "dereference" is
> about computing an address and accessing memory based on the result,
> and only the first half is happening here.  I can live with "The
> function does a pointer arithmetic on 'tree' before it makes sure
> that 'tree' is not NULL", but in any case, let's queue this as-is
> for now and wait for a while to see if others can come up with a
> more appropriate phrases.

Don't shoo away language lawyers, because this is a pure C language rule 
patch. If this were only about pointer arithmetic, a change would not be 
necessary. But it isn't. The patch corrects a case where the compiler 
can remove a NULL pointer check that we actually want to remain. The 
language rule that gives sufficient room for interpretation to the 
compiler is about dereferencing a pointer. It is irrelevant that an 
address of an object is taken after the dereference and then only 
pointer arithmetic remains---the dereference has already taken place, 
and that cannot occur for a NULL pointer in a valid program. So, the 
phrase "dereference" is precise and correct here.

-- Hannes

>
> Thanks.
>
>>   revision.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/revision.c b/revision.c
>> index 0fbb684..8c569cc 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -135,10 +135,12 @@ static void mark_tree_contents_uninteresting(struct tree *tree)
>>
>>   void mark_tree_uninteresting(struct tree *tree)
>>   {
>> -	struct object *obj = &tree->object;
>> +	struct object *obj;
>>
>>   	if (!tree)
>>   		return;
>> +
>> +	obj = &tree->object;
>>   	if (obj->flags & UNINTERESTING)
>>   		return;
>>   	obj->flags |= UNINTERESTING;
