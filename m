From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] git gc: Speed it up by 18% via faster hash comparisons
Date: Thu, 28 Apr 2011 13:32:56 +0400
Message-ID: <BANLkTin+qb6j8p+kOTEkQ2iK29ZWOsRk-g@mail.gmail.com>
References: <20110427225114.GA16765@elte.hu>
	<20110427231748.GA26632@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	=?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?= <fweisbec@gmail.com>,
	Pekka Enberg <penberg@cs.helsinki.fi>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 11:33:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFNap-0004qQ-E4
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 11:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049Ab1D1Jc6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Apr 2011 05:32:58 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:64368 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074Ab1D1Jc5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2011 05:32:57 -0400
Received: by qyg14 with SMTP id 14so1322308qyg.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 02:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=eBChYy3L6B1itLsevMp8mwoO+qduYPP/Wvzc2hetP3Q=;
        b=WhPIfaDnS7dg7vQkCZBhpCZRdOwG1fZsN1Z4SvrL5cOhZdJrCBeep4rGhLH5LUhSNh
         tZ28MfrxjWj/GNdjWyFeRtQShnybJBoVLNjFgdQ3OkmX0+n+0IWpToAtfsXoevXsZPnV
         jJXnRJeNrQhDJrRb7U2f2YPX9xNJ52SgflujE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sjclNEYfxxvAhUbEhXzAjstmKi41g8iGxKjpbvhuI3MRRsKGPx3SC2KGNVqT8zPh1y
         NCkziUrDWzigRJ9VM3sejSX14fc0Ci+bdX+03Veg8inVz8DqIlKf3N8MY0uHJu6QonUy
         EPH6VjO2r0uxYlmC2sfWXUXr5SwJ0pUBYMdGo=
Received: by 10.229.65.73 with SMTP id h9mr2528980qci.269.1303983176826; Thu,
 28 Apr 2011 02:32:56 -0700 (PDT)
Received: by 10.229.251.85 with HTTP; Thu, 28 Apr 2011 02:32:56 -0700 (PDT)
In-Reply-To: <20110427231748.GA26632@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172333>

2011/4/28 Jonathan Nieder <jrnieder@gmail.com>:
>
> Hm. =A0This would be very sensitive to the compiler, since a too-smar=
t
> optimizer could take this loop and rewrite it back to memcmp! =A0So I
> wonder if it's possible to convey this to the compiler more precisely=
:
>
> =A0 =A0 =A0 =A0return memcmp_probably_differs_early(sha1, sha2, 20);
>
> E.g., how would something like
>
> =A0 =A0 =A0 =A0const unsigned int *start1 =3D (const unsigned int *) =
sha1;
> =A0 =A0 =A0 =A0const unsigned int *start2 =3D (const unsigned int *) =
sha2;
>
> =A0 =A0 =A0 =A0if (likely(*start1 !=3D *start2)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (*start1 < *start2)

It can be a problem with unalligned access. So, IMHO, it is
better to use get_be32 here:

 =A0 =A0 =A0 =A0unsigned start1 =3D get_be32(sha1);
 =A0 =A0 =A0 =A0unsigned start2 =3D get_be32(sha2);

 =A0 =A0 =A0 =A0if (likely(start1 !=3D start2)) {
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (start1 < start2)

=2E..

Dmitry
