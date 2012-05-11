From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 3/4] notes: refuse to edit non-blobs
Date: Fri, 11 May 2012 08:25:05 +0700
Message-ID: <1336699506-28388-4-git-send-email-pclouds@gmail.com>
References: <1336658701-9004-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 11 03:26:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSecy-00020h-UL
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 03:26:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757890Ab2EKB0g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 May 2012 21:26:36 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:65022 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757853Ab2EKB0f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 21:26:35 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so2400997dad.19
        for <git@vger.kernel.org>; Thu, 10 May 2012 18:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0PFIv3LDGrhon/0boEgF5qrxDTW49EZ6K2txsTh0ytc=;
        b=BRGlHGnuMHfZ0G7TJn5f3mNUzoe47wNcL5Q+8rdYB5HnxTUTUdasglOT63jWraBhh+
         /BZ24wK0yXwCUR9o27TI7UfAlELH9wQgKQhs/4jGuz7WUwl6Fl2HzZaP7zsTyZvZU4me
         7tSAzeV8NjyYDjF4xcKwo+mbLxknZPRDwY0i8VTDZxro50rgGboKVBJYuWwE8/2hr+rA
         f+/AIIdokOur+NshDkQEobwMYXZgq/QB33B7P4xkABOy00ed2UCnBPLxf0Y7NpusMvJ5
         B1zUH8tr4O6pYS4ze04d38JG1SHSW9S+bYgY3/ZNvHONWdSN2jjybFTZLG7bzVRqXqF6
         K3QA==
Received: by 10.68.190.129 with SMTP id gq1mr14528832pbc.40.1336699595350;
        Thu, 10 May 2012 18:26:35 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id mr2sm1369417pbb.65.2012.05.10.18.26.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 May 2012 18:26:34 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 11 May 2012 08:25:34 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1336658701-9004-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197652>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/notes.c  |    6 ++++--
 t/t3301-notes.sh |    4 ++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 2960535..44fb8b6 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -109,12 +109,14 @@ static int list_each_note(const unsigned char *ob=
ject_sha1,
 	return 0;
 }
=20
-static void write_note_data(int fd, const unsigned char *sha1)
+static void write_note_blob(int fd, const unsigned char *sha1)
 {
 	unsigned long size;
 	enum object_type type;
 	char *buf =3D read_sha1_file(sha1, &type, &size);
 	if (buf) {
+		if (type !=3D OBJ_BLOB)
+			die(_("note %s is not a blob"), sha1_to_hex(sha1));
 		if (size)
 			write_or_die(fd, buf, size);
 		free(buf);
@@ -178,7 +180,7 @@ static void create_note(const unsigned char *object=
, struct msg_arg *msg,
 		if (msg->given)
 			write_or_die(fd, msg->buf.buf, msg->buf.len);
 		else if (prev && !append_only)
-			write_note_data(fd, prev);
+			write_note_blob(fd, prev);
 		write_or_die(fd, note_template, strlen(note_template));
=20
 		write_commented_object(fd, object);
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index dd8675f..66cc872 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1236,4 +1236,8 @@ test_expect_success 'non-blobs notes are shown in=
 human-readable form' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'cannot edit non-blob notes' '
+	test_must_fail git notes edit
+'
+
 test_done
--=20
1.7.3.1.256.g2539c.dirty
