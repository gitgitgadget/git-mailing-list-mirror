From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 4/4] Makefile: add xgettext target for *.sh files
Date: Sun,  8 May 2011 12:10:59 +0000
Message-ID: <1304856659-10672-5-git-send-email-avarab@gmail.com>
References: <1304856659-10672-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:11:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ2pq-0007jS-KL
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803Ab1EHMLj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:11:39 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44776 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab1EHMLi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:11:38 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1324709eyx.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=IqBg+c+TdNdEHXh9nyZ/Nd61u1SEgFYdV8+YHp3lPFw=;
        b=cLbw7MI1O8ct2eqmL3QpHqRMN9rhkVwfGGWa1xHCNJUixV3nUZ4bOmVngA7+mJwHd0
         sf+pE/Dn48oeaUhKqQ3jjxlqU/RBrdLFpmtwoeAtiTOXQ2HYrANlPsuSWpnTTfH+7sNy
         uCB/w8S92S67T+C2NtWok+ii67FHEkD2UADwA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=mFZCh3A8/99nwPpwbmMFSXT8Gu0m1zWJzgb+sSIAAdhmZ0nMQyZB6o2t0KJuiA/8Rs
         7TzMQcXh2Tb++FS3mI52UHBbNyL3f6NyIQ5MQ2loJSd5aMgNdTKzkZG/R98/w7DHCSEz
         K2yDc5S5Lijqr2QriWnily8142jngz4JazWIE=
Received: by 10.213.13.79 with SMTP id b15mr620390eba.95.1304856697322;
        Sun, 08 May 2011 05:11:37 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id s62sm2713947eea.24.2011.05.08.05.11.36
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:11:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304856659-10672-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173102>

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
index 83889f3..10252d5 100644
--- a/Makefile
+++ b/Makefile
@@ -2065,10 +2065,14 @@ XGETTEXT_FLAGS =3D \
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
