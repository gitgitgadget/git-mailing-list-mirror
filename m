From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Copy resolve_ref() return value for longer use
Date: Sat, 12 Nov 2011 21:57:46 -0800
Message-ID: <7vehxcpns5.fsf@alter.siamese.dyndns.org>
References: <CACsJy8Aw4_O_GMiK_D=HTENfxGUXTTzCHqM7FkriqU+mQtVWtA@mail.gmail.com>
 <1320719428-1802-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Tony Wang <wwwjfy@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 13 07:00:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPT7H-0005E0-Op
	for gcvg-git-2@lo.gmane.org; Sun, 13 Nov 2011 07:00:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805Ab1KMF5w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Nov 2011 00:57:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46550 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750752Ab1KMF5v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Nov 2011 00:57:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DADD7B34;
	Sun, 13 Nov 2011 00:57:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=axPcUI+8Wvhb
	5skl3oqBnGBtFmQ=; b=luLw6SiY8joZmElVN2bQliwzhw5tIN0bC9yge8DYmi0p
	Se9dc/lC6Y/6mEvx64EGsGkxyMfACaQV1mF8l6x58H91EF1M8TwqyoosSBk89Adv
	1JRjtfTVWLoYSgGGI6Sf54yllEWp2csdFRKQ3a3ssTk6d6knTipLfALO8xCdkBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=uNuTfw
	pfc4H42vJZLn33haSzTIo6y8Pb1HU6dC8KQA30wSFfXBklpTzjotXLzmeM6JWdzc
	7hU8Yl/ogAjz1x8b40XqDbvUsOMjPd0i6EWB21g0uw+boAacutYZwWWQ9uTXkOzO
	hnIpKlEMyQ6v8oNlmWsl853j9sfzh95qonAtI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45AEE7B33;
	Sun, 13 Nov 2011 00:57:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC1FB7B32; Sun, 13 Nov 2011
 00:57:47 -0500 (EST)
In-Reply-To: <1320719428-1802-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 8 Nov
 2011 09:30:28 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 69CC12D8-0DBC-11E1-BD70-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185321>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> resolve_ref() may return a pointer to a static buffer. Callers that
> use this value outside of a block should copy the value to avoid some
> hidden resolve_ref() call that may change the static buffer's value.
>
> The bug found by Tony Wang <wwwjfy@gmail.com> in builtin/merge.c
> demonstrates this. The first call is in cmd_merge()
>
> branch =3D resolve_ref("HEAD", head_sha1, 0, &flag);
>
> Then deep in lookup_commit_or_die() a few lines after, resolve_ref()
> may be called again and destroy "branch".
>
> lookup_commit_or_die
>  lookup_commit_reference
>   lookup_commit_reference_gently
>    parse_object
>     lookup_replace_object
>      do_lookup_replace_object
>       prepare_replace_object
>        for_each_replace_ref
>         do_for_each_ref
>          get_loose_refs
>           get_ref_dir
>            get_ref_dir
>             resolve_ref
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

Thanks.

The above log message with the callchain would be a perfect explanation
for a patch to fix builtin/merge.c and nothing else, but among 50+
callsites of resolve_ref(), only 5 places are modified in this patch, a=
nd
it is not explained in the commit log message at all how they were chos=
en.
Were the other 40+ or so places inspected and deemed to be OK? Or is th=
is
"I just did a few of them in addition to the immediate need of fixing w=
hat
was reported, and the rest are left as an exercise to the readers" patc=
h?

Some variables that receive xstrdup()'ed result with this patch are
globals whose lifetime lasts while the process is alive, and I do not
think it is a huge problem that this patch does not free it, but it see=
ms
the patch does not free some other function scope variables once their =
use
is done even when it is fairly easy to do so.

How much overhead would it incur if we return xstrdup()'ed memory from =
the
resolve_ref() and make it the caller's responsibility to free it? Would=
 it
make the calling site too ugly?
