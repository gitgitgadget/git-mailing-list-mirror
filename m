From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t4205: don't rely on en_US.UTF-8 locale existing
Date: Wed, 03 Jul 2013 14:41:06 -0700
Message-ID: <7vr4ffcoel.fsf@alter.siamese.dyndns.org>
References: <f607decdc65b86b1759438e375ddf77fd5b91042.1372882590.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Alexey Shumkin <Alex.Crezoff@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jul 03 23:41:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuUnb-00082i-DY
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 23:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417Ab3GCVlK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Jul 2013 17:41:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40287 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932128Ab3GCVlJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jul 2013 17:41:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E3272D7B5;
	Wed,  3 Jul 2013 21:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=lsCZKV8D0RPu
	XB612OEjYKPzqqI=; b=tRbHFh+IXMjYGQ75ATs5MIcy4JRnf6/tXTShtjEeFRTJ
	2TMrmPuDdUd52V7NzRG1rad4sS7PjxLVZCJ6LDckBjqpH6ciSkpWlszkVr+ZpWFI
	7oxmEeT/BJVM/AeIXeQ/mkEhW1kBEsH7C7U2f9f8WyNpADm8rq7yY1mspYU3uEo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pPSPrW
	klA75RdWvUnCggS+PaMAnyq070P/25jZjKMZJhlOn7GMNNk78B+mxz06Tbnm6wdz
	/+ESykP9LlzycuysPKQrrkSRDuLon5/swq/bjr2DV1tkw41yx1O86StTmJ8fxU2q
	tOq7Hag5GVH0aPzOPJntqXoCPA3vWNW6yJnZs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12BB22D7B3;
	Wed,  3 Jul 2013 21:41:08 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 81E9F2D7B1;
	Wed,  3 Jul 2013 21:41:07 +0000 (UTC)
In-Reply-To: <f607decdc65b86b1759438e375ddf77fd5b91042.1372882590.git.john@keeping.me.uk>
	(John Keeping's message of "Wed, 3 Jul 2013 21:18:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 44E8B72E-E429-11E2-B95A-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229535>

John Keeping <john@keeping.me.uk> writes:

> My system doesn't have the en_US.UTF-8 locale (or plain en_US), which
> causes t4205 to fail by counting bytes instead of UTF-8 codepoints.
>
> Instead of using sed for this, use Perl which behaves predictably
> whatever locale is in use.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
> This patch is on top of 'as/log-output-encoding-in-user-format'.

Thanks.  I think Alexey is going to send incremental updates to the
topic so I won't interfere by applying this patch on top of the
version I have in my tree.

But I do agree that using Perl may be a workable solution.

An alternative might be not to use this cryptic 3-arg form of
commit_msg at all.  They are used only for these three:

	$(commit_msg "" "8" "..*$")
	$(commit_msg "" "0" ".\{11\}")
	$(commit_msg "" "4" ".\{11\}")

I somehow find them simply not readable, in order to figure out what
is going on.

Just using three variables to hold what are expected would be far
more portable and readable.

# "anf=C3=A4nglich" whatever it means.
sample_utf8_part=3D$(printf "anf\303\244ng")

commit_msg () {
	msg=3D"initial. ${sample_utf8_part}lich";
	if test -n "$1"
	then
		echo "$msg" | iconv -f utf-8 -t "$1"
	else
		echo "$msg"
        fi
}

And then instead of writing in the expected test output.

	$(commit_msg "" "8" "..*$")
	$(commit_msg "" "0" ".\{11\}")
	$(commit_msg "" "4" ".\{11\}")

we can just say

	initial...
        ..an${sample_utf8_part}lich
	init..lich

It is no worse than those cryptic 0, 4, 8 and 11 magic numbers we
see in the test, no?
