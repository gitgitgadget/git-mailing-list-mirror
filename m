From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fetch: align new ref summary printout in UTF-8 locales
Date: Mon, 03 Sep 2012 12:26:52 -0700
Message-ID: <7vwr0aewlf.fsf@alter.siamese.dyndns.org>
References: <1346670609-19986-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 21:27:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8cIf-0005BD-Ri
	for gcvg-git-2@plane.gmane.org; Mon, 03 Sep 2012 21:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756552Ab2ICT05 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Sep 2012 15:26:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49329 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756530Ab2ICT0z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Sep 2012 15:26:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3072B9201;
	Mon,  3 Sep 2012 15:26:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=llIBsT/LTVYv
	SdrwdGoYM8iKRJE=; b=Kl6gls7jgNFmTFndMKuM6RzXqF97xDz57x0vb/GFzPKz
	W2YTHi55d9L21RpSTs9JM0W6IdahwYkgQygVjIunMVI7xon0ZpVDMi5skUwYFhZ4
	PC0PyF4MSyQMUcJ9TJn2Lq1VmIoNpajOtBrW1OMgCVUPFJE1uaVaHcfddrSxWDM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=vLIjXm
	VbM8r4a1VXRcu9iqAD7f3CQXllU9UyJDr+BWmt/1lP2dexrVc4lqiC4XdIEDDUgO
	ln0FTxnRGuB3ZchxlP9qaxAi1ZzfCk+kf2aBcplNrPaypNUfcDLkE00UUX0pP1vZ
	sC9LZ0rbft4fNDv5OxHFxIq85M96e/RfQrreU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14C1D9200;
	Mon,  3 Sep 2012 15:26:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8511091FF; Mon,  3 Sep 2012
 15:26:54 -0400 (EDT)
In-Reply-To: <1346670609-19986-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 3 Sep
 2012 18:10:09 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 51C99C62-F5FD-11E1-BBF8-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204706>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> fetch does printf("%-*s", width, "foo") where "foo" can be an utf-8
> string, but width is bytes, not letters. This results in misaligned
> ref summary table.

"but width is bytes, not letters" is a misleading statement.

Be careful about three different quantities when talking about
aligning on terminal output with monospaced fonts:

 - How many bytes does the string occupy in memory?
 - How many unicode codepoints are in the string?
 - How many display columns does the string occupy on terminal?

Note that some "letters" (e.g. Han) occupy two display columns, and
you want to measure the "width" and compensate that for "bytes".
Letter count do not come into the picture for the purpose of aligning
the terminal output.

> Introduce gettext_length() function that returns the string length in
> letters. Make the code use TRANSPORT_SUMMARY(x) where the length is

Again, are you measuring "string length in letters"?  Or are you
trying to measure in terms of git_wcwidth()?  If the latter, please
name this after "width", not "length" to make it more clear.

> compensated properly in utf-8 locales.
> ---

Is it in vogue to omit Signed-off-by line these days or something?

>  gettext_length() can be made to support other charsets too. But I'm
>  on utf-8, it's not my itch.
>
>  Grepping through '%-*s' does not reveal any other places that obviou=
sly
>  need adjustment like this (apply and remote might, but pathnames and
>  remote names are usually in ascii)

Thanks.
