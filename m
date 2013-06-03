From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] core: use env variable instead of config var to turn on logging pack access
Date: Mon, 03 Jun 2013 13:24:00 -0700
Message-ID: <7vmwr7c59b.fsf@alter.siamese.dyndns.org>
References: <1369921908-2988-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 22:24:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjbIY-0007vI-SZ
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 22:24:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754049Ab3FCUYG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Jun 2013 16:24:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59880 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753395Ab3FCUYE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jun 2013 16:24:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2EBC25B71;
	Mon,  3 Jun 2013 20:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Snb7v7QhVqub
	DjAWsgGSo6a6iv0=; b=t3pN7mBkpkRrCCixunSOvrr8OG2cgKm1JGBSC1NLM9e7
	k4/5aIDJrN21eHCFTNdmUMkbHJBEWPOSNmda7Ji4P62rT+x9+tM8k6GPgTq9c5au
	7zpPTmf7nVW0y28xntXKC8aiqF2DPKgLrdQGY1z8iHjJLHK3rlMTCBoshtJ/y2I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ZMHMf7
	jnQXyMXg4I0II7UUED0YC2w8y1DSae6MJD3QhZj7k8ukoLtCYhy4wjLSoidVvKDK
	EsyB2gQrs+VCE7REUV8CcSKZoQifGqQqo5XLZPUrZq5XdDPp5sT0AcejSDhqZMXE
	6F9cksGGq0y4SM422AOVd1wShB2VWxOeu9K+M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D714425B6F;
	Mon,  3 Jun 2013 20:24:02 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D1A5925B6E;
	Mon,  3 Jun 2013 20:24:01 +0000 (UTC)
In-Reply-To: <1369921908-2988-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 30
 May 2013 20:51:47 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 876684EC-CC8B-11E2-BF11-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226276>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/sha1_file.c b/sha1_file.c
> index 67e815b..7b47bdc 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -36,6 +36,8 @@ static inline uintmax_t sz_fmt(size_t s) { return s=
; }
> =20
>  const unsigned char null_sha1[20];
> =20
> +static const char *log_pack_access =3D "";
> +
>  /*
>   * This is meant to hold a *small* number of objects that you would
>   * want read_sha1_file() to be able to return, but yet you do not wa=
nt
> @@ -1956,6 +1958,14 @@ static void write_pack_access_log(struct packe=
d_git *p, off_t obj_offset)
>  {
>  	static FILE *log_file;
> =20
> +	if (!*log_pack_access) {
> +		log_pack_access =3D getenv("GIT_TRACE_PACK_ACCESS");
> +		if (!*log_pack_access)
> +			log_pack_access =3D NULL;
> +		if (!log_pack_access)
> +			return;
> +	}

Have you ever tested this?

Once log_pack_access goes to NULL (e.g. when it sees the empty
string it was initialized to), this new test will happily
dereference NULL.
