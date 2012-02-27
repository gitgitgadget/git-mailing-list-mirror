From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/11] cat-file: use streaming interface to print blobs
Date: Mon, 27 Feb 2012 09:44:21 -0800
Message-ID: <7vzkc49nnu.fsf@alter.siamese.dyndns.org>
References: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
 <1330329315-11407-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 18:44:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S24ci-0001TQ-M7
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 18:44:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753075Ab2B0Ro0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 12:44:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61020 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752197Ab2B0RoX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2012 12:44:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 197F56D19;
	Mon, 27 Feb 2012 12:44:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6L3pudUCpH7S
	NRg/YOwTYOorg8U=; b=Pi7wqxgaoNUYuicU3tJOQmH7LE+24AOtO/z6w+a4S8vD
	4mRnxNo5olD2hU+Cl9Dj/vW/RctMFoWzMQLQOZa/U0gjWym0bO9CX3gml5axS+BJ
	7mEVTGMQiZ4mhelgjbq7SQhbQa5BKvF9vlyWx+Is0L2FpKTVtbM0ocCJ22VtE9g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=nkhS7v
	9eUF8DOuwcTF6QVQgrFLeKX0mVqUYVAnndRtnE3lAD5FS5dBFry0EH0j4Fch9R3/
	fEYV/Ii0Q9YAScaB9LNHyj/ok+xh9UrjRj1VcJBeGQ4fM2xrSUTNL+HeEJzNMrRE
	XupMWCJPtCV40LicbWJvqKtaNtub3rUJ18Xhw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10FB36D18;
	Mon, 27 Feb 2012 12:44:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72B1E6D13; Mon, 27 Feb 2012
 12:44:22 -0500 (EST)
In-Reply-To: <1330329315-11407-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 27 Feb
 2012 14:55:07 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AECB2822-616A-11E1-B1C9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191636>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/cat-file.c |   22 ++++++++++++++++++++++
>  t/t1050-large.sh   |    2 +-
>  2 files changed, 23 insertions(+), 1 deletions(-)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 8ed501f..3f3b558 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -82,6 +82,24 @@ static void pprint_tag(const unsigned char *sha1, =
const char *buf, unsigned long
>  		write_or_die(1, cp, endp - cp);
>  }
> =20
> +static int write_blob(const unsigned char *sha1)
> +{
> +	unsigned char new_sha1[20];
> +
> +	if (sha1_object_info(sha1, NULL) =3D=3D OBJ_TAG) {

This smells bad.  Why in the world could an API be sane if lets a calle=
r
call "write_blob()" with something that can be a tag?

Both of your callsites call this function when (type =3D=3D OBJ_BLOB), =
but the
"case 0:" arm in the large switch in cat_one_file() only checks "expect=
ed
type" which may not match the real type at all, so it is wrong to switc=
h
on that in the first place.  In addition, that call site alone needs to
deref tag to the requested/expected type.

This block does not belong to this function, but to only one of its
callers among two.

> +		enum object_type type;
> +		unsigned long size;
> +		char *buffer =3D read_sha1_file(sha1, &type, &size);
> +		if (memcmp(buffer, "object ", 7) ||
> +		    get_sha1_hex(buffer + 7, new_sha1))
> +			die("%s not a valid tag", sha1_to_hex(sha1));
> +		sha1 =3D new_sha1;
> +		free(buffer);
> +	}
> +
> +	return streaming_write_sha1(1, 0, sha1, OBJ_BLOB, NULL);

I do not think your previous refactoring added a fall-back codepath to =
the
function you are calling here.  In the original context, the caller of
streaming_write_entry() made sure that the blob is suitable for streami=
ng
write by getting an istream, and called the function only when that is =
the
case.  Blobs unsuitable for streaming (e.g. an deltified object in a pa=
ck)
were handled by the caller that decided not to call
streaming_write_entry() with the conventional "read to core and then wr=
ite
it out" codepath.

And I do not think your updated caller in cat_one_file() is equipped to=
 do
so at all.

So it looks to me that this patch totally breaks the cat-file.  What am=
 I
missing?

> +}
> +
>  static int cat_one_file(int opt, const char *exp_type, const char *o=
bj_name)
>  {
>  	unsigned char sha1[20];
> @@ -127,6 +145,8 @@ static int cat_one_file(int opt, const char *exp_=
type, const char *obj_name)
>  			return cmd_ls_tree(2, ls_args, NULL);
>  		}
> =20
> +		if (type =3D=3D OBJ_BLOB)
> +			return write_blob(sha1);
>  		buf =3D read_sha1_file(sha1, &type, &size);
>  		if (!buf)
>  			die("Cannot read object %s", obj_name);
> @@ -149,6 +169,8 @@ static int cat_one_file(int opt, const char *exp_=
type, const char *obj_name)
>  		break;
> =20
>  	case 0:
> +		if (type_from_string(exp_type) =3D=3D OBJ_BLOB)
> +			return write_blob(sha1);
>  		buf =3D read_object_with_reference(sha1, exp_type, &size, NULL);
>  		break;
> =20
> diff --git a/t/t1050-large.sh b/t/t1050-large.sh
> index f245e59..39a3e77 100755
> --- a/t/t1050-large.sh
> +++ b/t/t1050-large.sh
> @@ -114,7 +114,7 @@ test_expect_success 'hash-object' '
>  	git hash-object large1
>  '
> =20
> -test_expect_failure 'cat-file a large file' '
> +test_expect_success 'cat-file a large file' '
>  	git cat-file blob :large1 >/dev/null
>  '
