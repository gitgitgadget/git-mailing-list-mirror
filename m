Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A3842047
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 09:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805215; cv=none; b=uxFZtbx2ld17ZWYmuCZm2QF6mLjB+KZPr9fwq46hev6k8aJ/AnM0OsYUIwpVxNvD5HQNgFNgLhYAzpwteQETa+p9rCIGo2Oh+ELSddthTqp2u9aRi7CMXJt+X5IZYxMUdLAxhXWnjwG5mzKHTlafrO7qXFa5Jg37DxoisQWBN8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805215; c=relaxed/simple;
	bh=FJbCGT35J9ccFLOxKn6k4GiZ3Hm0tub76HJSiPFekzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQvPZ383JDcLDFPvTdt+xug7OgW1VGjqfaNLtYHRTvIT3WBKyoLyeolqV8IQxZJzniGW2+8yExLl3SZfEUCowh4u4wYgbhiYhyGfDJ6bmYE58doZ4dyRw3/KOnMFYd5eChOwI+a+FPlfkf/++l//AJ5Pl569g5nEEbZi48LhGpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7198 invoked by uid 109); 7 Mar 2024 09:53:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Mar 2024 09:53:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12921 invoked by uid 111); 7 Mar 2024 09:53:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Mar 2024 04:53:37 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Mar 2024 04:53:32 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [PATCH 06/15] strbuf: accept a comment string for
 strbuf_stripspace()
Message-ID: <20240307095332.GB2650063@coredump.intra.peff.net>
References: <20240307091407.GA2072522@coredump.intra.peff.net>
 <20240307092126.GF2080210@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240307092126.GF2080210@coredump.intra.peff.net>

On Thu, Mar 07, 2024 at 04:21:26AM -0500, Jeff King wrote:

> As part of our transition to multi-byte comment characters, let's take a
> NUL-terminated string pointer for strbuf_stripspace(), rather than a
> single character. We can continue to support its feature of ignoring
> comments by accepting a NULL pointer (as opposed to the current behavior
> of a NUL byte).
> 
> All of the callers have to be adjusted, but they can all just pass
> comment_line_str (or NULL).

Bah. I relied on the compiler to tell me the call-sites that needed to
be adjusted. But interestingly gcc is quite happy to allow '\0' to be
passed in place of a pointer, but clang complains:

  gpg-interface.c:589:37: error: expression which evaluates to zero treated as a null pointer constant of type 'const char *' [-Werror,-Wnon-literal-null-conversion]
          strbuf_stripspace(&ssh_keygen_out, '\0');
                                             ^~~~

Likewise there are a few bare "0"'s which do not cause a warning, but
which violate our style standards. So I think we'd want to squash the
patch below in to this step. The other functions don't need the same
treatment because they never treated NUL specially.

---
diff --git a/builtin/am.c b/builtin/am.c
index d1990d7edc..5bc72d7822 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1286,7 +1286,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 
 	strbuf_addstr(&msg, "\n\n");
 	strbuf_addbuf(&msg, &mi.log_message);
-	strbuf_stripspace(&msg, '\0');
+	strbuf_stripspace(&msg, NULL);
 
 	assert(!state->author_name);
 	state->author_name = strbuf_detach(&author_name, NULL);
diff --git a/builtin/commit.c b/builtin/commit.c
index 8519a004d0..e04f1236e8 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -890,7 +890,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	s->hints = 0;
 
 	if (clean_message_contents)
-		strbuf_stripspace(&sb, '\0');
+		strbuf_stripspace(&sb, NULL);
 
 	if (signoff)
 		append_signoff(&sb, ignored_log_message_bytes(sb.buf, sb.len), 0);
diff --git a/builtin/notes.c b/builtin/notes.c
index 1a67f01d00..cb011303e6 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -264,7 +264,7 @@ static void concat_messages(struct note_data *d)
 		if ((d->stripspace == UNSPECIFIED &&
 		     d->messages[i]->stripspace == STRIPSPACE) ||
 		    d->stripspace == STRIPSPACE)
-			strbuf_stripspace(&d->buf, 0);
+			strbuf_stripspace(&d->buf, NULL);
 		strbuf_reset(&msg);
 	}
 	strbuf_release(&msg);
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 9c76b62b02..f0aa962cf8 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -657,7 +657,7 @@ static int can_use_local_refs(const struct add_opts *opts)
 			strbuf_add_real_path(&path, get_worktree_git_dir(NULL));
 			strbuf_addstr(&path, "/HEAD");
 			strbuf_read_file(&contents, path.buf, 64);
-			strbuf_stripspace(&contents, 0);
+			strbuf_stripspace(&contents, NULL);
 			strbuf_strip_suffix(&contents, "\n");
 
 			warning(_("HEAD points to an invalid (or orphaned) reference.\n"
diff --git a/gpg-interface.c b/gpg-interface.c
index 95e764acb1..b5993385ff 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -586,8 +586,8 @@ static int verify_ssh_signed_buffer(struct signature_check *sigc,
 		}
 	}
 
-	strbuf_stripspace(&ssh_keygen_out, '\0');
-	strbuf_stripspace(&ssh_keygen_err, '\0');
+	strbuf_stripspace(&ssh_keygen_out, NULL);
+	strbuf_stripspace(&ssh_keygen_err, NULL);
 	/* Add stderr outputs to show the user actual ssh-keygen errors */
 	strbuf_add(&ssh_keygen_out, ssh_principals_err.buf, ssh_principals_err.len);
 	strbuf_add(&ssh_keygen_out, ssh_keygen_err.buf, ssh_keygen_err.len);
