From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 2/2] convert: ce_compare_data() checks for a sha1 of a path
Date: Fri, 20 May 2016 10:46:41 -0700
Message-ID: <xmqqshxcei66.fsf@gitster.mtv.corp.google.com>
References: <xmqqk2iphcqe.fsf@gitster.mtv.corp.google.com>
	<1463764366-21683-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Fri May 20 19:46:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3oVf-00052s-3m
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 19:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696AbcETRqq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 May 2016 13:46:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62655 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752013AbcETRqp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2016 13:46:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 829891D329;
	Fri, 20 May 2016 13:46:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PND77KRnyRRt
	4UggNEoiXZM/FQo=; b=pgUbA5zVkezAxKtzVXMl40SgAUwMzE6akBmNZgGDmPS3
	bqcZwXPjLiqZp5Cm/iuRmqRgBrEGzLEf8FLuOoylnbQAN12bGlzrCb8WNbS6feUf
	XAAujeCyA1bYDn+X59uRc2pp3GOO3bSqMvxtvhhn2c6NeSeukVZLJaq0/qujbR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=u4K5yd
	mYrnHhceDMQ6AkVJk+pFIvTFNhwRQWmqI6MRjFKrN1Qi4AkTMKof6fbHQRDkN1+p
	/xR3+GRY//KLQDj2pl6ei461wg5utKe49tcCbFZHq4HVcyLao6GPr8QH4dEpzf62
	uhefSPxlyDSHhV9EZkGJCxPYKgwJah82HbfoA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 78D231D326;
	Fri, 20 May 2016 13:46:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E76F31D325;
	Fri, 20 May 2016 13:46:42 -0400 (EDT)
In-Reply-To: <1463764366-21683-1-git-send-email-tboegi@web.de>
	(tboegi@web.de's message of "Fri, 20 May 2016 19:12:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D054B436-1EB2-11E6-B76A-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295192>

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> To compare a file in working tree with the index, convert_to_git() is=
 used,
> the result is hashed and the hash value compared with ce->sha1.
>
> Deep down would_convert_crlf_at_commit() is invoked, to check if CRLF
> are converted or not: When a CRLF had been in the index before, CRLF =
in
> the working tree are not converted.
>
> While in a merge, a file name in the working tree has different blobs
> in the index with different hash values.
> Forwarding ce->sha1 from ce_compare_data() into crlf_to_git() makes s=
ure
> the would_convert_crlf_at_commit() looks at the appropriate blob.
>
> Forward sha1 from ce_compare_data() into convert_to_git().
> All other callers use NULL, and the sha1 it is determined from path u=
sing
> get_sha1_from_cache(path), this is the same handling as before.
>
> Re-order the arguments for convert_to_git() according to their import=
ance:
>   `src`, `len` and `dst` are the place in memory, where the conversio=
n is done
>   `path` is the file name to look up the attributes.
>   `sha1` is needed by the "new safer autocrlf handling".
>   `checksafe` determines, if a warning is printed or an error is rais=
ed.
>
> In the same spirit, forward the sha1 into would_convert_to_git().
>
> While at it, rename has_cr_in_index() into blob_has_cr()
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>


> Changes sinve v6:
>  decrease the messiness with 12 %

What does that mean????

>  convert_to_git() has a re-ordered parameter list.

That is not what I suggested, though.  <path, src, len> being
the first three would be fine, and that would be in line with
helpers ${frotz}_to_git() that are used from there.

The primary thing that made me worried was a new parameter with a
bland name "sha1" whose purpose is unclear was added near the
beginning, leading readers to confusion.

Whether you keep <path> at the beginning of move it to later
together with <sha1>, helpers like crlf_to_git() need to be updated
to match.  E.g. I would say that this

> -	ret |=3D crlf_to_git(path, src, len, dst, ca.crlf_action, checksafe=
);
> +	ret |=3D crlf_to_git(path, sha1, src, len, dst, ca.crlf_action, che=
cksafe);

would want to be ordered more like this:

    ret |=3D crlf_to_git(path, src, len, dst,
                       ca.crlf_action, checksafe, index_blob_sha1);

if you choose to keep the first four intact for convert_to_git(),
that is.

>  Describe whats going on better in the commit msg.

The suggestion to rename the parameter was to allow readers of the
code to immediately know what kind of SHA1 it is.  They cannot
afford to run "git blame" every time to find the commit to read the
commit log message; for a public function like convert_to_git(),
in-code comment is also necessary.
