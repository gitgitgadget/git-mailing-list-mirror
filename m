From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/24] dir.c: optionally compute sha-1 of a .gitignore file
Date: Wed, 11 Feb 2015 13:23:04 -0800
Message-ID: <xmqqiof8ta6f.fsf@gitster.dls.corp.google.com>
References: <1423385748-19825-1-git-send-email-pclouds@gmail.com>
	<1423385748-19825-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 22:23:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLekc-0005kK-Oq
	for gcvg-git-2@plane.gmane.org; Wed, 11 Feb 2015 22:23:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754642AbbBKVXJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Feb 2015 16:23:09 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64058 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754045AbbBKVXI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Feb 2015 16:23:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 64D7836D70;
	Wed, 11 Feb 2015 16:23:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=VgCUT43XM8sD
	YlfOhODBiy/hAuI=; b=qb98OEC+V3U9vUbH+VBBqiecmoj953jtar13hmsOwMqM
	tkR8UoCS67Rd8cxavncPRkU83Tt7UiGJkhtTvP1Rv7gfxM/3Geem1uq7BBYe76G4
	NIsr2RbvZZIKGnCr8GwtOBc5AGlwpRnsn447uDvukQOSx2A9mkC0DRTbdbKSTzU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PmWvGF
	qfN7a6Fov3k2+xLjdW2mw5A0RwYGhcEqBO2LMrbPxjR+6NsF08WWp+6d8ty7one/
	XoQoSKjr4aNC2D+Tj5f2uuUidcxzY4uJeDPuH6myeifGW+YldWpOybH3EbgPw2Ee
	wLZ+AhrtzlE/mNrwNwJ74Ax0bE++YogJqSwCs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4FCF536D6E;
	Wed, 11 Feb 2015 16:23:07 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B6CD336D6C;
	Wed, 11 Feb 2015 16:23:06 -0500 (EST)
In-Reply-To: <1423385748-19825-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 8 Feb
 2015 15:55:25 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2B9B8488-B234-11E4-AFC4-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263693>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> -int add_excludes_from_file_to_list(const char *fname,
> -				   const char *base,
> -				   int baselen,
> -				   struct exclude_list *el,
> -				   int check_index)
> +/*
> + * Given a file with name "fname", read it (either from disk, or fro=
m
> + * the index if "check_index" is non-zero), parse it and store the
> + * exclude rules in "el".
> + *
> + * If "ss" is not NULL, compute SHA-1 of the exclude file and fill
> + * stat data from disk (only valid if add_excludes returns zero). If
> + * ss_valid is non-zero, "ss" must contain good value as input.
> + */
> +static int add_excludes(const char *fname, const char *base, int bas=
elen,
> +			struct exclude_list *el, int check_index,
> +			struct sha1_stat *sha1_stat)
> ...
> @@ -571,6 +588,21 @@ int add_excludes_from_file_to_list(const char *f=
name,
>  		}
>  		buf[size++] =3D '\n';
>  		close(fd);
> +		if (sha1_stat) {
> +			int pos;
> +			if (sha1_stat->valid &&
> +			    !match_stat_data(&sha1_stat->stat, &st))
> +				; /* no content change, ss->sha1 still good */
> +			else if (check_index &&
> +				 (pos =3D cache_name_pos(fname, strlen(fname))) >=3D 0 &&
> +				 !ce_stage(active_cache[pos]) &&
> +				 ce_uptodate(active_cache[pos]))
> +				hashcpy(sha1_stat->sha1, active_cache[pos]->sha1);
> +			else
> +				hash_sha1_file(buf, size, "blob", sha1_stat->sha1);

I do not think this would work well on DOS.

This helper function originally is meant to work *only* on the
checked out representation of the file and that is what is read by
read_in_full(), and that is the reason why it handles the case where
the contents of buf[] happens to be CRLF terminated in the function.

If you want to detect the content changes across working tree, index
and the tree objects by reusing hash_sha1_file(), however, you must
not feed the checked out (aka "smudged") representation to it.
You'd need to turn it into "cleaned" representation by doing the
equivalent of calling index_path().  Some helpers in the callchain
that originates from index_path() might directly be reusable for
your purpose.
