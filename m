From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-testsvn: use internal argv_array of struct child_process in cmd_import()
Date: Fri, 18 Jul 2014 12:10:00 -0700
Message-ID: <xmqq8unqmqk7.fsf@gitster.dls.corp.google.com>
References: <53C93B33.5070006@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Fri Jul 18 21:10:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8DXw-0006pM-VW
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 21:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945989AbaGRTKO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jul 2014 15:10:14 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65490 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1945986AbaGRTKK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jul 2014 15:10:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A3C9529EF2;
	Fri, 18 Jul 2014 15:10:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=kl2J2VYmWQEJ
	ggVaTnhCFlPTaLY=; b=vdPGhMjeT6bWk3JdmT4LV4wBkGje06Kv0Vd6YjiSrD7X
	jknKLkFjH44wqDA3r/qwYT4ZQkD2m8wPIHt+y+TG0Ffg+EjabC5zBZDNfeFdtC5+
	AxhpouJM531qtjY30dZVVSsUwM7h/VtZFbdb8mYRIZAuDnGqfn/6gs25U9NZxVE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fqHjQU
	Fuj9YKKwZKGDP3LlaUAU5N0gHF3TrxirvfDWeRQ8a+tZ6/tt7Pma6CEJfN6WbtW3
	kO+DJYH3LswYD23zBSbRiDECuCYLOOlHbbndkTYamuqdWwaI0yhxmt7RthaEJ9jG
	3G6dBw9OInsq4fxGSEEWveSNDfbW+xyDUrApM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 20BB529EF0;
	Fri, 18 Jul 2014 15:10:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C941629EDD;
	Fri, 18 Jul 2014 15:10:02 -0400 (EDT)
In-Reply-To: <53C93B33.5070006@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Fri, 18
	Jul 2014 17:20:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1EE55AB2-0EAF-11E4-9764-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253839>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Use the existing argv_array member instead of providing our own.  Thi=
s
> way we don't have to initialize or clean it up explicitly.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---

The change below looks so trivial and I cannot offhand see why it
would break t9020 in a reproducible way.

Puzzled...

>  remote-testsvn.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/remote-testsvn.c b/remote-testsvn.c
> index 6be55cb..31415bd 100644
> --- a/remote-testsvn.c
> +++ b/remote-testsvn.c
> @@ -175,7 +175,6 @@ static int cmd_import(const char *line)
>  	char *note_msg;
>  	unsigned char head_sha1[20];
>  	unsigned int startrev;
> -	struct argv_array svndump_argv =3D ARGV_ARRAY_INIT;
>  	struct child_process svndump_proc;
> =20
>  	if (read_ref(private_ref, head_sha1))
> @@ -202,11 +201,10 @@ static int cmd_import(const char *line)
>  	} else {
>  		memset(&svndump_proc, 0, sizeof(struct child_process));
>  		svndump_proc.out =3D -1;
> -		argv_array_push(&svndump_argv, "svnrdump");
> -		argv_array_push(&svndump_argv, "dump");
> -		argv_array_push(&svndump_argv, url);
> -		argv_array_pushf(&svndump_argv, "-r%u:HEAD", startrev);
> -		svndump_proc.argv =3D svndump_argv.argv;
> +		argv_array_push(&svndump_proc.args, "svnrdump");
> +		argv_array_push(&svndump_proc.args, "dump");
> +		argv_array_push(&svndump_proc.args, url);
> +		argv_array_pushf(&svndump_proc.args, "-r%u:HEAD", startrev);
> =20
>  		code =3D start_command(&svndump_proc);
>  		if (code)
> @@ -227,7 +225,6 @@ static int cmd_import(const char *line)
>  		code =3D finish_command(&svndump_proc);
>  		if (code)
>  			warning("%s, returned %d", svndump_proc.argv[0], code);
> -		argv_array_clear(&svndump_argv);
>  	}
> =20
>  	return 0;
