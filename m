From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] Makefile: fix definition of $(TEST_PROGRAMS) on Windows
Date: Sun, 28 Feb 2010 03:03:12 -0600
Message-ID: <20100228090311.GA30143@progeny.tock>
References: <1267304969-1924-1-git-send-email-michael.lukashov@gmail.com>
 <7vy6ietlf7.fsf@alter.siamese.dyndns.org>
 <7vmxyupbpa.fsf@alter.siamese.dyndns.org>
 <63cde7731002271503oac53237ubed6d318b46042e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Lukashov <michael.lukashov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 10:03:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nlf3f-0003Od-06
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 10:03:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031653Ab0B1JDT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Feb 2010 04:03:19 -0500
Received: from mail-iw0-f182.google.com ([209.85.223.182]:55373 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030987Ab0B1JDK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 04:03:10 -0500
Received: by iwn12 with SMTP id 12so1556789iwn.21
        for <git@vger.kernel.org>; Sun, 28 Feb 2010 01:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=N+QigPz3vNNudr2vS/0YE8WsyGWokSvfvwdFkuiC+SI=;
        b=UOGIIbcgo0fPtVnd0UmJkB6QNWxnxAqyT50SMLRYsko8SQzESw2GImVP6Yt9UXF/49
         OuEF8vCSqLBHut7QfXqceXyD1ZzkfZ0FAJR51lpZQLjrV10tk2j7vfKz8cNSQjSwTLwe
         pWuDH/EMBe8F5GcrNSj8qzp1Qa3ZI/1zv0hwc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=VCeKC9dgnL06v7xdAhtM8uCrilSVEQbxKF8G4rQ89mrj/nC4c1PIbaSVtiBB8Jkh57
         +sgLNHtoEZlM4oOHDerfckzf0BczN5ptZaXDAxIzm/PJKO8O2Dg5WcKWcYcVCmQ+08MA
         28fXKs9gHlHAT1TuSjNrYTvHNnrgaQZciFdEY=
Received: by 10.231.79.193 with SMTP id q1mr363298ibk.59.1267347789168;
        Sun, 28 Feb 2010 01:03:09 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm1831033iwn.12.2010.02.28.01.03.07
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 28 Feb 2010 01:03:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <63cde7731002271503oac53237ubed6d318b46042e9@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141243>

=46rom: Michael Lukashov <michael.lukashov@gmail.com>

Commit ea92519 (build dashless "bin-wrappers" directory similar to
installed bindir, 2009-12-02) replaced the definition of
TEST_PROGRAMS with a macro:

 TEST_PROGRAMS =3D $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))

and commit daa99a9 (Makefile: make sure test helpers are rebuilt when
headers change, 2010-01-26) moved the (unchanged, non-macro)
definition of TEST_PROGRAMS earlier so it could be used in two
different sections of the Makefile.

The merge 225f78 resolving these two changes unfortunately snuck in an
optimization while at it: it replaced the delayed-evaluation =3D
operator with an immediate :=3D assignment:

 TEST_PROGRAMS :=3D $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))

Such a change would have been safe when TEST_PROGRAMS was defined
towards the bottom of the makefile, but in its new location before
the platform-specific definitions, $(X) is not yet defined.  Thus
the following error occurs when trying to compile Git in Windows:

  make: *** No rule to make target `test-chmtime', needed by `all'.  St=
op.

or if X is set to a nonempty value in config.mak.

So change the operator back to =3D.  This makes TEST_PROGRAMS more
similar to PROGRAMS and the other macros defined with delayed
evaluation in that section.

Thanks to Junio for the analysis.

Signed-off-by: Michael Lukashov <michael.lukashov@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks for the catch!  Here=E2=80=99s a longer explanation.

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 93e1a92..b64eec1 100644
--- a/Makefile
+++ b/Makefile
@@ -418,7 +418,7 @@ TEST_PROGRAMS_NEED_X +=3D test-sha1
 TEST_PROGRAMS_NEED_X +=3D test-sigchain
 TEST_PROGRAMS_NEED_X +=3D test-index-version
=20
-TEST_PROGRAMS :=3D $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
+TEST_PROGRAMS =3D $(patsubst %,%$X,$(TEST_PROGRAMS_NEED_X))
=20
 # List built-in command $C whose implementation cmd_$C() is not in
 # builtin-$C.o but is linked in as part of some other command.
--=20
1.7.0
