Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10939812
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 00:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712451515; cv=none; b=hhvryCmlYBG+W0Dv4KfZ9iVhSaHirCfa9zAZo8U248VXMaqwlhI+E5F07vrzeodv7BGnjxor+SfoRlL7wJa0igCKFQyDkuTcwey26unEy9CxSHQyyJwTMm/arHJctVxp5qadSmCSvLuurPxKCFdQZG/1uCDEzy8wTcEIJKCDTSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712451515; c=relaxed/simple;
	bh=rqVGd55dbd4HmjfQh20bnVInRKG1qk+lmsHWL5zDcHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dk/sDzI7RMaol7hlQmvGy0X/sI72Ilj8Q8GoK1ID1ZGqxYOxs1zHkowg9S7qAYgamaUM+5DhWxmirU8Gs5AwB8vEqPYoRxQQN3Z+OOwELvsQKXc5rWIhn0mDQZVfC+6X5PUe2KXY47fxJFCwmf9tB6SzMkUAEhX052BEz+HBGW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7267 invoked by uid 109); 7 Apr 2024 00:58:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 07 Apr 2024 00:58:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11184 invoked by uid 111); 7 Apr 2024 00:58:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Apr 2024 20:58:34 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Apr 2024 20:58:31 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH 01/11] config: make sequencer.c's git_config_string_dup()
 public
Message-ID: <20240407005831.GA868358@coredump.intra.peff.net>
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

Just about every caller of git_config_string() has a possible leak in
it: if we parse a config variable twice, it will overwrite the pointer
that was allocated the first time, leaving the memory unreferenced.

Unfortunately we can't just fix this directly in git_config_string().
Some callers do something like:

   const char *foo = "default_value";
   ...
   git_config_string(&foo, var, value);

And we must _not_ free that initial value, as it's a string literal. We
can't help those cases easily, as there's no way to distinguish a
heap-allocated variable from the default one. But let's start by at
least providing a helper that avoids the leak. That will let us convert
some cases right away, and give us one potential path forward for the
more complex ones.

It turns out we already have such a helper, courtesy of 03a4e260e2
(sequencer: plug memory leaks for the option values, 2016-10-21). The
problem is more acute in sequencer.c, which may load config multiple
times. Hence the solution was limited to that file back then. But this
really is a more general problem within our config callbacks.

Note that the new helper takes a "char *" rather than a const pointer.
This is more appropriate, since we tend to use "const" as a signal for
a lack of memory ownership (and this function is most certainly
asserting ownership over the pointed-to memory).

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c    |  9 +++++++++
 config.h    | 12 ++++++++++++
 sequencer.c | 10 ----------
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/config.c b/config.c
index eebce8c7e0..2194fb078a 100644
--- a/config.c
+++ b/config.c
@@ -1345,6 +1345,15 @@ int git_config_string(const char **dest, const char *var, const char *value)
 	return 0;
 }
 
+int git_config_string_dup(char **dest, const char *var, const char *value)
+{
+	if (!value)
+		return config_error_nonbool(var);
+	free(*dest);
+	*dest = xstrdup(value);
+	return 0;
+}
+
 int git_config_pathname(const char **dest, const char *var, const char *value)
 {
 	if (!value)
diff --git a/config.h b/config.h
index f4966e3749..cdffc14ccf 100644
--- a/config.h
+++ b/config.h
@@ -279,9 +279,21 @@ int git_config_bool(const char *, const char *);
 /**
  * Allocates and copies the value string into the `dest` parameter; if no
  * string is given, prints an error message and returns -1.
+ *
+ * Note that this function does _not_ free the memory referenced by the
+ * destination pointer. This makes it safe to use on a variable that initially
+ * points to a string literal, but it also means that it leaks if the config
+ * option is seen multiple times.
  */
 int git_config_string(const char **, const char *, const char *);
 
+/**
+ * Like git_config_string(), but frees any previously-allocated
+ * string at the destination pointer, avoiding a leak when a
+ * config variable is seen multiple times.
+ */
+int git_config_string_dup(char **, const char *, const char *);
+
 /**
  * Similar to `git_config_string`, but expands `~` or `~user` into the
  * user's home directory when found at the beginning of the path.
diff --git a/sequencer.c b/sequencer.c
index 2c19846385..3e5d82e0e5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2920,16 +2920,6 @@ static int read_populate_todo(struct repository *r,
 	return 0;
 }
 
-static int git_config_string_dup(char **dest,
-				 const char *var, const char *value)
-{
-	if (!value)
-		return config_error_nonbool(var);
-	free(*dest);
-	*dest = xstrdup(value);
-	return 0;
-}
-
 static int populate_opts_cb(const char *key, const char *value,
 			    const struct config_context *ctx,
 			    void *data)
-- 
2.44.0.872.g288abe5b5b

