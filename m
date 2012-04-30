From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] archive-tar: stream large blobs to tar file
Date: Mon, 30 Apr 2012 14:36:43 -0700
Message-ID: <7vhaw0ewb8.fsf@alter.siamese.dyndns.org>
References: <1335761837-12482-1-git-send-email-pclouds@gmail.com>
 <1335761837-12482-5-git-send-email-pclouds@gmail.com>
 <4F9EFF39.4010804@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Apr 30 23:37:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOyHS-000827-14
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 23:37:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756872Ab2D3Vgz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 17:36:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62614 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756850Ab2D3Vgq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Apr 2012 17:36:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A27974C2;
	Mon, 30 Apr 2012 17:36:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=oZ68j0ES81l8
	2QuQ5yJKuzzwkXs=; b=QvxuQFDKIywVmsJ5KOF2b2ZqHJtbp27GrDoAyIOZXwiD
	QLlfG47zBhwVFIrO1iM4iSDmipsKD7+7/HnQH9lJH1VYYS1WU/du0TGKMUUjrqgn
	QNDK4GOHat0yBsU8Y2p0yWCPa9NzeCjJAhK5nweGPxcJAC+NndF+srpPNgFlB+8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=RmBx5C
	1odUyDdOYj3W/lT9kN+x1KAYuxO/4nNOKuiU8oE9TAbWKEGQYhGvWZwqDwVzi/wy
	rWOahTGOhOmmW3lchcZUbTKTFwqi6P14eYU7F3AIOs1su6bzFHTELFTOU8eIAu62
	VfrCLPigFxrKE2wk+evZwnMxGMVEtgD8jjygY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E82DD74C1;
	Mon, 30 Apr 2012 17:36:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 62D5774BD; Mon, 30 Apr 2012
 17:36:45 -0400 (EDT)
In-Reply-To: <4F9EFF39.4010804@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Mon, 30 Apr 2012 23:08:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9574A0AA-930C-11E1-8CF6-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196612>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

>> +static int stream_blob_to_file(const unsigned char *sha1)
>> +{
>> +	struct git_istream *st;
>> +	enum object_type type;
>> +	unsigned long sz;
>> +
>> +	st =3D open_istream(sha1,&type,&sz, NULL);
>> +	if (!st)
>> +		return error("cannot stream blob %s", sha1_to_hex(sha1));
>> +	for (;;) {
>> +		char buf[BLOCKSIZE];
>> +		ssize_t readlen;
>> +
>> +		readlen =3D read_istream(st, buf, sizeof(buf));
>> +
>> +		if (readlen <=3D 0)
>> +			return readlen;
>> +		write_blocked(buf, readlen);
>> +	}
>> +	close_istream(st);
>> +	return 0;
>> +}
>
> The stream is never closed.  Perhaps squash this in?
>
> diff --git a/archive-tar.c b/archive-tar.c
> index 506c8cb..6109fd3 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -66,6 +66,7 @@ static void write_blocked(const void *data, unsigne=
d long size)
>  static int stream_blob_to_file(const unsigned char *sha1)
>  {
>  	struct git_istream *st;
> +	ssize_t readlen;
>  	enum object_type type;
>  	unsigned long sz;
> =20
> @@ -74,16 +75,15 @@ static int stream_blob_to_file(const unsigned cha=
r *sha1)
>  		return error("cannot stream blob %s", sha1_to_hex(sha1));
>  	for (;;) {
>  		char buf[BLOCKSIZE];
> -		ssize_t readlen;
> =20
>  		readlen =3D read_istream(st, buf, sizeof(buf));
> =20
>  		if (readlen <=3D 0)
> -			return readlen;
> +			break;
>  		write_blocked(buf, readlen);
>  	}
>  	close_istream(st);
> -	return 0;
> +	return readlen;
>  }

Your patch on top obviouly is the right thing to do, but reading the co=
de
again, I am not sure if the original is correct.  read_istream() itself
does not promise that it will always fill the buffer before returning (=
it
could return with a short read).  It seems incorrect that the caller do=
es
not loop to avoid padding a short read with padding by calling
write_blocked().
