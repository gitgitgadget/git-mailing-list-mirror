From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 24/25] upload-pack: make check_reachable_object() return unreachable list if asked
Date: Thu,  4 Feb 2016 16:04:00 +0700
Message-ID: <1454576641-29615-25-git-send-email-pclouds@gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 10:06:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRFsG-0007zZ-7B
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 10:06:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965472AbcBDJGn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 04:06:43 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33963 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965548AbcBDJGd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 04:06:33 -0500
Received: by mail-pf0-f176.google.com with SMTP id o185so38458000pfb.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 01:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=dpYpa/gvF1bobGAoKSodRMXV9pNyBCTgo03eYTVkGgQ=;
        b=cf6iPA6N4y4MvAH7e8spVnfL6qQ1nTFyU9QxxlMUMmbbTQB1EJeg4aSxX0B3i9f5Hl
         4BR1A45bJayZTEHyndwV9G5JHnbzV8c9jf28bcN2IBuiItAOXO98wI9otMD0oWFguMdQ
         KlHXtlzVQ/VqSVp42za0BVGvcAU4KS86wmj5pyrYCIekZ1rnmoaByzGY+UoPFkXcTCK5
         uLnr2xw7LdKBiOV6Ae9Qj/qxeUcIFVZMK32ZL9ji3RkQswImQfC9flzArd8ECzSpJfCp
         CMxXxLCyXswR46+nOyOPZK9PwCgOQqGtgfS+mMYAh1OKECsUNJyh8jubt4HGmS5/xJtr
         NULQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=dpYpa/gvF1bobGAoKSodRMXV9pNyBCTgo03eYTVkGgQ=;
        b=g6ok2Y+qUUi6qtHnpaURC3iNB11c77Hl+d/lOjTugp3aMvyFEKF4HPeJ0kMOH1C7sq
         9OZNci1lUb1tqsdlydKM9NyNDRLz3q5ZHuOUJIcu1330SzqwMKzhWXFqrIgmkipla287
         sFwuJ2W6T70FwJUnFH/GlyL4NRs58tiunU7VNtA/ow5Uu9SxSWTCdNsA7+ZiUU3Wywfm
         lG4tTftykTgJdYQVL3x1bTMzaKMT8Nh6YHQwCHbrf6dffn6XasfWcbOlJvcEwhay9qxi
         BmBbND8zYhToxUh1dYtGMWtcYIJ00O88ZeDUzL2kIfvIBBAqd8Am0tMs/x03JflYRZ2b
         kpLw==
X-Gm-Message-State: AG10YOQ/pAxxnJNfxUD9m/EuSYTGjWAUSZY4Mw+21VMl2vSl9U7XdHcW9QzXQ9PTcfF2HA==
X-Received: by 10.98.86.8 with SMTP id k8mr9239116pfb.28.1454576793440;
        Thu, 04 Feb 2016 01:06:33 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id pu3sm15437418pac.9.2016.02.04.01.06.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2016 01:06:31 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 04 Feb 2016 16:06:45 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285437>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 object.h      |  2 +-
 upload-pack.c | 51 ++++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/object.h b/object.h
index f8b6442..614a006 100644
--- a/object.h
+++ b/object.h
@@ -31,7 +31,7 @@ struct object_array {
  * revision.h:      0---------10                                26
  * fetch-pack.c:    0---4
  * walker.c:        0-2
- * upload-pack.c:               11----------------19
+ * upload-pack.c:       4       11----------------19
  * builtin/blame.c:               12-13
  * bisect.c:                               16
  * bundle.c:                               16
diff --git a/upload-pack.c b/upload-pack.c
index a72ffc2..1270aa3 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -451,8 +451,16 @@ static int is_our_ref(struct object *o)
 			(ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1));
 	return o->flags & ((allow_hidden_ref ? HIDDEN_REF : 0) | OUR_REF);
 }
-
-static int check_unreachable(struct object_array *src)
+/*
+ * If reachable is NULL, return 1 if there is no unreachable object,
+ * zero otherwise.
+ *
+ * If reachable is not NULL, it's filled with reachable objects.
+ * Return value is irrelevant. The caller has to compare reachable and
+ * src to find out if there's any unreachable object.
+ */
+static int check_unreachable(struct object_array *reachable,
+			     struct object_array *src)
 {
 	static const char *argv[] =3D {
 		"rev-list", "--stdin", NULL,
@@ -484,6 +492,8 @@ static int check_unreachable(struct object_array *s=
rc)
 		o =3D get_indexed_object(--i);
 		if (!o)
 			continue;
+		if (reachable && o->type =3D=3D OBJ_COMMIT)
+			o->flags &=3D ~TMP_MARK;
 		if (!is_our_ref(o))
 			continue;
 		memcpy(namebuf + 1, oid_to_hex(&o->oid), GIT_SHA1_HEXSZ);
@@ -493,8 +503,13 @@ static int check_unreachable(struct object_array *=
src)
 	namebuf[40] =3D '\n';
 	for (i =3D 0; i < src->nr; i++) {
 		o =3D src->objects[i].item;
-		if (is_our_ref(o))
+		if (is_our_ref(o)) {
+			if (reachable)
+				add_object_array(o, NULL, reachable);
 			continue;
+		}
+		if (reachable && o->type =3D=3D OBJ_COMMIT)
+			o->flags |=3D TMP_MARK;
 		memcpy(namebuf, oid_to_hex(&o->oid), GIT_SHA1_HEXSZ);
 		if (write_in_full(cmd.in, namebuf, 41) < 0)
 			return 0;
@@ -507,9 +522,31 @@ static int check_unreachable(struct object_array *=
src)
 	 * The commits out of the rev-list are not ancestors of
 	 * our ref.
 	 */
-	i =3D read_in_full(cmd.out, namebuf, 1);
-	if (i)
-		return 0;
+	if (!reachable) {
+		i =3D read_in_full(cmd.out, namebuf, 1);
+		if (i)
+			return 0;
+	} else {
+		while ((i =3D read_in_full(cmd.out, namebuf, 41)) =3D=3D 41) {
+			struct object_id sha1;
+
+			if (namebuf[40] !=3D '\n' || get_oid_hex(namebuf, &sha1))
+				break;
+
+			o =3D lookup_object(sha1.hash);
+			if (o && o->type =3D=3D OBJ_COMMIT) {
+				o->flags &=3D ~TMP_MARK;
+			}
+		}
+		for (i =3D get_max_object_index(); 0 < i; ) {
+			o =3D get_indexed_object(--i);
+			if (o && o->type =3D=3D OBJ_COMMIT &&
+			    (o->flags & TMP_MARK)) {
+				add_object_array(o, NULL, reachable);
+				o->flags &=3D ~TMP_MARK;
+			}
+		}
+	}
 	close(cmd.out);
=20
 	/*
@@ -535,7 +572,7 @@ static void check_non_tip(void)
 	 */
 	if (!stateless_rpc && !(allow_unadvertised_object_request & ALLOW_REA=
CHABLE_SHA1))
 		;		/* error */
-	else if (check_unreachable(&want_obj))
+	else if (check_unreachable(NULL, &want_obj))
 		return;
=20
 	/* Pick one of them (we know there at least is one) */
--=20
2.7.0.377.g4cd97dd
