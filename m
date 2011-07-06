From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] xdiff/xprepare: refactor abort cleanups
Date: Wed, 06 Jul 2011 16:31:52 -0700
Message-ID: <7vaacrhtp3.fsf@alter.siamese.dyndns.org>
References: <1309970337-6016-1-git-send-email-rctay89@gmail.com>
 <1309970337-6016-2-git-send-email-rctay89@gmail.com>
 <1309970337-6016-3-git-send-email-rctay89@gmail.com>
 <7vliwbmgv0.fsf@alter.siamese.dyndns.org>
 <CALUzUxqPf0nReHHhQ3zJoVbPAN7GNuzWeunWoxbzLuoYtuEbUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 07 01:32:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QebZZ-0000XC-3U
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 01:32:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846Ab1GFXb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 19:31:56 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42528 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754722Ab1GFXbz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 19:31:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B92C457BA;
	Wed,  6 Jul 2011 19:31:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U5wYn+xM9nHofa2zA9xqnDYNduA=; b=wRaljT
	nzRLdER+qaYbUgqfKBHH1IOYzRQVhAtrGkfjGPK5WVTCj8M/EBU9pM7IlvCoxlSS
	pLdjCjctaWmrNx0hQiVYJuSroSPnpBfWn8Ls2WDjMIU5NKN33oA2OpTOX0uZVhIe
	Qxph5yxDkKWnQTMwCYXSfXJs6RuotVwdKlLJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fuvApvhzV3VG5pJ+JfNYPE+4mCHQreKU
	y5a3beWDsDCJvdpBjum/TAHOVsJjnxFkOS3x3/vG+kscNK1hes29FGvRfW5pxvAK
	dZir8vmIelqXVpzY0J5KNBNjov+W4jkkPH/2iBHlphwqEWLgX8bEPiq614GsTa2U
	DOqlQoSWSoo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B268657B9;
	Wed,  6 Jul 2011 19:31:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0072557B5; Wed,  6 Jul 2011
 19:31:53 -0400 (EDT)
In-Reply-To: <CALUzUxqPf0nReHHhQ3zJoVbPAN7GNuzWeunWoxbzLuoYtuEbUw@mail.gmail.com> (Tay Ray
 Chuan's message of "Thu, 7 Jul 2011 02:10:21 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 21C91D86-A828-11E0-B5E7-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176737>

Tay Ray Chuan <rctay89@gmail.com> writes:

> On Thu, Jul 7, 2011 at 1:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Tay Ray Chuan <rctay89@gmail.com> writes:
>>
>>> Group free()'s that are called when a malloc() fails in
>>> xdl_prepare_ctx(), making for more readable code.
>>
>> Nicer, but I wonder if we can get away with a single label that lets us
>> abort with freeing whatever we have allocated by making sure that the
>> various pointer fields and variables are initialized to NULL, which may
>> lead to even more readable code.
>
> Pardon my dullness. Do you mean to check if the various fields are set
> to NULL upon allocation, and free()'ing them if so?

What I meant was that, instead of doing this:

    func() {
	if (somefunc(&A, ...) < 0)
		goto failA;
        ... do something ...
	B = someotheralloc();
        if (!B)
        	goto failB;
        ... do something ...
	C = yetanotheralloc();
        if (!C)
        	goto failC;
	... do things using A, B, C ...

	return 0;
    failC:
    	free(B);
    failB:
	free(A);
    failA:
        return -1;
    }

it would be easier to follow if you did:

    func() {
	A = B = C = NULL;
	if (somefunc(&A, ...) < 0)
		goto fail;
        ... do something ...
	B = someotheralloc();
        if (!B)
        	goto fail;
        ... do something ...
	C = yetanotheralloc();
        if (!C)
        	goto fail;
	... do things using A, B, C ...

    fail:
        free(B);
    	free(A);
        return -1;
    }

Especially when you have more than 2 such fail labels.
