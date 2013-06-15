From: Andrew Pimlott <andrew@pimlott.net>
Subject: Re: [PATCH] rebase -i: fixup fixup! fixup!
Date: Fri, 14 Jun 2013 23:50:21 -0700
Message-ID: <1371278908-sup-1930@pimlott.net>
References: <20130611180530.GA18488@oinkpad.pimlott.net> <87obbc8otc.fsf@hexa.v.cablecom.net> <1371237209-sup-639@pimlott.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Thomas Rast <trast@inf.ethz.ch>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 15 08:50:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnkJh-0003eH-Ce
	for gcvg-git-2@plane.gmane.org; Sat, 15 Jun 2013 08:50:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753423Ab3FOGuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Jun 2013 02:50:24 -0400
Received: from pimlott.net ([72.249.23.100]:38556 "EHLO fugue.pimlott.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751521Ab3FOGuY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Jun 2013 02:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pimlott.net; s=default;
	h=Content-Transfer-Encoding:Message-Id:Date:References:In-reply-to:To:From:Subject:Content-Type; bh=z/JE041LPr8hz4jD1esPI8Jb7Q8TfBKIc1zCdfwU0yw=;
	b=Vftiqzn3QwwUBkXKI7KZxtkFAY2cs6XeXk4Dv4+O/GhbzdUBpNNrXteMS4Wt/oR2NRPfvGXD89WhV9bcNgxTBZU529EVqYPRbzUygGpAi0RnCgTiOafu6R1kPIuT7fFnXrmr5yciRIOqTJ7KJRKBdpyW1AyV2OljvWV/noq2k5k=;
Received: from andrew by fugue.pimlott.net with local (Exim 4.72)
	(envelope-from <andrew@pimlott.net>)
	id 1UnkJZ-0006gj-Ol; Fri, 14 Jun 2013 23:50:21 -0700
In-reply-to: <1371237209-sup-639@pimlott.net>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227934>

Excerpts from Andrew Pimlott's message of Fri Jun 14 12:31:57 -0700 2013:
> It happened to work and I added a test.  But then it occurred to me that
> it might have been better to fix commit --fixup/--squash to strip the
> fixup! or squash! from the referenced commit in the first place.
> Anyhow, below is my patch for --autosquash, but unles someone has an
> objection to doing it in commit, I'll work on that.

Here is a patch for commit.c that does this.

Andrew

When building the commit message for --fixup/--squash, ignore a leading
fixup! or squash! on the referenced commit.  Handy in case the user referred
to an earlier squash/fixup commit instead of the original commit, for
example with :/msg.

Signed-off-by: Andrew Pimlott <andrew@pimlott.net>
---
 builtin/commit.c  |   18 ++++++++++++++----
 t/t7500-commit.sh |   36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 1621dfc..370df88 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -601,8 +601,13 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			if (!c)
 				die(_("could not lookup commit %s"), squash_message);
 			ctx.output_encoding = get_commit_output_encoding();
-			format_commit_message(c, "squash! %s\n\n", &sb,
-					      &ctx);
+			format_commit_message(c, "%s\n\n", &sb, &ctx);
+			if (!prefixcmp(sb.buf, "fixup! ")) {
+				strbuf_remove(&sb, 0, strlen("fixup! "));
+			} else if (!prefixcmp(sb.buf, "squash! ")) {
+				strbuf_remove(&sb, 0, strlen("squash! "));
+			}
+			strbuf_insert(&sb, 0, "squash! ", strlen("squash! "));
 		}
 	}
 
@@ -634,8 +639,13 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		if (!commit)
 			die(_("could not lookup commit %s"), fixup_message);
 		ctx.output_encoding = get_commit_output_encoding();
-		format_commit_message(commit, "fixup! %s\n\n",
-				      &sb, &ctx);
+		format_commit_message(commit, "%s\n\n", &sb, &ctx);
+		if (!prefixcmp(sb.buf, "fixup! ")) {
+			strbuf_remove(&sb, 0, strlen("fixup! "));
+		} else if (!prefixcmp(sb.buf, "squash! ")) {
+			strbuf_remove(&sb, 0, strlen("squash! "));
+		}
+		strbuf_insert(&sb, 0, "fixup! ", strlen("fixup! "));
 		hook_arg1 = "message";
 	} else if (!stat(git_path("MERGE_MSG"), &statbuf)) {
 		if (strbuf_read_file(&sb, git_path("MERGE_MSG"), 0) < 0)
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index 436b7b6..ecdf74a 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -320,4 +320,40 @@ test_expect_success 'invalid message options when using --fixup' '
 	test_must_fail git commit --fixup HEAD~1 -F log
 '
 
+test_expect_success 'commit --fixup of existing fixup' '
+	commit_for_rebase_autosquash_setup &&
+	git commit --fixup HEAD~1 &&
+	echo "fourth content line" >>foo &&
+	git add foo
+	git commit --fixup HEAD &&
+	commit_msg_is "fixup! target message subject line"
+'
+
+test_expect_success 'commit --fixup of existing squash' '
+	commit_for_rebase_autosquash_setup &&
+	git commit --squash HEAD~1 &&
+	echo "fourth content line" >>foo &&
+	git add foo
+	git commit --fixup HEAD &&
+	commit_msg_is "fixup! target message subject line"
+'
+
+test_expect_success 'commit --squash of existing squash' '
+	commit_for_rebase_autosquash_setup &&
+	git commit --squash HEAD~1 &&
+	echo "fourth content line" >>foo &&
+	git add foo
+	git commit --squash HEAD &&
+	commit_msg_is "squash! target message subject linecommit message"
+'
+
+test_expect_success 'commit --squash of existing fixup' '
+	commit_for_rebase_autosquash_setup &&
+	git commit --fixup HEAD~1 &&
+	echo "fourth content line" >>foo &&
+	git add foo
+	git commit --squash HEAD &&
+	commit_msg_is "squash! target message subject linecommit message"
+'
+
 test_done
-- 
1.7.10.4
