From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 1/5] sha1_file: support reading from a loose object of unknown type
Date: Wed, 29 Apr 2015 12:35:02 -0700
Message-ID: <xmqq383i6849.fsf@gitster.dls.corp.google.com>
References: <5540D397.8020104@gmail.com>
	<1430311933-23180-1-git-send-email-karthik.188@gmail.com>
	<xmqqtwvzt2fv.fsf@gitster.dls.corp.google.com>
	<554119F6.5010900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 21:35:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnXlK-0000Hq-0h
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 21:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbbD2TfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 15:35:09 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61337 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752015AbbD2TfI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 15:35:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 184C64C026;
	Wed, 29 Apr 2015 15:35:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KfMcLFhia6kTz35wYnyGyHyPRgA=; b=QKpDv1
	TxvQPwwHmq1Ble1LcPmWgS3nA3bwGrtkmU+amhWM4XRRJmD5XFJmRdNGGIVE+EZu
	irvrDCuhXJHV9m2Mw0GD/4YimoknMVGU2Pig85JHh0CpXIn5tpOorhKqT80eb5Jo
	QLyl6sWrTNwsmFoG3faYG3UuE6RAvIBQjYeYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JSz1aG9XrIIQeuBdFgpm5EyD5AWBJYlr
	+mMqBnBdzlN8gc1OueES3RgRvsprEA/qDNW+VWDN28pLSISloV5VbBkxHaTfng3I
	VIF5nSkdGt96w6ETRhKz1t6SJpcPgW7lFQE0EaazmS+x/iTMKzCPHF03l3AgY7nS
	+4Sep6cR7Ys=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 110DC4C025;
	Wed, 29 Apr 2015 15:35:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3C33E4C01C;
	Wed, 29 Apr 2015 15:35:04 -0400 (EDT)
In-Reply-To: <554119F6.5010900@gmail.com> (karthik nayak's message of "Wed, 29
	Apr 2015 23:20:46 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D58ACAF4-EEA6-11E4-8576-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267994>

karthik nayak <karthik.188@gmail.com> writes:

> On 04/29/2015 08:19 PM, Junio C Hamano wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> Update sha1_loose_object_info() to optionally allow it to read
>>> from a loose object file of unknown/bogus type; as the function
>>> usually returns the type of the object it read in the form of enum
>>> for known types, add an optional "typename" field to receive the
>>> name of the type in textual form and a flag to indicate the reading
>>> of a loose object file of unknown/bogus type.
>>>
>>> Add parse_sha1_header_extended() which acts as a wrapper around
>>> parse_sha1_header() allowing more information to be obtained.
>>
>> Thanks.  This mostly looks good modulo a nit.
>
> Sorry didn't get what you meant by "modulo a nit.".

"nit" as in "Nit-pick"; a small imperfection that may need to be
corrected (such as the "what if we saw failure earlier and 'status'
already had a value?" issue).

>> It is a good trade-off between complexity and efficiency.  The
>> complexity is isolated as the function is file-scope-static and it
>> is perfectly fine to force the callers to be extra careful.
>>
>> But this suggests that the patch to add tests should try at least
>> two, preferably three, kinds of test input.  A bogus type that needs
>> a header longer than the caller's fixed buffer, a bogus type whose
>> header would fit within the fixed buffer, and optionally a correct
>> type whose header should always fit within the fixed buffer.
>
> Yes it is a tradeoff, and it is complex as in the user has to check
> the strbuf provided to see if its been used. But this like you said I
> guess its a good tradeoff.
> About the three tests, My patch checks "a bogus type whose header
> would fit within the fixed buffer" and "correct type whose header
> should always fit within the fixed buffer" but will write a test to
> check "A bogus type that needs a header longer than the caller's fixed
> buffer"

Yup. Please do so; that would make the test coverage more complete.
