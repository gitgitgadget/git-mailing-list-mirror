From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] lockfile.c: remove PATH_MAX limitation (except in resolve_symlink)
Date: Fri, 01 Aug 2014 10:34:19 -0700
Message-ID: <xmqqbns4w1us.fsf@gitster.dls.corp.google.com>
References: <1405858399-23082-1-git-send-email-pclouds@gmail.com>
	<1406814214-21725-1-git-send-email-pclouds@gmail.com>
	<1406814214-21725-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, ramsay@ramsay1.demon.co.uk,
	yuelinho777@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 19:34:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDGiv-0001Et-SY
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 19:34:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754966AbaHARea convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Aug 2014 13:34:30 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61807 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694AbaHARe3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2014 13:34:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B70032C8FE;
	Fri,  1 Aug 2014 13:34:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jdQpFj+w5rZb
	lcn257dH6+i5oOI=; b=R260lLGoq2RHFmFKKj3Hke7FClbR729HSVmahqkWHXq1
	74syweuAUg/35X4PS3aSx17jJ0o/wSRgyIBaZDXHoJA5vQNCAZHPMRq9jvy1v2Vx
	nkeuCcqBsxnTZ1If8ndiBz2YgOUzuZEbhugvFKjhi23G69IXSj3dXGqg2OrxHKo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=yMWT03
	zydMIsRu16M/k1Rs6jzYPFiZfXSBX8U633Dfz0mujR5yoK8BK3xVG2xSVeSLhFGz
	GKC4k3vmhyn1zEGtPG92GQFMbba9d6mulv4iHZs0ykCcldVbuTE9CQshRwAt2qEo
	Q60PETt9AFYQuzPU15jEiRnsJCcW/5k+BATWY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AD53A2C8FD;
	Fri,  1 Aug 2014 13:34:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B36FF2C8F0;
	Fri,  1 Aug 2014 13:34:21 -0400 (EDT)
In-Reply-To: <1406814214-21725-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 31
 Jul 2014 20:43:32 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 12C2F7BE-19A2-11E4-B250-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254642>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/lockfile.c b/lockfile.c
> index 8fbcb6a..968b28f 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -7,13 +7,19 @@
>  static struct lock_file *lock_file_list;
>  static const char *alternate_index_output;
> =20
> +static void clear_filename(struct lock_file *lk)
> +{
> +	free(lk->filename);
> +	lk->filename =3D NULL;
> +}
> +

Given that you move commit_locked_index(), which you need to use
this function in, to read-cache.c in your own nd/split-index series,
this will need to be exposed to the wider world, and at that point,
its name will turn out to be too generic.
