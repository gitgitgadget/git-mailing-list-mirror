From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 16/28] receive-pack: reorder some code in unpack()
Date: Mon, 02 Dec 2013 14:25:08 -0800
Message-ID: <xmqqy542q4aj.fsf@gitster.dls.corp.google.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
	<1385351754-9954-17-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 02 23:25:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vnbva-0000Vg-Vy
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 23:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933Ab3LBWZP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Dec 2013 17:25:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33825 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752207Ab3LBWZM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Dec 2013 17:25:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B12F5759A;
	Mon,  2 Dec 2013 17:25:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ewlDLem/lX6o
	Rmy/+QLLPvty/Uk=; b=F5ThgimYoeOA6GEXx+wUyfxVXrrIOdpkpn0TH7uPvidK
	Jv3pvceOmyYD0huDqoqQmG5m7Lt1uZybuhFrHTQRyw1To2KMxGqaEDKjfCQF+XCp
	V0jb1AW0k0qZVEtVvNu9XIvK/PSOCU6kaB5z2O8vgmUlTYdHxaDO96bEFLoszF4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=I84A7K
	y4zyExGNC9tpxW9cRxR3wvfqeAzvFY8JGqLP2dOpZX2U6I2RFXXxHRODruAyOL3C
	6UIxva3Yllwz4iGkw0RePQIgUC51YD4ZOQKw4tpVeimkzGF8k6ATnMvwk0M/belZ
	PlV7k/oJa8sFIt2TZGW7MZP2cSrlsY4peUONo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0953857599;
	Mon,  2 Dec 2013 17:25:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1DFEF57598;
	Mon,  2 Dec 2013 17:25:11 -0500 (EST)
In-Reply-To: <1385351754-9954-17-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 25
 Nov 2013 10:55:42 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9B66581A-5BA0-11E3-9514-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238658>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This is the preparation for adding --shallow-file to both
> unpack-objects and index-pack. To sum up:
>
>  - status/code, ip/child, unpacker/keeper and i (now ac) are moved ou=
t
>    to function top level
>
>  - successful flow now ends at the end of the function
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

Sounds sensible; for a new piece of code, we probably should see if
argv_array API is more appropriate, and I think it is for this case.

Thanks.

> ---
>  builtin/receive-pack.c | 74 +++++++++++++++++++++++-----------------=
----------
>  1 file changed, 34 insertions(+), 40 deletions(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index cc8c34f..22e162d 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -822,8 +822,11 @@ static const char *pack_lockfile;
>  static const char *unpack(int err_fd)
>  {
>  	struct pack_header hdr;
> +	const char *argv[7];
>  	const char *hdr_err;
> +	int status, ac =3D 0;
>  	char hdr_arg[38];
> +	struct child_process child;
>  	int fsck_objects =3D (receive_fsck_objects >=3D 0
>  			    ? receive_fsck_objects
>  			    : transfer_fsck_objects >=3D 0
> @@ -840,63 +843,54 @@ static const char *unpack(int err_fd)
>  			"--pack_header=3D%"PRIu32",%"PRIu32,
>  			ntohl(hdr.hdr_version), ntohl(hdr.hdr_entries));
> =20
> +	memset(&child, 0, sizeof(child));
>  	if (ntohl(hdr.hdr_entries) < unpack_limit) {
> -		int code, i =3D 0;
> -		struct child_process child;
> -		const char *unpacker[5];
> -		unpacker[i++] =3D "unpack-objects";
> +		argv[ac++] =3D "unpack-objects";
>  		if (quiet)
> -			unpacker[i++] =3D "-q";
> +			argv[ac++] =3D "-q";
>  		if (fsck_objects)
> -			unpacker[i++] =3D "--strict";
> -		unpacker[i++] =3D hdr_arg;
> -		unpacker[i++] =3D NULL;
> -		memset(&child, 0, sizeof(child));
> -		child.argv =3D unpacker;
> +			argv[ac++] =3D "--strict";
> +		argv[ac++] =3D hdr_arg;
> +		argv[ac++] =3D NULL;
> +		child.argv =3D argv;
>  		child.no_stdout =3D 1;
>  		child.err =3D err_fd;
>  		child.git_cmd =3D 1;
> -		code =3D run_command(&child);
> -		if (!code)
> -			return NULL;
> -		return "unpack-objects abnormal exit";
> +		status =3D run_command(&child);
> +		if (status)
> +			return "unpack-objects abnormal exit";
>  	} else {
> -		const char *keeper[7];
> -		int s, status, i =3D 0;
> +		int s;
>  		char keep_arg[256];
> -		struct child_process ip;
> =20
>  		s =3D sprintf(keep_arg, "--keep=3Dreceive-pack %"PRIuMAX" on ", (u=
intmax_t) getpid());
>  		if (gethostname(keep_arg + s, sizeof(keep_arg) - s))
>  			strcpy(keep_arg + s, "localhost");
> =20
> -		keeper[i++] =3D "index-pack";
> -		keeper[i++] =3D "--stdin";
> +		argv[ac++] =3D "index-pack";
> +		argv[ac++] =3D "--stdin";
>  		if (fsck_objects)
> -			keeper[i++] =3D "--strict";
> +			argv[ac++] =3D "--strict";
>  		if (fix_thin)
> -			keeper[i++] =3D "--fix-thin";
> -		keeper[i++] =3D hdr_arg;
> -		keeper[i++] =3D keep_arg;
> -		keeper[i++] =3D NULL;
> -		memset(&ip, 0, sizeof(ip));
> -		ip.argv =3D keeper;
> -		ip.out =3D -1;
> -		ip.err =3D err_fd;
> -		ip.git_cmd =3D 1;
> -		status =3D start_command(&ip);
> -		if (status) {
> +			argv[ac++] =3D "--fix-thin";
> +		argv[ac++] =3D hdr_arg;
> +		argv[ac++] =3D keep_arg;
> +		argv[ac++] =3D NULL;
> +		child.argv =3D argv;
> +		child.out =3D -1;
> +		child.err =3D err_fd;
> +		child.git_cmd =3D 1;
> +		status =3D start_command(&child);
> +		if (status)
>  			return "index-pack fork failed";
> -		}
> -		pack_lockfile =3D index_pack_lockfile(ip.out);
> -		close(ip.out);
> -		status =3D finish_command(&ip);
> -		if (!status) {
> -			reprepare_packed_git();
> -			return NULL;
> -		}
> -		return "index-pack abnormal exit";
> +		pack_lockfile =3D index_pack_lockfile(child.out);
> +		close(child.out);
> +		status =3D finish_command(&child);
> +		if (status)
> +			return "index-pack abnormal exit";
> +		reprepare_packed_git();
>  	}
> +	return NULL;
>  }
> =20
>  static const char *unpack_with_sideband(void)
