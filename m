From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] config: add 'type' to config_source struct that identifies config type
Date: Sat, 13 Feb 2016 13:04:08 -0800
Message-ID: <xmqqio1ss4on.fsf@gitster.mtv.corp.google.com>
References: <1455373456-64691-1-git-send-email-larsxschneider@gmail.com>
	<1455373456-64691-3-git-send-email-larsxschneider@gmail.com>
	<20160213172435.GG30144@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: larsxschneider@gmail.com, git@vger.kernel.org,
	sschuberth@gmail.com, ramsay@ramsayjones.plus.com,
	sunshine@sunshineco.com, hvoigt@hvoigt.net, sbeller@google.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 13 22:04:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUhMV-0001Ka-9H
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 22:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbcBMVEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2016 16:04:12 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63067 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751306AbcBMVEK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2016 16:04:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 34ACF42B95;
	Sat, 13 Feb 2016 16:04:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XImGrUcNDgOEcmXQXIxX4PY5/XE=; b=wQsruO
	UN7w9+Be5WS0Rr5WSEu3VqRZJxeh2AjPJqzr1KxmW/UkfqxfrdYRt58GBgE5Apar
	KbDUZZ8xSf78oHlQNrsdVhF+OSRdkn0DXTXYjNVg30u9RWpk6/KZc52lGWHbc122
	5LieQEqndWqZK3PeSuEFPFd82mkxoQRbD9Rn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QYtn0pZUv0nIfESvz2yBwUXQK+DlvfUQ
	zCqcYPVJo8hCnndhx60VuJkfe5aQBhbbiIY/k4HhY3zn7Uk9BshZNGQ6l/dMpLVv
	Oo03CWyrwLt4YiameKN3F7cLfZpQUMJwOZD9RzNTmJjDew9LnVQys/xe5K7QgS/U
	e/6R3Ozzlr0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2902F42B94;
	Sat, 13 Feb 2016 16:04:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9A26442B93;
	Sat, 13 Feb 2016 16:04:09 -0500 (EST)
In-Reply-To: <20160213172435.GG30144@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 13 Feb 2016 12:24:35 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 537A15AA-D295-11E5-859D-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286128>

Jeff King <peff@peff.net> writes:

>> @@ -1104,6 +1106,7 @@ int git_config_from_buf(config_fn_t fn, const char *name, const char *buf,
>>  	top.u.buf.buf = buf;
>>  	top.u.buf.len = len;
>>  	top.u.buf.pos = 0;
>> +	top.type = "blob";
>>  	top.name = name;
>>  	top.path = NULL;
>>  	top.die_on_error = 0;
>
> This function is about reading config from a memory buffer. The only reason
> we do so _now_ is when reading from a blob, but I think it is laying a
> trap for somebody who wants to reuse the function later.
>
> Should git_config_from_buf() take a "type" parameter, and
> git_config_from_blob_sha1() pass in "blob"?

I think that is sensible.  I think s/from_buf/from_mem/ may also be
sensible (it would match the naming used in the index_{fd,mem,...}
functions in he hashing code).

>>  static int git_config_from_stdin(config_fn_t fn, void *data)
>>  {
>> -	return do_config_from_file(fn, "<stdin>", NULL, stdin, data);
>> +	return do_config_from_file(fn, NULL, NULL, stdin, data);
>>  }
>
> Likewise here, we make assumptions in do_config_from_file() about what
> the NULL path means. I think this is less likely to be a problem than
> the other case, but it seems like it would be cleaner for "file" or
> "stdin" to come from the caller, which knows for sure what we are doing.

Makes sense.

> Similarly, I think git_config_from_stdin() can simply pass in an empty
> name rather than NULL to avoid do_config_from_file() having to fix it
> up.

This too.

>> +test_expect_success 'invalid stdin config' '
>> +	echo "fatal: bad config line 1 in stdin " >expect &&
>> +	echo "[broken" | test_must_fail git config --list --file - >output 2>&1 &&
>> +	test_cmp expect output
>> +'
>
> The original would have been "bad config file line 1 in <stdin>"; I
> think this is an improvement to drop the "file" here.
>
> -Peff
