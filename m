Received: from mailproxy08.manitu.net (mailproxy08.manitu.net [217.11.48.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B9640626E
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 15:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.11.48.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538587; cv=none; b=Gxshwjo3YSBERyg9wuWHHJ4iEK4pyVpEoBaZS/GlDqsvv5iP0f4CCGA9I8K1nfMfmcE0q3lmj0pm/bWuqRgIeH3GUnKACUoUHPcp6BoQ08yhaw4wXFdEQiYl4KAOP2iTzsQ60e+vmv8z0tB/Df62LgsPaQsMc1WTJ7diMsiFTlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538587; c=relaxed/simple;
	bh=17YMchYaH5dP1h0/8dN8Dgp5nfF/lN3Ml7HWsUw1RfM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oDrV/S/HQHQ8KkWP00l4YVX+kIVPjy58n+9FELyGvCc+jLILfCaroU22EyaY8kpdRh7wlHlUwsQjL28fkw94uNWuK4dNMr5zcj5zAwJWhswKxfY0hir7Vx+UWPnx1Bq6sVPEzI6Z+cZ4rlU4BTqmn0PZchmGDKr7YQrpM1/dwH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grubix.eu; spf=pass smtp.mailfrom=grubix.eu; dkim=pass (2048-bit key) header.d=grubix.eu header.i=@grubix.eu header.b=xxVSfN5S; arc=none smtp.client-ip=217.11.48.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grubix.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grubix.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grubix.eu header.i=@grubix.eu header.b="xxVSfN5S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grubix.eu;
	s=manitu-webhosting; t=1774538579;
	bh=yZe4328eJy50x6LZ9HoqIurURM7R+p7M8+X+GmoBcHQ=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=xxVSfN5S/jKdqcppjdB8JaBkGlBvnt0uejiehm0USnZNzgv9pYagw5vb19OlTs7MK
	 eTalFSM13K+fD8vh1u+jCJukxAYHTZFeFDVsIgpFXbsRchVhOtiBRv+sH1tGI8iVxp
	 zuA4hjTgbCiwXXnxbspdcLzAvZT8UAOx4Mvg+fMu+83ksb/W4E+p02JVNB13kM9tQm
	 E7kYRbRUHnGHw1X6+xAYx3CVbySWig15/BRyGbG1bFccAkQK6inAkn9KOYvGONbFyl
	 PDbfaviV7tqpZf+2VZGuCYTfgC33UJo3areFprB9BIf4nOm0lltvBLSIDphOW6twC5
	 OFNpOZllFEb/A==
From: Michael J Gruber <git@grubix.eu>
To: git@vger.kernel.org
Subject: [PATCH 6/6] do not discard const: the ugly truth
Date: Thu, 26 Mar 2026 16:22:52 +0100
Message-ID: <fe9c86af4825a81b2618ae8ffc8be12300058af2.1774537954.git.git@grubix.eu>
In-Reply-To: <cover.1774537954.git.git@grubix.eu>
References: <cover.1774537954.git.git@grubix.eu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ISOC23 reveals that we mutate argv strings in place. Confess to this
with explicit casts.
---
 builtin/rev-parse.c | 8 ++++----
 revision.c          | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 01a62800e8..f429793b6f 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -265,7 +265,7 @@ static int show_file(const char *arg, int output_prefix)
 	return 0;
 }
 
-static int try_difference(const char *arg)
+static int try_difference(char *arg)
 {
 	char *dotdot;
 	struct object_id start_oid;
@@ -325,7 +325,7 @@ static int try_difference(const char *arg)
 	return 0;
 }
 
-static int try_parent_shorthands(const char *arg)
+static int try_parent_shorthands(char *arg)
 {
 	char *dotdot;
 	struct object_id oid;
@@ -1145,9 +1145,9 @@ int cmd_rev_parse(int argc,
 		}
 
 		/* Not a flag argument */
-		if (try_difference(arg))
+		if (try_difference((char *) arg))
 			continue;
-		if (try_parent_shorthands(arg))
+		if (try_parent_shorthands((char *) arg))
 			continue;
 		name = arg;
 		type = NORMAL;
diff --git a/revision.c b/revision.c
index 31808e3df0..a28b14a2ea 100644
--- a/revision.c
+++ b/revision.c
@@ -2132,7 +2132,7 @@ static int handle_dotdot(const char *arg,
 			 int cant_be_filename)
 {
 	struct object_context a_oc = {0}, b_oc = {0};
-	char *dotdot = strstr(arg, "..");
+	char *dotdot = (char *) strstr(arg, "..");
 	int ret;
 
 	if (!dotdot)
@@ -2176,7 +2176,7 @@ static int handle_revision_arg_1(const char *arg_, struct rev_info *revs, int fl
 		goto out;
 	}
 
-	mark = strstr(arg, "^@");
+	mark = (char *) strstr(arg, "^@");
 	if (mark && !mark[2]) {
 		*mark = 0;
 		if (add_parents_only(revs, arg, flags, 0)) {
@@ -2185,13 +2185,13 @@ static int handle_revision_arg_1(const char *arg_, struct rev_info *revs, int fl
 		}
 		*mark = '^';
 	}
-	mark = strstr(arg, "^!");
+	mark = (char *) strstr(arg, "^!");
 	if (mark && !mark[2]) {
 		*mark = 0;
 		if (!add_parents_only(revs, arg, flags ^ (UNINTERESTING | BOTTOM), 0))
 			*mark = '^';
 	}
-	mark = strstr(arg, "^-");
+	mark = (char *) strstr(arg, "^-");
 	if (mark) {
 		int exclude_parent = 1;
 
-- 
2.53.0.1195.g771ffcb452

