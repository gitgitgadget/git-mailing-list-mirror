From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gc --auto: do not lock refs in the background
Date: Tue, 27 May 2014 11:09:03 -0700
Message-ID: <xmqq8upngklc.fsf@gitster.dls.corp.google.com>
References: <CACsJy8BfziZ7ciyKL0+X3rT9EfH_0E8nKNu9mTb_WSeTYWix_Q@mail.gmail.com>
	<1400978309-25235-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kilobyte@angband.pl
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 20:09:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpLoo-0001FL-En
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 20:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234AbaE0SJm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 May 2014 14:09:42 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64574 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753232AbaE0SJl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 May 2014 14:09:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 99EA119C38;
	Tue, 27 May 2014 14:09:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=IJrcsNJ3LpGY
	Lo1+IOVBJfeimkg=; b=IrNPOgRkV1ReUIXp7NPlM98RQodjo6wcMpuEpz2jWUo8
	WUjCf7Up8Z0nAurqghogAZjQk7ymjy4UeT3tJmyCXcmBV4tGG0Fdut6YDvBzNCLv
	0N75cchK2DQ7QVd4RKuOZBzPw1OXOXwi4hZSbk980UEHAib9Bl9/Hcaz91+2shM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=a6c22M
	oF1Oay3nZvUUMVWZHQEBtysMaJaIMOdOpZygNPIhEMxDrNCyHKlodyMf3Miyyf9q
	T6JqmpTReOm1E7sN6ZJF5s9LlCjTWxvKP4G8TMiEidyljOekz27fRWPJx7VZLpE6
	L/t0kai8xZEvRROTe+wQySBdJILN1vhMEytac=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 91F6419C36;
	Tue, 27 May 2014 14:09:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 09E9419BF7;
	Tue, 27 May 2014 14:09:04 -0400 (EDT)
In-Reply-To: <1400978309-25235-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 25
 May 2014 07:38:29 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FD36189C-E5C9-11E3-A1B0-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250179>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> 9f673f9 (gc: config option for running --auto in background -
> 2014-02-08) puts "gc --auto" in background to reduce user's wait
> time. Part of the garbage collecting is pack-refs and pruning
> reflogs. These require locking some refs and may abort other processe=
s
> trying to lock the same ref. If gc --auto is fired in the middle of a
> script, gc's holding locks in the background could fail the script,
> which could never happen before 9f673f9.
>
> Keep running pack-refs and "reflog --prune" in foreground to stop
> parallel ref updates. The remaining background operations (repack,
> prune and rerere) should impact running git processes.
>
> Reported-by: Adam Borowski <kilobyte@angband.pl>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/gc.c | 26 ++++++++++++++++++++------
>  1 file changed, 20 insertions(+), 6 deletions(-)

OK, as it happens the order of various gc phases we have is already
to run pack-refs and reflog expire before everything else, so this
change does not affect semantics, which is good ;-)



> diff --git a/builtin/gc.c b/builtin/gc.c
> index 85f5c2b..8d219d8 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -26,6 +26,7 @@ static const char * const builtin_gc_usage[] =3D {
>  };
> =20
>  static int pack_refs =3D 1;
> +static int prune_reflogs =3D 1;
>  static int aggressive_depth =3D 250;
>  static int aggressive_window =3D 250;
>  static int gc_auto_threshold =3D 6700;
> @@ -258,6 +259,19 @@ static const char *lock_repo_for_gc(int force, p=
id_t* ret_pid)
>  	return NULL;
>  }
> =20
> +static int gc_before_repack(void)
> +{
> +	if (pack_refs && run_command_v_opt(pack_refs_cmd.argv, RUN_GIT_CMD)=
)
> +		return error(FAILED_RUN, pack_refs_cmd.argv[0]);
> +
> +	if (prune_reflogs && run_command_v_opt(reflog.argv, RUN_GIT_CMD))
> +		return error(FAILED_RUN, reflog.argv[0]);
> +
> +	pack_refs =3D 0;
> +	prune_reflogs =3D 0;
> +	return 0;
> +}
> +
>  int cmd_gc(int argc, const char **argv, const char *prefix)
>  {
>  	int aggressive =3D 0;
> @@ -320,12 +334,15 @@ int cmd_gc(int argc, const char **argv, const c=
har *prefix)
>  				fprintf(stderr, _("Auto packing the repository for optimum perfo=
rmance.\n"));
>  			fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n=
"));
>  		}
> -		if (detach_auto)
> +		if (detach_auto) {
> +			if (gc_before_repack())
> +				return -1;
>  			/*
>  			 * failure to daemonize is ok, we'll continue
>  			 * in foreground
>  			 */
>  			daemonize();
> +		}
>  	} else
>  		add_repack_all_option();
> =20
> @@ -337,11 +354,8 @@ int cmd_gc(int argc, const char **argv, const ch=
ar *prefix)
>  		    name, (uintmax_t)pid);
>  	}
> =20
> -	if (pack_refs && run_command_v_opt(pack_refs_cmd.argv, RUN_GIT_CMD)=
)
> -		return error(FAILED_RUN, pack_refs_cmd.argv[0]);
> -
> -	if (run_command_v_opt(reflog.argv, RUN_GIT_CMD))
> -		return error(FAILED_RUN, reflog.argv[0]);
> +	if (gc_before_repack())
> +		return -1;
> =20
>  	if (run_command_v_opt(repack.argv, RUN_GIT_CMD))
>  		return error(FAILED_RUN, repack.argv[0]);
