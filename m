From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 5/6] worktree: add "lock" command
Date: Tue, 31 May 2016 11:10:17 -0700
Message-ID: <xmqq4m9e5cae.fsf@gitster.mtv.corp.google.com>
References: <20160522104341.656-1-pclouds@gmail.com>
	<20160530104939.28407-1-pclouds@gmail.com>
	<20160530104939.28407-6-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	rethab.ch@gmail.com, rappazzo@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 31 20:10:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7o7X-0007EM-Pu
	for gcvg-git-2@plane.gmane.org; Tue, 31 May 2016 20:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755574AbcEaSKX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 May 2016 14:10:23 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62176 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755214AbcEaSKV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2016 14:10:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BB0AB1F855;
	Tue, 31 May 2016 14:10:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=E6IkAe4wmiUb
	CirJoKD0EP1tXEg=; b=PDiFR/uNNsYe0l+R7xgX2c8jHNpJFhZpcABM5+JLZcrA
	NHltReZBslm2RGwdh+3Dndnwn70ne2T5Vlh500aMV8rcOmHycZSwnU9C4yHX2dv7
	6r1oOcObT+b+TI6xBNeRCtisjhrovxvKPQVZ+9n1xIUKu3xlbtlrONRqfvYNfIM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=FVWfjL
	udhrPO6jNKa4sCDerJHGQD7md/9/zhoMQDlGG6xg/k5tnpEzql637H3lebZZgja6
	P0TPloDyR5Yp69HUMvtbyprhuANFwf0CYn6uI+grQj1JS9neoXSaeEPCMc0os7vd
	IYfDyiI6LNbYTMXIGHBuLmkTLYFtaTGt3o5q0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B48811F854;
	Tue, 31 May 2016 14:10:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 524DD1F853;
	Tue, 31 May 2016 14:10:19 -0400 (EDT)
In-Reply-To: <20160530104939.28407-6-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
	Duy"'s message of "Mon, 30 May 2016 17:49:38 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EF1B43A2-275A-11E6-BA13-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296002>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index f9dac37..84fe63b 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -14,6 +14,7 @@
>  static const char * const worktree_usage[] =3D {
>  	N_("git worktree add [<options>] <path> [<branch>]"),
>  	N_("git worktree list [<options>]"),
> +	N_("git worktree lock [<options>] <path>"),
>  	N_("git worktree prune [<options>]"),
>  	NULL
>  };
> @@ -459,6 +460,41 @@ static int list(int ac, const char **av, const c=
har *prefix)
>  	return 0;
>  }
> =20
> +static int lock_worktree(int ac, const char **av, const char *prefix=
)
> +{
> +	const char *reason =3D "", *old_reason;
> +	struct option options[] =3D {
> +		OPT_STRING(0, "reason", &reason, N_("string"),
> +			   N_("reason for locking")),
> +		OPT_END()
> +	};
> +	struct worktree **worktrees, *wt;
> +
> +	ac =3D parse_options(ac, av, prefix, options, worktree_usage, 0);
> +	if (ac !=3D 1)
> +		usage_with_options(worktree_usage, options);
> +
> +	worktrees =3D get_worktrees();
> +	wt =3D find_worktree(worktrees, prefix, av[0]);
> +	if (!wt)
> +		die(_("'%s' is not a working directory"), av[0]);
> +	if (is_main_worktree(wt))
> +		die(_("'%s' is a main working directory"), av[0]);
> +
> +	old_reason =3D wt->lock_reason;

This use pattern suggests that the reading of lock_reason should be
done lazily, doesn't it?  The other user of the "is it locked?"
information, which is builtin/worktree.c::prune_worktree(), does not
even use the get_worktrees() interface and instead it just checks if
the lock marker git_path("worktrees/*/locked") exists.

Perhaps you want one of these as a public interface:

	int worktree_is_locked(const char *id, const char **reason);
	int worktree_is_locked(struct worktree *wt, const char **reason);

where the caller can learn if a worktree is locked, and optionally why?
