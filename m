Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C5582D83
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803228; cv=none; b=Gy03UA/Ka+uxaDOr9V9pVj6zPfE4++zUyLKp5oQzgD7qRpD16rUmrXTvL73z6FXcuho48NlP/guQrxW4XYp9St8ibk+0ZvEk2HgM6ouJdfaHqz6rFSN2d0SD85PwkqcWlnqtV+abRGHmFG46mta1bYK8lbBAIDP2CL/T8ZVNr3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803228; c=relaxed/simple;
	bh=98qbewk4yJQQw7FLerZA4S0+D0u/XuiU1A5Fmw6oSvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsJFFfK0DECLEpoc43XBQRMs6kirouw1R9q0Wuhx2Q4q/GCTOgAwepenuDzsV73y1dgLGEXqdCRkgVv+pNJS6oTdidPFr71tcthYhOdu2eIYsMg+6FF/HhGuXIQTCPJmt76JI/KyaE64viX+U08rgbyXGvnO2KvJPDFHrnGTNAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 6897 invoked by uid 109); 7 Mar 2024 09:20:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Mar 2024 09:20:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12611 invoked by uid 111); 7 Mar 2024 09:20:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Mar 2024 04:20:30 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Mar 2024 04:20:24 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Manlio Perillo <manlio.perillo@gmail.com>
Subject: [PATCH 05/15] environment: store comment_line_char as a string
Message-ID: <20240307092024.GE2080210@coredump.intra.peff.net>
References: <20240307091407.GA2072522@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240307091407.GA2072522@coredump.intra.peff.net>

We'd like to eventually support multi-byte comment prefixes, but the
comment_line_char variable is referenced in many spots, making the
transition difficult.

Let's start by storing the character in a NUL-terminated string. That
will let us switch code over incrementally to the string format, and we
can easily support the existing code with a macro wrapper (since we'll
continue to allow only a single-byte prefix, this will behave
identically).

Once all references to the "char" variable have been converted, we can
drop it and enable longer strings.

We'll still have to touch all of the spots that create or set the
variable in this patch, but there are only a few (reading the config,
and the "auto" character selector).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/commit.c | 4 ++--
 config.c         | 2 +-
 environment.c    | 2 +-
 environment.h    | 3 ++-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d496980421..d8abbe48b1 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -685,7 +685,7 @@ static void adjust_comment_line_char(const struct strbuf *sb)
 	const char *p;
 
 	if (!memchr(sb->buf, candidates[0], sb->len)) {
-		comment_line_char = candidates[0];
+		comment_line_str = xstrfmt("%c", candidates[0]);
 		return;
 	}
 
@@ -706,7 +706,7 @@ static void adjust_comment_line_char(const struct strbuf *sb)
 	if (!*p)
 		die(_("unable to select a comment character that is not used\n"
 		      "in the current commit message"));
-	comment_line_char = *p;
+	comment_line_str = xstrfmt("%c", *p);
 }
 
 static void prepare_amend_commit(struct commit *commit, struct strbuf *sb,
diff --git a/config.c b/config.c
index 3cfeb3d8bd..e12ea68f24 100644
--- a/config.c
+++ b/config.c
@@ -1566,7 +1566,7 @@ static int git_default_core_config(const char *var, const char *value,
 		else if (!strcasecmp(value, "auto"))
 			auto_comment_line_char = 1;
 		else if (value[0] && !value[1]) {
-			comment_line_char = value[0];
+			comment_line_str = xstrfmt("%c", value[0]);
 			auto_comment_line_char = 0;
 		} else
 			return error(_("core.commentChar should only be one ASCII character"));
diff --git a/environment.c b/environment.c
index 90632a39bc..0a9f5db407 100644
--- a/environment.c
+++ b/environment.c
@@ -110,7 +110,7 @@ int protect_ntfs = PROTECT_NTFS_DEFAULT;
  * The character that begins a commented line in user-editable file
  * that is subject to stripspace.
  */
-char comment_line_char = '#';
+const char *comment_line_str = "#";
 int auto_comment_line_char;
 
 /* Parallel index stat data preload? */
diff --git a/environment.h b/environment.h
index e5351c9dd9..3496474cce 100644
--- a/environment.h
+++ b/environment.h
@@ -8,7 +8,8 @@ struct strvec;
  * The character that begins a commented line in user-editable file
  * that is subject to stripspace.
  */
-extern char comment_line_char;
+#define comment_line_char (comment_line_str[0])
+extern const char *comment_line_str;
 extern int auto_comment_line_char;
 
 /*
-- 
2.44.0.463.g71abcb3a9f

