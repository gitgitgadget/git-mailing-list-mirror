From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Patch that modifies git usage message
Date: Fri, 01 May 2015 09:29:50 -0700
Message-ID: <xmqqfv7gxnup.fsf@gitster.dls.corp.google.com>
References: <CAKB+oNtYbJXNb2wGzJCdQ5Ru5fq3HzcapSqiTVC_34=xDnTb7Q@mail.gmail.com>
	<CAGZ79kY1ZoYrVwVVqfyB+uMGsJo59qDxbDLgyo5qygSm=CUVhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Alangi Derick <alangiderick@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 01 18:30:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoDpE-0008Oa-AN
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 18:30:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbbEAQ37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 12:29:59 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51217 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752125AbbEAQ36 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 12:29:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C7344DD14;
	Fri,  1 May 2015 12:29:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XodS9E7sPWFA5D8bZrh4aPVcuEo=; b=e4mXum
	PjuLlqJa4gMYa5ELwuQdNriiebSuv2jcluwO45fhYigb9D7LL0H7drswgONRWAd1
	DlEts95xLnMEf+e03GO//6A1k1SK8hPIeZTnB/HJSZHy8o5PbRE5dFmlsIhkq5iR
	nmIFWpcrMksP/pUM2leQ99d0UcjURyx1mfcMg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cOp2iMpsKTEx+U3NvLgNuswKiGbvCzJg
	5yxSIOGu8mI3ezNJi3JmQX++jHq1MxsaDY5zyHpsaNPuvrnJ3Z2g5JqcIjJk9Qjr
	brnppPvdASKQQFSs/eJWn8ZPJX8WSpDVMVEL8hxLLLkVoODdBQX5Ry/1MdX1jmdD
	CLiFSbGvZs4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3619B4DD13;
	Fri,  1 May 2015 12:29:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AB91B4DD11;
	Fri,  1 May 2015 12:29:51 -0400 (EDT)
In-Reply-To: <CAGZ79kY1ZoYrVwVVqfyB+uMGsJo59qDxbDLgyo5qygSm=CUVhA@mail.gmail.com>
	(Stefan Beller's message of "Fri, 1 May 2015 08:51:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4AC6C6BE-F01F-11E4-B7E8-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268154>

Stefan Beller <sbeller@google.com> writes:

> For the patch itself:
>
> $ grep -r usage *.c builtin/*.c |wc -l
> 551
> $ grep -r Usage *.c builtin/*.c |wc -l
> 3
>
> The community agreed (maybe subconciously) to prefer lower case
> for the 'usage' string, so I don't think this is an improvement.

I tend to agree with the conclusion, but you need to be a bit
careful here.  These catch all the variable names that contain
"[uU]sage" as substring, but we do not spell in-code variables
with camelCase, so the former probably is over-counting.  Things
like "static const char usage[] = ..." are counted; so are calls
to usage_with_options().

If you look for the beginning of a string constant, you would get
this:

    $ git grep '"usage' -- \*.c builtin/\*.c
    12
    $ git grep '"Usage' -- \*.c builtin/\*.c
    0

The former undercounts the messages because many usage messages are
produced by calling usage_with_options() these days.

The latter being zero made me scratch my head and do this:

    $ git grep Usage -- \*.c builtin/\*.c
    commit.c: * Usage example:
    test-hashmap.c: * Usage: time echo "perfhas...

I cannot find the third one you found for "Usage" in your example,
though.
