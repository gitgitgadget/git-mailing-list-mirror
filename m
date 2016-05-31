From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/6] worktree.c: retrieve lock status (and optionally reason) in get_worktrees()
Date: Tue, 31 May 2016 10:55:08 -0700
Message-ID: <xmqq8tyq5czn.fsf@gitster.mtv.corp.google.com>
References: <20160522104341.656-1-pclouds@gmail.com>
	<20160530104939.28407-1-pclouds@gmail.com>
	<20160530104939.28407-5-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	rethab.ch@gmail.com, rappazzo@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 31 19:55:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7nsr-0004gx-BM
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 19:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755400AbcEaRzN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 May 2016 13:55:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62632 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755409AbcEaRzM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2016 13:55:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C4A191F532;
	Tue, 31 May 2016 13:55:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vl9fXXKMzKTf
	wsWer/nVBd5m79U=; b=eNimCWgT/aPrQ61alq3ihAtelkTIv60Z4TSkKGkPQL3v
	x0+tCFvQeaKZyYAq25SLnJVOO+8oIbPvrosUv+b5YYdnoTj0R0uneKuZlsnGiu5p
	RrWbjn3zdekVF1Tyrl9DUcwPac5esU2tv3P3YjfyZA+aMQSTX22KO8zPkze5tGA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=S+wn2W
	8hvk7OoAwlfZxftxHIXL3yoRQe85cdUTUTX1E0kej7zQUI96oK7LrHWsnDMM1E32
	Gov0dxYIDyiFrvTJg2mEbmEechuJWfO6z5i4jnSU8uM2HE20W3mRvTDMFd4dufNT
	vec4lQquska0Fvx3vXj0EDiGnqLaq3QszmZvw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BB5501F531;
	Tue, 31 May 2016 13:55:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3E0651F52F;
	Tue, 31 May 2016 13:55:10 -0400 (EDT)
In-Reply-To: <20160530104939.28407-5-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Mon, 30 May 2016 17:49:37 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D1408952-2758-11E6-BE2A-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296000>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> We need this later to avoid double locking a worktree, or unlocking o=
ne
> when it's not even locked.

Shouldn't this be done lazily?

If a user is working in worktree B and is not doing anything funky,
she would not care why worktree A and C are locked, even though she
might care the fact that they are locked.

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  worktree.c | 12 ++++++++++++
>  worktree.h |  1 +
>  2 files changed, 13 insertions(+)
>
> diff --git a/worktree.c b/worktree.c
> index 6432eec..c6a64b1 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -98,6 +98,7 @@ static struct worktree *get_main_worktree(void)
>  	worktree->is_detached =3D is_detached;
>  	worktree->is_current =3D 0;
>  	add_head_info(&head_ref, worktree);
> +	worktree->lock_reason =3D NULL;
> =20
>  done:
>  	strbuf_release(&path);
> @@ -144,6 +145,17 @@ static struct worktree *get_linked_worktree(cons=
t char *id)
>  	worktree->is_current =3D 0;
>  	add_head_info(&head_ref, worktree);
> =20
> +	strbuf_reset(&path);
> +	strbuf_addf(&path, "%s/worktrees/%s/locked", get_git_common_dir(), =
id);
> +	if (file_exists(path.buf)) {
> +		struct strbuf lock_reason =3D STRBUF_INIT;
> +		if (strbuf_read_file(&lock_reason, path.buf, 0) < 0)
> +			die_errno(_("failed to read '%s'"), path.buf);
> +		strbuf_trim(&lock_reason);
> +		worktree->lock_reason =3D strbuf_detach(&lock_reason, NULL);
> +	} else
> +		worktree->lock_reason =3D NULL;
> +
>  done:
>  	strbuf_release(&path);
>  	strbuf_release(&worktree_path);
> diff --git a/worktree.h b/worktree.h
> index e1c4715..9932710 100644
> --- a/worktree.h
> +++ b/worktree.h
> @@ -5,6 +5,7 @@ struct worktree {
>  	char *path;
>  	char *id;
>  	char *head_ref;
> +	char *lock_reason;	/* NULL means not locked */
>  	unsigned char head_sha1[20];
>  	int is_detached;
>  	int is_bare;
