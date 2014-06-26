From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] diff: mark any file larger than core.bigfilethreshold binary
Date: Thu, 26 Jun 2014 10:55:18 -0700
Message-ID: <xmqqegyb5zeh.fsf@gitster.dls.corp.google.com>
References: <1401368227-14469-1-git-send-email-pclouds@gmail.com>
	<1403610336-27761-1-git-send-email-pclouds@gmail.com>
	<1403610336-27761-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, worley@alum.mit.edu
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 19:55:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0DtY-0003LZ-3c
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 19:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757792AbaFZRzc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Jun 2014 13:55:32 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52467 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753555AbaFZRzb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jun 2014 13:55:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9BD8021997;
	Thu, 26 Jun 2014 13:55:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3DPozJRBAW61
	6d2dv8KyxipSkkg=; b=XmFAMrS8NSyaBTcBnOT/KNTiWvDacDlvVYnQ+Qkc3HTA
	wrUT2lW2Tl244xVelajNQl/2YtPVKDB/IC+9lTpSXf/1eMr0ZBLXFfsJTIcr9Y6i
	HDDO+w6y4qeC8wPOtOSohdYHnQTuxixqGNoWrJ45o7qH3xoRm8nM/el9zfdYJkM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=iCFQgf
	/WCyJND+NQN9igVIjKQN1SAdOIh6JrG2Of9Ge4hXUKo9oZ9mG8O0aqJTFlbQ/eZ/
	VMBYOQGYCXbzMXryIMGzi4HG4qoB0GVb7v2rx5YbSI1BJvk6iquzxEZU7HYWGnkd
	tWAN/fxSlfKCETqXijQlCklMGuO8+FsvnHqNs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 46CA621996;
	Thu, 26 Jun 2014 13:55:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2514221990;
	Thu, 26 Jun 2014 13:55:13 -0400 (EDT)
In-Reply-To: <1403610336-27761-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 24
 Jun 2014 18:45:36 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 05C1341C-FD5B-11E3-AC83-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252512>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Too large files may lead to failure to allocate memory. If it happens
> here, it could impact quite a few commands that involve
> diff. Moreover, too large files are inefficient to compare anyway (an=
d
> most likely non-text), so mark them binary and skip looking at their
> content.
> ...
> diff --git a/diff.c b/diff.c
> index a489540..7a977aa 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2185,8 +2185,8 @@ int diff_filespec_is_binary(struct diff_filespe=
c *one)
>  			one->is_binary =3D one->driver->binary;
>  		else {
>  			if (!one->data && DIFF_FILE_VALID(one))
> -				diff_populate_filespec(one, 0);
> -			if (one->data)
> +				diff_populate_filespec(one, DIFF_POPULATE_IS_BINARY);
> +			if (one->is_binary =3D=3D -1 && one->data)
>  				one->is_binary =3D buffer_is_binary(one->data,
>  						one->size);
>  			if (one->is_binary =3D=3D -1)

The name is misleading and forced me to read it twice before I
realized that this is "populating the is-binary bit".  It might make
it a bit better if you renamed it to DIFF_POPULATE_IS_BINARY_BIT or
perhaps DIFF_POPULATE_CHECK_BINARY or something.  For consistency,
the other bit may want to be also renamed from SIZE_ONLY to either

 (1) CHECK_SIZE_ONLY

 (2) One bit for CHECK_SIZE, another for NO_CONTENTS, and optionally
     make SIZE_ONLY the union of two

I do not have strong preference either way; the latter may be more
logical in that "not loading contents" and "check size" are sort of
orthogonal in that you can later choose to check, without loading
contents, only the binary-ness without checking size, but no calles
that passes a non-zero flag to the populate-filespec function will
want to slurp in the contents in practice, so in that sense we could
declare that the NO_CONENTS bit is implied.

But more importantly, would this patch actually help?  For one
thing, this wouldn't (and shouldn't) help if the user wants --binary
diff out of us anyway, I suspect, but I wonder what the following
codepath in the builtin_diff() function would do:

		...
	} else if (!DIFF_OPT_TST(o, TEXT) &&
	    ( (!textconv_one && diff_filespec_is_binary(one)) ||
	      (!textconv_two && diff_filespec_is_binary(two)) )) {
		if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
			die("unable to read files to diff");
		/* Quite common confusing case */
		if (mf1.size =3D=3D mf2.size &&
		    !memcmp(mf1.ptr, mf2.ptr, mf1.size)) {
			if (must_show_header)
				fprintf(o->file, "%s", header.buf);
			goto free_ab_and_return;
		}
		fprintf(o->file, "%s", header.buf);
		strbuf_reset(&header);
		if (DIFF_OPT_TST(o, BINARY))
			emit_binary_diff(o->file, &mf1, &mf2, line_prefix);
		else
			fprintf(o->file, "%sBinary files %s and %s differ\n",
				line_prefix, lbl[0], lbl[1]);
		o->found_changes =3D 1;
	} else {
		...

If we weren't told with --text/-a to force textual output, and
at least one of the sides is marked as binary (and this patch marks
a large blob as binary unless attributes says otherwise), we still
call fill_mmfile() on them to slurp the contents to be compared, no?

And before you get to the DIFF_OPT_TST(o, BINARY), you memcmp(3) to
check if the sides are identical, so...
