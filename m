From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Introduce pathspec struct
Date: Tue, 28 Sep 2010 21:26:42 -0700
Message-ID: <7vzkv1qinx.fsf@alter.siamese.dyndns.org>
References: <1284938514-16663-1-git-send-email-pclouds@gmail.com>
 <7v7hi6us35.fsf@alter.siamese.dyndns.org>
 <AANLkTinZ=dx1nBXTw0E=nLOmncsgNb7wv1-+ddWzPU+e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Bo Yang <struggleyb.nku@gmail.com>,
	David Ripton <dripton@ripton.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 29 06:27:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0oGD-0000RN-HB
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 06:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293Ab0I2E05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Sep 2010 00:26:57 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58956 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277Ab0I2E04 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Sep 2010 00:26:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 04EDBDA2D9;
	Wed, 29 Sep 2010 00:26:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QYC0k5vW1hla1H+VElNjjPKs+Ks=; b=D7hr9z
	6I28MZ3MpoZeYSMWrC/LIVzDuyNYTGp1sEGdp/a1JRwQcAGkB3m13BopjxaJRf3T
	5T6lXmNXYkPQJBUbGnjImpDRQC2HE1kL7fkLVgg/ZFzF2PxZVsSt8rz9xrYYGbd4
	vObLdfW0pwhLcg1Y6fyiztbG5inYfttU+J4eI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U5D6xINCw28gmi2Aa2VCRHJ/Q06w8LBq
	+t+AxRvEzS5Q1Scusp3pUEhYhBnJne2EyvhVr16KDwxdCe2uD7Up9ewls2CfNAkE
	B7TP1P3TJq8we/TXOCxngo0kKTKND6x6ZDZstKo9fPXPnG09A7r0ice/2Qx7Nivt
	D2JXtUG8dw4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B85AEDA2D6;
	Wed, 29 Sep 2010 00:26:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AE985DA2D4; Wed, 29 Sep
 2010 00:26:44 -0400 (EDT)
In-Reply-To: <AANLkTinZ=dx1nBXTw0E=nLOmncsgNb7wv1-+ddWzPU+e@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Wed\, 29 Sep 2010 08\:31\:08 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C7C5EBEE-CB81-11DF-974B-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157526>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>>  $ git log --exclude "Doc*" master..pu -- '*.txt'
>>  $ git grep --exclude "t/" -e 'test .*-L' -- '*.sh'
>
> I was writing "but you would lose the ability to mix negative and
> positive pathspecs together, something like 'exclude Documentation
> except Documentation/technical'",...

I think that is way overengineered.  We _could_ make the expressions
arbitrarily complex and hard to use by using irregular syntax tricks, but
let's not go there.  Let's just keep things simple and usable instead.

 * Without pathspec, everything is included;
 * pathspecs will filter everything that do not match;
 * --exclude also filters what matches them from the remainder.

So...

> $ git log --exclude Documentation --exclude "!Documentation/technical"
> master..pu -- '*.txt'
>
> does not sound too twisted to understand (I hope).

...I would not vote for this.

> ... If David
> needs "git grep --exclude-dir" now, he should keep working on
> builtin/grep.c as he's doing now (maybe change --exclude-dir to
> --exclude).

That's not what I am saying.

Because --exclude-dir is a special case of --exclude, it would be an
efficient solution _if_ we can externally keep the command line option
compatible with GNU grep as a syntax sugar, and turn it into something
else internally that can be passed to your "pathspec with negative"
engine.


> ..., but his work on the
> command line interface _and tests_ won't be wasted.

Yup.
