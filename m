From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Set hard limit on delta chain depth
Date: Tue, 06 Dec 2011 07:06:12 -0800
Message-ID: <7vvcpthh97.fsf@alter.siamese.dyndns.org>
References: <1323068688-31481-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 16:06:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXwb7-0004SA-ME
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 16:06:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933447Ab1LFPGP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Dec 2011 10:06:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35674 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933409Ab1LFPGP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Dec 2011 10:06:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CDA84E94;
	Tue,  6 Dec 2011 10:06:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ZrK5DU4q1fpy
	82ybREMOWfx/zZU=; b=opfGSQSEoifQNQrNyiaHEUIJjpDFNYqK6hBEijAtEc6O
	QREJfZf72hutSYHtGbeOOm7FTCmf60XzCs8g12ReLIbGkwr6RYL4vwYTN2phc4nF
	ZaaJ9k1W02l7E+87oEqw7UNMukiC1iC756kQ9+F6L+gqD2uDjQpR4jc2LsVPYpA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=mPYzrd
	9KRbIPheTyUD1DLgXCqXtj/Viq24HIJt1MCddxC9t1PXufkFU2oNK4bTgIc7lrTa
	uQlFUh2nmW+J+Aizic4zTqqFBHebD3UU30Yf9XHwc1jrwXG1X1w7lEJJCIulsh4I
	lZchOTWHK3uACs8etzutzlTswHmD1mgCrM6xc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13A984E93;
	Tue,  6 Dec 2011 10:06:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A5CF4E92; Tue,  6 Dec 2011
 10:06:13 -0500 (EST)
In-Reply-To: <1323068688-31481-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 5 Dec
 2011 14:04:48 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D6B837B6-201B-11E1-9E19-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186351>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Too deep delta chains can cause stack overflow in get_base_data(). Se=
t
> a hard limit so that index-pack does not run out of stack. Also stop
> people from producing such a long delta chains using "pack-object
> --depth=3D<too large>"
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  I used to make very long delta chains and triggered this in index-pa=
ck.
>  I did not care reporting because it's my fault anyway. Think again,
>  index-pack is called at server side and a malicious client can
>  trigger this. This patch does not improve the situation much, but at
>  least we won't get sigsegv at server side.

Why should we treat this condition any differently from the case where =
the
sender of a pack used beefier machine than you have and stuffed a huge
object that the index-pack running on your box cannot hold in core,
causing xmalloc() to die on your machine?

I do not think this is the right way to handle the issue. Your other pa=
tch
to flatten the recursion to iteration looked a lot saner approach.
