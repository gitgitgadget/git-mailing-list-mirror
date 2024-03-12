Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5B479B8D
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 09:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235049; cv=none; b=L4M0eVElUmvwcMXRjzSRotTfxLCFfLdcta6gc3RU0e3dDUT7+rRDL2nMjiIhsR0Wn5D4deEKOFg/WEC2klYO5WvpH2+TYYdAFyXnqUQbcjuk+9VhoRgnrzwLN2+agFz6/vVkuUGoPtYDcg2D8+V+giYGZK+MQyNeFCmtZ8x0wE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235049; c=relaxed/simple;
	bh=oK3fsY6r3C9akxd2KQJRp3QDpeiUExHCUbsm4tomJXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lu2hwmEO5bEkj+oVGRZ1cONfCozL1Zv4LllWp99Ey5Vj/dq2TfaW3IvPuuD8+twNkAHsQQ2ZNHCD3yEPk5dYUEIuDCcamlIKk7oPuMNQHO7tH4YS7XsHd5un0VAMAhR6QBrYAoTAyA2PEj3z1M+8dbEG6v7dEwFbQ5oqXpf+Spc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17534 invoked by uid 109); 12 Mar 2024 09:17:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Mar 2024 09:17:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28043 invoked by uid 111); 12 Mar 2024 09:17:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Mar 2024 05:17:30 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Mar 2024 05:17:24 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 06/16] environment: store comment_line_char as a string
Message-ID: <20240312091724.GF95609@coredump.intra.peff.net>
References: <20240312091013.GA95442@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240312091013.GA95442@coredump.intra.peff.net>

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
index b2d05c0cc9..82229c3100 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -686,7 +686,7 @@ static void adjust_comment_line_char(const struct strbuf *sb)
 	const char *p;
 
 	if (!memchr(sb->buf, candidates[0], sb->len)) {
-		comment_line_char = candidates[0];
+		comment_line_str = xstrfmt("%c", candidates[0]);
 		return;
 	}
 
@@ -707,7 +707,7 @@ static void adjust_comment_line_char(const struct strbuf *sb)
 	if (!*p)
 		die(_("unable to select a comment character that is not used\n"
 		      "in the current commit message"));
-	comment_line_char = *p;
+	comment_line_str = xstrfmt("%c", *p);
 }
 
 static void prepare_amend_commit(struct commit *commit, struct strbuf *sb,
diff --git a/config.c b/config.c
index f561631374..7e5dbca4bd 100644
--- a/config.c
+++ b/config.c
@@ -1568,7 +1568,7 @@ static int git_default_core_config(const char *var, const char *value,
 		else if (value[0] && !value[1]) {
 			if (value[0] == '\n')
 				return error(_("core.commentChar cannot be newline"));
-			comment_line_char = value[0];
+			comment_line_str = xstrfmt("%c", value[0]);
 			auto_comment_line_char = 0;
 		} else
 			return error(_("core.commentChar should only be one ASCII character"));
diff --git a/environment.c b/environment.c
index 60706ea398..a73ba9c12c 100644
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
index 5cec19cecc..1c7d0c2f74 100644
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
2.44.0.481.gf1a6d20963

