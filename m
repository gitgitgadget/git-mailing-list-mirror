From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gc --auto: do not run 'pack-refs' and 'reflog expire' twice
Date: Tue, 02 Sep 2014 11:12:11 -0700
Message-ID: <xmqqzjeh28p0.fsf@gitster.dls.corp.google.com>
References: <1409459610-8695-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 20:12:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOsZE-0007p5-73
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 20:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754882AbaIBSM2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Sep 2014 14:12:28 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63322 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754216AbaIBSM1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Sep 2014 14:12:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0436A366AA;
	Tue,  2 Sep 2014 14:12:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AHgJs4UEc2sg
	cIyhst6AwA6indo=; b=xFkLRm3Zh1IizMfba9Z2nGLITo7Dmnd8/APA6R4c9OsD
	Np9tmGKRwopFd2CRaSn+r3zt5SMFgxwlxzD+QnYvHPcCv5BW2kvEe+TGAoaxFW2y
	bzHx2BNwTJ2Twe0GCPwBamIJkXvWE+CdIAtqHvVoRggANzU+UYiine5LuoxAS2A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kYYMvZ
	xze5hQ98WxwhwDK6kylLF3DSM9W1Y0/nOdK8CjSYTLNPU4DhP/AO5i65JKS1ylhk
	dodkNCmwYQfI/4Wrut2PwRoG4B2iPYjQ2dUKarq++UkI/IkG1mW4R8yGX8oQABku
	M0qi/MmLTBvoSEDSnuHzY0dzlmL3xoLZrQ/z0=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ECD28366A9;
	Tue,  2 Sep 2014 14:12:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 99AF636692;
	Tue,  2 Sep 2014 14:12:13 -0400 (EDT)
In-Reply-To: <1409459610-8695-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 31
 Aug 2014 11:33:30 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AA182C86-32CC-11E4-A96C-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256330>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> In the --auto code path, gc_before_repack() is called once in parent
> process then again in the forked process. Stop the second run.

Hmph.  Is the true reason why this happens because we have two calls
to gc_before_repack() in the main, and one is before daemonize()?
Shouldn't this protection be in the caller?

>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/gc.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/builtin/gc.c b/builtin/gc.c
> index 8d219d8..fb0cff3 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -261,6 +261,11 @@ static const char *lock_repo_for_gc(int force, p=
id_t* ret_pid)
> =20
>  static int gc_before_repack(void)
>  {
> +	static int nr_runs;
> +
> +	if (nr_runs++)
> +		return 0;
> +
>  	if (pack_refs && run_command_v_opt(pack_refs_cmd.argv, RUN_GIT_CMD)=
)
>  		return error(FAILED_RUN, pack_refs_cmd.argv[0]);
