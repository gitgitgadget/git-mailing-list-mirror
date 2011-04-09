From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/5] Convert prefix_pathspec() to produce struct pathspec_item
Date: Sat,  9 Apr 2011 23:54:18 +0700
Message-ID: <1302368060-23827-4-git-send-email-pclouds@gmail.com>
References: <1302368060-23827-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Apr 09 18:55:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8bR8-0004pD-Mg
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 18:55:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754832Ab1DIQyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2011 12:54:53 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39895 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754329Ab1DIQyw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 12:54:52 -0400
Received: by mail-iw0-f174.google.com with SMTP id 34so4339826iwn.19
        for <git@vger.kernel.org>; Sat, 09 Apr 2011 09:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=eJVdH2RSYs5upSfR/RmY7MhqUpnupW+EWhURnjuaEYE=;
        b=dAoEgAo1W3H4RlNbAFjsg3iFhfK8c0f3IXtzdeXmXLMKPecDG4iDIyOAZwW3PeE9PR
         amzNM9X6F1qyvBti2HSkAckEr2klBKVjZnG1MqnfAvSt1uSnfE2AbzQ/gPWiGyBrKEdj
         hKb/84QhunekLK126WfHVheLxCPvy0wtrIUJI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=D86Eatw+ggKR4p+OExscp4FVHLf70wymDoBAlM3PzKtQypuiQe0+qOyJk6tGZskM8q
         ib29vNdre8miSRHtugnGfgewVBglKEgaDe7TTcn3FpCT7IivQznujMEdZKRZ44CAxMYr
         gXDb/nsMbPL6rYtUJmh1Ede31A0JHG5k3H5GY=
Received: by 10.42.135.193 with SMTP id q1mr2963396ict.41.1302368091999;
        Sat, 09 Apr 2011 09:54:51 -0700 (PDT)
Received: from tre ([115.73.238.90])
        by mx.google.com with ESMTPS id mv26sm2753603ibb.45.2011.04.09.09.54.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 09 Apr 2011 09:54:51 -0700 (PDT)
Received: by tre (sSMTP sendmail emulation); Sat, 09 Apr 2011 23:54:45 +0700
X-Mailer: git-send-email 1.7.4.74.g639db
In-Reply-To: <1302368060-23827-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171198>

New field plain_len is used to mark the first part of 'match' where no
magic can be applied.
---
 cache.h |    1 +
 setup.c |   26 ++++++++++++++++++--------
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index da1a46c..08b4633 100644
--- a/cache.h
+++ b/cache.h
@@ -528,6 +528,7 @@ struct pathspec {
 	struct pathspec_item {
 		const char *match;
 		int len;
+		int plain_len;	/* match[0..plain_len-1] does not have any kind of magic*/
 		unsigned magic;
 	} *items;
 };
diff --git a/setup.c b/setup.c
index 1e7dfb1..8a4a9d0 100644
--- a/setup.c
+++ b/setup.c
@@ -148,11 +148,12 @@ struct pathspec_magic {
  * the prefix part must always match literally, and a single stupid
  * string cannot express such a case.
  */
-const char *prefix_pathspec(const char *prefix, int prefixlen, const char *elt)
+int prefix_pathspec(struct pathspec_item *item,
+		    const char *prefix, int prefixlen,
+		    const char *elt)
 {
 	unsigned magic = 0;
 	const char *copyfrom = elt;
-	const char *retval;
 	int i, free_source = 0;
 
 	if (elt[0] != ':') {
@@ -184,7 +185,8 @@ const char *prefix_pathspec(const char *prefix, int prefixlen, const char *elt)
 			copyfrom++;
 	} else if (!elt[1]) {
 		/* Just ':' -- no element! */
-		return NULL;
+		memset(item, 0, sizeof(*item));
+		return -1;
 	} else {
 		/* shorthand */
 		for (copyfrom = elt + 1;
@@ -225,13 +227,19 @@ const char *prefix_pathspec(const char *prefix, int prefixlen, const char *elt)
 		}
 	}
 
+	memset(item, 0, sizeof(*item));
+	item->magic = magic;
+
 	if (magic & PATHSPEC_FROMTOP)
-		retval = xstrdup(copyfrom);
-	else
-		retval = prefix_path(prefix, prefixlen, copyfrom);
+		item->match = xstrdup(copyfrom);
+	else {
+		item->match = prefix_path(prefix, prefixlen, copyfrom);
+		item->plain_len = prefixlen;
+	}
+	item->len = strlen(item->match);
 	if (free_source)
 		free((char *)copyfrom);
-	return retval;
+	return 0;
 }
 
 const char **get_pathspec_old(const char *prefix, const char **pathspec)
@@ -255,7 +263,9 @@ const char **get_pathspec_old(const char *prefix, const char **pathspec)
 	dst = pathspec;
 	prefixlen = prefix ? strlen(prefix) : 0;
 	while (*src) {
-		*(dst++) = prefix_pathspec(prefix, prefixlen, *src);
+		struct pathspec_item item;
+		prefix_pathspec(&item, prefix, prefixlen, *src);
+		*(dst++) = item.match;
 		src++;
 	}
 	*dst = NULL;
-- 
1.7.4.74.g639db
