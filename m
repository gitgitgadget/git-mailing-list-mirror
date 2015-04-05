From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 1/4] sha1_file.c: support reading from a loose object of unknown type
Date: Sun, 05 Apr 2015 00:46:48 -0700
Message-ID: <xmqqiodbdnkn.fsf@gitster.dls.corp.google.com>
References: <551F7984.5070902@gmail.com>
	<1428126162-18987-1-git-send-email-karthik.188@gmail.com>
	<xmqq7ftrg02b.fsf@gitster.dls.corp.google.com>
	<55204141.9070100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 09:46:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YefGj-0006fB-C3
	for gcvg-git-2@plane.gmane.org; Sun, 05 Apr 2015 09:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbbDEHqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2015 03:46:52 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50224 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751760AbbDEHqv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2015 03:46:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4301B3E355;
	Sun,  5 Apr 2015 03:46:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eY4MvW1RxXDsdbTCpGU2MLURMJE=; b=nU0Sp7
	ziqhWScOaU3deWyXFFZT65KgfCw/khLgdkvswaVHniCoqqlJq2694qEdC8xUG5sq
	j+iAbAdmrKmMN2blAv495Dwkc6FxRhEP+t4qHJ08eEIbjkT+M7e728m+cGyk33vr
	WXZE1pGWqZLHwJArm87b/FIRlh9xifGNXvnpc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DaRdfRXpfXtqDxCW5ZmLvQvDC5stVCFD
	7H/044wL18K/cel3umqTf/5gOjSF86X4Tei6HmyBQdPpkzuNXysCso0o9abzxHsm
	3DYTB4BmAe7kgNb+JgR3bB5JopTHVQ9LnPBpNuvrjE6MsJlBDds9N6Ts/FpZqnBQ
	3P/yvKr8XQA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3AD8F3E353;
	Sun,  5 Apr 2015 03:46:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A44113E352;
	Sun,  5 Apr 2015 03:46:49 -0400 (EDT)
In-Reply-To: <55204141.9070100@gmail.com> (karthik nayak's message of "Sun, 05
	Apr 2015 01:23:37 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EAE36A84-DB67-11E4-9F62-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266799>

karthik nayak <karthik.188@gmail.com> writes:

>> So, it makes me wonder what guarantee we have that this does not
>> dereference a NULL here.
>>
> As per my code, oi->typename is only pointing to something when oi->typep
> is ( As oi->typename is currently only used in cat-file.c).
> But what you're saying also is true, there is no other guarantee, as a user may
> set oi->typename to point to a struct strbuf and leave out oi->typep.
>
>  if (oi->typename && oi->typep)
>          strbuf_addstr(oi->typename, typename(*oi->typep));
>
> This should suffice. Do you want me to re-roll this?

I'd rather avoid the thinking along the lines of "at this moment,
there happens to be only one caller that asks for typename and the
caller also sets typep, so we will be safe as long as we make sure
the caller passed typep before giving him typename back".

Somebody else may write new code that wants to learn the typename,
forgets to set typep, calls into this codepath, and ends up
scratching his head wondering why the typename string is returned to
him.  Surely the code may not crash at the new code you wrote, but
you are not helping him.

If it semantically does not make sense to ask for the typename
without asking for the type code, then we can and should make that
as a new calling convention _all_ callers must follow.

In other words, I think it is better to have

	if (oi->typename && !oi->typep)
		die("BUG");

somewhere near the beginning of the callchain that takes oi; that
will ensure all callers understand the rule.
