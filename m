Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D99C11181
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 01:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712451892; cv=none; b=MAtTDeskaj7WW8ZmMAUyM3ocwE/Ai3oIT6r1oRqnPamHGIrokFC/qfz49mbxmPx/jiuyCNzRB1ufkycAE+AW3zrGAavDRdAV0sdD+hk7YTSTjp7LsOz4VuwtFV6Qk4CVxqmgNKsx/2XHYrVciPeKBFSLclLWhGZSt3LBF5bByck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712451892; c=relaxed/simple;
	bh=vrPE1BYB2tZTQMsb8ePmXoAII92Tsf0g8/n2x0L0c4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9uDM71qNAnu+7U9+3HMZRSFg8Hz2W5Qz9exNScjesgtVJbNTP+VmT9i1ZDwY/QQtKeo4s5mcQ78biTDrb5agUbWn68l2bQTPuRwz+nT4kWgt4OJrYxVK2WMXshhtAwRc/P+2hvJbE5NE8US+80wBtldLnaEGeYnKHxQ3E1sCPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7398 invoked by uid 109); 7 Apr 2024 01:04:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 07 Apr 2024 01:04:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11271 invoked by uid 111); 7 Apr 2024 01:04:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Apr 2024 21:04:53 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Apr 2024 21:04:50 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH 10/11] userdiff: use git_config_string_dup() when we can
Message-ID: <20240407010450.GJ868358@coredump.intra.peff.net>
References: <20240407005656.GA436890@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240407005656.GA436890@coredump.intra.peff.net>

There are many uses of git_config_string() in the userdiff code which
have the usual "leak when we see the variable multiple times" problem.
We can fix many of these in the usual way by switching to the _dup()
variant.

But note there are some adjacent ones we cannot fix right now: funcname
patterns and word regexes default to string literals, and we can't use
those with our dup variant (which would try to free the literals). For
now let's convert what we can.

Signed-off-by: Jeff King <peff@peff.net>
---
 userdiff.c | 6 +++---
 userdiff.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index 92ef649c99..ba168f50b5 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -409,15 +409,15 @@ int userdiff_config(const char *k, const char *v)
 	if (!strcmp(type, "binary"))
 		return parse_tristate(&drv->binary, k, v);
 	if (!strcmp(type, "command"))
-		return git_config_string(&drv->external, k, v);
+		return git_config_string_dup(&drv->external, k, v);
 	if (!strcmp(type, "textconv"))
-		return git_config_string(&drv->textconv, k, v);
+		return git_config_string_dup(&drv->textconv, k, v);
 	if (!strcmp(type, "cachetextconv"))
 		return parse_bool(&drv->textconv_want_cache, k, v);
 	if (!strcmp(type, "wordregex"))
 		return git_config_string(&drv->word_regex, k, v);
 	if (!strcmp(type, "algorithm"))
-		return git_config_string(&drv->algorithm, k, v);
+		return git_config_string_dup(&drv->algorithm, k, v);
 
 	return 0;
 }
diff --git a/userdiff.h b/userdiff.h
index d726804c3e..7cae1f4da0 100644
--- a/userdiff.h
+++ b/userdiff.h
@@ -13,13 +13,13 @@ struct userdiff_funcname {
 
 struct userdiff_driver {
 	const char *name;
-	const char *external;
-	const char *algorithm;
+	char *external;
+	char *algorithm;
 	int binary;
 	struct userdiff_funcname funcname;
 	const char *word_regex;
 	const char *word_regex_multi_byte;
-	const char *textconv;
+	char *textconv;
 	struct notes_cache *textconv_cache;
 	int textconv_want_cache;
 };
-- 
2.44.0.872.g288abe5b5b

