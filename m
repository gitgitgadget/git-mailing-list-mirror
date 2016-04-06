From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/6] builtin/verify-tag.c: Ignore SIGPIPE on gpg-interface
Date: Wed, 06 Apr 2016 09:43:29 -0700
Message-ID: <xmqqpou2y9fy.fsf@gitster.mtv.corp.google.com>
References: <1459872449-7537-1-git-send-email-santiago@nyu.edu>
	<1459872449-7537-2-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: santiago@nyu.edu
X-From: git-owner@vger.kernel.org Wed Apr 06 18:43:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anqYO-00067c-3r
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 18:43:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbcDFQne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 12:43:34 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:58697 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751016AbcDFQnd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 12:43:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2D676527CB;
	Wed,  6 Apr 2016 12:43:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Gj3ETaUabM0vZU6mNyKqQI/OcDE=; b=xBXe+C
	BiJYf6/M2YryoLZgyRZYWge5rniE1d+BCRxtBUnDtfN+m7VVSBDTCLOLuUKzxiJv
	kEQVtmYIdXQk2hM9cFXtbSwAEYwbtOJKrhqbyVHqUqd7r7GrXX3DaRxzbnb9xkkJ
	Yp6krNjM6y0SeSH9m4TAd2gyG/x02wNzH5owk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p2rre6fI3ldg6btDuZVkSzgssYuBUPUe
	3C7vbFWfCV+T8BJwSJUqfhNEkbBZajCuA8LNRtbXK1+DK5jI6jXWhtGLuSmd9YUY
	WcsuFHej4xAN+DNpY4MCLUCGGkwaRULEUeiwV/qLYlSDYta4VS/UDNlKLR6Dtcuq
	WYyCjXzfid0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 23F42527CA;
	Wed,  6 Apr 2016 12:43:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6B47C527C8;
	Wed,  6 Apr 2016 12:43:31 -0400 (EDT)
In-Reply-To: <1459872449-7537-2-git-send-email-santiago@nyu.edu>
	(santiago@nyu.edu's message of "Tue, 5 Apr 2016 12:07:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B23DBEDE-FC16-11E5-BDFD-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290850>

santiago@nyu.edu writes:

> Subject: [PATCH v5 1/6] builtin/verify-tag.c: Ignore SIGPIPE on gpg-interface

s/Ignore/ignore/

> From: Santiago Torres <santiago@nyu.edu>
>
> The verify_signed_buffer comand might cause a SIGPIPE signal when the
> gpg child process terminates early (due to a bad keyid, for example) and
> git tries to write to it afterwards. Previously, ignoring SIGPIPE was
> done on the builtin/verify-tag.c command to avoid this issue. However,
> any other caller who wanted to use the verify_signed_buffer command
> would have to include this signal call.

s/comand/command/ but more importantly, it is not a command ;-)

> Instead, we use sigchain_push(SIGPIPE, SIG_IGN) on the
> verify_signed_buffer call (pretty much like in sign_buffer()) so
> that any caller is not required to perform this task. This will avoid
> possible mistakes by further developers using verify_signed_buffer.

I'd rephrase like this if I were doing this patch:

    verify-tag: ignore SIGPIPE in verify_signed_buffer()

    The verify_signed_buffer() function may trigger a SIGPIPE when
    the GPG child process terminates early (due to a bad keyid, for
    example) and we try to write to it afterwards.  Ignoring SIGPIPE
    is done in builtin/verify-tag.c to avoid dying from it, but any
    other caller who wants to call verify_signed_buffer() would have
    to do the same.

    Use sigchain_push(SIGPIPE, SIG_IGN) in verify_signed_buffer(),
    pretty much like in sign_buffer(), so that any caller is not
    required to perform this task.

    This will avoid possible mistakes by further developers using
    verify_signed_buffer().

The patch text (as I already said in the response to the cover
letter) looked fine.
