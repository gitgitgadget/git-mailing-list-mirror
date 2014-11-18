From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] refs.c: use a stringlist for repack_without_refs
Date: Tue, 18 Nov 2014 15:39:41 -0800
Message-ID: <xmqqh9xwt6wy.fsf@gitster.dls.corp.google.com>
References: <1416350636-12934-1-git-send-email-sbeller@google.com>
	<xmqqlhn8t8g2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 00:39:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqsND-0008I3-K2
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 00:39:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754692AbaKRXjq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 18:39:46 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59416 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754538AbaKRXjo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 18:39:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 854D11F7DF;
	Tue, 18 Nov 2014 18:39:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BdOuEQ+vWh1+gZaQBZXKKfY7vnI=; b=riGLc6
	MPrvURp/eYvjoYw0xlb9CHOfNiXcRxa8RpS+KN4Us9AT9mUFbfW4UXLTU5xCs2nQ
	O6u6eAaUgbSFulzWMs/EiIvZ2kxtLNZAkx7QsSNDny+gqyJa6G5ery26Axg94YgB
	GG9XToc2MB73JUcSElmG0WdFbdrRCRzxvYOL0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q8Dm4Obp/ZhGFwNbVuUz5LTnsqb3FnuZ
	fD8X7DFr6bU0yVLagcLPdNPCX7KyHOuIwuxvJ+RcHeEpROerBEk0fpYqiGjKc8Yn
	qUeCaAK43fWEu5CTtqpD3cgWYBcdzSAywCBUfaaASq5lSl3hm8KrNEa15kMmQy1d
	BP6DbkLqTvU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7BC9C1F7DE;
	Tue, 18 Nov 2014 18:39:45 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ECCE31F7DD;
	Tue, 18 Nov 2014 18:39:44 -0500 (EST)
In-Reply-To: <xmqqlhn8t8g2.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 18 Nov 2014 15:06:37 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2D03C95C-6F7C-11E4-96A2-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> This patch was heavily inspired by a part of the ref-transactions-rename
>> series[1], but people tend to dislike large series and this part is
>> relatively easy to take out and unrelated, so I'll send it as a single
>> patch.
>>
>> This patch doesn't intend any functional changes. It is just a refactoring, 
>> which replaces a char** array by a stringlist in the function 
>> repack_without_refs.
>>
>> [1] https://www.mail-archive.com/git@vger.kernel.org/msg60604.html
>>
>> Idea-by: Ronnie Sahlberg <sahlberg@google.com>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  builtin/remote.c | 22 +++++++---------------
>>  refs.c           | 41 ++++++++++++++++++++---------------------
>>  refs.h           |  3 +--
>>  3 files changed, 28 insertions(+), 38 deletions(-)
>
> In one codepath we were already using a string_list delete_refs_list
> anyway, so it makes sense to reuse that by movingan existing call to
> string_list_insert() a bit higher, instead of maintaining another
> array of pointers delete_refs[] to strings.
>
> OK, it simplifies the code by reducing the line count, which is a
> plus ;-)
>
> Sounds good.

I queued this but as I suspected yesterday had to drop all the other
rs/ref-transaction-* topics that are not in 'next' yet.  I am
guessing that your plan is to make them come back one piece at a
time in many easier-to-digest bite sized series.
