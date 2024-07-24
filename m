Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0018713AD3D
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 21:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721855339; cv=none; b=F24dB24eUXklJaMB2reuTOF5OJisiha/ogSymJtprvCvcQbDK2dqA1yGuPOCM04g6r1/QKtYA0iEuufV4x6wQ+oH2cF16IU6kZqqE7TtKMQp4Ya7UMM9lGmKtpF/6P/RsfH5R9JZ0NL5LAufzkx8KfGl3DG+JRFH03VvC4oCE5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721855339; c=relaxed/simple;
	bh=AKO9PAtXwIDeSM8JWs6uZr0K/wVumcDyDgsXZ9qHfa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohyoWItpCp69v2N1Ahj4tvxkuCG1eYk2a5BmMS3nDFov/z2GsxXybcc7u75NVwhZ184jkoIOuDfBgWzZN2ZE+JbyX/G5199UWN8x3LHMBlVAzdw48LEixM+RlxcKCxgA08/iBqiBaMSxHMi1B0274j5eN87GjuXlsu4DgdI7FiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 1964 invoked by uid 109); 24 Jul 2024 21:08:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Jul 2024 21:08:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14440 invoked by uid 111); 24 Jul 2024 21:08:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Jul 2024 17:08:57 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 24 Jul 2024 17:08:54 -0400
From: Jeff King <peff@peff.net>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Robert Coup <robert.coup@koordinates.com>,
	git <git@vger.kernel.org>
Subject: Re: bug/defaults: COMMIT_EDITMSG not reused after a failed commit
Message-ID: <20240724210854.GB557365@coredump.intra.peff.net>
References: <CAFLLRpJgpjJpNRC_UpZmUXF2626e0BiH8CkOkoMrX3zcrOp7YA@mail.gmail.com>
 <xmqq1q3iyceq.fsf@gitster.g>
 <20240724-cryptic-private-mustang-3f50aa@meerkat>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240724-cryptic-private-mustang-3f50aa@meerkat>

On Wed, Jul 24, 2024 at 12:53:36PM -0400, Konstantin Ryabitsev wrote:

> Yes, I would say even doing the following would result in a better experience
> for users who don't know about .git/COMMIT_EDITMSG:
> 
> 1. when git-commit fails, save the message as .git/FAILED_COMMIT_MSG
> 2. output "Commit message saved as .git/FAILED_COMMIT_MSG"

I proposed something like (2) long ago. I'll reproduce the (rebased
forward) patch below, but here's the original thread with a little bit
of discussion:

  https://lore.kernel.org/git/20120723185218.GC27588@sigill.intra.peff.net/

It just told you about COMMIT_EDITMSG, making it your responsibility to
recover it before running "git commit" again. Your (1) makes it a little
nicer, in that you can run "git commit" and then pull the content from
the other file into your editor. Or we could even provide an option to
pre-populate the message with it.

Junio was lukewarm on the original, so I'm not sure why I've been
holding on to it all these years. But maybe it would help as a guide for
anybody who wants to work on what you've proposed above.

-- >8 --
From: Jeff King <peff@peff.net>
Date: Mon, 23 Jul 2012 14:52:18 -0400
Subject: [PATCH] commit: give a hint when a commit message has been abandoned

If we launch an editor for the user to create a commit
message, they may put significant work into doing so.
Typically we try to check common mistakes that could cause
the commit to fail early, so that we die before the user
goes to the trouble.

We may still experience some errors afterwards, though; in
this case, the user is given no hint that their commit
message has been saved. Let's tell them where it is.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/commit.c                          | 15 +++++++++++++++
 t/t7500-commit-template-squash-signoff.sh |  3 +--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index dec78dfb86..42fefaa0e3 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -160,6 +160,16 @@ static int opt_parse_porcelain(const struct option *opt, const char *arg, int un
 	return 0;
 }
 
+static int mention_abandoned_message;
+static void maybe_mention_abandoned_message(void)
+{
+	if (!mention_abandoned_message)
+		return;
+	advise(_("Your commit message has been saved in '%s' and will be\n"
+		 "overwritten by the next invocation of \"git commit\"."),
+	       git_path_commit_editmsg());
+}
+
 static int opt_parse_m(const struct option *opt, const char *arg, int unset)
 {
 	struct strbuf *buf = opt->value;
@@ -1090,6 +1100,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			exit(1);
 		}
 		strvec_clear(&env);
+		atexit(maybe_mention_abandoned_message);
+		mention_abandoned_message = 1;
 	}
 
 	if (!no_verify &&
@@ -1813,11 +1825,13 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	if (message_is_empty(&sb, cleanup_mode) && !allow_empty_message) {
 		rollback_index_files();
 		fprintf(stderr, _("Aborting commit due to empty commit message.\n"));
+		mention_abandoned_message = 0;
 		exit(1);
 	}
 	if (template_untouched(&sb, template_file, cleanup_mode) && !allow_empty_message) {
 		rollback_index_files();
 		fprintf(stderr, _("Aborting commit; you did not edit the message.\n"));
+		mention_abandoned_message = 0;
 		exit(1);
 	}
 
@@ -1855,6 +1869,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		die("%s", err.buf);
 	}
 
+	mention_abandoned_message = 0;
 	sequencer_post_commit_cleanup(the_repository, 0);
 	unlink(git_path_merge_head(the_repository));
 	unlink(git_path_merge_msg(the_repository));
diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
index 4dca8d97a7..c476a26235 100755
--- a/t/t7500-commit-template-squash-signoff.sh
+++ b/t/t7500-commit-template-squash-signoff.sh
@@ -396,13 +396,12 @@ test_expect_success 'consecutive amend! commits remove amend! line from commit m
 
 test_expect_success 'deny to create amend! commit if its commit msg body is empty' '
 	commit_for_rebase_autosquash_setup &&
-	echo "Aborting commit due to empty commit message body." >expected &&
 	(
 		set_fake_editor &&
 		test_must_fail env FAKE_COMMIT_MESSAGE="amend! target message subject line" \
 			git commit --fixup=amend:HEAD~ 2>actual
 	) &&
-	test_cmp expected actual
+	grep "Aborting commit due to empty commit message body" actual
 '
 
 test_expect_success 'amend! commit allows empty commit msg body with --allow-empty-message' '
-- 
2.46.0.rc1.447.g578b9b2b5c

