From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/3] git: submodule honor -c credential.* from command line
Date: Mon, 29 Feb 2016 11:47:51 -0800
Message-ID: <xmqqa8mj9u3c.fsf@gitster.mtv.corp.google.com>
References: <1456532000-22971-1-git-send-email-jacob.e.keller@intel.com>
	<1456532000-22971-4-git-send-email-jacob.e.keller@intel.com>
	<xmqqmvqjcr95.fsf@gitster.mtv.corp.google.com>
	<CA+P7+xoNdsDH0jBz6bcikpeMa-qMR6795U+hKqGDSfu52dJFSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 20:48:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaTnT-0007Td-QJ
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 20:48:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752786AbcB2Trz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 14:47:55 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52615 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752328AbcB2Try (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 14:47:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AD22B488A4;
	Mon, 29 Feb 2016 14:47:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tfawsOPvtnuqjy9tIC8cYO9kXo4=; b=twUGcf
	PXWk8d+KUgjySGjMczMNtj0Tab6sN8a9b6lxPYwxXWt6rNHNB6/+JargiXe3S4wx
	4l0K0xGoDznCTq+1udzc04pfCH+taPWShfoES6jveF5yEeZ4fxot41ycbLoUqBEi
	UJgx0Qnu7ySK2Op8X6iTrb8v1xl6o86TO3HLo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VODAV692uz4G+QVckug9mQ7bXmDV5SZ6
	gfj/2nCcLcv44RYyGUdT1TzLNXFu//wWGa24FqnB5bBsvaXhYW3GqIyBm3kGOX82
	J7R3sbURHL2VtP6e0pN18VYpXCW+LMJh3G4WchEIV7zjmE2uo25LfWwwx1NOCOzF
	sMhtC5amwCc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A1F8F488A3;
	Mon, 29 Feb 2016 14:47:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 881294889F;
	Mon, 29 Feb 2016 14:47:52 -0500 (EST)
In-Reply-To: <CA+P7+xoNdsDH0jBz6bcikpeMa-qMR6795U+hKqGDSfu52dJFSw@mail.gmail.com>
	(Jacob Keller's message of "Mon, 29 Feb 2016 11:37:33 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 51F5B8F8-DF1D-11E5-BC5B-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287893>

Jacob Keller <jacob.keller@gmail.com> writes:

> On Mon, Feb 29, 2016 at 10:20 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jacob Keller <jacob.e.keller@intel.com> writes:
>>
>>> +static int sanitize_submodule_config(const char *var, const char *value, void *data)
>>> +{
>>> +     struct strbuf quoted = STRBUF_INIT;
>>> +     struct strbuf *out = data;
>>> +
>>> +     if (submodule_config_ok(var)) {
>>> +             if (out->len)
>>> +                     strbuf_addch(out, ' ');
>>> +
>>> +             sq_quotef(out, "%s=%s", var, value);
>>
>> Can a configuration variable that comes from the original command
>> line be a boolean true that is spelled without "=true", i.e. can
>> value be NULL here?
>>
>
> Wouldn't it just be the empty string?

I was talking about the "not even an equal sign" true, i.e.

    $ git -c random.what -c random.false=no -c random.true=yes \
      config --bool --get-regexp 'random.*'
    random.what true
    random.false false
    random.true true

What would you see for random.what in the above function (if the
callchain allowed you to pass it through)?
