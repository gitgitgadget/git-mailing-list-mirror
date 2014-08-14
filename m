From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 6/6] diff: shortcut for diff'ing two binary SHA-1 objects
Date: Thu, 14 Aug 2014 10:17:45 -0700
Message-ID: <xmqqy4ur0z46.fsf@gitster.dls.corp.google.com>
References: <1403610336-27761-1-git-send-email-pclouds@gmail.com>
	<1407927454-9268-1-git-send-email-pclouds@gmail.com>
	<1407927454-9268-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, worley@alum.mit.edu
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 19:18:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHyfK-0001Fh-U0
	for gcvg-git-2@plane.gmane.org; Thu, 14 Aug 2014 19:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945AbaHNRSF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2014 13:18:05 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63772 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752800AbaHNRRz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Aug 2014 13:17:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 46C932F8A9;
	Thu, 14 Aug 2014 13:17:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=gm/bb5qyrwWq
	mdyejOCMwPbIVyU=; b=TmUuE/4/btcde7wQYLGNZJQEK47MNTe8k9lF9Iv9KIjU
	4NbsW1fEhW2iVScDjArotTtl6Z2AqsMc5ELX3JOsF8E1tiG5/4+FaY7SK7HRm0kf
	U42VUobY5L1eczP26FzYHf49eeBb9YrEUY5kPdDr9o2Xe1Cu915/PLDOh93DC1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Rsgcjb
	qfWkZ4GqKeJzCIPK3OWzQB38wB1AdDckO0+ovdm2hNh1KNT7hG5I9AgxFFeP27Te
	M4Yi14HhbM1isCtItgp8hZS7weN520Ud7cq5r/neyp+vcl8YJcf8kdmVvI0mittr
	npH0cPJqMNUBJJSiuZLMyRvHfHdaE9J/wVynE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3B71B2F8A8;
	Thu, 14 Aug 2014 13:17:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 062102F88C;
	Thu, 14 Aug 2014 13:17:46 -0400 (EDT)
In-Reply-To: <1407927454-9268-7-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 13
 Aug 2014 17:57:34 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E9334C8E-23D6-11E4-9F13-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255268>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> If we are given two SHA-1 and asked to determine if they are differen=
t
> (but not _what_ differences), we know right away by comparing SHA-1.
>
> A side effect of this patch is, because large files are marked binary=
,
> diff-tree will not need to unpack them. 'diff-index --cached' will no=
t
> either. But 'diff-files' still does.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  diff.c           | 13 +++++++++++++
>  t/t1050-large.sh |  8 ++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/diff.c b/diff.c
> index d381a6f..b85bcfb 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2324,6 +2324,19 @@ static void builtin_diff(const char *name_a,
>  	} else if (!DIFF_OPT_TST(o, TEXT) &&
>  	    ( (!textconv_one && diff_filespec_is_binary(one)) ||
>  	      (!textconv_two && diff_filespec_is_binary(two)) )) {
> +		if (!one->data && !two->data &&
> +		    S_ISREG(one->mode) && S_ISREG(two->mode) &&
> +		    !DIFF_OPT_TST(o, BINARY)) {
> +			if (!hashcmp(one->sha1, two->sha1)) {
> +				if (must_show_header)
> +					fprintf(o->file, "%s", header.buf);
> +				goto free_ab_and_return;
> +			}
> +			fprintf(o->file, "%s", header.buf);
> +			fprintf(o->file, "%sBinary files %s and %s differ\n",
> +				line_prefix, lbl[0], lbl[1]);
> +			goto free_ab_and_return;
> +		}

A tangent.

I think one and two can point at the same object only when this
filepair is involved in rename/copy.  In other words, one and two
with the same <mode,sha1,name> would not be given to this code.  And
must-show-header would be set to true long before we get here in
fill-metainfo in such a case.

I think this new code and the original below which you copied this
one from can probably be simplified.  It already felt wrong to see
two copies of "fprintf(o->file "%s", header.buf)" and now we have
four of them.  Because this is a copy-and-paste of the identical
logic from below, I do not want you to attempt fixing this tangent
in this patch, though.

Thanks.

>  		if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
>  			die("unable to read files to diff");
>  		/* Quite common confusing case */
> diff --git a/t/t1050-large.sh b/t/t1050-large.sh
> index 711f22c..b294963 100755
> --- a/t/t1050-large.sh
> +++ b/t/t1050-large.sh
> @@ -116,6 +116,14 @@ test_expect_success 'diff --stat' '
>  	git diff --stat HEAD^ HEAD
>  '
> =20
> +test_expect_success 'diff' '
> +	git diff HEAD^ HEAD
> +'
> +
> +test_expect_success 'diff --cached' '
> +	git diff --cached HEAD^
> +'
> +
>  test_expect_success 'hash-object' '
>  	git hash-object large1
>  '
