Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3CA24A08
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 08:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711527566; cv=none; b=I9n+N4SdEMFqlEY0+l4+/ulmld3qjGIvZYyFJeAq+DlavFpRLH5ByU2nGP64lR23eTI2kqJOPM4dHk5wgGTbqisk9jAo4gppXEyoBZxS6HvBpWkAWUJelkNLf1sbk0mbSIpt1McCf+Mict72qFFDpdLgFXOPjgAQQLgKcgQ981I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711527566; c=relaxed/simple;
	bh=R6FTFSsv9T4PmyZmvGWbL2gSqtJ/PNQ13tfvnCKBYIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLq84whmd3TouFjR69cofHJdM+fVRSHmEImD0ygwWYHilgKMYGaoBVFq1fv5tZFt6JDLCTi/HsfhvA7167Zq3f5x0rawHC6PwKCro+2eli8IPFIz4fUEZWeO5FXK3OwolFQhQBeOSvYZxHUl/rHA497GgDH2/7ThotdyZP6lRcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 21198 invoked by uid 109); 27 Mar 2024 08:19:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 Mar 2024 08:19:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24289 invoked by uid 111); 27 Mar 2024 08:19:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Mar 2024 04:19:27 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 27 Mar 2024 04:19:22 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Dragan Simic <dsimic@manjaro.org>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: [PATCH 17/16] config: add core.commentString
Message-ID: <20240327081922.GA830163@coredump.intra.peff.net>
References: <20240312091013.GA95442@coredump.intra.peff.net>
 <20240312091750.GP95609@coredump.intra.peff.net>
 <0426f7bf-6032-4fc7-886c-c4278c6e105b@app.fastmail.com>
 <20240315055944.GB1741107@coredump.intra.peff.net>
 <6be335ed-8598-406c-b535-2e58554b00e9@app.fastmail.com>
 <20240315081041.GA1753560@coredump.intra.peff.net>
 <xmqq8r247igg.fsf@gitster.g>
 <20240327074655.GA831122@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240327074655.GA831122@coredump.intra.peff.net>

On Wed, Mar 27, 2024 at 03:46:55AM -0400, Jeff King wrote:

> > My preference is to introduce core.commentString to avoid confusion
> > coming from an older Git using the first-byte of a multi-byte
> > string, or dying upon reading a configuration file meant for a newer
> > Git, and then let core.commentString override core.commentChar, but
> > I would prefer to see the discussion participants to raise their
> > opinions and reach a conclusion.
> 
> OK. I don't have a strong opinion. Are you OK with core.commentString as
> a strict synonym (so last-one-wins and either name overwrites previous)?
> Or do you want an override (i.e., commentString always overrides
> commentChar, regardless of order). I think it's mostly academic, and the
> strict synonym version is much easier to implement.

Like this, on top of what you have queued in jk/core-comment-string.

Note that you graduated kh/doc-commentchar-is-a-byte, which says "this
ASCII character" early in the description, which will be incorrect if my
series is merged. This would need to be fixed (possibly as part of
merging my topic, though I don't think it actually triggers a conflict,
so you'll have to remember to do so manually). Or mine could be rebased
on top of master and then remove it as part of the series.

-- >8 --
Subject: [PATCH] config: add core.commentString

The core.commentChar code recently learned to accept more than a
single ASCII character. But using it is annoying with multiple versions
of Git, since older ones will reject it outright:

    $ git.v2.44.0 -c core.commentchar=foo stripspace -s
    error: core.commentChar should only be one ASCII character
    fatal: unable to parse 'core.commentchar' from command-line config

Let's add an alias core.commentString. That's arguably a better name
anyway, since we now can handle strings, and it makes it possible to
have a config that works reasonably with both old and new versions of
Git (see the example in the documentation).

This is strictly an alias, so there's not much point in adding duplicate
tests; I added a single one to t0030 that exercises the alias code.

Note also that the error messages for invalid values will now show the
variable the config parser handed us, and thus will be normalized to
lowercase (rather than camelcase). A few tests in t0030 are adjusted to
match.

Signed-off-by: Jeff King <peff@peff.net>
---
An alternative to using "$var cannot ..." in the error messages (if we
don't like the all-lowercase variable name) is to just say "comment
strings cannot ...". That vaguely covers both cases, and the message
printed by the config code itself does mention the actual variable name
that triggered the error.

 Documentation/config/core.txt | 19 ++++++++++++++++---
 config.c                      |  7 ++++---
 t/t0030-stripspace.sh         |  9 +++++++--
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index c86b8c8408..bbe869c497 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -520,15 +520,28 @@ core.editor::
 	`GIT_EDITOR` is not set.  See linkgit:git-var[1].
 
 core.commentChar::
+core.commentString::
 	Commands such as `commit` and `tag` that let you edit
 	messages consider a line that begins with this character
 	commented, and removes them after the editor returns
-	(default '#'). Note that this option can take values larger than
-	a byte (whether a single multi-byte character, or you
-	could even go wild with a multi-character sequence).
+	(default '#').
 +
 If set to "auto", `git-commit` would select a character that is not
 the beginning character of any line in existing commit messages.
++
+Note that these two variables are aliases of each other, and in modern
+versions of Git you are free to use a string (e.g., `//` or `⁑⁕⁑`) with
+`commentChar`. Versions of Git prior to v2.45.0 will ignore
+`commentString` but will reject a value of `commentChar` that consists
+of more than a single ASCII byte. If you plan to use your config with
+older and newer versions of Git, you may want to specify both:
++
+    [core]
+    # single character for older versions
+    commentChar = "#"
+    # string for newer versions (which will override commentChar
+    # because it comes later in the file)
+    commentString = "//"
 
 core.filesRefLockTimeout::
 	The length of time, in milliseconds, to retry when trying to
diff --git a/config.c b/config.c
index 92c752ed9f..d12e0f34f1 100644
--- a/config.c
+++ b/config.c
@@ -1560,18 +1560,19 @@ static int git_default_core_config(const char *var, const char *value,
 	if (!strcmp(var, "core.editor"))
 		return git_config_string(&editor_program, var, value);
 
-	if (!strcmp(var, "core.commentchar")) {
+	if (!strcmp(var, "core.commentchar") ||
+	    !strcmp(var, "core.commentstring")) {
 		if (!value)
 			return config_error_nonbool(var);
 		else if (!strcasecmp(value, "auto"))
 			auto_comment_line_char = 1;
 		else if (value[0]) {
 			if (strchr(value, '\n'))
-				return error(_("core.commentChar cannot contain newline"));
+				return error(_("%s cannot contain newline"), var);
 			comment_line_str = xstrdup(value);
 			auto_comment_line_char = 0;
 		} else
-			return error(_("core.commentChar must have at least one character"));
+			return error(_("%s must have at least one character"), var);
 		return 0;
 	}
 
diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
index a161faf702..f10f42ff1e 100755
--- a/t/t0030-stripspace.sh
+++ b/t/t0030-stripspace.sh
@@ -401,14 +401,19 @@ test_expect_success 'strip comments with changed comment char' '
 	test -z "$(echo "; comment" | git -c core.commentchar=";" stripspace -s)"
 '
 
+test_expect_success 'strip comments with changed comment string' '
+	test ! -z "$(echo "// comment" | git -c core.commentchar=// stripspace)" &&
+	test -z "$(echo "// comment" | git -c core.commentchar="//" stripspace -s)"
+'
+
 test_expect_success 'newline as commentchar is forbidden' '
 	test_must_fail git -c core.commentChar="$LF" stripspace -s 2>err &&
-	grep "core.commentChar cannot contain newline" err
+	grep "core.commentchar cannot contain newline" err
 '
 
 test_expect_success 'empty commentchar is forbidden' '
 	test_must_fail git -c core.commentchar= stripspace -s 2>err &&
-	grep "core.commentChar must have at least one character" err
+	grep "core.commentchar must have at least one character" err
 '
 
 test_expect_success '-c with single line' '
-- 
2.44.0.727.g4d9414de3a

