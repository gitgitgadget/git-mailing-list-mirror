Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35A6D279
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 05:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="w9mrH77B"
X-Greylist: delayed 318 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 Oct 2023 22:28:52 PDT
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F94DA
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 22:28:52 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6C9762164C;
	Tue, 31 Oct 2023 01:23:34 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=qk85S00ukPJJj2ySTuNXt4GaW
	cYNLzfdozlyZ+x+pEY=; b=w9mrH77BWmRtNCxXkhHesqHbHPBDeRxnX9eLPAfJp
	/h+mij6YyChG0bqZzUDxyWKcEs7X6YFRYOZYT9KwtSwRz+mE3+H7TdG5DLXM2rXu
	FBQ9OS2c4U7vGHZeQhb33btGa6g6W2Nek5eURCG9/dpUdKkEj8YdRP2tHYHzYVyB
	nI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 657CA2164B;
	Tue, 31 Oct 2023 01:23:34 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 79CEF2164A;
	Tue, 31 Oct 2023 01:23:31 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 0/2] Deprecate test_i18ngrep further
Date: Tue, 31 Oct 2023 14:23:28 +0900
Message-ID: <20231031052330.3762989-1-gitster@pobox.com>
X-Mailer: git-send-email 2.42.0-530-g692be87cbb
In-Reply-To: <881c7fea-47bb-45a9-b6e3-314f9ed9e0cd@gmail.com>
References: <881c7fea-47bb-45a9-b6e3-314f9ed9e0cd@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 A15999EC-77AD-11EE-8480-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

As an attempt to come up with a useful mechanism to ensure that
certain messages are left untranslated [*], we earlier wrote
GIT_TEST_GETTEXT_POISON off as a failed experiment.

But the output from the test helper was easier to use while
debugging failed tests, compared to the same test writtein with the
plain-vanilla "grep".  Especially when a test that expects a certain
string to appear in the output (e.g. "this test must fail with this
message") fails, "grep message output" would just silently fail and
in a &&-chained sequence of commands, it is hard to tell which step
failed.  test_i18ngrep explicitly said "we wanted to see a line that
match this pattern but did not see a hit in this file".

Let's introduce test_grep and replace existing uses of test_i18ngrep
with it.  The helper is still useful, but now has nothing to do with
i18n.

Junio C Hamano (2):
  test framework: further deprecate test_i18ngrep
  tests: teach callers of test_i18ngrep to use test_grep

 t/lib-httpd.sh                               |   2 +-
 t/lib-submodule-update.sh                    |   2 +-
 t/t0001-init.sh                              |  16 +--
 t/t0002-gitfile.sh                           |   4 +-
 t/t0003-attributes.sh                        |   4 +-
 t/t0008-ignores.sh                           |   4 +-
 t/t0012-help.sh                              |  16 +--
 t/t0013-sha1dc.sh                            |   2 +-
 t/t0014-alias.sh                             |   8 +-
 t/t0021-conversion.sh                        |   6 +-
 t/t0028-working-tree-encoding.sh             |  32 ++---
 t/t0040-parse-options.sh                     |   4 +-
 t/t0041-usage.sh                             |  32 ++---
 t/t0061-run-command.sh                       |   6 +-
 t/t0070-fundamental.sh                       |   4 +-
 t/t0091-bugreport.sh                         |   2 +-
 t/t0300-credentials.sh                       |   2 +-
 t/t1060-object-corruption.sh                 |   2 +-
 t/t1091-sparse-checkout-builtin.sh           |  68 ++++-----
 t/t1092-sparse-checkout-compatibility.sh     |   6 +-
 t/t1300-config.sh                            |  44 +++---
 t/t1307-config-blob.sh                       |   2 +-
 t/t1308-config-set.sh                        |  10 +-
 t/t1309-early-config.sh                      |   2 +-
 t/t1310-config-default.sh                    |   4 +-
 t/t1400-update-ref.sh                        |  22 +--
 t/t1404-update-ref-errors.sh                 |   4 +-
 t/t1410-reflog.sh                            |   6 +-
 t/t1416-ref-transaction-hooks.sh             |   2 +-
 t/t1430-bad-ref-name.sh                      |  22 +--
 t/t1450-fsck.sh                              |  80 +++++------
 t/t1506-rev-parse-diagnosis.sh               |  34 ++---
 t/t1512-rev-parse-disambiguation.sh          |   6 +-
 t/t2004-checkout-cache-temp.sh               |   2 +-
 t/t2006-checkout-index-basic.sh              |  14 +-
 t/t2010-checkout-ambiguous.sh                |   4 +-
 t/t2018-checkout-branch.sh                   |   4 +-
 t/t2019-checkout-ambiguous-ref.sh            |   8 +-
 t/t2020-checkout-detach.sh                   |   8 +-
 t/t2024-checkout-dwim.sh                     |   8 +-
 t/t2025-checkout-no-overlay.sh               |   2 +-
 t/t2026-checkout-pathspec-file.sh            |   8 +-
 t/t2027-checkout-track.sh                    |   2 +-
 t/t2030-unresolve-info.sh                    |   2 +-
 t/t2072-restore-pathspec-file.sh             |   8 +-
 t/t2106-update-index-assume-unchanged.sh     |   2 +-
 t/t2107-update-index-basic.sh                |   4 +-
 t/t2203-add-intent.sh                        |   6 +-
 t/t2204-add-ignored.sh                       |   8 +-
 t/t2401-worktree-prune.sh                    |  10 +-
 t/t2402-worktree-list.sh                     |   6 +-
 t/t2403-worktree-move.sh                     |   2 +-
 t/t2406-worktree-repair.sh                   |  24 ++--
 t/t3004-ls-files-basic.sh                    |   4 +-
 t/t3007-ls-files-recurse-submodules.sh       |   4 +-
 t/t3200-branch.sh                            |  18 +--
 t/t3202-show-branch.sh                       |   2 +-
 t/t3206-range-diff.sh                        |  22 +--
 t/t3210-pack-refs.sh                         |   2 +-
 t/t3301-notes.sh                             |   4 +-
 t/t3310-notes-merge-manual-resolve.sh        |  16 +--
 t/t3320-notes-merge-worktrees.sh             |   4 +-
 t/t3321-notes-stripspace.sh                  |   2 +-
 t/t3400-rebase.sh                            |   6 +-
 t/t3402-rebase-merge.sh                      |   2 +-
 t/t3403-rebase-skip.sh                       |  30 ++--
 t/t3404-rebase-interactive.sh                |  38 ++---
 t/t3406-rebase-message.sh                    |  18 +--
 t/t3418-rebase-continue.sh                   |   6 +-
 t/t3431-rebase-fork-point.sh                 |   2 +-
 t/t3501-revert-cherry-pick.sh                |   6 +-
 t/t3507-cherry-pick-conflict.sh              |   8 +-
 t/t3510-cherry-pick-sequence.sh              |   6 +-
 t/t3600-rm.sh                                |   8 +-
 t/t3601-rm-pathspec-file.sh                  |   6 +-
 t/t3700-add.sh                               |   6 +-
 t/t3701-add-interactive.sh                   |   8 +-
 t/t3704-add-pathspec-file.sh                 |  12 +-
 t/t3900-i18n-commit.sh                       |   8 +-
 t/t3901-i18n-patch.sh                        |   2 +-
 t/t3903-stash.sh                             |  10 +-
 t/t3905-stash-include-untracked.sh           |   2 +-
 t/t3909-stash-pathspec-file.sh               |   6 +-
 t/t4001-diff-rename.sh                       |  34 ++---
 t/t4013-diff-various.sh                      |   2 +-
 t/t4014-format-patch.sh                      |  12 +-
 t/t4015-diff-whitespace.sh                   |  20 +--
 t/t4018-diff-funcname.sh                     |  14 +-
 t/t4031-diff-rewrite-binary.sh               |   2 +-
 t/t4047-diff-dirstat.sh                      |  22 +--
 t/t4053-diff-no-index.sh                     |   2 +-
 t/t4055-diff-context.sh                      |   4 +-
 t/t4068-diff-symmetric-merge-base.sh         |  28 ++--
 t/t4115-apply-symlink.sh                     |   2 +-
 t/t4120-apply-popt.sh                        |   4 +-
 t/t4122-apply-symlink-inside.sh              |  14 +-
 t/t4129-apply-samemode.sh                    |   4 +-
 t/t4133-apply-filenames.sh                   |   8 +-
 t/t4150-am.sh                                |   4 +-
 t/t4151-am-abort.sh                          |   2 +-
 t/t4153-am-resume-override-opts.sh           |   2 +-
 t/t4200-rerere.sh                            |   4 +-
 t/t4201-shortlog.sh                          |   2 +-
 t/t4202-log.sh                               |  18 +--
 t/t4203-mailmap.sh                           |   2 +-
 t/t4208-log-magic-pathspec.sh                |   6 +-
 t/t4209-log-pickaxe.sh                       |   4 +-
 t/t4211-line-log.sh                          |   4 +-
 t/t4212-log-corrupt.sh                       |   2 +-
 t/t4256-am-format-flowed.sh                  |   2 +-
 t/t5300-pack-object.sh                       |   4 +-
 t/t5302-pack-index.sh                        |   4 +-
 t/t5304-prune.sh                             |   4 +-
 t/t5310-pack-bitmaps.sh                      |   8 +-
 t/t5318-commit-graph.sh                      |  18 +--
 t/t5319-multi-pack-index.sh                  |  10 +-
 t/t5324-split-commit-graph.sh                |  16 +--
 t/t5331-pack-objects-stdin.sh                |   4 +-
 t/t5411/test-0026-push-options.sh            |   2 +-
 t/t5411/test-0027-push-options--porcelain.sh |   2 +-
 t/t5500-fetch-pack.sh                        |  10 +-
 t/t5504-fetch-receive-strict.sh              |  26 ++--
 t/t5505-remote.sh                            |  22 +--
 t/t5510-fetch.sh                             |   8 +-
 t/t5512-ls-remote.sh                         |   2 +-
 t/t5514-fetch-multiple.sh                    |   4 +-
 t/t5516-fetch-push.sh                        |   8 +-
 t/t5520-pull.sh                              |  34 ++---
 t/t5521-pull-options.sh                      |   2 +-
 t/t5523-push-upstream.sh                     |  12 +-
 t/t5528-push-default.sh                      |   2 +-
 t/t5530-upload-pack-error.sh                 |   4 +-
 t/t5531-deep-submodule-push.sh               |   2 +-
 t/t5534-push-signed.sh                       |   6 +-
 t/t5536-fetch-conflicts.sh                   |   8 +-
 t/t5541-http-push-smart.sh                   |  20 +--
 t/t5545-push-options.sh                      |   2 +-
 t/t5550-http-fetch-dumb.sh                   |   8 +-
 t/t5551-http-fetch-smart.sh                  |   4 +-
 t/t5570-git-daemon.sh                        |  10 +-
 t/t5572-pull-submodule.sh                    |   2 +-
 t/t5573-pull-verify-signatures.sh            |  26 ++--
 t/t5574-fetch-output.sh                      |   4 +-
 t/t5580-unc-paths.sh                         |   2 +-
 t/t5601-clone.sh                             |   6 +-
 t/t5604-clone-reference.sh                   |   2 +-
 t/t5606-clone-options.sh                     |  10 +-
 t/t5607-clone-bundle.sh                      |   4 +-
 t/t5611-clone-config.sh                      |   4 +-
 t/t5616-partial-clone.sh                     |  22 +--
 t/t5701-git-serve.sh                         |   8 +-
 t/t5702-protocol-v2.sh                       |  34 ++---
 t/t5703-upload-pack-ref-in-want.sh           |   4 +-
 t/t5704-protocol-violations.sh               |   4 +-
 t/t5801-remote-helpers.sh                    |   8 +-
 t/t5812-proto-disable-http.sh                |   2 +-
 t/t6001-rev-list-graft.sh                    |   4 +-
 t/t6021-rev-list-exclude-hidden.sh           |   4 +-
 t/t6030-bisect-porcelain.sh                  |  24 ++--
 t/t6040-tracking-info.sh                     |  18 +--
 t/t6050-replace.sh                           |  14 +-
 t/t6102-rev-list-unexpected-objects.sh       |  16 +--
 t/t6112-rev-list-filters-objects.sh          |   2 +-
 t/t6120-describe.sh                          |   2 +-
 t/t6134-pathspec-in-submodule.sh             |   2 +-
 t/t6135-pathspec-with-attrs.sh               |   8 +-
 t/t6136-pathspec-in-bare.sh                  |   8 +-
 t/t6402-merge-rename.sh                      |  16 +--
 t/t6422-merge-rename-corner-cases.sh         |  16 +--
 t/t6423-merge-rename-directories.sh          | 140 +++++++++----------
 t/t6424-merge-unrelated-index-changes.sh     |   6 +-
 t/t6425-merge-rename-delete.sh               |   4 +-
 t/t6426-merge-skip-unneeded-updates.sh       |   2 +-
 t/t6430-merge-recursive.sh                   |   8 +-
 t/t6433-merge-toplevel.sh                    |   4 +-
 t/t6436-merge-overwrite.sh                   |   4 +-
 t/t6437-submodule-merge.sh                   |   2 +-
 t/t6500-gc.sh                                |  14 +-
 t/t7001-mv.sh                                |   4 +-
 t/t7105-reset-patch.sh                       |   6 +-
 t/t7106-reset-unborn-branch.sh               |   2 +-
 t/t7107-reset-pathspec-file.sh               |  10 +-
 t/t7110-reset-merge.sh                       |   6 +-
 t/t7201-co.sh                                |   4 +-
 t/t7300-clean.sh                             |   2 +-
 t/t7400-submodule-basic.sh                   |  64 ++++-----
 t/t7403-submodule-sync.sh                    |   4 +-
 t/t7406-submodule-update.sh                  |   6 +-
 t/t7411-submodule-config.sh                  |   4 +-
 t/t7414-submodule-mistakes.sh                |   8 +-
 t/t7416-submodule-dash-url.sh                |   4 +-
 t/t7417-submodule-path-url.sh                |   4 +-
 t/t7450-bad-git-dotfiles.sh                  |  12 +-
 t/t7500-commit-template-squash-signoff.sh    |   2 +-
 t/t7501-commit-basic-functionality.sh        |   6 +-
 t/t7502-commit-porcelain.sh                  |  32 ++---
 t/t7506-status-submodule.sh                  |  28 ++--
 t/t7507-commit-verbose.sh                    |   4 +-
 t/t7508-status.sh                            |  24 ++--
 t/t7509-commit-authorship.sh                 |   4 +-
 t/t7518-ident-corner-cases.sh                |  10 +-
 t/t7519-status-fsmonitor.sh                  |   6 +-
 t/t7520-ignored-hook-warning.sh              |   8 +-
 t/t7525-status-rename.sh                     |  54 +++----
 t/t7526-commit-pathspec-file.sh              |  14 +-
 t/t7600-merge.sh                             |  30 ++--
 t/t7601-merge-pull-config.sh                 |  50 +++----
 t/t7611-merge-abort.sh                       |   4 +-
 t/t7612-merge-verify-signatures.sh           |  24 ++--
 t/t7703-repack-geometric.sh                  |   4 +-
 t/t7800-difftool.sh                          |   4 +-
 t/t7810-grep.sh                              |   4 +-
 t/t7811-grep-open.sh                         |   2 +-
 t/t7814-grep-recurse-submodules.sh           |   2 +-
 t/t7816-grep-binary-pattern.sh               |   4 +-
 t/t7900-maintenance.sh                       |  24 ++--
 t/t8003-blame-corner-cases.sh                |   2 +-
 t/t8013-blame-ignore-revs.sh                 |   6 +-
 t/t9001-send-email.sh                        |   8 +-
 t/t9300-fast-import.sh                       |  26 ++--
 t/t9800-git-p4-basic.sh                      |  18 +--
 t/t9801-git-p4-branch.sh                     |   2 +-
 t/t9807-git-p4-submit.sh                     |  12 +-
 t/t9815-git-p4-submit-fail.sh                |  12 +-
 t/test-lib-functions.sh                      |  10 +-
 225 files changed, 1196 insertions(+), 1194 deletions(-)

--=20
2.42.0-530-g692be87cbb

