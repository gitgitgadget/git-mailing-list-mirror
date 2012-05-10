From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/4] notes: refuse to edit non-blobs
Date: Thu, 10 May 2012 21:05:00 +0700
Message-ID: <1336658701-9004-4-git-send-email-pclouds@gmail.com>
References: <1336482692-30729-1-git-send-email-pclouds@gmail.com>
 <1336658701-9004-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 16:09:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSU3b-0000AG-MH
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 16:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759667Ab2EJOJP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 May 2012 10:09:15 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58252 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759654Ab2EJOJM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 10:09:12 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so1953088pbb.19
        for <git@vger.kernel.org>; Thu, 10 May 2012 07:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=voVszlBFbLKoEz+9kO0VWtUWewSl/GYqyZPWgADJJAk=;
        b=obDKnaAFgNgKic2QL+mRZwAfQCNXnNrJ66Z4terGeFdIGEwD16n4/6/QzOboiRCea6
         6frDIr9/ewWq6yJiPmrYXSyalPedrPq3eMbKo0kokxYAV9/ek4XV0dJ6EDkbXI1mLiO5
         /odFrpI6Y8yaKX9lx5tpEWlamxhlRkZQsnumMms/I0GB8Zxsf9sYymf2o+dKFyTZHHr2
         ZlvV76MMGzcIr+8/QlaUXwSBiaeTbi+Z6/Yg7W4skieSjO2l9+c9weEG5ad9p3LbguUO
         BLfQmnn+UNeyOYLdq71B7DhBmSAduhTTnxLRVzkEdNZsdzCzEXwStf4c9s07E9Fk6cTg
         Ohvg==
Received: by 10.68.129.194 with SMTP id ny2mr20554388pbb.56.1336658952521;
        Thu, 10 May 2012 07:09:12 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.158])
        by mx.google.com with ESMTPS id uu3sm9613472pbc.70.2012.05.10.07.09.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 May 2012 07:09:11 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 10 May 2012 21:05:31 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1336658701-9004-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197568>


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
index add13bc..9104bf0 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1236,4 +1236,8 @@ test_expect_success 'non-blobs notes are shown in=
 human-readable form' '
 	test_cmp expected actual
 '
=20
+test_expect_success 'cannot edit non-blob notes' '
+	EDITOR=3Dcat test_must_fail git notes edit
+'
+
 test_done
--=20
1.7.8.36.g69ee2
