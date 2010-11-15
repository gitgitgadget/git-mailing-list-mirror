From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/10] unpack-trees: add function to update ce_flags based on sparse patterns
Date: Mon, 15 Nov 2010 17:36:43 +0700
Message-ID: <1289817410-32470-4-git-send-email-pclouds@gmail.com>
References: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 15 11:39:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHwSz-0001rb-Kp
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 11:39:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075Ab0KOKjB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 05:39:01 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54021 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182Ab0KOKjA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 05:39:00 -0500
Received: by mail-pz0-f46.google.com with SMTP id 28so921988pzk.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 02:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=aZaAjJOrL0SWaAyxymlrFxQ9xrcTTVFXOYmfbAp4PhE=;
        b=Mc11idSJKEcln4YEGG3wF8aDlDimUhHCyXywANVI1vzflZn17ithcXkVRVGYnSYiL0
         /sevgv2qCR1QL4Ni1JryMGNPPeUkYAdkKb60V/4ZyNrfbKnNOTeQlGyPXPmSY+BE49BF
         1F9omUxTpA/Yck4JWZg5hvebhE2O1h/JMtfvY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=KuA78Ktk/LGMFsjSZ5vOx45uubEiu4x5pStNdLGeQbsJZx7EM70c+wx7c507/aO0Gx
         ekiwvwsO7Tii2A+cSB+/5mbdkwYd38zg1eCjB77ww2T4Ag22RsR9elLi+0ZLysqzSF1c
         7FDA/c2kR43myCOd6ZcdXw8UvHrcuUzY33YKc=
Received: by 10.142.134.16 with SMTP id h16mr4847552wfd.411.1289817540168;
        Mon, 15 Nov 2010 02:39:00 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.247.75])
        by mx.google.com with ESMTPS id w42sm8574643wfh.15.2010.11.15.02.38.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 02:38:59 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 15 Nov 2010 17:37:43 +0700
X-Mailer: git-send-email 1.7.3.2.210.g045198
In-Reply-To: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161480>

The function will reconstruct directory structure from index and feed
excluded_from_list() with proper dtype.

Another advantage over the old will_have_skip_worktree() is that when
a directory is matched or not matched, we can go ahead and set
ce_flags for all of its children without calling excluded_from_list()
again. The old solution requires one excluded_from_list() call per
index entry.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 unpack-trees.c |   88 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 88 insertions(+), 0 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 9acd9be..6c266ef 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -834,6 +834,94 @@ static int unpack_callback(int n, unsigned long ma=
sk, unsigned long dirmask, str
 	return mask;
 }
=20
+/*
+ * traverse the index, find every entry that matches according to
+ * o->el. Do "ce_flags &=3D ~clear_mask" on those entries. Return the
+ * number of traversed entries.
+ *
+ * If select_mask is non-zero, only entries whose ce_flags has on of
+ * those bits enabled are traversed.
+ */
+static int clear_ce_flags_1(struct cache_entry **cache, int nr,
+			    int prefix_len, int match_all,
+			    int select_mask, int clear_mask,
+			    struct unpack_trees_options *o)
+{
+	const char *name, *slash;
+	struct cache_entry *ce =3D cache[0];
+	const char *prefix =3D ce->name;
+	int processed, original_nr =3D nr;
+
+	if (prefix_len && !match_all) {
+		int dtype =3D DT_DIR;
+		static char path[PATH_MAX];
+		int pathlen =3D prefix_len - 1;
+		const char *basename;
+
+		memcpy(path, prefix, pathlen);
+		path[pathlen] =3D '\0';
+		basename =3D strrchr(path, '/');
+		basename =3D basename ? basename+1 : path;
+		switch (excluded_from_list(path, pathlen, basename, &dtype, o->el)) =
{
+		case 0:
+			while (nr && !strncmp(ce->name, prefix, prefix_len)) {
+				cache++;
+				ce =3D *cache;
+				nr--;
+			}
+			return original_nr - nr;
+		case 1:
+			match_all =3D 1;
+			break;
+		default:	/* case -1, undecided */
+			break;
+		}
+	}
+
+	while (nr) {
+		if (select_mask && !(ce->ce_flags & select_mask)) {
+			cache++;
+			ce =3D *cache;
+			nr--;
+			continue;
+		}
+
+		if (prefix_len && strncmp(ce->name, prefix, prefix_len))
+			break;
+
+		name =3D ce->name + prefix_len;
+		slash =3D strchr(name, '/');
+
+		/* no slash, this is a file */
+		if (!slash) {
+			int dtype =3D ce_to_dtype(ce);
+			if (match_all ||
+			    excluded_from_list(ce->name, ce_namelen(ce), name, &dtype, o->e=
l) > 0)
+				ce->ce_flags &=3D ~clear_mask;
+			cache++;
+			ce =3D *cache;
+			nr--;
+			continue;
+		}
+
+		/* has slash, this is a directory */
+		processed =3D clear_ce_flags_1(cache, nr,
+					     slash + 1 - ce->name, match_all,
+					     select_mask, clear_mask, o);
+		cache +=3D processed;
+		ce =3D *cache;
+		nr -=3D processed;
+	}
+	return original_nr - nr;
+}
+
+static int clear_ce_flags(struct cache_entry **cache, int nr,
+			    int select_mask, int clear_mask,
+			    struct unpack_trees_options *o)
+{
+	return clear_ce_flags_1(cache, nr, 0, 0, select_mask, clear_mask, o);
+}
+
 static void set_new_skip_worktree_1(struct unpack_trees_options *o)
 {
 	int i;
--=20
1.7.3.2.210.g045198
