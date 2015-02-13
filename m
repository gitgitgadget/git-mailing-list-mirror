From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] hex.c: reduce memory footprint of sha1_to_hex static buffers
Date: Fri, 13 Feb 2015 15:45:20 -0800
Message-ID: <xmqqtwypl6jz.fsf@gitster.dls.corp.google.com>
References: <1423862329-7899-1-git-send-email-sbeller@google.com>
	<xmqq7fvlmqu8.fsf@gitster.dls.corp.google.com>
	<CAGZ79kaEun-mEQPg7cmPV7RJR8A+BxSsSpeAQgcsuJn8L4TGEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 00:45:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMPvQ-0007eH-D5
	for gcvg-git-2@plane.gmane.org; Sat, 14 Feb 2015 00:45:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919AbbBMXpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 18:45:25 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50914 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752153AbbBMXpY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 18:45:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B1E637DC6;
	Fri, 13 Feb 2015 18:45:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6gDegB9NzCKEgLRq+3td4N6TvJM=; b=FkpvcH
	LAIU3kajAvAXq8e9nAMA0kzQ/whtRHYwXaX6EspcvO8TMBYB4t/S68/lRCXJCtXv
	Jgu1r68RpWILjp1c/+pBQfI9QNAx+8oWqI4Y1wqmDRckpAIIhNOvKQntZL8p/Wok
	pHV+4hSFljzPF4Bcw9ziNd127iJKSQ7DA2Nnc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=km5ubFgun4zJGRYCZ1N7yyVcJve6CasL
	nAx4+V6Bx4yf8ia+OqR4U2wF9GcN/HdzMp23Lw16IEqm9HhwhuDN9kFxjvIFSqVl
	vBO7zUMCsfjwbtaIZUyPWAiSdbZZBgZx8DEgNP7sgszF5Grf8Q7MdImMPU7TEI1p
	Y69jg63bLGs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4093737DC5;
	Fri, 13 Feb 2015 18:45:23 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B769B37DC3;
	Fri, 13 Feb 2015 18:45:21 -0500 (EST)
In-Reply-To: <CAGZ79kaEun-mEQPg7cmPV7RJR8A+BxSsSpeAQgcsuJn8L4TGEg@mail.gmail.com>
	(Stefan Beller's message of "Fri, 13 Feb 2015 13:56:37 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5FB2CB76-B3DA-11E4-8455-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263846>

Stefan Beller <sbeller@google.com> writes:

> On Fri, Feb 13, 2015 at 1:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> 41 bytes is the exact number of bytes needed for having the returned
>>> hex string represented. 50 seems to be an arbitrary number, such
>>> that there are no benefits from alignment to certain address boundaries.
>>
>> Yes, with s/seems to be/is/;
>>
>> This comes from e83c5163 (Initial revision of "git", the information
>> manager from hell, 2005-04-07), and when dcb3450f (sha1_to_hex()
>> usage cleanup, 2006-05-03) introduced the "4 recycled buffers" on
>> top, the underlying array was left at 50 bytes long.
>>
>> You can now have "I fixed Linus's bug" badge ;-)
>
> I don't think it's a bug, it's just wasting memory?

Yes and no ;-)  As I already said above, 50 "is" just an arbitrary
number that is round and enough to hold 40 bytes with trailing NUL,
and the waste does not lead to behaviour that is different from what
was intended, of course, so it would not crash.

However, the wastage was bothersome enough to make you send a patch,
so you can call it a "bug".  It was wasting readers time ;-)
