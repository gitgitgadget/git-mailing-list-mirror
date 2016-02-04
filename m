From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 08/25] upload-pack: use skip_prefix() instead of starts_with() when possible
Date: Thu, 04 Feb 2016 15:42:57 -0800
Message-ID: <xmqqzivgdou6.fsf@gitster.mtv.corp.google.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
	<1454576641-29615-9-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 00:43:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRTYJ-0000dx-Ps
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 00:43:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757398AbcBDXnC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 18:43:02 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64112 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754044AbcBDXnA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Feb 2016 18:43:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C1FA0422DA;
	Thu,  4 Feb 2016 18:42:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=oLAaKcoRyqsR
	vRQg0zxr+1hoYwY=; b=E+REqYQUaSIm2QQFZPPafE6MpXiIDj8umVtRx2tko/np
	HQKNfq7lsBE+UZo7hsH0WXquoo2MmZ9oJija/zKBgVLXFe+L7V8oY9BbH22lcLNT
	YFKXPW8pxagjAvTIJFG8PX/su3RTtiCafYcPkOetvj+SOPEhj7tNpL7G0z42zBw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=oIYwg4
	tCetAhY5bayi/kVRJkKAA1HFxP4qVK1k5eJfV7Oj6h1pYmQKZoUOKipDi/fhNnMu
	T4IEPkJsxJOeBDJyuH70+D/9teZTMO9+VoLk5d8lgTuzIIOJpoLX3jkCqGHsgUBR
	/gleWy48DN9fSrt1r6DR0l7Ix1yZWGrZ8FUSY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BA7BC422D9;
	Thu,  4 Feb 2016 18:42:59 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 38835422D5;
	Thu,  4 Feb 2016 18:42:59 -0500 (EST)
In-Reply-To: <1454576641-29615-9-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 4 Feb
 2016 16:03:44 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 05CDC39A-CB99-11E5-9A4A-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285521>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

The result is certainly easier to read.  "when possible" is not
quite a right way to look at it, though.  I think the patch does it
when it makes sense (i.e. when the result becomes easier to read),
which is much better ;-)

I initially thought that the name "arg" was too bland, but we can
think of these as pointing at an argument on each line that begins
with a command (e.g. "have", "shallow", etc.), and when viewed that
way, calling the second token on the line an "arg" makes sense.



>  upload-pack.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/upload-pack.c b/upload-pack.c
> index bfb7985..257ad48 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -276,7 +276,7 @@ static void create_pack_file(void)
>  	die("git upload-pack: %s", abort_msg);
>  }
> =20
> -static int got_sha1(char *hex, unsigned char *sha1)
> +static int got_sha1(const char *hex, unsigned char *sha1)
>  {
>  	struct object *o;
>  	int we_knew_they_have =3D 0;
> @@ -382,6 +382,8 @@ static int get_common_commits(void)
> =20
>  	for (;;) {
>  		char *line =3D packet_read_line(0, NULL);
> +		const char *arg;
> +
>  		reset_timeout();
> =20
>  		if (!line) {
> @@ -403,8 +405,8 @@ static int get_common_commits(void)
>  			got_other =3D 0;
>  			continue;
>  		}
> -		if (starts_with(line, "have ")) {
> -			switch (got_sha1(line+5, sha1)) {
> +		if (skip_prefix(line, "have ", &arg)) {
> +			switch (got_sha1(arg, sha1)) {
>  			case -1: /* they have what we do not */
>  				got_other =3D 1;
>  				if (multi_ack && ok_to_give_up()) {
> @@ -616,14 +618,16 @@ static void receive_needs(void)
>  		const char *features;
>  		unsigned char sha1_buf[20];
>  		char *line =3D packet_read_line(0, NULL);
> +		const char *arg;
> +
>  		reset_timeout();
>  		if (!line)
>  			break;
> =20
> -		if (starts_with(line, "shallow ")) {
> +		if (skip_prefix(line, "shallow ", &arg)) {
>  			unsigned char sha1[20];
>  			struct object *object;
> -			if (get_sha1_hex(line + 8, sha1))
> +			if (get_sha1_hex(arg, sha1))
>  				die("invalid shallow line: %s", line);
>  			object =3D parse_object(sha1);
>  			if (!object)
> @@ -636,19 +640,19 @@ static void receive_needs(void)
>  			}
>  			continue;
>  		}
> -		if (starts_with(line, "deepen ")) {
> +		if (skip_prefix(line, "deepen ", &arg)) {
>  			char *end;
> -			depth =3D strtol(line + 7, &end, 0);
> -			if (end =3D=3D line + 7 || depth <=3D 0)
> +			depth =3D strtol(arg, &end, 0);
> +			if (end =3D=3D arg || depth <=3D 0)
>  				die("Invalid deepen: %s", line);
>  			continue;
>  		}
> -		if (!starts_with(line, "want ") ||
> -		    get_sha1_hex(line+5, sha1_buf))
> +		if (!skip_prefix(line, "want ", &arg) ||
> +		    get_sha1_hex(arg, sha1_buf))
>  			die("git upload-pack: protocol error, "
>  			    "expected to get sha, not '%s'", line);
> =20
> -		features =3D line + 45;
> +		features =3D arg + 40;
> =20
>  		if (parse_feature_request(features, "multi_ack_detailed"))
>  			multi_ack =3D 2;
