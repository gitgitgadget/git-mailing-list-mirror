From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] config: restructure format_config() for better control flow
Date: Thu, 20 Aug 2015 16:14:22 +0200
Message-ID: <1440080062-26811-1-git-send-email-szeder@ira.uka.de>
References: <xmqqa8twj7b8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 20 16:14:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSQcH-0003uu-Hu
	for gcvg-git-2@plane.gmane.org; Thu, 20 Aug 2015 16:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752820AbbHTOOt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2015 10:14:49 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:33418 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751690AbbHTOOs (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Aug 2015 10:14:48 -0400
Received: from x590d6ed3.dyn.telefonica.de ([89.13.110.211] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1ZSQc5-0007rs-QI; Thu, 20 Aug 2015 16:14:43 +0200
X-Mailer: git-send-email 2.5.0.415.g33d64ef
In-Reply-To: <xmqqa8twj7b8.fsf@gitster.dls.corp.google.com>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1440080083.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276242>

Commit 578625fa91 (config: add '--name-only' option to list only
variable names, 2015-08-10) modified format_config() such that it
returned from the middle of the function when showing only keys,
resulting in ugly code structure.

Reorganize the if statements and dealing with the key-value delimiter t=
o
make the function easier to read.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

> The topic is now in 'next'; I think I've locally fixed it up for
> these when I originally queued them a few days ago, so if there are
> any remaining issues, please throw incremental polishing patches.

OK, though it's not a major issue, I think this is still worth doing on
top.

 builtin/config.c | 78 +++++++++++++++++++++++++++---------------------=
--------
 1 file changed, 37 insertions(+), 41 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 631db458ec..810e104224 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -108,52 +108,48 @@ struct strbuf_list {
=20
 static int format_config(struct strbuf *buf, const char *key_, const c=
har *value_)
 {
-	int must_free_vptr =3D 0;
-	int must_print_delim =3D 0;
-	char value[256];
-	const char *vptr =3D value;
-
 	strbuf_init(buf, 0);
=20
-	if (show_keys) {
+	if (show_keys)
 		strbuf_addstr(buf, key_);
-		must_print_delim =3D 1;
-	}
-	if (omit_values) {
-		strbuf_addch(buf, term);
-		return 0;
-	}
-	if (types =3D=3D TYPE_INT)
-		sprintf(value, "%"PRId64,
-			git_config_int64(key_, value_ ? value_ : ""));
-	else if (types =3D=3D TYPE_BOOL)
-		vptr =3D git_config_bool(key_, value_) ? "true" : "false";
-	else if (types =3D=3D TYPE_BOOL_OR_INT) {
-		int is_bool, v;
-		v =3D git_config_bool_or_int(key_, value_, &is_bool);
-		if (is_bool)
-			vptr =3D v ? "true" : "false";
-		else
-			sprintf(value, "%d", v);
-	} else if (types =3D=3D TYPE_PATH) {
-		if (git_config_pathname(&vptr, key_, value_) < 0)
-			return -1;
-		must_free_vptr =3D 1;
-	} else if (value_) {
-		vptr =3D value_;
-	} else {
-		/* Just show the key name */
-		vptr =3D "";
-		must_print_delim =3D 0;
-	}
+	if (!omit_values) {
+		int must_free_vptr =3D 0;
+		int must_add_delim =3D show_keys;
+		char value[256];
+		const char *vptr =3D value;
=20
-	if (must_print_delim)
-		strbuf_addch(buf, key_delim);
-	strbuf_addstr(buf, vptr);
+		if (types =3D=3D TYPE_INT)
+			sprintf(value, "%"PRId64,
+				git_config_int64(key_, value_ ? value_ : ""));
+		else if (types =3D=3D TYPE_BOOL)
+			vptr =3D git_config_bool(key_, value_) ? "true" : "false";
+		else if (types =3D=3D TYPE_BOOL_OR_INT) {
+			int is_bool, v;
+			v =3D git_config_bool_or_int(key_, value_, &is_bool);
+			if (is_bool)
+				vptr =3D v ? "true" : "false";
+			else
+				sprintf(value, "%d", v);
+		} else if (types =3D=3D TYPE_PATH) {
+			if (git_config_pathname(&vptr, key_, value_) < 0)
+				return -1;
+			must_free_vptr =3D 1;
+		} else if (value_) {
+			vptr =3D value_;
+		} else {
+			/* Just show the key name */
+			vptr =3D "";
+			must_add_delim =3D 0;
+		}
+
+		if (must_add_delim)
+			strbuf_addch(buf, key_delim);
+		strbuf_addstr(buf, vptr);
+
+		if (must_free_vptr)
+			free((char *)vptr);
+	}
 	strbuf_addch(buf, term);
-
-	if (must_free_vptr)
-		free((char *)vptr);
 	return 0;
 }
=20
--=20
2.5.0.415.g33d64ef
