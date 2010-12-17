From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/21] Convert ce_path_match() to use struct pathspec
Date: Thu, 16 Dec 2010 16:02:21 -0800
Message-ID: <7v39pxl10y.fsf@alter.siamese.dyndns.org>
References: <1292425376-14550-1-git-send-email-pclouds@gmail.com>
 <1292425376-14550-15-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 17 01:02:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTNmN-0003XT-Jq
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 01:02:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753567Ab0LQACa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Dec 2010 19:02:30 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37989 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485Ab0LQACa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Dec 2010 19:02:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DAB8E37C4;
	Thu, 16 Dec 2010 19:02:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=RsDpNeyJqgn2
	BzBKU+74eUcJYyU=; b=pswsR88WX1W66y39kM7yfA1D+mn9RUn+6S98VkRRaKE6
	3Pd4wmk6KayZJKfiaoC49gOoYS4NknJV4zw+pjReowVskA3rVbuL2UolmMyUPyS5
	Vtof7+iCGK6rzfdATJd8AoVT476mDjBcoGS0cyiyevLKL/pouNT5jfOmMWaodO4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cymSiA
	OBaUpWhQ5wPRmJcj46JUyMGzXyXsxGlPSyUxfKV7qOWLZGuzh0iS+5AV4ZG7xqhA
	KU0ctrZjw3N/jr0eq+rJKoZhjnpGVuqeuVOTsMx+rpK3wIkM8Dpjrp6Vx+Lxfxkd
	JnVmA+StXfBhygjPlC6JOWUOUjXsHxthlBZao=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B9A4B37C2;
	Thu, 16 Dec 2010 19:02:52 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C631137C1; Thu, 16 Dec 2010
 19:02:49 -0500 (EST)
In-Reply-To: <1292425376-14550-15-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Wed\, 15 Dec
 2010 22\:02\:49 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FE3875E8-0970-11E0-96D9-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163843>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/diff-lib.c b/diff-lib.c
> index 3b809f2..63db7f4 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -89,9 +89,11 @@ int run_diff_files(struct rev_info *revs, unsigned=
 int option)
>  	int silent_on_removed =3D option & DIFF_SILENT_ON_REMOVED;
>  	unsigned ce_option =3D ((option & DIFF_RACY_IS_MODIFIED)
>  			      ? CE_MATCH_RACY_IS_DIRTY : 0);
> +	struct pathspec pathspec;
> =20
>  	diff_set_mnemonic_prefix(&revs->diffopt, "i/", "w/");
> =20
> +	init_pathspec(&pathspec, revs->prune_data);

I wonder if it makes more sense to change the type of revs->prune_data
from an array of pointers to strings to a pointer to struct pathspec.
Is there a downside?

> diff --git a/preload-index.c b/preload-index.c
> index e3d0bda..49cb08d 100644
> --- a/preload-index.c
> +++ b/preload-index.c
> @@ -35,7 +35,9 @@ static void *preload_thread(void *_data)
>  	struct index_state *index =3D p->index;
>  	struct cache_entry **cep =3D index->cache + p->offset;
>  	struct cache_def cache;
> +	struct pathspec pathspec;
> =20
> +	init_pathspec(&pathspec, p->pathspec);

Likewise; would it make the API cleaner to make read_cache_preload() an=
d
read_index_preload() take "const struct pathspec *" instead of the
traditional "const char **"?
