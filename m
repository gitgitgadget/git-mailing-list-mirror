From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] git-send-pack: fix --all option when used with directory
Date: Thu, 31 Mar 2016 15:02:43 -0700
Message-ID: <xmqqoa9ul30c.fsf@gitster.mtv.corp.google.com>
References: <1459432509-12934-1-git-send-email-stanislav@assembla.com>
	<xmqq1t6qmlxk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: peff@peff.net, dborowitz@google.com, stanislav@assembla.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 00:02:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alkfz-0000rJ-64
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 00:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756003AbcCaWCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 18:02:47 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54438 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751933AbcCaWCq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 18:02:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3F9FB52EF1;
	Thu, 31 Mar 2016 18:02:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SUVAjvBpqbbNrtsJLbaIVTetyA8=; b=d+YIG8
	B2foisoIFelFjZhV+oBeJvAHxB9Do54CW9/fZ799sNzZlT6bc6YXt3bl/AMMBPTX
	ugj+A3r4BCXb2MN/A9apDaKm6Rw5V+VG6VKBrjIyB3R/JTN5mw/cCD82Zxx4R3LU
	KVwvgT5v/yprcmLlQ2PMBNqXL6VSbVGiDppjg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WzddubPAxd03bwVwHnvC06GVPB86EE72
	QgJm9XoiLJyvs4i0uRughJB8JvxV8EOF2VBCGGYfpfzRJrxafsvLkYO8laOw0cEK
	y9+lHU9xzNEEK7ChQdRRWb5Vo4vjixsEYOVJ+4kjcyiqt5xrvgG/gM6fEzFnUHjz
	Q0M/Xi26CCw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 367B752EF0;
	Thu, 31 Mar 2016 18:02:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9B2A052EEF;
	Thu, 31 Mar 2016 18:02:44 -0400 (EDT)
In-Reply-To: <xmqq1t6qmlxk.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 31 Mar 2016 13:28:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4BF56714-F78C-11E5-AAFD-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290476>

Junio C Hamano <gitster@pobox.com> writes:

> stanislav@assembla.com writes:
>
>> From: Stanislav Kolotinskiy <stanislav@assembla.com>
>>
>> When using git send-pack with --all option
>> and a target repository specification ([<host>:]<directory>),
>> usage message is being displayed instead of performing
>> the actual transmission.
>>
>> The reason for this issue is that destination and refspecs are being set
>> in the same conditional and are populated from argv. When a target
>> repository is passed, refspecs is being populated as well with its value.
>> This makes the check for refspecs not being NULL to always return true,
>> which, in conjunction with the check for --all or --mirror options,
>> is always true as well and returns usage message instead of proceeding.
>>
>> This ensures that send-pack will stop execution only when --all
>> or --mirror switch is used in conjunction with any refspecs passed.
>>
>> Signed-off-by: Stanislav Kolotinskiy <stanislav@assembla.com>
>> ---
>
> Thanks, will queue.

By the way, for some reason it was unusually painful to find the
exact breakage by bisecting between maint-2.4 and maint-2.6.  It
somehow ended up on fingering random places like v2.6.0 itself.

The true culprit is 068c77a5 (builtin/send-pack.c: use parse_options
API, 2015-08-19).  I didn't dug deep enough to tell if we recently
broke "git bisect" or if there are something wrong in the shape of
my history.
