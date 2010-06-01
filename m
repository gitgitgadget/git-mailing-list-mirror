From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/8] revert: use run_command_v_opt() instead of
 execv_git_cmd()
Date: Mon, 31 May 2010 23:01:15 -0500
Message-ID: <20100601040115.GA22401@progeny.tock>
References: <20100531193359.28729.55562.chriscool@tuxfamily.org>
 <20100531194240.28729.9964.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Jun 01 06:01:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJIfP-0002IA-9z
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 06:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748Ab0FAEBW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 00:01:22 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:36490 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716Ab0FAEBV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 00:01:21 -0400
Received: by gwaa12 with SMTP id a12so3244791gwa.19
        for <git@vger.kernel.org>; Mon, 31 May 2010 21:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=xbdn568NIxMIxZwo+9kRL81jWaThPy/q8xEH58sbQ7c=;
        b=jAT8mZHyjXfUtLHNlNOVNkZK8+CGKr0lWjL8ANEokCbLeC66EUsU5FGY/80dUXuvc2
         NNq3EAUQlDCP8whtWpNuQOJzvH47qCBktj4qZzMKZhKuI1TwNmZP9wN0WfHOD9fbFK2Z
         MKG19/6r6/32HB79tKt2AKGfB2G8AqvZh9SSg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=d8Gy0Y+dPyH5l5S1qnEPq4ORt7c3oeAaTl4Yf/hjvMet6/Cwz6mLIyOYmYCHdhy2jb
         5U5t7KqWfxh/PG1rEgKOh7Em/Bs+OapHqW5FjVPJxtSFsPqx/VwoP7rahshaxhXCU59B
         dxoGy/Mss+iAmC5wLqvn3BheXgGw4S9pidgLk=
Received: by 10.231.125.87 with SMTP id x23mr6988524ibr.88.1275364880668;
        Mon, 31 May 2010 21:01:20 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id b3sm29392855ibf.19.2010.05.31.21.01.18
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 31 May 2010 21:01:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100531194240.28729.9964.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148073>

Christian Couder wrote:

> diff --git a/builtin/revert.c b/builtin/revert.c
> index 5df0d69..9085894 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -530,7 +530,7 @@ static int revert_or_cherry_pick(int argc, const =
char **argv)
>  			args[i++] =3D defmsg;
>  		}
>  		args[i] =3D NULL;
> -		return execv_git_cmd(args);
> +		return run_command_v_opt(args, RUN_GIT_CMD);
>  	}
>  	free_message(&msg);
>  	free(defmsg);

Doesn=E2=80=99t this leak msg and defmsg?  Maybe it would make sense to=
 free
the in-core copy of the commit message before the if (!no_commit)
block.

	int ret;

	...
	ret =3D 0;
	free_message(&msg);
	if (!no_commit)
		ret =3D commit_for_cherry_pick(signoff, edit, defmsg);
	free(defmsg);
	return ret;

Jonathan
