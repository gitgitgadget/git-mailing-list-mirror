From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP 08/11] tree-walk: mark useful pathspecs
Date: Mon, 24 Oct 2011 17:36:13 +1100
Message-ID: <1319438176-7304-9-git-send-email-pclouds@gmail.com>
References: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 08:39:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIEC3-0000xX-Dl
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 08:39:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753326Ab1JXGj1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Oct 2011 02:39:27 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47409 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990Ab1JXGj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 02:39:26 -0400
Received: by gyb13 with SMTP id 13so5420704gyb.19
        for <git@vger.kernel.org>; Sun, 23 Oct 2011 23:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=MxQJnhZu6QtFwN+BalPYZ3hi59r3wqW0Ic5C+6dTS1Q=;
        b=IXeAduiexU5/ojVzplKLqw15ov8MKaWqsKWublFc5q2F8mMRx77OTq22OjXXsbrx9t
         lLtdX2RcHueqi20nXfmmsuJee5DPGHO8jg0eZO6s/a9K/P7X0XVtt6mq9aT0nmUPJRew
         5PbUGi9hPm98N5TNycWMpg0vHILF/Vabh3CiU=
Received: by 10.236.135.66 with SMTP id t42mr27071651yhi.31.1319438366278;
        Sun, 23 Oct 2011 23:39:26 -0700 (PDT)
Received: from pclouds@gmail.com (220-244-161-237.static.tpgi.com.au. [220.244.161.237])
        by mx.google.com with ESMTPS id c10sm30217609yhj.2.2011.10.23.23.39.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 23 Oct 2011 23:39:25 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 24 Oct 2011 17:37:43 +1100
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184161>

Useful pathspecs are those that help decide whether an item is in or
out, as opposed to useless ones whose existence does not change the
results.

Callers are responsible for cleaning before use, or doing anything
after.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 cache.h     |    1 +
 tree-walk.c |   13 ++++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index be07ec7..946d910 100644
--- a/cache.h
+++ b/cache.h
@@ -532,6 +532,7 @@ struct pathspec {
 		const char *match;
 		int len;
 		unsigned int use_wildcard:1;
+		unsigned int useful:1;
 	} *items;
 };
=20
diff --git a/tree-walk.c b/tree-walk.c
index 2d9d17a..5e9c522 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -595,11 +595,15 @@ enum interesting tree_entry_interesting(const str=
uct name_entry *entry,
 	pathlen =3D tree_entry_len(entry);
=20
 	for (i =3D ps->nr - 1; i >=3D 0; i--) {
-		const struct pathspec_item *item =3D ps->items+i;
+		struct pathspec_item *item =3D ps->items+i;
 		const char *match =3D item->match;
 		const char *base_str =3D base->buf + base_offset;
 		int matchlen =3D item->len;
=20
+		/* assume it will be used (which usually means break
+		   the loop and return), reset it otherwise */
+		item->useful =3D 1;
+
 		if (baselen >=3D matchlen) {
 			/* If it doesn't match, move along... */
 			if (!match_dir_prefix(base_str, match, matchlen))
@@ -634,12 +638,12 @@ enum interesting tree_entry_interesting(const str=
uct name_entry *entry,
 					return entry_interesting;
 			}
=20
-			continue;
+			goto nouse;
 		}
=20
 match_wildcards:
 		if (!item->use_wildcard)
-			continue;
+			goto nouse;
=20
 		/*
 		 * Concatenate base and entry->path into one and do
@@ -660,6 +664,9 @@ match_wildcards:
 		 */
 		if (ps->recursive && S_ISDIR(entry->mode))
 			return entry_interesting;
+
+nouse:
+		item->useful =3D 0;
 	}
 	return never_interesting; /* No matches */
 }
--=20
1.7.3.1.256.g2539c.dirty
