From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/4] notes: refuse to append to non-blob notes
Date: Thu, 10 May 2012 21:05:01 +0700
Message-ID: <1336658701-9004-5-git-send-email-pclouds@gmail.com>
References: <1336482692-30729-1-git-send-email-pclouds@gmail.com>
 <1336658701-9004-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 16:09:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSU3c-0000AG-NV
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 16:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759684Ab2EJOJY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 May 2012 10:09:24 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58252 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759672Ab2EJOJV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 10:09:21 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so1953088pbb.19
        for <git@vger.kernel.org>; Thu, 10 May 2012 07:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=9N6D8F/sadskB1X0thaRKfwWpPbxeI3Z7D2zEjZoZFc=;
        b=oqe5/hHKuMdi49zV1yVJ9BE9de00TvvT9tLNRiicfUSE681Ktgr57SdAnsdKbTnRA+
         E2UepJOwWuxK1a+0205BiRpdq8jr2N4R1G62TWRq8xLaBjwfeg67983IJzA6LcaS3Ss1
         J16JXFbdXLmDXg1WVbj1a7yipCnVqMfyZVtGtNnGuXjkMfV8gO/489g03GOFEtipzgw9
         bQu6Li0JZI6rOnloe048Y0xcL2xYCkegowI8bPlVTGZKXBfWO/5EltbBGi9EBFZ8KeL7
         uERH7GSrFeap/71mbNXPTXMkoEnA5TxXO+zjSuCRxWRabKL8Zua/ThJrSgteh8XyQfxF
         n7Ew==
Received: by 10.68.228.2 with SMTP id se2mr20836340pbc.109.1336658961505;
        Thu, 10 May 2012 07:09:21 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.158])
        by mx.google.com with ESMTPS id va3sm5322441pbc.9.2012.05.10.07.09.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 May 2012 07:09:20 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 10 May 2012 21:05:40 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1336658701-9004-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197567>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/notes.c  |    5 ++++-
 t/t3301-notes.sh |    4 ++++
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 44fb8b6..d958618 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -204,8 +204,11 @@ static void create_note(const unsigned char *objec=
t, struct msg_arg *msg,
 		strbuf_grow(&(msg->buf), size + 1);
 		if (msg->buf.len && prev_buf && size)
 			strbuf_insert(&(msg->buf), 0, "\n", 1);
-		if (prev_buf && size)
+		if (prev_buf && size) {
+			if (type !=3D OBJ_BLOB)
+				die(_("note %s is not a blob"), sha1_to_hex(prev));
 			strbuf_insert(&(msg->buf), 0, prev_buf, size);
+		}
 		free(prev_buf);
 	}
=20
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 9104bf0..0dac1e9 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1240,4 +1240,8 @@ test_expect_success 'cannot edit non-blob notes' =
'
 	EDITOR=3Dcat test_must_fail git notes edit
 '
=20
+test_expect_success 'refuse to launch editor with existing non-blob no=
tes' '
+	EDITOR=3Dcat test_must_fail git notes append -m foo
+'
+
 test_done
--=20
1.7.8.36.g69ee2
