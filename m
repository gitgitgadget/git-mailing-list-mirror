From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] remote-testsvn: use internal argv_array of struct child_process in cmd_import()
Date: Fri, 18 Jul 2014 14:18:42 -0700
Message-ID: <xmqqtx6el619.fsf@gitster.dls.corp.google.com>
References: <53C93B33.5070006@web.de>
	<xmqq8unqmqk7.fsf@gitster.dls.corp.google.com>
	<53C975C5.8020709@web.de> <53C97BA4.7020503@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Fri Jul 18 23:18:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8FYQ-0002UK-Vp
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 23:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935228AbaGRVSx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jul 2014 17:18:53 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63574 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932311AbaGRVSu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jul 2014 17:18:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CCCA229561;
	Fri, 18 Jul 2014 17:18:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=gWeGzpLLavOo
	l7Pmpodrdq/Ld0w=; b=ucY8bUFMbG3QitQVpgSVE9a7YHYLgZmTXHHfLfYtb4H2
	qnGKf8ooKGmbS3l3yKxDgyStdWlFzeLlNgDrURxVwkA1Lvjwbfa6vcpsvjoLQSSL
	6Thbw+C8m+5mbHFBKu+ewX3FqPY0rBoAxAim+gNK0zGmeWSDsPbNpzuQ9k7+kNg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=SP3vNR
	a9Wh1BjPexLk59US6C7SYSU00S7ZMProtTZfFW6QInR2u7e2VAu9MrZeKkwrP1xb
	2FtkoBv4lDCs+A9osOZJnEom4A+AhsrqvyDlBRPjARqKuqa0DYMJrNQ21ZqMlM/j
	101CYK7FgY2IQNm8DInO+cNKIuCcozRXZiZuE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C34EC29560;
	Fri, 18 Jul 2014 17:18:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 28E992955D;
	Fri, 18 Jul 2014 17:18:44 -0400 (EDT)
In-Reply-To: <53C97BA4.7020503@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Fri, 18
	Jul 2014 21:55:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 192C96E6-0EC1-11E4-A08F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253848>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Use the existing argv_array member instead of providing our own.  Thi=
s
> way we don't have to initialize or clean it up explicitly.  Because o=
f
> that automatic cleanup, we need to keep our own reference to the
> command name instead of using .argv[0] to print the warning at the en=
d.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> The added command pointer makes the patch more complicated, but I thi=
nk
> it still counts as a cleanup.

Surely.  I'd move the "svnrdump" assignment to where the variable is
defined, though; we do not switch what "command" to run depending on
some computed conditions anyway.

>
>  remote-testsvn.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/remote-testsvn.c b/remote-testsvn.c
> index 6be55cb..e3ad11b 100644
> --- a/remote-testsvn.c
> +++ b/remote-testsvn.c
> @@ -175,8 +175,8 @@ static int cmd_import(const char *line)
>  	char *note_msg;
>  	unsigned char head_sha1[20];
>  	unsigned int startrev;
> -	struct argv_array svndump_argv =3D ARGV_ARRAY_INIT;
>  	struct child_process svndump_proc;
> +	const char *command;
> =20
>  	if (read_ref(private_ref, head_sha1))
>  		startrev =3D 0;
> @@ -200,17 +200,17 @@ static int cmd_import(const char *line)
>  		if(dumpin_fd < 0)
>  			die_errno("Couldn't open svn dump file %s.", url);
>  	} else {
> +		command =3D "svnrdump";
>  		memset(&svndump_proc, 0, sizeof(struct child_process));
>  		svndump_proc.out =3D -1;
> -		argv_array_push(&svndump_argv, "svnrdump");
> -		argv_array_push(&svndump_argv, "dump");
> -		argv_array_push(&svndump_argv, url);
> -		argv_array_pushf(&svndump_argv, "-r%u:HEAD", startrev);
> -		svndump_proc.argv =3D svndump_argv.argv;
> +		argv_array_push(&svndump_proc.args, command);
> +		argv_array_push(&svndump_proc.args, "dump");
> +		argv_array_push(&svndump_proc.args, url);
> +		argv_array_pushf(&svndump_proc.args, "-r%u:HEAD", startrev);
> =20
>  		code =3D start_command(&svndump_proc);
>  		if (code)
> -			die("Unable to start %s, code %d", svndump_proc.argv[0], code);
> +			die("Unable to start %s, code %d", command, code);
>  		dumpin_fd =3D svndump_proc.out;
>  	}
>  	/* setup marks file import/export */
> @@ -226,8 +226,7 @@ static int cmd_import(const char *line)
>  	if (!dump_from_file) {
>  		code =3D finish_command(&svndump_proc);
>  		if (code)
> -			warning("%s, returned %d", svndump_proc.argv[0], code);
> -		argv_array_clear(&svndump_argv);
> +			warning("%s, returned %d", command, code);
>  	}
> =20
>  	return 0;
