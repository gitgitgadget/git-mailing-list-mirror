From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 03/13] transport-helper: factor out push_update_refs_status
Date: Sun, 29 Aug 2010 16:45:21 -0500
Message-ID: <AANLkTikP_Mm4C2C_TC57Adi9egPMdv83htc1J8ZJ4mN-@mail.gmail.com>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
 <1283053540-27042-4-git-send-email-srabbelier@gmail.com> <20100829213618.GD1890@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 29 23:45:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpphC-0002OC-Vr
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 23:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753935Ab0H2Vpm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Aug 2010 17:45:42 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:40779 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753256Ab0H2Vpl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Aug 2010 17:45:41 -0400
Received: by gwj17 with SMTP id 17so1774527gwj.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 14:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=XoMOE4yFuZUsiGHLdAAj0QIABOhTaRSZ+0lONEE3Fcc=;
        b=mNqFGcsxHKGZgix/Pm+YDR1KeqcrjYDGYrsx9kjeyPrinnPbRXJJAQ7rFLLcx3qR0I
         G/iYlwnA+WidAwb7a1ArO5TGnloXlwWasRjFEWn4wSMuhBLkf9jVcSkv+DRu5ck6yUwy
         RN9DkVwhBM04N/tCswTCXdRi7dCTyzeUnxxL4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Rizn+gmDASWgkb+Z2sKHvoR4Ik114TSHzmrL4Qp3Oft89TXWDRoS1fSFCkGrIpC1+2
         7cJEW3MzJWIc+c2GN4g4OZmvHwnF008sjfIoXCMLjDiqTiOiH/Nq6YMl8Iyk8Oxuqqwb
         U5Ewvu2PFxgf8TO5HcXAdeYFvQd4liMUpN36c=
Received: by 10.150.52.11 with SMTP id z11mr4246166ybz.149.1283118341168; Sun,
 29 Aug 2010 14:45:41 -0700 (PDT)
Received: by 10.151.49.17 with HTTP; Sun, 29 Aug 2010 14:45:21 -0700 (PDT)
In-Reply-To: <20100829213618.GD1890@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154721>

Heya,

On Sun, Aug 29, 2010 at 16:36, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Hmm, I am not too happy with the long loop without explicit condition=
=2E
> Maybe it would make sense to split out the loop body as its own funct=
ion?
> Something like
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ref *ref =3D remote_refs;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for (;;) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0recvline(data,=
 &buf);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!buf.len)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0push_update_re=
f_status(&buf, &ref, remote_refs);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}

Ok, will fix.

>> =C2=A0 =C2=A0 =C2=A0 strbuf_release(&buf);
>> - =C2=A0 =C2=A0 return 0;
>> + =C2=A0 =C2=A0 return;
>
> Not necessary, I think.

Removed the return.

> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Thanks for a pleasant read.

Thanks for reading :).

--=20
Cheers,

Sverre Rabbelier
