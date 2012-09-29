From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/3] grep: prepare for new header field filter
Date: Sat, 29 Sep 2012 11:41:27 +0700
Message-ID: <1348893689-20240-2-git-send-email-pclouds@gmail.com>
References: <7vr4pmm3qz.fsf@alter.siamese.dyndns.org>
 <1348893689-20240-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 29 06:49:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THozT-0007bo-6V
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 06:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899Ab2I2EtG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 Sep 2012 00:49:06 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38637 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556Ab2I2Es0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2012 00:48:26 -0400
Received: by pbbrr4 with SMTP id rr4so5926981pbb.19
        for <git@vger.kernel.org>; Fri, 28 Sep 2012 21:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=8NqZ7FnXZiYU3Au3rs9nwm19jbDldPZe1w6XQBOKCV8=;
        b=omrYhgKOOfNtAyJyKu957o2q9tGcIuj1rxqHrpcUujZJqdq2O3sHAKYE8o15dKrM98
         ubKQ2LD3BTJkQjz6g9yh3oucFMiJfQFX3fa1Z82tQgHDOB8ataYdHErLHPVo4sFeKPHY
         z/1AczwDNNPHDzKCi2UCZtp/5CfZKLbNbmf5CHznkymcsg8z0idXFxR8210/i+fW2/MO
         hdqbSzclE1xN1aCswyQetxZjCE9TYeIhRMityl9eZUBegfxXdPh0z9g2ypwoSkfBXow9
         HNG1mYYol6gyj9qcPvET6FRWwkqnKLerX9jDGK8z5cBVetU7wxtgZEnVdYB09hb/2cnp
         X9lg==
Received: by 10.68.189.70 with SMTP id gg6mr25640301pbc.125.1348894106083;
        Fri, 28 Sep 2012 21:48:26 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.51.2])
        by mx.google.com with ESMTPS id d9sm6602387paw.35.2012.09.28.21.48.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 28 Sep 2012 21:48:25 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 29 Sep 2012 11:41:37 +0700
X-Mailer: git-send-email 1.7.12.1.406.g6ab07c4
In-Reply-To: <1348893689-20240-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206620>

grep supports only author and committer headers, which have the same
special treatment that later headers may or may not have. Check for
field type and only strip_timestamp() when the field is either author
or committer.

GREP_HEADER_FIELD_MAX is put in the grep_header_field enum to be
calculated automatically, correctly, as long as it's at the end of the
enum.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 grep.c          |  9 ++++++++-
 grep.h          |  6 ++++--
 t/t7810-grep.sh | 12 ++++++++++++
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/grep.c b/grep.c
index 898be6e..8d73995 100644
--- a/grep.c
+++ b/grep.c
@@ -720,7 +720,14 @@ static int match_one_pattern(struct grep_pat *p, c=
har *bol, char *eol,
 		if (strncmp(bol, field, len))
 			return 0;
 		bol +=3D len;
-		saved_ch =3D strip_timestamp(bol, &eol);
+		switch (p->field) {
+		case GREP_HEADER_AUTHOR:
+		case GREP_HEADER_COMMITTER:
+			saved_ch =3D strip_timestamp(bol, &eol);
+			break;
+		default:
+			break;
+		}
 	}
=20
  again:
diff --git a/grep.h b/grep.h
index 8a28a67..d54adbe 100644
--- a/grep.h
+++ b/grep.h
@@ -29,9 +29,11 @@ enum grep_context {
=20
 enum grep_header_field {
 	GREP_HEADER_AUTHOR =3D 0,
-	GREP_HEADER_COMMITTER
+	GREP_HEADER_COMMITTER,
+
+	/* Must be at the end of the enum */
+	GREP_HEADER_FIELD_MAX
 };
-#define GREP_HEADER_FIELD_MAX (GREP_HEADER_COMMITTER + 1)
=20
 struct grep_pat {
 	struct grep_pat *next;
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 91db352..30eaa9a 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -628,6 +628,18 @@ test_expect_success 'log --all-match --grep --grep=
 --author takes intersection'
 	test_cmp expect actual
 '
=20
+test_expect_success 'log --author does not search in timestamp' '
+	: >expect &&
+	git log --author=3D"$GIT_AUTHOR_DATE" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --committer does not search in timestamp' '
+	: >expect &&
+	git log --committer=3D"$GIT_COMMITTER_DATE" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'grep with CE_VALID file' '
 	git update-index --assume-unchanged t/t &&
 	rm t/t &&
--=20
1.7.12.1.406.g6ab07c4
