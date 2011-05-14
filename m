From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 4/4] Makefile: add xgettext target for *.sh files
Date: Sat, 14 May 2011 13:47:45 +0000
Message-ID: <1305380865-21339-5-git-send-email-avarab@gmail.com>
References: <1305380865-21339-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 15:48:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLFCV-0007GJ-DB
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 15:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757878Ab1ENNsH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 May 2011 09:48:07 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56391 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609Ab1ENNsB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2011 09:48:01 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so914469ewy.19
        for <git@vger.kernel.org>; Sat, 14 May 2011 06:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=0ckkNTXER/f7QoYcY6T3x8MXR9DHDdOgcQAK+9tu91k=;
        b=xSsF/Z4fJOcoRODbbof5L30xt1SMfe4Atx172W3Roum0EKTU2ZiS4q3t3duVcLfF2j
         ZPk1JxEITm43jzJE81FoNPI0vAOFrxiRyA3cNc7q0sggoIvyGKTqCaTiLn2iXKOFQGlW
         cgWJzL8/A1uYzL4KfExPt+CDIp/Lt/B/K2XDA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=sD49edpjXql9NDE5lInihk5SVNwJT2BmuYPs+9itpJn/IXTIUY4QX4PTuKnJDWwByX
         v6MzmMPgBePETpZNwuhIOGQ0wXi9m0VR2m6AGpmZpl2Fg/RcGl43RH71C3QV/+hD5zE7
         Hb1llXMSGJwf9pP3wLKWFEGQFuXrMaJysqWg0=
Received: by 10.213.105.66 with SMTP id s2mr1169653ebo.78.1305380880678;
        Sat, 14 May 2011 06:48:00 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y9sm2110298eeh.8.2011.05.14.06.47.59
        (version=SSLv3 cipher=OTHER);
        Sat, 14 May 2011 06:48:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1305380865-21339-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173586>

Change the "pot" target to also extract strings from our $(SCRIPT_SH)
files with xgettext(1).

Note that due to Jonathan Nieder's trick of doing "mv $@+ $@" at the
end of the target the "pot" target will now warn:

    $ make pot
        XGETTEXT po/git.pot
    po/git.pot+: warning: Charset "CHARSET" is not a portable encoding =
name.
                          Message conversion to user's charset might no=
t work.

This warnings is emitted because xgettext is writing into a non-*.pot
file, it's harmless however. The content that's written out is
equivalent to what it would be if we were writing directly into an
existing POT file with --join-existing.

As part of this change I've eliminated the && chain between xgettext
calls, this is incompatible with $(QUIET_XGETTEXT), if the && is left
in it'll emit:

    /bin/sh: @echo: not found

Since it's redundant (the Makefile will stop if there's an error) I've
removed it altogether.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Makefile |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 854fe69..1b1a7e8 100644
--- a/Makefile
+++ b/Makefile
@@ -2039,10 +2039,14 @@ XGETTEXT_FLAGS =3D \
 	--from-code=3DUTF-8
 XGETTEXT_FLAGS_C =3D $(XGETTEXT_FLAGS) --language=3DC \
 	--keyword=3D_ --keyword=3DN_ --keyword=3D"Q_:1,2"
+XGETTEXT_FLAGS_SH =3D $(XGETTEXT_FLAGS) --language=3DShell
 LOCALIZED_C :=3D $(C_OBJ:o=3Dc)
+LOCALIZED_SH :=3D $(SCRIPT_SH)
=20
 po/git.pot: $(LOCALIZED_C)
-	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ $(XGETTEXT_FLAGS_C) $(LOCALIZED_C)=
 && \
+	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ $(XGETTEXT_FLAGS_C) $(LOCALIZED_C)
+	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_S=
H) \
+		$(LOCALIZED_SH)
 	mv $@+ $@
=20
 pot: po/git.pot
--=20
1.7.4.4
