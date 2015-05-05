From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] write_sha1_file_prepare: fix buffer overrun with extra-long object type
Date: Mon, 04 May 2015 17:28:54 -0700
Message-ID: <xmqq4mnrg94p.fsf@gitster.dls.corp.google.com>
References: <1430724315-524-1-git-send-email-sunshine@sunshineco.com>
	<1430775451-31130-1-git-send-email-gitster@pobox.com>
	<1430775451-31130-3-git-send-email-gitster@pobox.com>
	<CAPig+cS3f2XggxqbvX6Z2Da24QKLOg915Bf-bTVa+4oVzfhA1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 05 02:29:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpQjN-0003HF-1m
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 02:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbbEEA25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 20:28:57 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58167 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751732AbbEEA24 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 20:28:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A1ADD4F640;
	Mon,  4 May 2015 20:28:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DtwTKlqNSUs+ipHhtzl36koa/4k=; b=ipKenE
	0CiLRvhMaIhmYq9IJmN4NMTh68Q9wPgL3kNudmnptU95vVY1dkcjqbpMe/g3dEXf
	JESW6R0KpoNdPJgOxfkcqgKSQ9LdDkOuX7LWAc5pCumVsEib0vrsBZkdzGa3agss
	5ZNGGvya+X/5J39AhwXpep+4lVhFiETU5QncA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=onihskwSJ+XQmj/PdqB5KWe5D9r6xjXc
	Gumdzo4oOxT8650ASOsOq6/nqEwo5IUxoo2A6biWFN0hektxgu7maEdm6dZWiSgM
	+uUAwgeaMPCI0YHQ3xKOJ5haodfDWW8KKdBraFJN7wOINxmelb+Jyw/BOWhafZUu
	Prn20nyMV9c=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 995594F63F;
	Mon,  4 May 2015 20:28:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 21B174F63E;
	Mon,  4 May 2015 20:28:55 -0400 (EDT)
In-Reply-To: <CAPig+cS3f2XggxqbvX6Z2Da24QKLOg915Bf-bTVa+4oVzfhA1A@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 4 May 2015 20:13:18 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B67043C2-F2BD-11E4-9B6C-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268376>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +extern int hash_sha1_file_literally(struct strbuf *buf, const char
>> *type, unsigned char *return_sha1, unsigned flags);
>
> A few questions:
>
> What's the value of making the first argument of
> hash_sha1_file_literally() a strbuf rather than the two-argument
> buf & len accepted by hash_sha1_file() and write_sha1_file()? Is
> the inconsistency warranted?

I do not care either way, as this is really meant to be a
single-purpose wrapper for a single caller.

> Would it make sense to name the third argument "sha1" instead of
> "return_sha1" to match the argument name of hash_sha1_file()?
>
> And, as an aside, should your new patch 4/4 rename "return_sha1" to
> "sha1" in the write_sha1_file() prototype also?

Because most of the read-cache.c functions take object name and do
something about it, but these small number of functions compute and
return object name, I actually think it is a good way to keep
"return" in the name to remind those who are writing or reading
callers.

>> +       /* type string, SP, %lu of the length plus NUL must fit this */
>> +       strbuf_grow(&header, strlen(type) + 20);
>
> A couple comments:
>
> First, given that the largest 64-bit unsigned long value
> (18,446,744,073,709,551,615) is 20 characters, do we want to be really
> pedantic and add 22 instead of 20?

32 is fine ;-)

> Second, is strbuf overkill in this situation when a simple
> xmalloc()/free() would do?

I think underneath the number of xmalloc()/free() calls are the
same.  The code that uses strbuf abstraction is easier to read, I
would think.
