From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/5] tree-walk: support negative pathspec
Date: Thu, 10 Mar 2011 10:13:35 +0700
Message-ID: <1299726819-5576-2-git-send-email-pclouds@gmail.com>
References: <1299726819-5576-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 10 04:15:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxWL8-0008Lm-0E
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 04:15:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715Ab1CJDO4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2011 22:14:56 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41493 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256Ab1CJDO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 22:14:56 -0500
Received: by ywj3 with SMTP id 3so484792ywj.19
        for <git@vger.kernel.org>; Wed, 09 Mar 2011 19:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=yItdGFXu7ddbjgLXMJyMutENdZXdmXLMojXXqP809TE=;
        b=ZF+ffDQvtawLafJD+BSwVRVeMAhROIDgI3ECFzbPsLhvxFEgH+ULSaqD/ydOZ44850
         QaFFfOFAuorCwFfXnSgK0O7FU1qztIm/mt5WCAXk519DkJ4yAB9/gYOFelIAdg1W8FXK
         IbU9u+NSJf7UMPPMltAQAvaXZRJDbPWuX1KdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=kNMEZfRVfg9ZWUji3pX2+I3eW8DQSbO5iLzHHHItUt7LIpoBJvrok3VHl0Qk5MYkLg
         qyB3n9q5Y4MTrAiSU01QynekuhJdekXp4LdvXxgjzaRCSBSO5/+O73tExlWugbkWWsa6
         /q1q3ljA3htTQyrwd8mt71SrhUPDS4cSJ7vrI=
Received: by 10.147.158.16 with SMTP id k16mr10903488yao.22.1299726895139;
        Wed, 09 Mar 2011 19:14:55 -0800 (PST)
Received: from pclouds@gmail.com ([118.69.34.31])
        by mx.google.com with ESMTPS id r8sm3249638ane.19.2011.03.09.19.14.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2011 19:14:54 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 10 Mar 2011 10:13:51 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1299726819-5576-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While the UI will be simple, where negative pathspecs are always
appended in the end, this could should be able to handle a mixed set
of negative and positive pathspecs (ie. overlapping must be handled
correctly).

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h     |    1 +
 tree-walk.c |   37 ++++++++++++++++++++++++++++---------
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/cache.h b/cache.h
index 08a9022..2189366 100644
--- a/cache.h
+++ b/cache.h
@@ -510,6 +510,7 @@ struct pathspec {
 		const char *match;
 		int len;
 		int has_wildcard:1;
+		int to_exclude:1;
 	} *items;
 };
=20
diff --git a/tree-walk.c b/tree-walk.c
index 322becc..acbee1b 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -560,6 +560,7 @@ int tree_entry_interesting(const struct name_entry =
*entry,
 	int i;
 	int pathlen, baselen =3D base->len - base_offset;
 	int never_interesting =3D ps->has_wildcard ? 0 : -1;
+	int all_interesting_ok =3D !ps->recursive || ps->max_depth =3D=3D -1;
=20
 	if (!ps->nr) {
 		if (!ps->recursive || ps->max_depth =3D=3D -1)
@@ -569,6 +570,19 @@ int tree_entry_interesting(const struct name_entry=
 *entry,
 				      ps->max_depth);
 	}
=20
+	/*
+	 * TODO: add prepare_pathspec() to scan for pathspecs
+	 * overlapped with negative ones. The ones that do not overlap
+	 * can still return 2.
+	 */
+	for (i =3D 0; i < ps->nr; i++) {
+		const struct pathspec_item *item =3D ps->items+i;
+		if (item->to_exclude) {
+			all_interesting_ok =3D 0;
+			break;
+		}
+	}
+
 	pathlen =3D tree_entry_len(entry->path, entry->sha1);
=20
 	for (i =3D ps->nr - 1; i >=3D 0; i--) {
@@ -578,17 +592,22 @@ int tree_entry_interesting(const struct name_entr=
y *entry,
 		int matchlen =3D item->len;
=20
 		if (baselen >=3D matchlen) {
+			int ret;
+
 			/* If it doesn't match, move along... */
 			if (!match_dir_prefix(base_str, baselen, match, matchlen))
 				goto match_wildcards;
=20
-			if (!ps->recursive || ps->max_depth =3D=3D -1)
+			if (all_interesting_ok)
 				return 2;
=20
-			return !!within_depth(base_str + matchlen + 1,
-					      baselen - matchlen - 1,
-					      !!S_ISDIR(entry->mode),
-					      ps->max_depth);
+			ret =3D !!within_depth(base_str + matchlen + 1,
+					     baselen - matchlen - 1,
+					     !!S_ISDIR(entry->mode),
+					     ps->max_depth);
+			if (item->to_exclude)
+				ret =3D !ret;
+			return ret;
 		}
=20
 		/* Does the base match? */
@@ -596,18 +615,18 @@ int tree_entry_interesting(const struct name_entr=
y *entry,
 			if (match_entry(entry, pathlen,
 					match + baselen, matchlen - baselen,
 					&never_interesting))
-				return 1;
+				return item->to_exclude ? 0 : 1;
=20
 			if (ps->items[i].has_wildcard) {
 				if (!fnmatch(match + baselen, entry->path, 0))
-					return 1;
+					return item->to_exclude ? 0 : 1;
=20
 				/*
 				 * Match all directories. We'll try to
 				 * match files later on.
 				 */
 				if (ps->recursive && S_ISDIR(entry->mode))
-					return 1;
+					return item->to_exclude ? 0 : 1;
 			}
=20
 			continue;
@@ -626,7 +645,7 @@ match_wildcards:
=20
 		if (!fnmatch(match, base->buf + base_offset, 0)) {
 			strbuf_setlen(base, base_offset + baselen);
-			return 1;
+			return item->to_exclude ? 0 : 1;
 		}
 		strbuf_setlen(base, base_offset + baselen);
=20
--=20
1.7.3.1.256.g2539c.dirty
