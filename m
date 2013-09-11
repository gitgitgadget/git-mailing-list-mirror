From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 17/21] unpack-objects: allow to save processed bytes to a buffer
Date: Wed, 11 Sep 2013 13:06:18 +0700
Message-ID: <1378879582-15372-18-git-send-email-pclouds@gmail.com>
References: <xmqqtxhswexg.fsf@gitster.dls.corp.google.com>
 <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 11 08:09:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJdbv-0007O4-1Y
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 08:09:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946Ab3IKGJB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Sep 2013 02:09:01 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:44337 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251Ab3IKGJA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 02:09:00 -0400
Received: by mail-pa0-f47.google.com with SMTP id kl13so8800480pab.34
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 23:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=+Ts+zVB+cmHhTOFl8l3BFd7k9fGBCkoOasNSB7GsivQ=;
        b=gwBDUz/NrnFH0eAiPqK3hec33fa0TiaQd3gxnO4Xhrl7WYW/cwt51VXt8hbdCbezOo
         51w5jmtnclg0feqo3rgafCdArdhALXfXOVwbFXCeWDs0q1ut12XpRIfcbEh+WguW5lkl
         +3ewg/3djKUC/J+SL6nQSzJrSdiOUw9r6fbh748rh0N2IwlZNoiXuAALlHIRdpi1pBkj
         6CeRfdW9O1puK/5NKAfjV41Fl1vMg3fiQlvIrOhHdjunnhOr/lMOrAD6/lu65PxwtvAw
         4gEI3FrR1EL2290KP7PNbgWCcPRFHZMPwPkRjQY5pQ7JbLqJBXljd0SKaDpRHFD4p065
         joqA==
X-Received: by 10.66.251.1 with SMTP id zg1mr1736732pac.160.1378879740010;
        Tue, 10 Sep 2013 23:09:00 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPSA id ht5sm27444238pbb.29.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 23:08:59 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 11 Sep 2013 13:08:52 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1378879582-15372-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234541>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/unpack-objects.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 6fc72c1..044a087 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -54,6 +54,9 @@ static void add_object_buffer(struct object *object, =
char *buffer, unsigned long
 		die("object %s tried to add buffer twice!", sha1_to_hex(object->sha1=
));
 }
=20
+static struct strbuf back_buffer =3D STRBUF_INIT;
+static int save_to_back_buffer;
+
 /*
  * Make sure at least "min" bytes are available in the buffer, and
  * return the pointer to the buffer.
@@ -66,6 +69,8 @@ static void *fill(int min)
 		die("cannot fill %d bytes", min);
 	if (offset) {
 		git_SHA1_Update(&ctx, buffer, offset);
+		if (save_to_back_buffer)
+			strbuf_add(&back_buffer, buffer, offset);
 		memmove(buffer, buffer + offset, len);
 		offset =3D 0;
 	}
@@ -81,6 +86,18 @@ static void *fill(int min)
 	return buffer;
 }
=20
+static void copy_back_buffer(int set)
+{
+	if (offset) {
+		git_SHA1_Update(&ctx, buffer, offset);
+		if (save_to_back_buffer)
+			strbuf_add(&back_buffer, buffer, offset);
+		memmove(buffer, buffer + offset, len);
+		offset =3D 0;
+	}
+	save_to_back_buffer =3D set;
+}
+
 static void use(int bytes)
 {
 	if (bytes > len)
--=20
1.8.2.82.gc24b958
