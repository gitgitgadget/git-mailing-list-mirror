From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] unpack-trees: do not abort when overwriting an existing
 file with the same content
Date: Sun, 20 Jan 2013 10:35:33 -0800
Message-ID: <7va9s3n1my.fsf@alter.siamese.dyndns.org>
References: <1358594648-26851-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 19:36:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwzkR-0008Iz-2F
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 19:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392Ab3ATSfg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jan 2013 13:35:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44976 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752354Ab3ATSfg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Jan 2013 13:35:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB13ABBA4;
	Sun, 20 Jan 2013 13:35:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Ah6NLv6ZJnJJ
	YL5Ig9QOrseIzsc=; b=szlaxLX4SY7yepBBjhAaB49Ktub8GoM5UUI9LQlq8dIv
	oQdnlYL+CRpDjAYlUCCtqvJul0UdgUes+0ttR0L1be2Hd11PLnLq/SBJeyUI7eBd
	L4ZA6RlDqtpGdX267t9y0rF5hwOt1FEGUHHLcAPzT04+cAdz0C5s6s2T3AtiCOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=iRMHWy
	uS4Rye1Rn+Z1uAP6X6o47R1xR/LxN6HG2Tuu/iv7evvjn7peSOqNK0OY03SnRZDL
	mcd4APPbZTSmZei9C9uRzALGY5vGGkmXR7Ozr2bZdfiTaLH8Ic8PMfe0qutCU6ge
	vA1BARbPGYYqSFaa76Fw59zTMBysat9PR5ik8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C06A7BBA3;
	Sun, 20 Jan 2013 13:35:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 55B2DBBA2; Sun, 20 Jan 2013
 13:35:35 -0500 (EST)
In-Reply-To: <1358594648-26851-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 19 Jan
 2013 18:24:08 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2DDCF682-6330-11E2-BE18-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214027>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +	/*
> +	 * If it has the same content that we are going to write down,

write down???

> +	 * there's no point in complaining. We still overwrite it in the
> +	 * end though. Permission is not checked so it may be lost.
> +	 */

That is a regression, isn't it?  Is it too cumbersome to avoid
losing the permission bits by stopping in that case?

> +	if (ce &&
> +	    S_ISREG(st->st_mode) && S_ISREG(ce->ce_mode) &&
> +	    st->st_size < 1024 * 1024 && /* should be configurable */
> +	    sha1_object_info(ce->sha1, &ce_size) =3D=3D OBJ_BLOB &&
> +	    ce_size =3D=3D st->st_size) {
> +		void *buffer =3D NULL;
> +		unsigned long size;
> +		enum object_type type;
> +		struct strbuf sb =3D STRBUF_INIT;
> +		int matched =3D
> +			strbuf_read_file(&sb, ce->name, ce_size) =3D=3D ce_size &&
> +			(buffer =3D read_sha1_file(ce->sha1, &type, &size)) !=3D NULL &&
> +			type =3D=3D OBJ_BLOB &&
> +			size =3D=3D ce_size &&
> +			!memcmp(buffer, sb.buf, size);
> +		free(buffer);
> +		strbuf_release(&sb);
> +		if (matched)
> +			return 0;
> +	}
> +
>  	return o->gently ? -1 :
>  		add_rejected_path(o, error_type, name);
>  }
