From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] index-format.txt: be more liberal on what can represent
 invalid cache tree
Date: Wed, 12 Dec 2012 10:14:03 -0800
Message-ID: <7v4njr5eac.fsf@alter.siamese.dyndns.org>
References: <1355316276-7661-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 19:14:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tiqp9-0000r5-0F
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 19:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754586Ab2LLSOI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Dec 2012 13:14:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48204 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754143Ab2LLSOF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Dec 2012 13:14:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72357A785;
	Wed, 12 Dec 2012 13:14:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5kinjuyFusMd
	nEYNjU3xV6Afnrk=; b=BaSQJVeitrg3nNRHWKZsUYkr6Dhq5xRpIdVKP5MIfeaG
	+ObzCp5l6h78jzYVLT7MLV95pfPd+Ho7zwTz45pR4so2QEwzeWc0/bR5tUt3Kz7m
	EOH+0B2opabqQjPnqJR1Yw5sIgNZWJ7c1b67UCBA5oD8C7j5H/PXTGm6eX0fTkA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=g7LEEl
	yySQC/XVS4iP3OEVmUigi2UYxLgYczP+mIL89/lYvd7t9x2edT3ttPgEvjFypoH5
	v8xUMIYvQbv1+lAyINmn6LPu2UkD2nSEEU21GlBltf6xC1lJfHJfOUakoK/3syEm
	lGoLbGUuEG4azYlx/d27QjkoG+Js5QP8/VutI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 60154A784;
	Wed, 12 Dec 2012 13:14:05 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B2171A783; Wed, 12 Dec 2012
 13:14:04 -0500 (EST)
In-Reply-To: <1355316276-7661-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 12 Dec
 2012 19:44:36 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B67BB158-4487-11E2-B033-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211378>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> We have been writing -1 as "invalid" since day 1. On that same day we
> accept all negative entry counts as "invalid". So in theory all C Git
> versions out there would be happy to accept any negative numbers. JGi=
t
> seems to do exactly the same.

I am of two minds here.

The existing code is being more lenient than specified when they
read stuff others wrote, but it still adheres to -1 when writing.
Allowing random implementations to write random negative values will
close the door for us to later update the specification to encode
more informatin about these invalid entries by using negative value
other than -1 here.

I am OK with a reword to say "negative means invalid, and writers
should write -1 for invalid entries", but without the latter half,
this change is not justified.

> diff --git a/Documentation/technical/index-format.txt b/Documentation=
/technical/index-format.txt
> index 9d25b30..2028a49 100644
> --- a/Documentation/technical/index-format.txt
> +++ b/Documentation/technical/index-format.txt
> @@ -161,8 +161,8 @@ GIT index format
>      this span of index as a tree.
> =20
>    An entry can be in an invalidated state and is represented by havi=
ng
> -  -1 in the entry_count field. In this case, there is no object name
> -  and the next entry starts immediately after the newline.
> +  a negative number in the entry_count field. In this case, there is=
 no
> +  object name and the next entry starts immediately after the newlin=
e.
> =20
>    The entries are written out in the top-down, depth-first order.  T=
he
>    first entry represents the root level of the repository, followed =
by the
