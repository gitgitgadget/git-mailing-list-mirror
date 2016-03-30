From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] path.c: allocate enough memory for string
Date: Wed, 30 Mar 2016 10:16:13 -0700
Message-ID: <xmqqr3erubs2.fsf@gitster.mtv.corp.google.com>
References: <1459298333-21899-1-git-send-email-sbeller@google.com>
	<1459298333-21899-2-git-send-email-sbeller@google.com>
	<CAPig+cSqC1muy+vcmpkp9uM9T3CC4pa5jWGUot_FtrVshEAUEw@mail.gmail.com>
	<CAGZ79kb6dsaSxQ+HaYODBurnFz3MbsisSNkdrckFZLvSCvS-JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 19:16:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alJjC-00069K-F2
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 19:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbcC3RQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 13:16:17 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:65498 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751714AbcC3RQR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 13:16:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8DEB84FD78;
	Wed, 30 Mar 2016 13:16:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F85F0HfgLZ99lAwOBTlV/KGx/uI=; b=ByeJPf
	3vc/GhEQiJQ8l0Z8I0dnejnd6IOezk6A4JIyDSzSRwnQ9Ugzx2yl2XusCCFcj94O
	oVYlUEbqkSK5IU/UsK4SpyW5+II+Sx+XfQGO580JVnWXWqbjIBT6Fr7DH7H5r9+1
	wP6IP2v4wPUbDumNvdEEqhzOARVeVUtK3ILXE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jSPRmFxDXlVyDcQd/zSthMNd+YIfAlML
	VVeaMYGg0qTKGyz6elAs4f/z29oEoG8PruetdWO0T5swNs+oBy8q8wMBtIF5KdNz
	yiRbyJZGMkE2d23vgaQ+Vjmo9rqEAKm2qyYQYXZ+sZW8mC11UGSaPRPRMEh66Lib
	oBvAfPANXaQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 859E14FD77;
	Wed, 30 Mar 2016 13:16:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E009C4FD76;
	Wed, 30 Mar 2016 13:16:14 -0400 (EDT)
In-Reply-To: <CAGZ79kb6dsaSxQ+HaYODBurnFz3MbsisSNkdrckFZLvSCvS-JQ@mail.gmail.com>
	(Stefan Beller's message of "Wed, 30 Mar 2016 09:41:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1BAC669E-F69B-11E5-A07E-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290320>

Stefan Beller <sbeller@google.com> writes:

> On Tue, Mar 29, 2016 at 5:57 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Tue, Mar 29, 2016 at 8:38 PM, Stefan Beller <sbeller@google.com> wrote:
>>> `strlen` returns the length of a string without the terminating null byte.
>>> To make sure enough memory is allocated we need to pass `strlen(..) + 1`
>>> to the allocation function.
>>>
>>> Signed-off-by: Stefan Beller <sbeller@google.com>
>>> ---
>>> diff --git a/path.c b/path.c
>>> @@ -155,7 +155,7 @@ static struct trie *make_trie_node(const char *key, void *value)
>>>         struct trie *new_node = xcalloc(1, sizeof(*new_node));
>>>         new_node->len = strlen(key);
>>>         if (new_node->len) {
>>> -               new_node->contents = xmalloc(new_node->len);
>>> +               new_node->contents = xmalloc(new_node->len + 1);
>>>                 memcpy(new_node->contents, key, new_node->len);
>>
>> Huh? This is a trie. It never accesses 'contents' as a NUL-terminated
>> string. Plus, no NUL is ever even copied, thus this is just
>> overallocating. How is this an improvement?
>
> By using strlen, I assumed it was a standard C string.
> I missed that, though.

You took hint from a wrong place.  You are auditing the destination
buffer, so the correct place to take hint from is the memcpy() that
touches the destination.
