From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] fsck: detect and warn a commit with embedded NUL
Date: Thu, 14 Apr 2016 11:25:29 -0700
Message-ID: <xmqq1t68gi92.fsf@gitster.mtv.corp.google.com>
References: <20160414180709.28968-1-gitster@pobox.com>
	<20160414180709.28968-2-gitster@pobox.com>
	<20160414182102.GB22068@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 14 20:25:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqlxR-0006UW-HX
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 20:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755030AbcDNSZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 14:25:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60823 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753706AbcDNSZd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 14:25:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CE4B913429;
	Thu, 14 Apr 2016 14:25:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ycTQ+Ni0ta4UHJZD3JFg9acrQyY=; b=rRp9lm
	P8Dbtb1WTojlQNcFQUqSoV1jCtbZQdOohxIclCgxmbC+pkR3DeN8owruKq6ObFRx
	nR+JH1C3KWWJ624AhdaBBL4PdaOSDXnx9tuciH9zSuwHUPm9qcTM89jZ9uuIOWid
	Zi2B3pwNn5cMp1kvoGTDov0A2t2jLTLqwhfks=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TDUEZYWDwZBAJ/0EXGZB2Eqf5+a+5BRq
	pjECKMkc8o4lTRojwYAzdiBqhnBzQ57NWV/z+/Wmk803BMcmq9XxNSTQxn6qF28M
	CfzMkx2ru2+BdNKa0WUC2iMWVfSlAc8Z1t/op9iJ4JlquoZgL30FdnnxCRVzsXAw
	wE+IGbkv99w=
Received: from pb-smtp2. (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C68B613428;
	Thu, 14 Apr 2016 14:25:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2197513427;
	Thu, 14 Apr 2016 14:25:31 -0400 (EDT)
In-Reply-To: <20160414182102.GB22068@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 14 Apr 2016 14:21:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 452B2C38-026E-11E6-B175-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291550>

Jeff King <peff@peff.net> writes:

>> +	const char *buffer_begin = buffer;
>>  
>>  	if (verify_headers(buffer, size, &commit->object, options))
>>  		return -1;
>
> You need this "buffer_begin" because we move the "buffer" pointer
> forward as we parse. But perhaps whole-buffer checks should simply go at
> the top (next to verify_headers) before we start advancing the pointer.
> To me, that makes the function's flow more natural.

That was my second iteration.  I didn't want the function return
with warning without checking more serious errors that may be in the
object.

> But alternatively...
>
>> @@ -671,6 +673,12 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
>>  		if (err)
>>  			return err;
>>  	}
>> +	if (memchr(buffer_begin, '\0', size)) {
>> +		err = report(options, &commit->object, FSCK_MSG_NUL_IN_COMMIT,
>> +			     "NUL byte in the commit object body");
>> +		if (err)
>> +			return err;
>> +	}
>
> Here we've parsed to the end of the headers we know about. We know
> there's no NUL there, because verify_headers() would have complained.
> And because the individual header parsers would have complained. So I
> actually think we could check from "buffer" (of course we do still need
> to record the beginning of the buffer to adjust "size" appropriately).

Yes, keeping the "begin" pointer is a cheap way to do an equivalent
of "adjusting size".

> It's a little more efficient (we don't have to memchr over the same
> bytes again). But I'd worry a little that doing it that way would
> introduce coupling between this check and verify_headers(), though (so
> that if the latter ever changes, our check may start missing cases).
>
> So yet another alternative would be to include this check in
> verify_headers(). It would parse to the end of the headers as now, and
> then from there additionally look for a NUL in the body.
>
> Of the three approaches, I think I like that third one. It's the most
> efficient, and I think the flow is pretty clear. We'd probably want to
> rename verify_headers(), though. :)

Sounds sensible, except the "should a mere warning hide potentially
more serious errors?" question remains.
