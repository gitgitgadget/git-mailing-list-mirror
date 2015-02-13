From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/12] ref_transaction_update(): remove "have_old" parameter
Date: Fri, 13 Feb 2015 10:27:44 -0800
Message-ID: <xmqqfva9oee7.fsf@gitster.dls.corp.google.com>
References: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>
	<1423739543-1025-5-git-send-email-mhagger@alum.mit.edu>
	<CAPc5daX80Mk2cRNAijTckHZ-EFJhiF4GHWMxBK4wYJYSwaEe0w@mail.gmail.com>
	<54DE3135.7070902@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Feb 13 19:27:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMKxz-0005zx-1N
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 19:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752823AbbBMS1r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 13:27:47 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61006 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752754AbbBMS1q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 13:27:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D07936687;
	Fri, 13 Feb 2015 13:27:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h4Uwt1R1YzqjnIxdt7DsAuVQVY4=; b=P+awZ1
	dODKhDVB4Tt/Aij0WPPpEY5Lz/0GmzIDySy5x06FPQC3cMKyzQYl9kKmRnRrNA+K
	WvoxlmQdvwGkT1X2CvTZXDqWRtgKS1M3eZ+ruBh9tUFsTPPc0cQ+gN5vas2+PhAA
	2VCGUC7j584XlCJZwtS06tWAXATm3NTTOy8EM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MZpQByrjDu1DBkm4MG3hJeyTl26TrOR8
	ZnKZQQCRtYiUJuvPxJuA2Pqc38mKuWKkYhYtSX4O2lyS3XUjAXOqQVHMo1S5tL6l
	8ce/KUbiCJGI35tBIS5C/8BvX0aOjsLdqRfVK9dIRYgI8aVS9fxzC8pdh67ffUxP
	Lc1HJYWeL30=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 508AD36686;
	Fri, 13 Feb 2015 13:27:46 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B58A936685;
	Fri, 13 Feb 2015 13:27:45 -0500 (EST)
In-Reply-To: <54DE3135.7070902@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 13 Feb 2015 18:15:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 016CCDE0-B3AE-11E4-92EE-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263819>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 02/12/2015 06:32 PM, Junio C Hamano wrote:
>> On Thu, Feb 12, 2015 at 3:12 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> Instead, verify the reference's old value if and only if old_sha1 is
>>> non-NULL.
>>>
>>> ...
>>> @@ -3664,9 +3664,6 @@ int ref_transaction_update(struct ref_transaction *transaction,
>>>         if (transaction->state != REF_TRANSACTION_OPEN)
>>>                 die("BUG: update called for transaction that is not open");
>>>
>>> -       if (have_old && !old_sha1)
>>> -               die("BUG: have_old is true but old_sha1 is NULL");
>>> -
>> 
>> In the old world, old_sha1 here used to be one of
>>  (1) NULL, (2) null_sha1[], or (3) a real object name.
>> What is the rule in the new world?
> ...
>     ... If old_sha1 is NULL, then the previous
>     value is not checked.

OK.  That makes it perfectly clear that removing these lines is the
right thing to do.

Thanks.
