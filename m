From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH 2/3] Move unsigned long option parsing out of pack-objects.c
Date: Sat, 20 Jun 2015 17:31:03 +0200
Message-ID: <55858737.6070207@gmail.com>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>	<1434705059-2793-3-git-send-email-charles@hashpling.org>	<xmqq7fqza8bo.fsf@gitster.dls.corp.google.com> <xmqqh9q38ruq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Sat Jun 20 17:31:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6Kk4-00024Z-GV
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jun 2015 17:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754200AbbFTPb0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Jun 2015 11:31:26 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:38273 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753759AbbFTPbY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2015 11:31:24 -0400
Received: by wibdq8 with SMTP id dq8so41119470wib.1
        for <git@vger.kernel.org>; Sat, 20 Jun 2015 08:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=EjamArSSlyfoyVpzU9O2h/rTXGvW1ganiqHVnat1qig=;
        b=Axbv3RaqBJplY0+aszYjwxonJWLlzUbORSdv5oEDV3dDYGYiBaCMUCOUQqxAHKeWsH
         t6zw8a9zP2g0AYW1JJq5vSjsY1Ws7o9qbhhOhvsYwPz/gZfm/cO3Lf/SiL7q3uuMpBFD
         in9oHG1HHwAFc0jYo0d19RZYEV4ay0Ia2eUKNT3CFY8HjJy51EoFfpsYJoacaYJRYDhQ
         w0rjliOtC7zFrDHVKjS98TbG/Nt71ij1s82SIpi5iSWSrPjiSgRzsykOKC3fGvzmIBYR
         TjKoXR498pYvajWvjk101J6ehfywaYmsDFdpOCaMWdt3Hmr+h8hO5f5mJ9yFQjG3sCwS
         pDbA==
X-Received: by 10.194.209.130 with SMTP id mm2mr34405941wjc.64.1434814282750;
        Sat, 20 Jun 2015 08:31:22 -0700 (PDT)
Received: from [192.168.1.53] (aga181.neoplus.adsl.tpnet.pl. [83.25.156.181])
        by mx.google.com with ESMTPSA id i5sm8560564wic.10.2015.06.20.08.31.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jun 2015 08:31:21 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <xmqqh9q38ruq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272232>

W dniu 2015-06-19 o 20:39, Junio C Hamano pisze:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
>> Except for the minor nits above, I think this is a good change.
>=20
> Oh, I forgot to mention one thing.  I am not sure if this should be
> called ULONG.  "unsigned long"-ness is not the most important part
> of this thing from the end-user's point of view, and also from the
> point of view of the programmer who supports end-users by using this
> new feature.
>=20
> It is "unlike OPT_INTEGER, the user can specify it as a human
> readble scaled quantity" that is the reason to use this new thing.
> I think we discussed to introduce OPT_HUMINT (HUM stands for HUMAN,
> obviously) or some name like that a few years ago to do exactly
> this, but that is not a great name, either.

On the output side it is often called --human-readable (e.g. du(1)),
I don't know how it is called on input side (e.g. in 'dd' and friends).

> I was tempted to suggest a name that has "size" in it, but because
> places that we may conceivably want to use it in the future would be
> to specify:
>=20
>  - sizes, e.g. "split the packfiles into 4.3G chunks".
>=20
>  - counts, e.g. "show me the most recent 2k commits".
>=20
>  - bandwidth, e.g. "limit the transfer to consume at most 2M bps".
>=20
> which is not limited to size, it is not a very good idea, either.
>=20
> OPT_SCALED_ULONG(), or something with "scaled" in its name, perhaps?

OPT_HUMAN_READABLE_INTEGER() is probably out as too long? ;-P

--=20
Jakub Nar=C4=99bski

=20
