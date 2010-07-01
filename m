From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] rerere: fix overeager gc
Date: Thu, 01 Jul 2010 12:10:55 +0200
Message-ID: <4C2C69AF.4010303@viscovery.net>
References: <4C2AE04E.9090901@viscovery.net> <1277977009-22780-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Jul 01 12:11:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUGje-0005Mj-Nk
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 12:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754818Ab0GAKLD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 06:11:03 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:30363 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754719Ab0GAKLA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jul 2010 06:11:00 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OUGjQ-0007UH-36; Thu, 01 Jul 2010 12:10:56 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id C81071660F;
	Thu,  1 Jul 2010 12:10:55 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
In-Reply-To: <1277977009-22780-1-git-send-email-szeder@ira.uka.de>
X-Enigmail-Version: 1.0.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150023>

Am 7/1/2010 11:36, schrieb SZEDER G=C3=A1bor:
> -static time_t rerere_created_at(const char *name)
> +static time_t rerere_last_checked_at(const char *name)

rerere_last_used_at?

> @@ -378,7 +378,13 @@ static int merge(const char *name, const char *p=
ath)
>  	}
>  	ret =3D ll_merge(&result, path, &base, NULL, &cur, "", &other, "", =
0);
>  	if (!ret) {
> -		FILE *f =3D fopen(path, "w");
> +		FILE *f;
> +
> +		if (utime(rerere_path(name, "preimage"), NULL) < 0)
> +			warning("failed utime() on %s: %s",
> +					rerere_path(name, "preimage"),
> +					strerror(errno));
> +		f =3D fopen(path, "w");

I think this should be outside of 'if (!ret)' condition because even if
the merge fails, the resolution was *used*.

Mental note: update mingw_utime to accept NULL for the second parameter=
=2E..

-- Hannes
