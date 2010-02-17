From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/3] apply: Allow blank context lines to match beyond
 EOF
Date: Wed, 17 Feb 2010 00:14:47 -0800
Message-ID: <7vbpfo5le0.fsf@alter.siamese.dyndns.org>
References: <4B7B94A8.5000102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 09:15:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhf3l-0002Hf-VL
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 09:15:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934162Ab0BQIO4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Feb 2010 03:14:56 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54040 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934126Ab0BQIOy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Feb 2010 03:14:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1753E9A3CC;
	Wed, 17 Feb 2010 03:14:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=6G27MVu67iLsB//3tzUl8dvqT
	ms=; b=MBSjboCxHFBeZeRGE+SP4nmQsfYj//m0D/U1XFveGDXdqcIKhzky1wT/3
	SjzXbj3oialGfBih1t5p7xi6g5P7nZyTPA/IX1I75iiiky5O5JWxV7zxsYEYpNyW
	jJPqBachAzs7y1ga7+/DZp77QNTse/B2K6CIzE2S/4BEAooNbM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=XjIZvy5xY3oy69wdUGA
	xCTpra2skbSt7bUxUQSHri6YTRyyHumVTvKXL+IETnvWjkbqAAV5Hnu9yAfQwKvo
	aZehNc6NLpzc93aWVFbdb+EvC6LOnQ1lH0y7X5X92ZkvHZt11uBGfa7aozGXAnDM
	BW3tO0rQsRW9T1IrNV3apRtA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E20079A3C8;
	Wed, 17 Feb 2010 03:14:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 106829A3C4; Wed, 17 Feb
 2010 03:14:48 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 85D9F544-1B9C-11DF-90A2-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140216>

Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com> writes:

> "git apply --whitespace=3Dfix" will not always succeed when used
> on a series of patches in the following circumstances:
>
> * One patch adds a blank line at the end of a file. (Since
>   --whitespace=3Dfix is used, the blank line will *not* be added.)
>
> * The next patch adds non-blanks lines after the blank line
>   introduced in the first patch. That patch will not apply
>   because the blank line that is expected to be found at end
>   of the file is no longer there.
>
> Fix this problem by allowing a blank context line at the beginning
> of a hunk to match if parts of it falls beyond end of the file
> (i.e. at least one context line must match an existing line in
> the file).
>
> TODO: We should probably require that at least one *non-blank*
> context line should fall within the boundaries of the file.

I think that is very sensible; I thought about this after I wrote the
review message in the previous round but failed to mention it.  Happy t=
o
see that you are thinking along the same line.

> @@ -2002,11 +2071,17 @@ static int find_pos(struct image *img,
>  	unsigned long backwards, forwards, try;
>  	int backwards_lno, forwards_lno, try_lno;
> =20
> -	if (preimage->nr > img->nr)
> -		return -1;
> +	/*
> +	 * There used to be a quick reject here in case preimage
> +	 * had more lines than img. We must let match_fragment()
> +	 * handle that case because a hunk is now allowed to
> +	 * extend beyond the end of img when --whitespace=3Dfix
> +	 * has been given (and core.whitespace.blanks-at-eof is
> +	 * enabled).
> +	 */

Is it worth to keep the quick-reject if we are not running under
blank-at-eof mode?
