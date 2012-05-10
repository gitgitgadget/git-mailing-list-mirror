From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/4] notes: only append a blob to a blob
Date: Thu, 10 May 2012 21:43:35 +0700
Message-ID: <1336661015-14149-1-git-send-email-pclouds@gmail.com>
References: <1336658701-9004-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 16:47:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSUeQ-0005RG-KS
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 16:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759291Ab2EJOrZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 May 2012 10:47:25 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56609 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759259Ab2EJOrY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 10:47:24 -0400
Received: by dady13 with SMTP id y13so1798114dad.19
        for <git@vger.kernel.org>; Thu, 10 May 2012 07:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Wcrm/cY1+T/UGpp6YaPbenPTOI5sws4YQayRU0hebeE=;
        b=ILQR2ygteD3twxpR7NQLrjhGEWTwz4mXBzwQOyDvALb4Uf7B/N03WsDC+gIAODBFXc
         PHEO6frMjEfO/7d9C65pzJF8AdtV29L8vdISrUBdS4Z7HZhHZTD1DTAX9iWYxjoTFFW1
         ILfl6F7dVCLV2Y0avgBsBm0aTvgM3dVM7ivWHT2AtHwZ7E5PICzVZiRHXX3Oi1DLA3g1
         M1bh/dP/oRR++KbpR6ASNVV6gL/dcq4cXJfzUDrgAGWJM77C8zyCrBVfbsv9Su5bZBII
         3G+gI13HxH0QMJnUjhIHgEJan6A2Xy49KZFQWuX4Ghq+q+vl0p+gBUP3uJ/ke0LHiJIY
         b48Q==
Received: by 10.68.193.226 with SMTP id hr2mr20580978pbc.155.1336661244061;
        Thu, 10 May 2012 07:47:24 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.158])
        by mx.google.com with ESMTPS id py6sm9736169pbc.13.2012.05.10.07.47.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 May 2012 07:47:22 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 10 May 2012 21:43:42 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1336658701-9004-5-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197574>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On Thu, May 10, 2012 at 9:29 PM, Jeff King <peff@peff.net> wrote:
 > It's a little odd that we rewrite the object in the "-C" case at all=
; we
 > should never even need to open the object. I guess it is just to mak=
e
 > the code paths between "-c" and "-C" simpler.

 Yeah. It made me look again to see if that was true, and I found that
 my last patch was flawed. Reading object content in memory in "add
 -C" is nonsense, not so much in "append -C".

 builtin/notes.c  |   18 +++++++++++++++++-
 t/t3301-notes.sh |    6 ++++++
 2 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 44fb8b6..595bcc8 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -162,6 +162,18 @@ static void write_commented_object(int fd, const u=
nsigned char *object)
 		    sha1_to_hex(object));
 }
=20
+static const char *type_name(enum object_type type)
+{
+	switch (type) {
+	case OBJ_BLOB: return _("a blob");
+	case OBJ_TAG: return _("a tag");
+	case OBJ_COMMIT: return _("a commit");
+	case OBJ_TREE: return _("a tree");
+	default:
+		die("BUG: put a new string for type %d here", type);
+	}
+}
+
 static void create_note(const unsigned char *object, struct msg_arg *m=
sg,
 			int append_only, const unsigned char *prev,
 			unsigned char *result)
@@ -204,8 +216,12 @@ static void create_note(const unsigned char *objec=
t, struct msg_arg *msg,
 		strbuf_grow(&(msg->buf), size + 1);
 		if (msg->buf.len && prev_buf && size)
 			strbuf_insert(&(msg->buf), 0, "\n", 1);
-		if (prev_buf && size)
+		if (prev_buf && size) {
+			if (type !=3D OBJ_BLOB || msg->type !=3D OBJ_BLOB)
+				die(_("cannot append %s to %s"),
+				    type_name(type), type_name(msg->type));
 			strbuf_insert(&(msg->buf), 0, prev_buf, size);
+		}
 		free(prev_buf);
 	}
=20
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 9104bf0..9b17e56 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1240,4 +1240,10 @@ test_expect_success 'cannot edit non-blob notes'=
 '
 	EDITOR=3Dcat test_must_fail git notes edit
 '
=20
+test_expect_success 'refuse to concatenate two notes of different type=
' '
+	EDITOR=3Dcat test_must_fail git notes append -m foo &&
+	git notes add -f -m foo &&
+	EDITOR=3Dcat test_must_fail git notes append -C HEAD^{tree}
+'
+
 test_done
--=20
1.7.8.36.g69ee2
