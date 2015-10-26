From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] run-command: factor out child_process_clear()
Date: Mon, 26 Oct 2015 11:43:26 -0700
Message-ID: <xmqqziz5h3n5.fsf@gitster.mtv.corp.google.com>
References: <562B756F.1020305@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 19:43:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zqmk0-0005ZV-Pj
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 19:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386AbbJZSn3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Oct 2015 14:43:29 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60100 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751183AbbJZSn2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Oct 2015 14:43:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B444E2669F;
	Mon, 26 Oct 2015 14:43:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+N9cGe9YsNAl
	Bjney77iHtrPy50=; b=Rhh6k26eGkBtW897ohDyWenhaTjkhoew0K2B630dB2PU
	EpCEM1qbSXkZRFjy3bKa6EGLw3vmDfGt/lqsEZwz4dGdsNsqs6Z8LQvKs3sfBibx
	kKL4geKEYWLg1v1yKt7z8TRWGpi+PjipfYn2skKsk9L4IW+GFaqkxIfGYhqAuZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JN8a24
	rPR9bADT2pxBMOtsPN+YMsokGv8iJPM3xBbThjGI2jNCncRtVeQ4T1cVoYINFo7J
	H/N2M4+hYtj0p3UVVbSLsKi+UZzlGY4+oGr5qHfQb9IU2lrt45vbfM9bcC9Q5MVa
	uhEQDlzxcupTYeKdgHxTZItBivmy3b+lLFFso=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AC6F22669C;
	Mon, 26 Oct 2015 14:43:27 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3278C2669A;
	Mon, 26 Oct 2015 14:43:27 -0400 (EDT)
In-Reply-To: <562B756F.1020305@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Sat, 24
	Oct 2015 14:11:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 71EB64B0-7C11-11E5-A3E4-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280207>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Avoid duplication by moving the code to release allocated memory for
> arguments and environment to its own function, child_process_clear().
> Export it to provide a counterpart to child_process_init().
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---

Hmm, is this _deinit() Stefan added to his series recently?

>  Documentation/technical/api-run-command.txt |  7 +++++++
>  run-command.c                               | 15 +++++++++------
>  run-command.h                               |  1 +
>  3 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/technical/api-run-command.txt b/Documentat=
ion/technical/api-run-command.txt
> index a9fdb45..8bf3e37 100644
> --- a/Documentation/technical/api-run-command.txt
> +++ b/Documentation/technical/api-run-command.txt
> @@ -46,6 +46,13 @@ Functions
>  	The argument dir corresponds the member .dir. The argument env
>  	corresponds to the member .env.
> =20
> +`child_process_clear`::
> +
> +	Release the memory associated with the struct child_process.
> +	Most users of the run-command API don't need to call this
> +	function explicitly because `start_command` invokes it on
> +	failure and `finish_command` calls it automatically already.
> +
>  The functions above do the following:
> =20
>  . If a system call failed, errno is set and -1 is returned. A diagno=
stic
> diff --git a/run-command.c b/run-command.c
> index e17e456..13fa452 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -11,6 +11,12 @@ void child_process_init(struct child_process *chil=
d)
>  	argv_array_init(&child->env_array);
>  }
> =20
> +void child_process_clear(struct child_process *child)
> +{
> +	argv_array_clear(&child->args);
> +	argv_array_clear(&child->env_array);
> +}
> +
>  struct child_to_clean {
>  	pid_t pid;
>  	struct child_to_clean *next;
> @@ -327,8 +333,7 @@ int start_command(struct child_process *cmd)
>  fail_pipe:
>  			error("cannot create %s pipe for %s: %s",
>  				str, cmd->argv[0], strerror(failed_errno));
> -			argv_array_clear(&cmd->args);
> -			argv_array_clear(&cmd->env_array);
> +			child_process_clear(cmd);
>  			errno =3D failed_errno;
>  			return -1;
>  		}
> @@ -513,8 +518,7 @@ fail_pipe:
>  			close_pair(fderr);
>  		else if (cmd->err)
>  			close(cmd->err);
> -		argv_array_clear(&cmd->args);
> -		argv_array_clear(&cmd->env_array);
> +		child_process_clear(cmd);
>  		errno =3D failed_errno;
>  		return -1;
>  	}
> @@ -540,8 +544,7 @@ fail_pipe:
>  int finish_command(struct child_process *cmd)
>  {
>  	int ret =3D wait_or_whine(cmd->pid, cmd->argv[0], 0);
> -	argv_array_clear(&cmd->args);
> -	argv_array_clear(&cmd->env_array);
> +	child_process_clear(cmd);
>  	return ret;
>  }
> =20
> diff --git a/run-command.h b/run-command.h
> index 5428b04..12bb26c 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -47,6 +47,7 @@ struct child_process {
> =20
>  #define CHILD_PROCESS_INIT { NULL, ARGV_ARRAY_INIT, ARGV_ARRAY_INIT =
}
>  void child_process_init(struct child_process *);
> +void child_process_clear(struct child_process *);
> =20
>  int start_command(struct child_process *);
>  int finish_command(struct child_process *);
