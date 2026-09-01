Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BB32F5498
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 06:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788244609; cv=none; b=fIQAH21j/s7jXxHNf4/uosrF4ot2tZBewxz6hPNeC6/+W93OnhonQzT+2HJ1WMNb8JbLgsh59qCXQZIbYJx0gCSgh97zK5AhDMCF/0JbULAPHYH8+D3gwfzCFDKSHy7GBxPYA8c+/SwcpkYpf4TrbxtEUr8/VLxWbIsKdVQyVUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788244609; c=relaxed/simple;
	bh=BuRZ+11AYO+5KhwkwGS6VHxlFBS6LOnA2YHB7PtdUk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jN5UOd1e+nbvTBhVQ92tKQS9pW7G7ufmWPmN6IbjGlteLSD9JwxL2VEb4nBX7Y/h9wYncdgDem1zFhujYVU3H7jHp7HiO8g4lJeML9WbmG2Z3aud34z3wz8TxXWe/G9wnD5ml8DsYp9DiGGuq5drP76/BCfW0lXcFMSA2zY7gAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VbFrCQSK; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VbFrCQSK"
Received: (qmail 7083 invoked by uid 106); 1 Sep 2026 06:36:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=BuRZ+11AYO+5KhwkwGS6VHxlFBS6LOnA2YHB7PtdUk0=; b=VbFrCQSKCORWTja98JIZzEZ1+LrfpRMg6draLqJMRgjrfuUYJNHqgy712R9SBXs54/+lrMJF5NfdcjiyWCX9YBfFka/4uXb8KlDT4gdbH/Rf4RtFJNGdcjcTCIFjP5Wl+NVsWdNBm3uo/ZH2k9t4PovjeHwYtn4TzytpRiWRnZNFLJ6qcQKJF2qqx/hde3W0Y3o5nOdUmk5C0qakLeA9PbTx7CxOi4elsca8ZH17GSOdDtnP/dTsIAOnv0GrCV2nZGje27wVniyQF8nG778gwxq4iLW8eUx2Z99zu5Y9POFAmgSGcDuqL16954JVnKA4rQB0SVmw0DmrZt2/nmpciQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Sep 2026 06:36:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 33902 invoked by uid 111); 1 Sep 2026 06:36:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Sep 2026 02:36:46 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 1 Sep 2026 02:36:45 -0400
From: Jeff King <peff@peff.net>
To: Nicolas Le Cam <niko.lecam@gmail.com>
Cc: git@vger.kernel.org
Subject: [PATCH 2/1] revision: simplify mark_argv_for_free() callers
Message-ID: <20260901063645.GA2951423@coredump.intra.peff.net>
References: <20260901062815.GC1075462@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260901062815.GC1075462@coredump.intra.peff.net>

BTW, this is a small cleanup that I resisted putting into the earlier
commit in order to keep it focused. But maybe worth doing on top?

-- >8 --
Subject: revision: simplify mark_argv_for_free() callers

You do not want to mark an argv element for freeing unless the caller
has given us the free_removed_argv_elements flag. Originally we just
called free() in this case, so each caller checked the flag itself. Now
that we mark them via a helper function, we can push the check down into
the helper. This saves a little bit of duplicated code, but also
hopefully makes the result conceptually simpler.

Every caller but one was already checking this flag. The exception is
setup_revisions_from_strvec(), but it always sets the flag explicitly
(since its whole purpose is managing argv memory). So even though it was
not checking the flag, doing so is OK (it will always be set).

Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/revision.c b/revision.c
index 7aee96bd8e..59d6372506 100644
--- a/revision.c
+++ b/revision.c
@@ -2317,8 +2317,11 @@ static timestamp_t parse_age(const char *arg)
  * usual const argv array, even when opt->free_removed_argv_elements is set).
  * We cast away the const on their behalf.
  */
-static void mark_argv_for_free(struct rev_info *revs, const char *str)
+static void mark_argv_for_free(const struct setup_revision_opt *opt,
+			       struct rev_info *revs, const char *str)
 {
+	if (!opt || !opt->free_removed_argv_elements)
+		return;
 	if (!str)
 		return;
 	strvec_push_nodup(&revs->argv_to_free, (char *)str);
@@ -2335,8 +2338,7 @@ static void overwrite_argv(int *argc, const char **argv,
 	 * cases around the free() and NULL operations.
 	 */
 	if (*value != argv[*argc]) {
-		if (opt && opt->free_removed_argv_elements)
-			mark_argv_for_free(revs, argv[*argc]);
+		mark_argv_for_free(opt, revs, argv[*argc]);
 		argv[*argc] = *value;
 		*value = NULL;
 	}
@@ -3055,8 +3057,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			const char *arg = argv[i];
 			if (strcmp(arg, "--"))
 				continue;
-			if (opt && opt->free_removed_argv_elements)
-				mark_argv_for_free(revs, argv[i]);
+			mark_argv_for_free(opt, revs, argv[i]);
 			argv[i] = NULL;
 			argc = i;
 			if (argv[i + 1])
@@ -3260,8 +3261,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	}
 
 	if (argv) {
-		if (opt && opt->free_removed_argv_elements)
-			mark_argv_for_free(revs, argv[left]);
+		mark_argv_for_free(opt, revs, argv[left]);
 		argv[left] = NULL;
 	}
 
@@ -3283,7 +3283,7 @@ void setup_revisions_from_strvec(struct strvec *argv, struct rev_info *revs,
 	ret = setup_revisions(argv->nr, argv->v, revs, opt);
 
 	for (size_t i = ret; i < argv->nr; i++)
-		mark_argv_for_free(revs, argv->v[i]);
+		mark_argv_for_free(opt, revs, argv->v[i]);
 	argv->nr = ret;
 }
 
-- 
2.55.0.1050.g5a46c03bac
