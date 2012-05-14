From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pack-objects: use streaming interface for reading
 large loose blobs
Date: Mon, 14 May 2012 08:56:47 -0700
Message-ID: <7vvcjyiwn4.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.02.1205121220070.21030@xanadu.home>
 <1336883862-9013-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 14 17:56:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STxdo-0007Dx-FA
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 17:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756717Ab2ENP4v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 May 2012 11:56:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51382 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756666Ab2ENP4u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 May 2012 11:56:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6ED278AD9;
	Mon, 14 May 2012 11:56:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2ydpWOy0DuBi
	DIPgdy8E5F7w2Y0=; b=U5dkXjsAhhzBUmUkIQNUlrOIioJSixUgdg6hsSEIcDuY
	e0P6oYvqxrBeBGQYmnxUnn7rjkO9bWRGgcr7M7QKgvYEotHQ+f01QpsfJMs6mSKE
	bKy72S67dsoFijjz2AZ7exwgbR+zu4TQ3ZkXmoqCZP2kf/PNYQx//5oShBdPh0A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=AAgymj
	IPk9B+Z9WMhWi+OzCPLWmbEeIW8j66k4AbEKf9bhBX0kjhzx89EF8FQ5RpNKZVvx
	5WFh6QDfh4SaHCfkd3jnxi3PCqcsvRiJUJQxSDeds96Ewzp3QZzoRoJgKojkYM7u
	uS/s3TjI5jBns3ETtZFbQvLbHmE/i+9u5CVFE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65AF38AD8;
	Mon, 14 May 2012 11:56:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D600C8AD6; Mon, 14 May 2012
 11:56:48 -0400 (EDT)
In-Reply-To: <1336883862-9013-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 13 May
 2012 11:37:42 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 69F5BEB0-9DDD-11E1-AB0C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197777>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> +	st =3D open_istream(sha1, &type, &sz, NULL);
> +	if (!st)
> +		die(_("unable to read %s"), sha1_to_hex(sha1));
> +
> +	memset(&stream, 0, sizeof(stream));
> +	git_deflate_init(&stream, pack_compression_level);
> +
> +	if (type !=3D OBJ_BLOB)
> +		die("BUG: %s is not a blob", sha1_to_hex(sha1));

Just a comment, not an expression of preference, but if we are treating
istream interface as an add-on, I wonder it might make sense not to die=
 in
these places, and instead fall back to the usual "read and then write"
codepath.

To put it another way, I am wondering if it makes the logic more clear =
if
you restructure the calling side a bit more, perhaps like this:

        if (!to_reuse) {
                if (!usable_delta) {
                        /* we know we will write as base object */
                        ... do *NOT* do read_sha1_file() here !!!
                } else if ... delta cases {
                        decide delta_data and z_delta_size as before
                }

                if (entry->z_delta_size) {
                        datalen =3D entry->z_delta_size;
                        hdrlen =3D encode_in_pack_object_header(type, s=
ize, header);
                        ... write either OFS_DELTA or REF_DELTA here
                } else {
                        /* base object case */
                        if (write_object_in_base_representation(f, sha1=
)) {
                                /* stream interface punted */
                                read_sha1_file();
                                do_compress();
                                write it;
                        }
                }
        } else { /* reuse case ... */

> @@ -259,9 +309,13 @@ static unsigned long write_object(struct sha1fil=
e *f,
>  	if (!to_reuse) {
>  		no_reuse:
>  		if (!usable_delta) {
> -			buf =3D read_sha1_file(entry->idx.sha1, &type, &size);
> -			if (!buf)
> -				die("unable to read %s", sha1_to_hex(entry->idx.sha1));
> +			if (entry->type =3D=3D OBJ_BLOB && entry->size > big_file_thresho=
ld)
> +				buf =3D NULL;

Two comments:

 - In get_object_details(), we do this:

		if (big_file_threshold <=3D entry->size)
			entry->no_try_delta =3D 1;

   The new code is inconsistent with respect to the boundary conditions=
,
   when the size is exactly at the threshold.

 - Magic condition "buf has NULL means we will read via streaming
   interface" feels somewhat hacky and tasteless.  I am borderline OK w=
ith
   such a hack whose scope is clearly limited to a short function like
   this one, but at least it needs to be documented.  I'd rather see th=
e
   conditionals that look at !buf/buf are rewritten to use a new bool
   variable similar to to_reuse and usable_delta whose name tells the
   reader more explicitly what is going on, though.
