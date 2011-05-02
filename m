From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/3] t3700: note a .gitignore matching fault
Date: Mon,  2 May 2011 19:47:42 +0700
Message-ID: <1304340464-14829-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: skillzero@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 02 14:50:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGsaM-0006Qj-Sm
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 14:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757546Ab1EBMum convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2011 08:50:42 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47106 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756303Ab1EBMul (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2011 08:50:41 -0400
Received: by pzk9 with SMTP id 9so3021642pzk.19
        for <git@vger.kernel.org>; Mon, 02 May 2011 05:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=zjeU+A0JooPSfB8XLE+k00pmo031yOSB2umxti7XpW0=;
        b=SWnO8WhGzjxJgpKvFdnLEoXsp1mGP41KJuxOCZExyndOM3I4oNBg5U7jMHpbimUgKx
         Uo69YaRtbvd4JK4JHoe1U7VJbjnOC2kkOecLia0AKR0YUv9sZjNq2dEWHMoKsqXUapx7
         603vIkHJ6AFgj7/gjmY1fpXZkB/2h+4gNWgx8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=dioHbHRaw6+acAYJHWCYwqRbtRFzEscw/sc4tIEY2lgRjLE6aZjC0FmhcDhRQsR5nx
         zSdGEH26kltmXhGbpzBrfEMkCFXiZ6X6HwbppUzHP3GujNlmAlL3XE0HcXeDmOOFwEcr
         USZG24oni0bb8QFE1belz+E1Z3Aoin5gx7JQs=
Received: by 10.142.195.17 with SMTP id s17mr3026987wff.257.1304340640643;
        Mon, 02 May 2011 05:50:40 -0700 (PDT)
Received: from pclouds@gmail.com ([115.73.248.91])
        by mx.google.com with ESMTPS id s7sm3805015pba.18.2011.05.02.05.50.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 02 May 2011 05:50:38 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 02 May 2011 19:47:46 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172579>

=2Egitignore support both positive and negative patterns. One may negat=
e
the other. Current code works well if both patterns target files in
the same directory.

When a pattern targets a directory and an opposite pattern targets
some files/directories within that directory, we need to descend in
the directory until we're clear which ones are matched and which are
not.

excluded_from_list() (or its callers) fails to handle this case. It
too eagerly decides the fate of the whole directory without looking
further in.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Haven't figured out how to cleanly fix this yet, unfortunately.

 t/t3700-add.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 7de42fa..6c3eed6 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -295,4 +295,20 @@ test_expect_success C_LOCALE_OUTPUT 'git add --dry=
-run --ignore-missing of non-e
 	test_cmp expect.err actual.err
 '
=20
+cat >expected <<EOF
+add 'test/.gitignore'
+add 'test/out/in'
+EOF
+
+test_expect_failure C_LOCALE_OUTPUT '' '
+	mkdir -p test/out &&
+	touch test/out/in test/out/out &&
+	cat >test/.gitignore <<EOF &&
+out
+!out/in
+EOF
+	git add --dry-run test >actual &&
+	test_cmp expected actual
+'
+
 test_done
--=20
1.7.4.74.g639db
