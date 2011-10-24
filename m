From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP 09/11] tree_entry_interesting: differentiate partial vs full match
Date: Mon, 24 Oct 2011 17:36:14 +1100
Message-ID: <1319438176-7304-10-git-send-email-pclouds@gmail.com>
References: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 08:39:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIECC-0000zZ-9m
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 08:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339Ab1JXGjg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Oct 2011 02:39:36 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44169 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990Ab1JXGjf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 02:39:35 -0400
Received: by ywm3 with SMTP id 3so1171804ywm.19
        for <git@vger.kernel.org>; Sun, 23 Oct 2011 23:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=QMywDykmEtzE9b8ZFfursIpiIzOPwErO+sBDJWMFoNw=;
        b=I43A3rkRgrYakw3imhF30tNm8ov4+AVPpff2GAcZIjDxM356rcmJJMHjQHfpAJ/iJU
         GtsTwjcFGNK7mG5gDXkuyXljplwJSborTrTXp3/PUBQ9aDn5EjZ22jWoxA0u3OzA9mej
         7HykwPz/I0yM5mlto5drFqXdEQhdqeGDeREZY=
Received: by 10.236.22.33 with SMTP id s21mr32516750yhs.70.1319438375092;
        Sun, 23 Oct 2011 23:39:35 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id i67sm23955746yhm.16.2011.10.23.23.39.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 23 Oct 2011 23:39:34 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 24 Oct 2011 17:37:52 +1100
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184162>

Up until now, for a/b pathspec, both paths a and a/b would return
entry_interesting. Make it return entry_matched for the latter.

This way if the caller follows up to "a", but decide to stop for some
reason, then it knows that "a" has not really matched the given
pathspec yet.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 tree-walk.c |   13 ++++++++-----
 tree-walk.h |    5 +++--
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 5e9c522..6e12f0f 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -616,19 +616,22 @@ enum interesting tree_entry_interesting(const str=
uct name_entry *entry,
 					    baselen - matchlen - 1,
 					    !!S_ISDIR(entry->mode),
 					    ps->max_depth) ?
-				entry_interesting : entry_not_interesting;
+				entry_matched : entry_not_interesting;
 		}
=20
 		/* Either there must be no base, or the base must match. */
 		if (baselen =3D=3D 0 || !strncmp(base_str, match, baselen)) {
 			if (match_entry(entry, pathlen,
 					match + baselen, matchlen - baselen,
-					&never_interesting))
-				return entry_interesting;
+					&never_interesting)) {
+				if (match[baselen + pathlen] =3D=3D '/')
+					return entry_interesting;
+				return entry_matched;
+			}
=20
 			if (item->use_wildcard) {
 				if (!fnmatch(match + baselen, entry->path, 0))
-					return entry_interesting;
+					return entry_matched;
=20
 				/*
 				 * Match all directories. We'll try to
@@ -654,7 +657,7 @@ match_wildcards:
=20
 		if (!fnmatch(match, base->buf + base_offset, 0)) {
 			strbuf_setlen(base, base_offset + baselen);
-			return entry_interesting;
+			return entry_matched;
 		}
 		strbuf_setlen(base, base_offset + baselen);
=20
diff --git a/tree-walk.h b/tree-walk.h
index 2bf0db9..a5f92fa 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -65,8 +65,9 @@ static inline int traverse_path_len(const struct trav=
erse_info *info, const stru
 enum interesting {
 	all_entries_not_interesting =3D -1, /* no, and no subsequent entries =
will be either */
 	entry_not_interesting =3D 0,
-	entry_interesting =3D 1,
-	all_entries_interesting =3D 2 /* yes, and all subsequent entries will=
 be */
+	entry_interesting =3D 1, /* a potential match, not not there yet  */
+	entry_matched =3D 2,
+	all_entries_interesting =3D 3 /* yes, and all subsequent entries will=
 be */
 };
=20
 extern enum interesting tree_entry_interesting(const struct name_entry=
 *,
--=20
1.7.3.1.256.g2539c.dirty
