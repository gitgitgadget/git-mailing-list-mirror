Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7A11849
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 01:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712451663; cv=none; b=UIEMXbOrvhVSH8ro02UNtlsmR4jtUC6I4iyMovIrwbFcBpSh01grCHQB3K6mqpLwdXOzRxC0q+za81FOSH7ad+iGnS6LawVUWmSkQPfcDleLLfTw2xKa+6v3Ue7l/uYNelQJ/ZeKyG6D1sGQFgV29931E0/e6mZfACxxNVQMxFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712451663; c=relaxed/simple;
	bh=Leanzy9Bn6oeMEdNGetzQUHj6oNhvgRC5Mpbb6EWb2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHh9+hk4HueMpoiTUv4taSbu6EwPcQvDIDQjDYfrlwmUI1nvkvCERiy8fmw2vcEGrQF1HC/BeTKeuVS/zdExBK8KRUWbnGkUpNJyybePn+hF/r9MIMKWxv40PjBQ+qSasYwpx0MAtQfKl1S8o2I9NqeYRynlAKd28dd6XKT+6M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7309 invoked by uid 109); 7 Apr 2024 01:01:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 07 Apr 2024 01:01:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11235 invoked by uid 111); 7 Apr 2024 01:01:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 06 Apr 2024 21:01:03 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 6 Apr 2024 21:01:00 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH 04/11] config: use git_config_string_dup() for open-coded
 equivalents
Message-ID: <20240407010100.GD868358@coredump.intra.peff.net>
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

These are cases where the calling code does the exact same thing
git_config_string_dup() would do. We can shorten the code a bit by using
it.

Note in the final case that we rely on leaving the if-else chain to
return "0" for success, and now we'll return more directly. The two are
equivalent.

Signed-off-by: Jeff King <peff@peff.net>
---
 archive-tar.c  | 10 +++-------
 compat/mingw.c |  7 ++-----
 setup.c        |  5 +----
 3 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 8ae30125f8..6da7101553 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -393,13 +393,9 @@ static int tar_filter_config(const char *var, const char *value,
 		tar_filters[nr_tar_filters++] = ar;
 	}
 
-	if (!strcmp(type, "command")) {
-		if (!value)
-			return config_error_nonbool(var);
-		free(ar->filter_command);
-		ar->filter_command = xstrdup(value);
-		return 0;
-	}
+	if (!strcmp(type, "command"))
+		return git_config_string_dup(&ar->filter_command, var, value);
+
 	if (!strcmp(type, "remote")) {
 		if (git_config_bool(var, value))
 			ar->flags |= ARCHIVER_REMOTE;
diff --git a/compat/mingw.c b/compat/mingw.c
index 320fb99a90..aeccb3957f 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -255,11 +255,8 @@ int mingw_core_config(const char *var, const char *value,
 	}
 
 	if (!strcmp(var, "core.unsetenvvars")) {
-		if (!value)
-			return config_error_nonbool(var);
-		free(unset_environment_variables);
-		unset_environment_variables = xstrdup(value);
-		return 0;
+		return git_config_string_dup(&unset_environment_variables, var,
+					     value);
 	}
 
 	if (!strcmp(var, "core.restrictinheritedhandles")) {
diff --git a/setup.c b/setup.c
index 9f35a27978..7204fd2815 100644
--- a/setup.c
+++ b/setup.c
@@ -529,10 +529,7 @@ static int read_worktree_config(const char *var, const char *value,
 	if (strcmp(var, "core.bare") == 0) {
 		data->is_bare = git_config_bool(var, value);
 	} else if (strcmp(var, "core.worktree") == 0) {
-		if (!value)
-			return config_error_nonbool(var);
-		free(data->work_tree);
-		data->work_tree = xstrdup(value);
+		return git_config_string_dup(&data->work_tree, var, value);
 	}
 	return 0;
 }
-- 
2.44.0.872.g288abe5b5b

