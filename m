From: =?utf-8?B?0KDQvtC80LDQvSDQlNC+0L3Rh9C10L3QutC+?= 
	<dpb@corrigendum.ru>
Subject: Re: [PATCH v2 2/2] send-email: handle adjacent RFC 2047-encoded words
 properly
Date: Sun, 07 Dec 2014 17:35:41 +0300
Message-ID: <op.xqh5hrafnngjn5@freezie>
References: <1417894583-2352-1-git-send-email-dpb@corrigendum.ru>
 <1417894583-2352-2-git-send-email-dpb@corrigendum.ru>
 <20141207091859.GA21311@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>,
	=?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjar?= =?utf-8?Q?mason?= 
	<avarab@gmail.com>, "Jay Soffian" <jaysoffian@gmail.com>,
	"Thomas Rast" <tr@thomasrast.ch>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Dec 07 15:36:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xxcwf-0007WS-A6
	for gcvg-git-2@plane.gmane.org; Sun, 07 Dec 2014 15:36:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbaLGOfr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Dec 2014 09:35:47 -0500
Received: from forward8l.mail.yandex.net ([84.201.143.141]:48931 "EHLO
	forward8l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbaLGOfq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Dec 2014 09:35:46 -0500
Received: from smtp11.mail.yandex.net (smtp11.mail.yandex.net [95.108.130.67])
	by forward8l.mail.yandex.net (Yandex) with ESMTP id DDC291A41298;
	Sun,  7 Dec 2014 17:35:42 +0300 (MSK)
Received: from smtp11.mail.yandex.net (localhost [127.0.0.1])
	by smtp11.mail.yandex.net (Yandex) with ESMTP id 09A917E0A60;
	Sun,  7 Dec 2014 17:35:41 +0300 (MSK)
Received: from 109-184-135-154.dynamic.mts-nn.ru (109-184-135-154.dynamic.mts-nn.ru [109.184.135.154])
	by smtp11.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id GjsPW0n8WY-ZfHCQA9P;
	Sun,  7 Dec 2014 17:35:41 +0300
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 403a55a2-2661-4536-91cf-7b0b585d7ffc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=corrigendum.ru; s=mail;
	t=1417962941; bh=F3ruRLoPd/eg8lO3rB7kJPVFFC1f2UQjVtuxIKCLiNM=;
	h=Content-Type:To:Cc:Subject:References:Date:MIME-Version:
	 Content-Transfer-Encoding:From:Message-ID:In-Reply-To:User-Agent;
	b=xKfScMUYxD66228cwxWOBzzjJyA7ZTqfCBkoGPhfvLbSsLcs9nbWjPR1e5s7F/9MV
	 ZNhFmtptFelEnWD8U3kAtEalVkmr54nsgU8fu1Iihe2BO/1268EQrwblTqSia72D26
	 dyyxXtgJX4H4pYTNXdwXCk3Uv4MrdUNiEwpe867A=
Authentication-Results: smtp11.mail.yandex.net; dkim=pass header.i=@corrigendum.ru
In-Reply-To: <20141207091859.GA21311@peff.net>
User-Agent: Opera Mail/12.17 (Win64)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260990>

Jeff King <peff@peff.net> =D0=BF=D0=B8=D1=81=D0=B0=D0=BB =D0=B2 =D1=81=D0=
=B2=D0=BE=D1=91=D0=BC =D0=BF=D0=B8=D1=81=D1=8C=D0=BC=D0=B5 Sun, 07 Dec =
2014 12:18:59 =20
+0300:

> On Sat, Dec 06, 2014 at 10:36:23PM +0300, =D0=A0=D0=BE=D0=BC=D0=B0=D0=
=BD =D0=94=D0=BE=D0=BD=D1=87=D0=B5=D0=BD=D0=BA=D0=BE wrote:
>
>> The RFC says that they are to be concatenated after decoding (i.e. t=
he
>> intervening whitespace is ignored).
>
> Thanks. Both patches look good to me, and I'd be happy to have them
> applied as-is. I wrote a few comments below, but in all cases I think=
 I
> convinced myself that what you wrote is best.

I had the same concerns myself, and eventually convinced myself of the =
=20
same. :-)

> One final note on this bit of code: if there are multiple encoded wor=
ds,
> we grab the $charset from the final encoded word, and never report th=
e
> earlier charsets. Technically they do not all have to be the same
> (rfc2047 even has an example where they are not). I think we can dism=
iss
> this, though, as:
>
>   1. It was like this before your patches (we might have seen multipl=
e
>      non-adjacent encoded words; you're just handling adjacent ones),
>      and nobody has complained.
>
>   2. Using two separate encodings in the same header is sufficiently
>      ridiculous that I can live with us not handling it properly.

Yeah, that bugs me as well. But I think handling multiple encodings wou=
ld =20
require substantial reworking of the code, so I chickened out (with the=
 =20
same excuses :-)).

Roman.
