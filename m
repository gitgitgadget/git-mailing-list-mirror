From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] sha1_name: support sha1^{note} to return note sha-1
Date: Tue,  8 May 2012 20:14:30 +0700
Message-ID: <1336482870-30842-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 08 15:18:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRkIy-0000Vq-V8
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 15:18:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754383Ab2EHNSM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 09:18:12 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38565 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277Ab2EHNSK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 09:18:10 -0400
Received: by pbbrp8 with SMTP id rp8so8033725pbb.19
        for <git@vger.kernel.org>; Tue, 08 May 2012 06:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=ofozjXYgASVtBYBtvJw42eHmQnuEMZWFPh4sx+LGTvs=;
        b=m/q58/uaaZUWOBk7OMypncltIQUSFGhgl12YjRci4tKLiABVtE/MOmLuo1YjnhtmuU
         xX/JQlgWIhzUazzIyBqRV8ERwt8ZCAxkcDqzJP/PcLABOqrzoapLCrz5341npVyfo/eE
         ajGQTbEhzYolSelHiap471zULFVOL6gf1GkJ1N0ZGjObkyq6OUH9XMTWXYyQmP5mvZlw
         IGYvQBEciCnbhkfnGbm/58bPzbZvOh+uV5GFWQ9plx83BstNrc31H+04ZmHw6UynZYva
         t8ZWAFd3W9eQ0W0ngP17FDrWKVfp/25sE97Po884J1Pe3XXvsrGfTYl8z2+S65FawBJV
         D18w==
Received: by 10.68.132.35 with SMTP id or3mr5689526pbb.144.1336483090240;
        Tue, 08 May 2012 06:18:10 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.38.158])
        by mx.google.com with ESMTPS id nk2sm2356641pbc.54.2012.05.08.06.18.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 May 2012 06:18:09 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 08 May 2012 20:14:31 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197361>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 It may be useful for scripting, and looks nice. Though may be not
 worth adding if there are no actual users.

 Documentation/revisions.txt |    1 +
 sha1_name.c                 |   15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 1725661..5a671fe 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -114,6 +114,7 @@ the '$GIT_DIR/refs' directory or from the '$GIT_DIR=
/packed-refs' file.
   object of that type is found or the object cannot be
   dereferenced anymore (in which case, barf).  '<rev>{caret}0'
   is a short-hand for '<rev>{caret}\{commit\}'.
+  A special type "note" can be used to return the note object.
=20
 '<rev>{caret}\{\}', e.g. 'v0.99.8{caret}\{\}'::
   A suffix '{caret}' followed by an empty brace pair
diff --git a/sha1_name.c b/sha1_name.c
index c633113..02d28df 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -6,6 +6,7 @@
 #include "tree-walk.h"
 #include "refs.h"
 #include "remote.h"
+#include "notes.h"
=20
 static int get_sha1_oneline(const char *, unsigned char *, struct comm=
it_list *);
=20
@@ -473,7 +474,19 @@ static int peel_onion(const char *name, int len, u=
nsigned char *sha1)
 		expected_type =3D OBJ_NONE;
 	else if (sp[0] =3D=3D '/')
 		expected_type =3D OBJ_COMMIT;
-	else
+	else if (!strncmp("note}", sp, 5)) {
+		const unsigned char *note;
+		struct notes_tree t;
+		if (get_sha1_1(name, sp - name - 2, outer))
+			return -1;
+		memset(&t, 0, sizeof(t));
+		init_notes(&t, NULL, NULL, 0);
+		note =3D get_note(&t, outer);
+		if (note)
+			hashcpy(sha1, note);
+		free_notes(&t);
+		return note ? 0 : -1;
+	} else
 		return -1;
=20
 	if (get_sha1_1(name, sp - name - 2, outer))
--=20
1.7.8.36.g69ee2
