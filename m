From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/11] show: use streaming interface for showing blobs
Date: Mon, 27 Feb 2012 14:55:09 +0700
Message-ID: <1330329315-11407-6-git-send-email-pclouds@gmail.com>
References: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 08:56:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1vRk-00076v-Pg
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 08:56:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165Ab2B0H4c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 02:56:32 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33496 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099Ab2B0H4b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 02:56:31 -0500
Received: by mail-pw0-f46.google.com with SMTP id up15so1787730pbc.19
        for <git@vger.kernel.org>; Sun, 26 Feb 2012 23:56:31 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.211.102 as permitted sender) client-ip=10.68.211.102;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.211.102 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.211.102])
        by 10.68.211.102 with SMTP id nb6mr37205808pbc.54.1330329391539 (num_hops = 1);
        Sun, 26 Feb 2012 23:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=V/cdTK26uRxRoxXNCPu3yX/hdTKY1UV027uGCy7yaTQ=;
        b=HjAQoAZIsi/M3r7scGr4UeVzrbDU9HDRhad2fnfzhVr6ZL2oDuEGjqW1vi3opfMAC7
         C5Te1QlEO/bXXV0W2B5iCEZ0mud9p/5hogr0Qv5fW3ep0yJYY3zfoglMXQhv7+YUBv1u
         n4Af7ol/LlrU0tBz04N7TUIz1QxxOaMbKEUsk=
Received: by 10.68.211.102 with SMTP id nb6mr31658017pbc.54.1330329391487;
        Sun, 26 Feb 2012 23:56:31 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id x8sm12051135pbr.11.2012.02.26.23.56.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 26 Feb 2012 23:56:30 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 27 Feb 2012 14:56:07 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191610>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/log.c    |    9 ++++++++-
 t/t1050-large.sh |    2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 7d1f6f8..4c4b17a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -386,13 +386,20 @@ static int show_object(const unsigned char *sha1,=
 int show_tag_object,
 {
 	unsigned long size;
 	enum object_type type;
-	char *buf =3D read_sha1_file(sha1, &type, &size);
+	char *buf;
 	int offset =3D 0;
=20
+	if (!show_tag_object) {
+		fflush(stdout);
+		return streaming_write_sha1(1, 0, sha1, OBJ_ANY, NULL);
+	}
+
+	buf =3D read_sha1_file(sha1, &type, &size);
 	if (!buf)
 		return error(_("Could not read object %s"), sha1_to_hex(sha1));
=20
 	if (show_tag_object)
+		assert(type =3D=3D OBJ_TAG);
 		while (offset < size && buf[offset] !=3D '\n') {
 			int new_offset =3D offset + 1;
 			while (new_offset < size && buf[new_offset++] !=3D '\n')
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 39a3e77..66acb3b 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -118,7 +118,7 @@ test_expect_success 'cat-file a large file' '
 	git cat-file blob :large1 >/dev/null
 '
=20
-test_expect_failure 'git-show a large file' '
+test_expect_success 'git-show a large file' '
 	git show :large1 >/dev/null
=20
 '
--=20
1.7.3.1.256.g2539c.dirty
