From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] Makefile: clarify definition of TEST_OBJS
Date: Sun, 28 Feb 2010 03:11:55 -0600
Message-ID: <20100228091155.GB30143@progeny.tock>
References: <1267304969-1924-1-git-send-email-michael.lukashov@gmail.com>
 <7vy6ietlf7.fsf@alter.siamese.dyndns.org>
 <7vmxyupbpa.fsf@alter.siamese.dyndns.org>
 <63cde7731002271503oac53237ubed6d318b46042e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Lukashov <michael.lukashov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 10:11:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlfBu-00063e-Kt
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 10:11:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031636Ab0B1JLx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Feb 2010 04:11:53 -0500
Received: from mail-iw0-f182.google.com ([209.85.223.182]:50559 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030987Ab0B1JLv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 04:11:51 -0500
Received: by iwn12 with SMTP id 12so1559215iwn.21
        for <git@vger.kernel.org>; Sun, 28 Feb 2010 01:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=VTGKwP16txIWLVdCJjYe81fGISyR5zuru7MetrUn0pA=;
        b=pkVid2c90D4d6s80wWdW7Njc/l4poBgGDy5kl473xNDmaT1qfZlsTXFiD5Qj+aEKtR
         Ccg+rSsRF1OE2oaB6Jx3GnrIk2taH71kltlubxCBTDQlbPVukyqf2VqUlqYib9Fisui0
         kaMrE/OO+QBCgH7/LWpMXMmKQOkigGNgCRmLw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=eDbassswWk51JLFfd9A6fI13mdkesYRkx1vj4jddx2f/eJ6I7HIwJNRw69q2ly5jAv
         pvqPQWG6NB4dPuSTx9pEfIJT5iZ5RB/gybQloWXoydCej5/jMiV2phDUA0dLfNsdZESa
         xF8rabmt/szz9ybfSMp/MpDqMkSyUJDmii00g=
Received: by 10.231.60.17 with SMTP id n17mr2117125ibh.24.1267348310437;
        Sun, 28 Feb 2010 01:11:50 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm1849032iwn.15.2010.02.28.01.11.49
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 28 Feb 2010 01:11:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <63cde7731002271503oac53237ubed6d318b46042e9@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141244>

The definition of TEST_OBJS in commit daa99a91 (Makefile: make sure
test helpers are rebuilt when headers change, 2010-01-26) moved a use
of $X to before the platform-specific section where it gets defined.
There are at least two ways to fix that:

 - Change the definition of TEST_OBJS to use the =3D delayed
   evaluation operator.  This way, one need not worry about $(X)
   needing to be defined before TEST_OBJS is set.

 - Move the definition of TEST_OBJS to below the definition of $X.

Carry out the second.  The later site of definition makes the code more
readable, since now a reader only has to look down one line to see what
TEST_OBJS is meant to be used for.

Oddly enough, with or without this change the behavior of the Makefile
is the same.  Since TEST_PROGRAMS is defined with delayed evaluation,
the value of

 TEST_OBJS :=3D $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))

is independent of the value of $X when it is evaluated: the $X in the
pattern and the $X in $(TEST_PROGRAMS) will simply always cancel out.
Make sure $X has the expected expansion anyway to make the code and
the reader=E2=80=99s sanity more robust in the face of future changes.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Michael Lukashov wrote:

> It seems there's no difference between
>=20
> TEST_OBJS :=3D $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
>=20
> and
>=20
> TEST_OBJS =3D $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
>=20
> Both variants seem to work under mingw.

Yep.  I think the unexpected value of $X is worth fixing regardless jus=
t to
keep people from going insane.

Thanks, both.

 Makefile |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index b64eec1..e95c128 100644
--- a/Makefile
+++ b/Makefile
@@ -738,8 +738,6 @@ BUILTIN_OBJS +=3D builtin-verify-pack.o
 BUILTIN_OBJS +=3D builtin-verify-tag.o
 BUILTIN_OBJS +=3D builtin-write-tree.o
=20
-TEST_OBJS :=3D $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
-
 GITLIBS =3D $(LIB_FILE) $(XDIFF_LIB)
 EXTLIBS =3D
=20
@@ -1686,6 +1684,7 @@ git.o git.spec \
 	$(patsubst %.perl,%,$(SCRIPT_PERL)) \
 	: GIT-VERSION-FILE
=20
+TEST_OBJS :=3D $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
 GIT_OBJS :=3D $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS)=
 \
 	git.o http.o http-walker.o remote-curl.o
 XDIFF_OBJS =3D xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xe=
mit.o \
--=20
1.7.0
