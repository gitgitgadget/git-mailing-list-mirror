From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] daemon: return "access denied" if a service is not
 allowed
Date: Mon, 03 Oct 2011 15:20:03 -0700
Message-ID: <7vaa9hemzw.fsf@alter.siamese.dyndns.org>
References: <7vsjn9etm3.fsf@alter.siamese.dyndns.org>
 <1317678909-19383-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 00:20:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAqrt-0000Dg-PV
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 00:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757703Ab1JCWUJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Oct 2011 18:20:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41887 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755036Ab1JCWUG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Oct 2011 18:20:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 404A46180;
	Mon,  3 Oct 2011 18:20:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=X4LJoj+sfTxy
	4h7YnTVARe/7XGQ=; b=KKhbErRCNDZVMl8gcD+HbkXUxLVMgIdy/oOsVGYrxfFp
	mbMGULtfl23w9GiVASFzR6xJQvH43gSt0Ic+I/tsaVbRAMSNVnfDUeVD5G9VH9ji
	mX1vgTfK2BlmzXzIpqIpA9nMgu5NGUxShXTs0cBtmAFi0hwft4tUrc4jOjhxuo4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Zjhgbw
	RPjFMmqKesQrZnwDB7w8WuWEYVi8jauJoFaeIDiSgS/p4x8IQF82HOPyL6wdmrNS
	7PPnhNaDLQv6PWAu32BOEPOq2j85OmLArFPKyo+mJ6d5liKPcN7CyzISESW1rIgm
	GcWaQ0ohg1Tj/vt86fz4oo5PfxWV1ekLRyKic=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36D66617F;
	Mon,  3 Oct 2011 18:20:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89515617E; Mon,  3 Oct 2011
 18:20:04 -0400 (EDT)
In-Reply-To: <1317678909-19383-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 4 Oct
 2011 08:55:09 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D7F2B0D8-EE0D-11E0-AB39-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182717>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> The message is chosen to avoid leaking information, yet let users kno=
w
> that they are deliberately not allowed to use the service, not a faul=
t
> in service configuration or the service itself.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  OK let's try again. I don't send ERR when faults happen in
>  service->fn() (eventually run_service_command) because
>
>   - if it's start_command(), it's likely due to service configuration
>     fault (wrong --exec-path..)
>
>   - if it's finish_command(), the service may have run and sent
>     something back to users. We may break the protocol by sending ERR
>
>  daemon.c |   12 ++++++++----
>  1 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/daemon.c b/daemon.c
> index 4c8346d..f0cae24 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -257,11 +257,11 @@ static int run_service(char *dir, struct daemon=
_service *service)
>  	if (!enabled && !service->overridable) {
>  		logerror("'%s': service not enabled.", service->name);
>  		errno =3D EACCES;
> -		return -1;
> +		goto failed;
>  	}
> =20
>  	if (!(path =3D path_ok(dir)))
> -		return -1;
> +		goto failed;
> =20
>  	/*
>  	 * Security on the cheap.
> @@ -277,7 +277,7 @@ static int run_service(char *dir, struct daemon_s=
ervice *service)
>  	if (!export_all_trees && access("git-daemon-export-ok", F_OK)) {
>  		logerror("'%s': repository not exported.", path);
>  		errno =3D EACCES;
> -		return -1;
> +		goto failed;
>  	}
> =20
>  	if (service->overridable) {
> @@ -291,7 +291,7 @@ static int run_service(char *dir, struct daemon_s=
ervice *service)
>  		logerror("'%s': service not enabled for '%s'",
>  			 service->name, path);
>  		errno =3D EACCES;
> -		return -1;
> +		goto failed;
>  	}
> =20
>  	/*
> @@ -301,6 +301,10 @@ static int run_service(char *dir, struct daemon_=
service *service)
>  	signal(SIGTERM, SIG_IGN);
> =20
>  	return service->fn();
> +
> +failed:
> +	packet_write(1, "ERR %s: access denied", dir);
> +	return -1;
>  }

This looks better.

I think telling "dir" back to the user is probably safe (it is not
affected by what path_ok() does).

I briefly wondered if we also want to say which service failed, but "di=
r"
is much more likely to be typoed and deserves to be parroted back to he=
lp
the user realize mistakes, while the service name is not something the
user usually types, so the balance the patch strikes is probably the
optimal.

Thanks.
