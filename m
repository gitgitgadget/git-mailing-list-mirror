Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E35C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 11:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BFB36108B
	for <git@archiver.kernel.org>; Wed, 19 May 2021 11:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349001AbhESLSi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 07:18:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:58860 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346253AbhESLSg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 07:18:36 -0400
Received: (qmail 22913 invoked by uid 109); 19 May 2021 11:17:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 19 May 2021 11:17:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18836 invoked by uid 111); 19 May 2021 11:17:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 19 May 2021 07:17:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 19 May 2021 07:17:15 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Greg Pflaum <greg.pflaum@pnp-hcl.com>
Subject: [PATCH] clone: clean up directory after transport_fetch_refs()
 failure
Message-ID: <YKTzu96fN7XlpDoG@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-clone started respecting errors from the transport subsystem in
aab179d937 (builtin/clone.c: don't ignore transport_fetch_refs() errors,
2020-12-03). However, that commit didn't handle the cleanup of the
filesystem quite right.

The cleanup of the directory that cmd_clone() creates is done by an
atexit() handler, which we control with a flag. It starts as
JUNK_LEAVE_NONE ("clean up everything"), then progresses to
JUNK_LEAVE_REPO when we know we have a valid repo but not working tree,
and then finally JUNK_LEAVE_ALL when we have a successful checkout.

Most errors cause us to die(), which then triggers the handler to do the
right thing based on how far into cmd_clone() we got. But the checks
added by aab179d937 instead set the "err" variable and then jump to a
new "cleanup" label, which then returns our non-zero status. However,
the code after the cleanup label includes setting the flag to
JUNK_LEAVE_ALL, and so we accidentally leave the repository and working
tree in place.

One obvious option to fix this is to reorder the end of the function to
set the flag first, before cleanup code, and put the label between them.

But we can observe another small bug: the error return from
transport_fetch_refs() is generally "-1", and we propagate that to the
return value of cmd_clone(), which ultimately becomes the exit code of
the process. And we try to avoid transmitting negative values via exit
codes (only the low 8 bits are passed along as an unsigned value, though
in practice for "-1" this at least retains the property that it's
non-zero).

Instead, let's just die(). That makes us consistent with rest of the
code in the function. It does add a new "fatal:" line to the output, but
I'd argue that's a good thing:

  - in the rare case that the transport code didn't say anything, now
    the user gets _some_ error message

  - even if the transport code said something like "error: ssh died of
    signal 9", it's nice to also say "fatal" to indicate that we
    considered that to be a show-stopper.

Triggering this in the test suite turns out to be surprisingly
difficult. Almost every error we'd encounter, including ones deep inside
the transport code, cause us to just die() right there! However, one way
is to put a fake wrapper around git-upload-pack that sends the complete
packfile but exits with a failure code.

Signed-off-by: Jeff King <peff@peff.net>
---
Pulling this out of the discussion in:

  https://lore.kernel.org/git/YKTg8nYjSGpKbq8W@coredump.intra.peff.net/

The problem is in v2.30.0, so this doesn't need to be part of the
upcoming v2.32 release (but it's probably a good candidate for maint).
Note that it isn't even a regression in v2.30. Before then, we ignored
the error completely! So the fix there simply didn't go far enough. :)

 builtin/clone.c               | 11 ++++-------
 t/t5600-clone-fail-cleanup.sh |  7 +++++++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index eeb74c0217..66fe66679c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1320,9 +1320,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			}
 
 		if (!is_local && !complete_refs_before_fetch) {
-			err = transport_fetch_refs(transport, mapped_refs);
-			if (err)
-				goto cleanup;
+			if (transport_fetch_refs(transport, mapped_refs))
+				die(_("remote transport reported error"));
 		}
 
 		remote_head = find_ref_by_name(refs, "HEAD");
@@ -1380,9 +1379,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (is_local)
 		clone_local(path, git_dir);
 	else if (refs && complete_refs_before_fetch) {
-		err = transport_fetch_refs(transport, mapped_refs);
-		if (err)
-			goto cleanup;
+		if (transport_fetch_refs(transport, mapped_refs))
+			die(_("remote transport reported error"));
 	}
 
 	update_remote_refs(refs, mapped_refs, remote_head_points_at,
@@ -1410,7 +1408,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	junk_mode = JUNK_LEAVE_REPO;
 	err = checkout(submodule_progress);
 
-cleanup:
 	free(remote_name);
 	strbuf_release(&reflog_msg);
 	strbuf_release(&branch_top);
diff --git a/t/t5600-clone-fail-cleanup.sh b/t/t5600-clone-fail-cleanup.sh
index 4a1a912e03..5bf10261d3 100755
--- a/t/t5600-clone-fail-cleanup.sh
+++ b/t/t5600-clone-fail-cleanup.sh
@@ -97,4 +97,11 @@ test_expect_success 'failed clone into empty leaves directory (separate, wt)' '
 	test_dir_is_empty empty-wt
 '
 
+test_expect_success 'transport failure cleans up directory' '
+	test_must_fail git clone --no-local \
+		-u "f() { git-upload-pack \"\$@\"; return 1; }; f" \
+		foo broken-clone &&
+	test_path_is_missing broken-clone
+'
+
 test_done
-- 
2.32.0.rc0.424.g95d3bde94f
