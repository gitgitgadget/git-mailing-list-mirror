From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/6] Convert prefix_pathspec() to produce struct pathspec_item
Date: Wed, 12 Oct 2011 09:44:40 +1100
Message-ID: <1318373083-13840-4-git-send-email-pclouds@gmail.com>
References: <1318373083-13840-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 12 00:45:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDl4e-0006tI-Jv
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 00:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751612Ab1JKWpS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Oct 2011 18:45:18 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:35345 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490Ab1JKWpR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 18:45:17 -0400
Received: by mail-vx0-f174.google.com with SMTP id gb30so85726vcb.19
        for <git@vger.kernel.org>; Tue, 11 Oct 2011 15:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=IYaO46pfsLXJsQPxsbhNOoK8CCrcKszGv52RKgENTkM=;
        b=WbA8FEjBr5GiSVE3agkOsKxSfzFku5t11TRSB7wAj1bS82FuGZhlxD+LQbxxReRxaS
         PonYrDX2w7hwS83lxkg8TNZTS7IAhPssU604ZpnQavnsfYXc/8xmFxGAZMCBbLRp4j6s
         tnEvtLL1xWvvFW45irBeSj06SIPP+rkumNPkY=
Received: by 10.52.37.72 with SMTP id w8mr20637407vdj.32.1318373117417;
        Tue, 11 Oct 2011 15:45:17 -0700 (PDT)
Received: from pclouds@gmail.com (dektec3.lnk.telstra.net. [165.228.202.174])
        by mx.google.com with ESMTPS id hl5sm153865vdb.18.2011.10.11.15.45.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Oct 2011 15:45:16 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 12 Oct 2011 09:45:10 +1100
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
In-Reply-To: <1318373083-13840-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183337>

New field plain_len is used to mark the first part of 'match' where no
magic can be applied. It's not used though. tree_entry_interesting()
should learn to utilize it.

Now we can show get_pathspec() what magic a pathspec has. Make sure
only certain magic is accepted because more will come in future and
not all of them can be converted to plain string like
PATHSPEC_FROMTOP.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 match_pathspec_depth() should also check for unsupported magic..

 cache.h |    1 +
 setup.c |   22 +++++++++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index fe46f1e..17df06f 100644
--- a/cache.h
+++ b/cache.h
@@ -548,6 +548,7 @@ struct pathspec {
 	struct pathspec_item {
 		const char *match;
 		int len;
+		int plain_len;	/* match[0..plain_len-1] does not have any kind of ma=
gic*/
 		unsigned magic;
 	} *items;
 };
diff --git a/setup.c b/setup.c
index 35db910..8f1c2c0 100644
--- a/setup.c
+++ b/setup.c
@@ -126,7 +126,8 @@ static struct pathspec_magic {
  * the prefix part must always match literally, and a single stupid
  * string cannot express such a case.
  */
-static const char *prefix_pathspec(const char *prefix, int prefixlen, =
const char *elt)
+static const char *prefix_pathspec(struct pathspec_item *item, const c=
har *prefix,
+				   int prefixlen, const char *elt)
 {
 	unsigned magic =3D 0;
 	const char *copyfrom =3D elt;
@@ -181,10 +182,17 @@ static const char *prefix_pathspec(const char *pr=
efix, int prefixlen, const char
 			copyfrom++;
 	}
=20
+	memset(item, 0, sizeof(*item));
+	item->magic =3D magic;
+
 	if (magic & PATHSPEC_FROMTOP)
-		return xstrdup(copyfrom);
-	else
-		return prefix_path(prefix, prefixlen, copyfrom);
+		item->match =3D xstrdup(copyfrom);
+	else {
+		item->match =3D prefix_path(prefix, prefixlen, copyfrom);
+		item->plain_len =3D prefixlen;
+	}
+	item->len =3D strlen(item->match);
+	return 0;
 }
=20
 const char **get_pathspec(const char *prefix, const char **pathspec)
@@ -208,7 +216,11 @@ const char **get_pathspec(const char *prefix, cons=
t char **pathspec)
 	dst =3D pathspec;
 	prefixlen =3D prefix ? strlen(prefix) : 0;
 	while (*src) {
-		*(dst++) =3D prefix_pathspec(prefix, prefixlen, *src);
+		struct pathspec_item item;
+		prefix_pathspec(&item, prefix, prefixlen, *src);
+		if (item.magic & ~PATHSPEC_FROMTOP)
+			die("Unsupported magic pathspec %s", *src);
+		*(dst++) =3D item.match;
 		src++;
 	}
 	*dst =3D NULL;
--=20
1.7.3.1.256.g2539c.dirty
