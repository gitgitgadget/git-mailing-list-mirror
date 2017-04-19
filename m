Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5FD1207BC
	for <e@80x24.org>; Wed, 19 Apr 2017 01:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933138AbdDSBtT (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 21:49:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53812 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758851AbdDSBtR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 21:49:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7EAF28191D;
        Tue, 18 Apr 2017 21:49:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=VYbPaf5HTP8n
        KlJXQjHD9U+6b6I=; b=huNiNyETlQPMc+CeV5zdhWJwmEIibEXbZZxUWXnV0set
        pPz8ZUJl/gSU+7XswvIZT4n/cGKk92IHP+5XjUZfk6CuN6zi/W5cxC7nw1tXVtLS
        uqjraWDWY+JSO1o002vAxWP+zHlWUPKpG0nr+NRC8raJpq+To0+BKlIrCnYYcCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=BHCzaS
        RaM5E5sLHEKdlXiBoMAIuxnWoJiRPvXGu/h351ds8B4468lm2Fa91CwpmAfRryQO
        okj5B9SxuW1FoH7Lm4pALZBN7b/M5mFNHVhS+5Q7RC1pqujtoBO3ScbczOk+HsZ6
        EVY3l1JZNb49PehSqwp3iUh3iQni0FkoKZ7y8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7751A8191C;
        Tue, 18 Apr 2017 21:49:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CDB738191B;
        Tue, 18 Apr 2017 21:49:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     David Turner <dturner@twosigma.com>, git@vger.kernel.org,
        peff@peff.net, jrnieder@gmail.com, Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] xgethostname: handle long hostnames
References: <20170417161748.31231-1-dturner@twosigma.com>
        <xmqq1ssqikc5.fsf@gitster.mtv.corp.google.com>
        <xmqqwpaih4q2.fsf@gitster.mtv.corp.google.com>
        <281d0843-d48a-b7ab-737b-b9528689d44e@web.de>
Date:   Tue, 18 Apr 2017 18:49:09 -0700
In-Reply-To: <281d0843-d48a-b7ab-737b-b9528689d44e@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 18 Apr 2017 18:07:43 +0200")
Message-ID: <xmqqpog9cgkq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 623822AC-24A2-11E7-84E4-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> How important is it to scan the whole file in one call?  We could split
> it up like this and use a strbuf to handle host names of any length.  W=
e
> need to be permissive here to allow machines with different values for
> HOST_NAME_MAX to work with the same file on a network file system, so
> this would have to be the first patch, right?

Absolutely.  FWIW, I agree with Peff that we do not need to use
fscanf here; just reading a line into strbuf and picking pieces
would be sufficient.

> NB: That && cascade has enough meat for a whole function.

True, too.

>
> Ren=C3=A9
>
> ---
>  builtin/gc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 1fca84c19d..d5e880028e 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -251,10 +251,9 @@ static const char *lock_repo_for_gc(int force, pid=
_t* ret_pid)
>  	fd =3D hold_lock_file_for_update(&lock, pidfile_path,
>  				       LOCK_DIE_ON_ERROR);
>  	if (!force) {
> -		static char locking_host[128];
> +		static struct strbuf locking_host =3D STRBUF_INIT;
>  		int should_exit;
>  		fp =3D fopen(pidfile_path, "r");
> -		memset(locking_host, 0, sizeof(locking_host));
>  		should_exit =3D
>  			fp !=3D NULL &&
>  			!fstat(fileno(fp), &st) &&
> @@ -268,9 +267,10 @@ static const char *lock_repo_for_gc(int force, pid=
_t* ret_pid)
>  			 * running.
>  			 */
>  			time(NULL) - st.st_mtime <=3D 12 * 3600 &&
> -			fscanf(fp, "%"SCNuMAX" %127c", &pid, locking_host) =3D=3D 2 &&
> +			fscanf(fp, "%"SCNuMAX" ", &pid) =3D=3D 1 &&
> +			!strbuf_getwholeline(&locking_host, fp, '\0') &&
>  			/* be gentle to concurrent "gc" on remote hosts */
> -			(strcmp(locking_host, my_host) || !kill(pid, 0) || errno =3D=3D EPE=
RM);
> +			(strcmp(locking_host.buf, my_host) || !kill(pid, 0) || errno =3D=3D=
 EPERM);
>  		if (fp !=3D NULL)
>  			fclose(fp);
>  		if (should_exit) {
> @@ -278,7 +278,7 @@ static const char *lock_repo_for_gc(int force, pid_=
t* ret_pid)
>  				rollback_lock_file(&lock);
>  			*ret_pid =3D pid;
>  			free(pidfile_path);
> -			return locking_host;
> +			return locking_host.buf;
>  		}
>  	}
