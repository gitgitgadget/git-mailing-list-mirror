From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] gc: reject if another gc is running, unless --force is given
Date: Mon, 05 Aug 2013 11:17:37 -0700
Message-ID: <7vsiyoj932.fsf@alter.siamese.dyndns.org>
References: <1375510890-4728-1-git-send-email-pclouds@gmail.com>
	<1375712354-13171-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 05 20:17:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6PLl-0004ha-AR
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 20:17:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073Ab3HESRl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Aug 2013 14:17:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55924 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753844Ab3HESRk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Aug 2013 14:17:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDF4136CD2;
	Mon,  5 Aug 2013 18:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=iCV+aIPbL4y4
	ppxsns4mub+gZlw=; b=hNju97h/fmMQpzAGSFN4d3tQYt4x/4t3qW4TYBUOrD6f
	coQFUMXzwCnLIfIVguuznaY/wY9E12KT37l9owio3zrEa7YAy1yWPUTZ3huFnV4O
	v0jG7CRj7kWukfF+8oiSe+OiGl496ehiHvsaZQ8qY0fa2w0Zb5nKv4beRjBHLlw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ILdHUp
	jqddNYqE9anqaX+6/RyGoQx9Fh+UnhSlgekapTY9AHAhsyScr43diy333sky3FGT
	j2rasufkIOHIQBGzm0erqWjC8mc/DO2dWuuuRtaXDdDGsZH58IujiPM7V/QLDAES
	Tl7cxqkCQOyc4DaDrxhF2BcyJhC7h+J+WPQnE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0C5436CD1;
	Mon,  5 Aug 2013 18:17:39 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E0FD836CD0;
	Mon,  5 Aug 2013 18:17:38 +0000 (UTC)
In-Reply-To: <1375712354-13171-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 5 Aug
 2013 21:19:14 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4FA43AB2-FDFB-11E2-965F-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231686>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/builtin/gc.c b/builtin/gc.c
> index 6be6c8d..1f33908 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -167,11 +167,66 @@ static int need_to_gc(void)
>  	return 1;
>  }
> =20
> +static int gc_running(int force)

Sounds like a bool asking "Is a GC running?  Yes, or no?".  Since
there is no room for "force" to enter in order to answer that
question, I have to guess that this function is somewhat misnamed.

> +{
> +	static struct lock_file lock;
> +	struct utsname utsname;
> +	struct stat st;
> +	uintmax_t pid;
> +	FILE *fp;
> +	int fd, should_exit;
> +
> +	if (uname(&utsname))
> +		strcpy(utsname.nodename, "unknown");
> +
> +	fd =3D hold_lock_file_for_update(&lock,
> +			git_path("gc-%s.pid", utsname.nodename), 0);
> +	if (!force) {
> +		if (fd < 0)
> +			return 1;
> +
> +		fp =3D fopen(git_path("gc-%s.pid", utsname.nodename), "r");

I would have imagined that you would use a lockfile gc.pid and write
nodename and pid to it (and if nodename matches, you know pid may
have a chance to actually match another instance of "gc", while
there will not way it matches if nodename is different, and do
something intelligent about it).  By letting GC that is running on
another node to be completely unnoticed, this change is closing the
door to "do something intelligent about it", like giving it the same
12 hour limit.

> +		should_exit =3D
> +			fp !=3D NULL &&
> +			!fstat(fileno(fp), &st) &&
> +			/*
> +			 * 12 hour limit is very generous as gc should
> +			 * never take that long. On the other hand we
> +			 * don't really need a strict limit here,
> +			 * running gc --auto one day late is not a big
> +			 * problem. --force can be used in manual gc
> +			 * after the user verifies that no gc is
> +			 * running.
> +			 */
> +			time(NULL) - st.st_mtime <=3D 12 * 3600 &&
> +			fscanf(fp, "%"PRIuMAX, &pid) =3D=3D 1 &&
> +			!kill(pid, 0);
> +		if (fp !=3D NULL)
> +			fclose(fp);
> +		if (should_exit) {
> +			if (fd >=3D 0)
> +				rollback_lock_file(&lock);
> +			return 1;
> +		}
> +	}
> +
> +	if (fd >=3D 0) {
> +		struct strbuf sb =3D STRBUF_INIT;
> +		strbuf_addf(&sb, "%"PRIuMAX"\n", (uintmax_t) getpid());
> +		write_in_full(fd, sb.buf, sb.len);
> +		strbuf_release(&sb);
> +		commit_lock_file(&lock);
> +	}
> +
> +	return 0;
> +}

After reading what the whole function does, I think the purpose of
this function is to take gc-lock (with optionally force).  Perhaps a
name along the lines of "lock_gc", "gc_lock", "lock_repo_for_gc",
would be more appropriate.
