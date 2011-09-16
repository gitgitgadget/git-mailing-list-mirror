From: Alexey Shumkin <zapped@mail.ru>
Subject: =?UTF-8?q?=5BPATCH=5D=20send-email=3A=20Honor=20multi-part=20email=20messages?=
Date: Sat, 17 Sep 2011 02:32:48 +0400
Message-ID: <1316212368-334-1-git-send-email-zapped@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alexey Shumkin <zapped@mail.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 17 00:33:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4gye-0001PB-9L
	for gcvg-git-2@lo.gmane.org; Sat, 17 Sep 2011 00:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449Ab1IPWde convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Sep 2011 18:33:34 -0400
Received: from smtp3.mail.ru ([94.100.176.131]:48995 "EHLO smtp3.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932426Ab1IPWdc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 18:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail;
	h=Sender:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From; bh=tDfhKcAD2PtulMcVdj97bK6L5zz2LNF78aQA18FA9zw=;
	b=u9g4qZODWUk2tMY5VQZ9J/EN7CtLzjqcFRtfKWMbzY+iBCMNlvOiSGevJ6zD8tPu1CkDJvSK83sKZ8d5oszAEf3KrIp26zK0n+NSUMWdSMeN1puCZm6Lwpjmu1i5PeiE;
Received: from [91.77.45.252] (port=35556 helo=zappedws)
	by smtp3.mail.ru with asmtp 
	id 1R4gyQ-0007Je-00; Sat, 17 Sep 2011 02:33:30 +0400
Received: from Alex by zappedws with local (Exim 4.76)
	(envelope-from <zapped@mail.ru>)
	id 1R4gxz-00006F-Vj; Sat, 17 Sep 2011 02:33:04 +0400
X-Mailer: git-send-email 1.7.6.3.4.gf71f
X-Spam: Not detected
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181563>

"git format-patch --attach/--inline" generates multi-part messages.
Every part of such messages can contain non-ASCII characters with its o=
wn
"Content-Type" and "Content-Transfer-Encoding" headers.
But git-send-mail script interprets a patch-file as one-part message
and does not recognize multi-part messages.
So already quoted printable email subject may be encoded as quoted prin=
table
again. Due to this bug email subject looks corrupted in email clients.

Signed-off-by: Alexey Shumkin <zapped@mail.ru>
---
 git-send-email.perl   |    5 +++
 t/t9001-send-email.sh |   66 +++++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 98ab33a..1abf4a4 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1403,12 +1403,17 @@ sub file_has_nonascii {
=20
 sub body_or_subject_has_nonascii {
 	my $fn =3D shift;
+	my $multipart =3D 0;
 	open(my $fh, '<', $fn)
 		or die "unable to open $fn: $!\n";
 	while (my $line =3D <$fh>) {
 		last if $line =3D~ /^$/;
+		if ($line =3D~ /^Content-Type:\s*multipart\/mixed.*$/) {
+			$multipart =3D 1;
+		}
 		return 1 if $line =3D~ /^Subject.*[^[:ascii:]]/;
 	}
+	return 0 if $multipart;
 	while (my $line =3D <$fh>) {
 		return 1 if $line =3D~ /[^[:ascii:]]/;
 	}
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 579ddb7..151ad35 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1168,4 +1168,70 @@ test_expect_success $PREREQ '--force sends cover=
 letter template anyway' '
 	test -n "$(ls msgtxt*)"
 '
=20
+test_expect_success $PREREQ 'setup multi-part message' '
+cat >multi-part-email-using-8bit <<EOF
+From fe6ecc66ece37198fe5db91fa2fc41d9f4fe5cc4 Mon Sep 17 00:00:00 2001
+Message-Id: <bogus-message-id@example.com>
+From: author@example.com
+Date: Sat, 12 Jun 2010 15:53:58 +0200
+Subject: [PATCH] =3D?UTF-8?q?=3DD0=3D94=3DD0=3DBE=3DD0=3DB1=3DD0=3DB0=3D=
D0=3DB2=3DD0=3DBB=3DD0=3DB5=3DD0=3DBD=3D20?=3D
+ =3D?UTF-8?q?=3DD1=3D84=3DD0=3DB0=3DD0=3DB9=3DD0=3DBB?=3D
+MIME-Version: 1.0
+Content-Type: multipart/mixed; boundary=3D"------------123"
+
+This is a multi-part message in MIME format.
+--------------1.7.6.3.4.gf71f
+Content-Type: text/plain; charset=3DUTF-8; format=3Dfixed
+Content-Transfer-Encoding: 8bit
+
+This is a message created with "git format-patch --attach=3D123"
+---
+ master   |    1 +
+ =D1=84=D0=B0=D0=B9=D0=BB |    1 +
+ 2 files changed, 2 insertions(+), 0 deletions(-)
+ create mode 100644 master
+ create mode 100644 =D1=84=D0=B0=D0=B9=D0=BB
+
+
+--------------123
+Content-Type: text/x-patch; name=3D"0001-.patch"
+Content-Transfer-Encoding: 8bit
+Content-Disposition: attachment; filename=3D"0001-.patch"
+
+diff --git a/master b/master
+new file mode 100644
+index 0000000..1f7391f
+--- /dev/null
++++ b/master
+@@ -0,0 +1 @@
++master
+diff --git a/=D1=84=D0=B0=D0=B9=D0=BB b/=D1=84=D0=B0=D0=B9=D0=BB
+new file mode 100644
+index 0000000..44e5cfe
+--- /dev/null
++++ b/=D1=84=D0=B0=D0=B9=D0=BB
+@@ -0,0 +1 @@
++=D1=81=D0=BE=D0=B4=D0=B5=D1=80=D0=B6=D0=B8=D0=BC=D0=BE=D0=B5 =D1=84=D0=
=B0=D0=B9=D0=BB=D0=B0
+
+--------------123--
+EOF
+'
+
+test_expect_success $PREREQ 'setup expect' '
+cat >expected <<EOF
+Subject: [PATCH] =3D?UTF-8?q?=3DD0=3D94=3DD0=3DBE=3DD0=3DB1=3DD0=3DB0=3D=
D0=3DB2=3DD0=3DBB=3DD0=3DB5=3DD0=3DBD=3D20?=3D =3D?UTF-8?q?=3DD1=3D84=3D=
D0=3DB0=3DD0=3DB9=3DD0=3DBB?=3D
+EOF
+'
+
+test_expect_success $PREREQ '--attach/--inline also treats subject' '
+	clean_fake_sendmail &&
+	echo bogus |
+	git send-email --from=3Dauthor@example.com --to=3Dnobody@example.com =
\
+			--smtp-server=3D"$(pwd)/fake.sendmail" \
+			--8bit-encoding=3DUTF-8 \
+			multi-part-email-using-8bit >stdout &&
+	grep "Subject" msgtxt1 >actual &&
+	test_cmp expected actual
+'
+
 test_done
--=20
1.7.6.3.4.gf71f
