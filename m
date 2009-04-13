From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH] builtin-apply: keep information about files to be
 deleted
Date: Mon, 13 Apr 2009 23:03:51 +0200
Message-ID: <20090413230351.7cbb01f5@gmail.com>
References: <1239478260-7420-1-git-send-email-michal.kiedrowicz@gmail.com>
	<7v4owsfktw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 23:06:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtTLb-0004OP-VL
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 23:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbZDMVEM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Apr 2009 17:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbZDMVEL
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 17:04:11 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:43677 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbZDMVEK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Apr 2009 17:04:10 -0400
Received: by fxm2 with SMTP id 2so2156365fxm.37
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 14:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=ZMT2NdyJGkqwXT9VMfibsPy23JeXRMzT6F/GUujjmOc=;
        b=e+qrvceA58l9Dxx9aUFUMHrNJhiZLcyAyJhPUJo80YeWevjty9RuUYNyqTAMB/GgrI
         NabUniKipwgrq1neS7/pfNBQBEKwEJmsw2XdXFZAyc0+itYTYMxK0TItmG0+5NX9/kja
         1NSMPgVmWPasf0htmSsAml79qTgCwc8cEBD30=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=HjVCKPOclLj6V3Evo8ZfAzF+1f4FCI9PXtnXsTX7vpfN9pp2snpfRc6nOyM7nI1b7t
         VMjiGk50YVc1VJC6srvMLb8H1uUOayWeFLH2nOIbvOrvTkavJg4hfhfWu8yC5PcNukae
         xkc43Xyv15OipBhw8XhRq9iCzKhsIy5wduAh0=
Received: by 10.86.68.1 with SMTP id q1mr1301751fga.19.1239656648448;
        Mon, 13 Apr 2009 14:04:08 -0700 (PDT)
Received: from localhost (77-253-133-96.adsl.inetia.pl [77.253.133.96])
        by mx.google.com with ESMTPS id e20sm7975882fga.19.2009.04.13.14.04.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 13 Apr 2009 14:04:08 -0700 (PDT)
In-Reply-To: <7v4owsfktw.fsf@gitster.siamese.dyndns.org>
X-Mailer: Claws Mail 3.7.0 (GTK+ 2.14.7; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116487>

Junio C Hamano <gitster@pobox.com> wrote:

> This PATH_TO_BE_DELETED logic should be Ok for the normal case, but i=
t
> seems a bit fragile.  In a sequence of patches, if you have even one
> patch that makes the path disappear, you initialize it as
> PATH_TO_BE_DELETED, and special case the "creation should not clobber
> existing path" rule to allow it to be present in the tree.
>=20
> That may make this sequence work, I presume, with your change:
>=20
> 	patch #1	renames frotz.c to hello.c
>       patch #2	renames hello.c to frotz.c
>=20
> because of patch #2, hello.c is marked as PATH_TO_BE_DELETED
> initially and then when patch #1 is handled, frotz.c is allowed to
> replace it.
>=20
> But if you have further patches that do the following (the "file
> table" mechanism was added to handle concatenated patches that affect
> the same path more than once), I thing PATH_TO_BE_DELETED logic would
> break down:
>=20
>       patch #3	renames alpha.c to hello.c
> 	patch #4	renames hello.c to alpha.c
>=20
> When patch #3 is handled, the PATH_TO_BE_DELETED mark is long gone
> from hello.c, and we will see the same failure you addressed in your
> patch, won't we?

As far as I understand the code, diffs are applied independently
(for every file apply_patch() is called) and for every apply_patch()
call fn_table is cleared. So situation you described in only possible
in a *single* diff and I don't think it is possible to happen.=20

Performing two criss-cross renames results in following diff:

	mv file1 tmp
	mv file2 file1
	mv tmp file2

	mv file1 tmp
	mv file3 file1
	mv tmp file3

	git diff -M -B

diff --git a/file3 b/file1
similarity index 100%
rename from file3
rename to file1
diff --git a/file1 b/file2
similarity index 100%
rename from file1
rename to file2
diff --git a/file2 b/file3
similarity index 100%
rename from file2
rename to file3

However, sanity checking still may be performed and error printed on
situations which cannot be resolved.

>=20
> The prepare_fn_table() may be a good place to diagnose such a
> situation and warn or error out if the user feeds such an input we
> cannot handle sanely.
>=20

I'll add some checks to this function as you suggest.

>=20
> Style;
>=20
> 	if (to_be_deleted(tpatch))
>         	tpatch =3D NULL;
>=20
> Other than that, I think it is a sensible approach.

Thanks for feedback.

--=20
Micha=C5=82 Kiedrowicz
