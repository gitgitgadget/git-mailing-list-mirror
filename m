From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 05/11] show: use streaming interface for showing blobs
Date: Mon, 27 Feb 2012 10:00:57 -0800
Message-ID: <7vvcms9mw6.fsf@alter.siamese.dyndns.org>
References: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
 <1330329315-11407-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 19:01:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S24sl-0002f9-PL
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 19:01:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069Ab2B0SBC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 13:01:02 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37252 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753354Ab2B0SBA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2012 13:01:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1CC672FF;
	Mon, 27 Feb 2012 13:00:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+mDvFrCyZxFd
	ly6LW8Jxf+9qAbg=; b=BFclrmjEDO+ntFvzuh1SzZkBJ8M+CAJUWn8miQm8S5Cs
	T9fKmf4PyWs9T1d2uJNq+CFScGcU34l3XWwAFtbjjIAmGN50Bp+p/AnG8JnR674r
	OzKAq/6uEPxGgyeaH7loRk6pzV7i+rkhjCD/PlcY2ptF3RMHsUiXh6BrwpRhWgA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dlFAJN
	29iRsX7aqbMxTH+JqXfGAUVEjQ7mqFkZ8+lkM95nETouTVWN9tmPMVo0PKP78czn
	RJ07NxslPhC3WB5I6ooZ7sWJ+9V/3Jhr8oZDOAkLaGbBVgOWy2ssQvxMzzLQQG/S
	Cpbsv9lOGD0TIyvDvfSgaDMLlRtuRLEBpD47w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A90A272FE;
	Mon, 27 Feb 2012 13:00:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0818072FD; Mon, 27 Feb 2012
 13:00:58 -0500 (EST)
In-Reply-To: <1330329315-11407-6-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 27 Feb
 2012 14:55:09 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 00D03548-616D-11E1-9060-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191639>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/log.c    |    9 ++++++++-
>  t/t1050-large.sh |    2 +-
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index 7d1f6f8..4c4b17a 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -386,13 +386,20 @@ static int show_object(const unsigned char *sha=
1, int show_tag_object,
>  {
>  	unsigned long size;
>  	enum object_type type;
> -	char *buf =3D read_sha1_file(sha1, &type, &size);
> +	char *buf;
>  	int offset =3D 0;
> =20
> +	if (!show_tag_object) {
> +		fflush(stdout);
> +		return streaming_write_sha1(1, 0, sha1, OBJ_ANY, NULL);
> +	}
> +
> +	buf =3D read_sha1_file(sha1, &type, &size);
>  	if (!buf)
>  		return error(_("Could not read object %s"), sha1_to_hex(sha1));
> =20
>  	if (show_tag_object)
> +		assert(type =3D=3D OBJ_TAG);
>  		while (offset < size && buf[offset] !=3D '\n') {
>  			int new_offset =3D offset + 1;
>  			while (new_offset < size && buf[new_offset++] !=3D '\n')

Yuck.

The two callsites to this static function are to do BLOB to do TAG.  An=
d
after you start handing all the blob handling to streaming_write_sha1()=
,
there is no shared code between the two callers for this function.

So why not remove this function, create one show_blob_object() and the
other show_tag_object(), and update the callers to call the appropriate
one?

> diff --git a/t/t1050-large.sh b/t/t1050-large.sh
> index 39a3e77..66acb3b 100755
> --- a/t/t1050-large.sh
> +++ b/t/t1050-large.sh
> @@ -118,7 +118,7 @@ test_expect_success 'cat-file a large file' '
>  	git cat-file blob :large1 >/dev/null
>  '
> =20
> -test_expect_failure 'git-show a large file' '
> +test_expect_success 'git-show a large file' '
>  	git show :large1 >/dev/null
> =20
>  '
