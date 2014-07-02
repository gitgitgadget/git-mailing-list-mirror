From: Avi Kivity <avi@cloudius-systems.com>
Subject: [PATCH v4] git-am: add option to extract email Message-Id: tag into commit log
Date: Wed,  2 Jul 2014 17:51:13 +0300
Message-ID: <1404312673-11836-1-git-send-email-avi@cloudius-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 02 16:51:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2Lsj-0007lE-Ms
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 16:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754588AbaGBOva convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jul 2014 10:51:30 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:34799 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093AbaGBOv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 10:51:29 -0400
Received: by mail-wg0-f43.google.com with SMTP id b13so903166wgh.14
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 07:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-type:content-transfer-encoding;
        bh=buMoy0Bq6twyYG3fHq7b7OM640xBg3PWl0AQQ4bjNPE=;
        b=XFmjpC50QCETPtU9oKVhDge1KNvpOmD+qYKoYPMpHp/Id/w+tcVAQ6RYhp3qW4AkSO
         mZpFLWXGQVRVL1FE7sDHpWfl7uLl8olYqtUTcsnslOTBWgGgxsZBMLj/9xFBidb9dAVI
         25BjuWUxP96I2IJC16Gqer3zjXZI3hG2f64VcYUgd8jYfTUWXVRCSJI9Ba5ytcYFe4eR
         nhKtL7/6DfLFKf5moxaB2yA/84W3BEjYNO3YLtKr/lxQwQIt6aOcGYHjmp2BH5CO4x06
         lhWziiSvIJQyFS7EjX8f9nU5XwToW0ASPB9kMp8E6semUrEk0/kBtrDVJ7oL0S9hGoLl
         18oA==
X-Gm-Message-State: ALoCoQnEhnhjFErLZdtEQFoTkynyNZlsj/OTITlxqXkljpymeOpxXAc+IIfggHB0F+p5klWoA9w0
X-Received: by 10.194.238.168 with SMTP id vl8mr3177853wjc.133.1404312688335;
        Wed, 02 Jul 2014 07:51:28 -0700 (PDT)
Received: from avi.cloudius (84.94.198.183.cable.012.net.il. [84.94.198.183])
        by mx.google.com with ESMTPSA id dt7sm55985549wic.6.2014.07.02.07.51.26
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jul 2014 07:51:27 -0700 (PDT)
X-Mailer: git-send-email 1.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252785>

Some workflows prefer to track exactly which email message was used to
generate a commit.  This can be used, for example, to generate an
automated acknowledgement when a patch is committed as a response to
the patch email, or as a reference to the thread which introduced the
patch.

Support this by adding a --message-id option (abbreviated as -m) to
git-am, which will then extract the message ID and append it to the
email commit log.

Signed-off-by: Avi Kivity <avi@cloudius-systems.com>
---

v4: adjust coding style
    recover message_id variable after a resumed git-am
    use sane_grep
    drop unneeded grep error handling

v3: remove bashism and unneeded quoting

v2: adjust to pass test suite (t5100)

 Documentation/git-am.txt |  6 ++++++
 builtin/mailinfo.c       |  2 +-
 git-am.sh                | 14 +++++++++++++-
 t/t5100/info0004         |  1 +
 t/t5100/info0005         |  1 +
 t/t5100/info0012         |  1 +
 6 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 9adce37..8a251a1 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 	 [--whitespace=3D<option>] [-C<n>] [-p<n>] [--directory=3D<dir>]
 	 [--exclude=3D<path>] [--include=3D<path>] [--reject] [-q | --quiet]
 	 [--[no-]scissors] [-S[<keyid>]] [--patch-format=3D<format>]
+	 [--message-id]
 	 [(<mbox> | <Maildir>)...]
 'git am' (--continue | --skip | --abort)
=20
@@ -121,6 +122,11 @@ default.   You can use `--no-utf8` to override thi=
s.
 	user to lie about the author date by using the same
 	value as the committer date.
=20
+-m::
+--message-id::
+	Extract the Message-Id: header from the e-mail and
+	append it to the commit message's tag stanza.
+
 --skip::
 	Skip the current patch.  This is only meaningful when
 	restarting an aborted patch.
diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index cf11c8d..f1e1fed 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -278,7 +278,7 @@ static void cleanup_space(struct strbuf *sb)
=20
 static void decode_header(struct strbuf *line);
 static const char *header[MAX_HDR_PARSED] =3D {
-	"From","Subject","Date",
+	"From","Subject","Date","Message-Id"
 };
=20
 static inline int cmp_header(const struct strbuf *line, const char *hd=
r)
diff --git a/git-am.sh b/git-am.sh
index ee61a77..fd0181f 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -39,6 +39,7 @@ committer-date-is-author-date    lie about committer =
date
 ignore-date     use current timestamp for author date
 rerere-autoupdate update the index with reused conflict resolution if =
possible
 S,gpg-sign?     GPG-sign commits
+m,message-id    copy the Message-Id: header to the commit's tag stanza
 rebasing*       (internal use for git-rebase)"
=20
 . git-sh-setup
@@ -371,7 +372,7 @@ split_patches () {
 prec=3D4
 dotest=3D"$GIT_DIR/rebase-apply"
 sign=3D utf8=3Dt keep=3D keepcr=3D skip=3D interactive=3D resolved=3D =
rebasing=3D abort=3D
-resolvemsg=3D resume=3D scissors=3D no_inbody_headers=3D
+resolvemsg=3D resume=3D scissors=3D no_inbody_headers=3D message_id=3D
 git_apply_opt=3D
 committer_date_is_author_date=3D
 ignore_date=3D
@@ -442,6 +443,8 @@ it will be removed. Please do not use it anymore."
 		gpg_sign_opt=3D-S ;;
 	--gpg-sign=3D*)
 		gpg_sign_opt=3D"-S${1#--gpg-sign=3D}" ;;
+	-m|--message-id)
+		message_id=3Dt ;;
 	--)
 		shift; break ;;
 	*)
@@ -565,6 +568,7 @@ Use \"git am --abort\" to remove it.")"
 	echo " $git_apply_opt" >"$dotest/apply-opt"
 	echo "$threeway" >"$dotest/threeway"
 	echo "$sign" >"$dotest/sign"
+	echo "$message_id" >"$dotest/message-id"
 	echo "$utf8" >"$dotest/utf8"
 	echo "$keep" >"$dotest/keep"
 	echo "$scissors" >"$dotest/scissors"
@@ -651,6 +655,10 @@ then
 else
 	SIGNOFF=3D
 fi
+if test "$(cat "$dotest/message-id")" =3D t
+then
+	message_id=3Dt
+fi
=20
 last=3D$(cat "$dotest/last")
 this=3D$(cat "$dotest/next")
@@ -757,6 +765,10 @@ To restore the original branch and stop patching r=
un \"\$cmdline --abort\"."
 		then
 			cat "$dotest/msg-clean"
 		fi
+		if test t =3D "$message_id"
+		then
+			sane_grep ^Message-Id: "$dotest/info"
+		fi
 		if test '' !=3D "$ADD_SIGNOFF"
 		then
 			echo "$ADD_SIGNOFF"
diff --git a/t/t5100/info0004 b/t/t5100/info0004
index 616c309..f7e2983 100644
--- a/t/t5100/info0004
+++ b/t/t5100/info0004
@@ -2,4 +2,5 @@ Author: YOSHIFUJI Hideaki / =E5=90=89=E8=97=A4=E8=8B=B1=
=E6=98=8E
 Email: yoshfuji@linux-ipv6.org
 Subject: GIT: Try all addresses for given remote name
 Date: Thu, 21 Jul 2005 09:10:36 -0400 (EDT)
+Message-Id: <20050721.091036.01119516.yoshfuji@linux-ipv6.org>
=20
diff --git a/t/t5100/info0005 b/t/t5100/info0005
index 46a46fc..592388f 100644
--- a/t/t5100/info0005
+++ b/t/t5100/info0005
@@ -2,4 +2,5 @@ Author: David K=C3=A5gedal
 Email: davidk@lysator.liu.se
 Subject: Fixed two bugs in git-cvsimport-script.
 Date: Mon, 15 Aug 2005 20:18:25 +0200
+Message-Id: <u5tacjjdpxq.fsf@lysator.liu.se>
=20
diff --git a/t/t5100/info0012 b/t/t5100/info0012
index ac1216f..b5d89a1 100644
--- a/t/t5100/info0012
+++ b/t/t5100/info0012
@@ -2,4 +2,5 @@ Author: Dmitriy Blinov
 Email: bda@mnsspb.ru
 Subject: =D0=98=D0=B7=D0=BC=D0=B5=D0=BD=D1=91=D0=BD =D1=81=D0=BF=D0=B8=
=D1=81=D0=BE=D0=BA =D0=BF=D0=B0=D0=BA=D0=B5=D1=82=D0=BE=D0=B2 =D0=BD=D0=
=B5=D0=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D1=8B=D1=85 =D0=B4=D0=BB=D1=
=8F =D1=81=D0=B1=D0=BE=D1=80=D0=BA=D0=B8
 Date: Wed, 12 Nov 2008 17:54:41 +0300
+Message-Id: <1226501681-24923-1-git-send-email-bda@mnsspb.ru>
=20
--=20
1.9.3
