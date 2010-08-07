From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] imap-send: Code correctness flagged by clang
Date: Sat, 7 Aug 2010 16:04:29 -0500
Message-ID: <20100807210429.GA2216@burratino>
References: <1281183136-10352-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Mike McCormack <mike@codeweavers.com>,
	Benjamin Kramer <benny.kra@googlemail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 07 23:06:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ohqae-0000Qh-VW
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 23:06:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041Ab0HGVF4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Aug 2010 17:05:56 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:54775 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216Ab0HGVFz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Aug 2010 17:05:55 -0400
Received: by gxk23 with SMTP id 23so3157802gxk.19
        for <git@vger.kernel.org>; Sat, 07 Aug 2010 14:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=rxFZKTQlzbXv72+hODBGUFnjmtMV60I+10XZaj0e0eE=;
        b=OQen9jzSBYlIYFaVx5MYkobAOjHSUzutTqJUt2Z3RlwX9JsiyvlPLBSMnFS2pQk0OS
         XVSc24LC+98I+xwLZx6RKnEaEdgty40iZfwHmLz4A5hAqOQUlux/+h5WsszFTGV9kyUc
         0F0nOJk4bsi9Dr7IR2STGOTIx89CNZECPTBAc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=rtDoAXTjppK4b6khV1hasBS4idURLvaQoxnp4dVbO1ZapIXJrm3xMakXPsbTCIJVk4
         6QhWvDrXQA8Hm4DoBfMlB/704t888pAmu5CpXhr+/qRheB+iAnKosLSXvXgLfQpJMFtS
         lV8jkBWIBsllUsY+XI3gSd14E4m9RLThG3aJU=
Received: by 10.151.101.6 with SMTP id d6mr4518721ybm.236.1281215154280;
        Sat, 07 Aug 2010 14:05:54 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id m12sm2988356ybn.19.2010.08.07.14.05.52
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 07 Aug 2010 14:05:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1281183136-10352-1-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152865>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> [Subject: imap-send: Code correctness flagged by clang]
>
> Clang 1.1 flagged the following issues in imap-send.c, this change
> fixes the warnings by moving some code around:
>=20
>     imap-send.c:548:27: warning: data argument not used by format str=
ing [-Wformat-extra-args]
>                                cmd->tag, cmd->cmd, cmd->cb.dlen);
>                                                    ^
>=20
> Here the sprintf format didn't use the cmd->cb.dlen argument if
> cmd->cb.data was false. Change the code to use a if/else instead of a
> two-level ternary to work it. This code was introduced with imap-send
> itself in f2561fda.
>=20
>     imap-send.c:1089:41: warning: conversion specifies type 'unsigned=
 short' but the argument has type 'int' [-Wformat]
>                     snprintf(portstr, sizeof(portstr), "%hu", srvc->p=
ort);
>                                                         ~~^   ~~~~~~~=
~~~
>=20
> Here sprintf is being given an int with a %hu format. Cast the
> srvc->port to unsigned short to work it. This code was introduced in
> 94ad2437 to add IPv6 support.

Nitpick: that this was found by clang is probably not the first thing
a person trying to figure out what the patch does needs to know.
Maybe:

	Subject: imap-send: Fix sprintf usage

	When composing a command for the imap server, imap-send
	uses a single nfsnprintf() invocation for brevity
	instead of dealing separately with the case when there
	is a message to be sent and the case when there isn=E2=80=99t.
	The unused argument in the second case, while valid,
	is confusing for static analyzers and human readers.

	v1.6.4-rc0~117 (imap-send: add support for IPv6, 2009-05-25)
	mistakenly used %hu as the format for an int =E2=80=9Cport=E2=80=9D, b=
y
	analogy with existing usage for the unsigned short
	=E2=80=9Caddr.sin_port=E2=80=9D.  Use %d instead.

	Noticed with clang.

> +++ b/imap-send.c
> @@ -543,9 +543,14 @@ static struct imap_cmd *v_issue_imap_cmd(struct =
imap_store *ctx,
>  	while (imap->literal_pending)
>  		get_cmd_result(ctx, NULL);
> =20
> -	bufl =3D nfsnprintf(buf, sizeof(buf), cmd->cb.data ? CAP(LITERALPLU=
S) ?
> -			   "%d %s{%d+}\r\n" : "%d %s{%d}\r\n" : "%d %s\r\n",
> -			   cmd->tag, cmd->cmd, cmd->cb.dlen);
> +	if (cmd->cb.data) {
> +		bufl =3D nfsnprintf(buf, sizeof(buf),
> +		                  CAP(LITERALPLUS) ? "%d %s{%d+}\r\n" : "%d %s{%d}=
\r\n",
> +		                  cmd->tag, cmd->cmd, cmd->cb.dlen);
> +	} else {
> +		bufl =3D nfsnprintf(buf, sizeof(buf), "%d %s\r\n", cmd->tag, cmd->=
cmd);
> +	}
> +

Hmm, maybe this would be easier to read:

	if (!cmd->cb.data)
		bufl =3D nfsnprintf(buf, sizeof(buf), "%d %s\r\n", cmd->tag, cmd->cmd=
);
	else
		bufl =3D nfsnprintf(buf, sizeof(buf), "%d %s{%d%s}\r\n",
		                  cmd->tag, cmd->cmd, cmd->cb.dlen,
		                  CAP(LITERALPLUS) ? "+" : "");

i.e., putting the easier case first and avoiding a variable format stri=
ng.

> @@ -1086,7 +1091,7 @@ static struct store *imap_open_store(struct ima=
p_server_conf *srvc)
>  		int gai;
>  		char portstr[6];
> =20
> -		snprintf(portstr, sizeof(portstr), "%hu", srvc->port);
> +		snprintf(portstr, sizeof(portstr), "%hu", (unsigned short)srvc->po=
rt);

Why not

		snprintf(portstr, sizeof(portstr), "%d", srvc->port);

?

Thanks for checking the code.
