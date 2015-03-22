From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] strbuf: introduce strbuf_read_cmd helper
Date: Sun, 22 Mar 2015 15:54:29 -0700
Message-ID: <xmqqwq28bq3e.fsf@gitster.dls.corp.google.com>
References: <20150322095924.GA24651@peff.net>
	<20150322100724.GC11615@peff.net>
	<CAPig+cR5Ur4xOKZ6K=bOwOVM8bHHjJJXHxzCbvYBhqOTtD6dXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Wincent Colaiuta <win@wincent.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 23:54:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZolQ-0004Ld-RN
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 23:54:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbbCVWyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 18:54:32 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64888 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751907AbbCVWyc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 18:54:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6FFA042A7C;
	Sun, 22 Mar 2015 18:54:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qZQ1v925Ieb8DM6IL9ZHxh4ZoFw=; b=Ut3E0f
	bY8hg/KfRYRCXxupmjfBRsQVxtYM5iNP1K+QdKDJ6BxdSfdYB7HMGBlDBE9hYr/v
	gUWZN28xXcP8o+24XAPZAv0E47CRyR1GBRcLlPdCACeAdzocrC11vx+LrfNTbRT/
	3sxKrtS8Zn0KjcIJsXz3eE3lggkO9/f7oV6Hs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=inZrE864bCN0xYbOKSygS2GCOATwgeLv
	3cM907x5myryXGEjtrFe3qlw2S3NnbGcSSm8z+AVqt7x/IEBLx1wv6tzrIZb1gWT
	J+FBUjp2XleHXk5qDO5olii16nWuqmCocV+uHa94uRq2PzyHHQoEhpHxz6LgM3aJ
	tGjZQUX76SI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 681F642A7B;
	Sun, 22 Mar 2015 18:54:31 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DDD5642A79;
	Sun, 22 Mar 2015 18:54:30 -0400 (EDT)
In-Reply-To: <CAPig+cR5Ur4xOKZ6K=bOwOVM8bHHjJJXHxzCbvYBhqOTtD6dXg@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 22 Mar 2015 15:36:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 668837C8-D0E6-11E4-B02A-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266102>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sun, Mar 22, 2015 at 6:07 AM, Jeff King <peff@peff.net> wrote:
>> Something as simple as reading the stdout from a command
>> turns out to be rather hard to do right. Doing:
>>
>>   if (!run_command(&cmd))
>>         strbuf_read(&buf, cmd.out, 0);
>>
>> can result in deadlock if the child process produces a large
>> amount of output. [...]
>>
>> Let's introduce a strbuf helper that can make this a bit
>> simpler for callers to do right.
>>
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
>> This is really at the intersection of the strbuf and
>> run-command APIs, so you could argue for it being part of
>> either It is logically quite like the strbuf_read_file()
>> function, so I put it there.
>
> It does feel like a layering violation. If moved to the run-command
> API, it could given one of the following names or something better:
>
>     run_command_capture()
>     capture_command()
>     command_capture()
>     run_command_with_output()
>     capture_output()

Sound like a good suggestion (but I haven't read the users of the
proposed function, after doing which I might change my mind---I'll
see).

Thanks.
