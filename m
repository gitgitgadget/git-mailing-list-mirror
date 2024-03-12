Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86317CF0D
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710235073; cv=none; b=sz9sNYDtbBHL8wQknAqShM5KI2kxpRXYaPAb5ezwyJMIEEI6LLvx6fOBfK6KZl8tstvKhaLuNK02ARofOU7xUws9nrldbMUp5USZrWRcjnlksKA7CEZez87boTl8Z9VsqSySaFHozEIJKeSK3GLbEBmZkLxP9hnpwgxSg3Ps8qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710235073; c=relaxed/simple;
	bh=W2X2wQciIpkIp04Cl9A9H8wLP75DFSRAktUZyFd8CTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMOjcXUwgjeW3J1UtG9sJrmdUoL6h6ilEFN8a5KqgK/+Iy8oizGrLkX4frLItRC8O9GeJjOAVeBhGflknhOi7zr+Map5/iR4bpRaV7sZNr2obw1jYZQHhRH1UqPXpzydZjzS0XxA4EmvwT45KUH6nA18Pi4o3MFpbBSTN1IEKLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17747 invoked by uid 109); 12 Mar 2024 09:17:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Mar 2024 09:17:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28135 invoked by uid 111); 12 Mar 2024 09:17:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Mar 2024 05:17:55 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Mar 2024 05:17:50 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 16/16] config: allow multi-byte core.commentChar
Message-ID: <20240312091750.GP95609@coredump.intra.peff.net>
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

Now that all of the code handles multi-byte comment characters, it's
safe to allow users to set them.

There is one special case I kept: we still will not allow an empty
string for the commentChar. While it might make sense in some contexts
(e.g., output where you don't want any comment prefix), there are plenty
where it will behave badly (e.g., all of our starts_with() checks will
indicate that every line is a comment!). It might be reasonable to
assign some meaningful semantics, but it would probably involve checking
how each site behaves. In the interim let's forbid it and we can loosen
things later.

Likewise, the "commentChar cannot be a newline" rule is now extended to
"it cannot contain a newline" (for the same reason: it can confuse our
parsing loops).

Since comment_line_str is used in many parts of the code, it's hard to
cover all possibilities with tests. We can convert the existing
double-semicolon prefix test to show that "git status" works. And we'll
give it a more challenging case in t7507, where we confirm that
git-commit strips out the commit template along with any --verbose text
when reading the edited commit message back in. That covers the basics,
though it's possible there could be issues in more exotic spots (e.g.,
the sequencer todo list uses its own code).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config/core.txt |  4 +++-
 config.c                      | 10 +++++-----
 t/t0030-stripspace.sh         |  7 ++++++-
 t/t7507-commit-verbose.sh     | 10 ++++++++++
 t/t7508-status.sh             |  4 +++-
 5 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 0e8c2832bf..c86b8c8408 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -523,7 +523,9 @@ core.commentChar::
 	Commands such as `commit` and `tag` that let you edit
 	messages consider a line that begins with this character
 	commented, and removes them after the editor returns
-	(default '#').
+	(default '#'). Note that this option can take values larger than
+	a byte (whether a single multi-byte character, or you
+	could even go wild with a multi-character sequence).
 +
 If set to "auto", `git-commit` would select a character that is not
 the beginning character of any line in existing commit messages.
diff --git a/config.c b/config.c
index 7e5dbca4bd..92c752ed9f 100644
--- a/config.c
+++ b/config.c
@@ -1565,13 +1565,13 @@ static int git_default_core_config(const char *var, const char *value,
 			return config_error_nonbool(var);
 		else if (!strcasecmp(value, "auto"))
 			auto_comment_line_char = 1;
-		else if (value[0] && !value[1]) {
-			if (value[0] == '\n')
-				return error(_("core.commentChar cannot be newline"));
-			comment_line_str = xstrfmt("%c", value[0]);
+		else if (value[0]) {
+			if (strchr(value, '\n'))
+				return error(_("core.commentChar cannot contain newline"));
+			comment_line_str = xstrdup(value);
 			auto_comment_line_char = 0;
 		} else
-			return error(_("core.commentChar should only be one ASCII character"));
+			return error(_("core.commentChar must have at least one character"));
 		return 0;
 	}
 
diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
index e399dd9189..a161faf702 100755
--- a/t/t0030-stripspace.sh
+++ b/t/t0030-stripspace.sh
@@ -403,7 +403,12 @@ test_expect_success 'strip comments with changed comment char' '
 
 test_expect_success 'newline as commentchar is forbidden' '
 	test_must_fail git -c core.commentChar="$LF" stripspace -s 2>err &&
-	grep "core.commentChar cannot be newline" err
+	grep "core.commentChar cannot contain newline" err
+'
+
+test_expect_success 'empty commentchar is forbidden' '
+	test_must_fail git -c core.commentchar= stripspace -s 2>err &&
+	grep "core.commentChar must have at least one character" err
 '
 
 test_expect_success '-c with single line' '
diff --git a/t/t7507-commit-verbose.sh b/t/t7507-commit-verbose.sh
index c3281b192e..4c7db19ce7 100755
--- a/t/t7507-commit-verbose.sh
+++ b/t/t7507-commit-verbose.sh
@@ -101,6 +101,16 @@ test_expect_success 'verbose diff is stripped out with set core.commentChar' '
 	test_grep "Aborting commit due to empty commit message." err
 '
 
+test_expect_success 'verbose diff is stripped with multi-byte comment char' '
+	(
+		GIT_EDITOR=cat &&
+		export GIT_EDITOR &&
+		test_must_fail git -c core.commentchar="foo>" commit -a -v >out 2>err
+	) &&
+	grep "^foo> " out &&
+	test_grep "Aborting commit due to empty commit message." err
+'
+
 test_expect_success 'status does not verbose without --verbose' '
 	git status >actual &&
 	! grep "^diff --git" actual
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index a3c18a4fc2..10ed8b32bc 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1403,7 +1403,9 @@ test_expect_success "status (core.commentchar with submodule summary)" '
 
 test_expect_success "status (core.commentchar with two chars with submodule summary)" '
 	test_config core.commentchar ";;" &&
-	test_must_fail git -c status.displayCommentPrefix=true status
+	sed "s/^/;/" <expect >expect.double &&
+	git -c status.displayCommentPrefix=true status >output &&
+	test_cmp expect.double output
 '
 
 test_expect_success "--ignore-submodules=all suppresses submodule summary" '
-- 
2.44.0.481.gf1a6d20963
