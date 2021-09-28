Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02384C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 00:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA3B0611BD
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 00:45:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238343AbhI1ArP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 20:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238236AbhI1ArN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 20:47:13 -0400
X-Greylist: delayed 1672 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Sep 2021 17:45:34 PDT
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70144C061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 17:45:34 -0700 (PDT)
Received: from [2400:4160:1877:2b00:410a:fd15:2718:8b5d] (helo=glandium.org)
        by vuizook.err.no with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <glandium@glandium.org>)
        id 1mV0oS-0001WW-QL; Tue, 28 Sep 2021 00:17:37 +0000
Received: from glandium by goemon.lan with local (Exim 4.94.2)
        (envelope-from <glandium@goemon>)
        id 1mV0oN-00AsUY-Lf; Tue, 28 Sep 2021 09:17:31 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Mike Hommey <mh@glandium.org>
Subject: [PATCH] Don't ignore transport_disconnect error codes in fetch and clone
Date:   Tue, 28 Sep 2021 09:17:26 +0900
Message-Id: <20210928001726.2592734-1-mh@glandium.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a remote-helper fails in a way that is not directly visible in the
remote-helper protocol, the helper failure is ignored by git during
fetch or clone.

For example, a helper cannot directly report an error during an `import`
command (short of sending `feature done` to the fast-import file
descriptor and not sending a `done` later on).

Or if the helper crashes at the wrong moment, git doesn't notice and
thinks everything went well.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 builtin/clone.c | 5 +++--
 builtin/fetch.c | 6 +++---
 2 files changed, 6 insertions(+), 5 deletions(-)

What I'm not sure about is whether a message should be explicitly
printed by git itself in those cases.

diff --git a/builtin/clone.c b/builtin/clone.c
index 66fe66679c..f26fa027c5 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1398,7 +1398,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	submodule_progress = transport->progress;
 
 	transport_unlock_pack(transport);
-	transport_disconnect(transport);
+	err = transport_disconnect(transport);
 
 	if (option_dissociate) {
 		close_object_store(the_repository->objects);
@@ -1406,7 +1406,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	}
 
 	junk_mode = JUNK_LEAVE_REPO;
-	err = checkout(submodule_progress);
+	if (!err)
+		err = checkout(submodule_progress);
 
 	free(remote_name);
 	strbuf_release(&reflog_msg);
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 25740c13df..66bccf6f50 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1886,7 +1886,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
 {
 	struct refspec rs = REFSPEC_INIT_FETCH;
 	int i;
-	int exit_code;
+	int exit_code, disconnect_code;
 	int maybe_prune_tags;
 	int remote_via_config = remote_is_configured(remote, 0);
 
@@ -1952,9 +1952,9 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
 	exit_code = do_fetch(gtransport, &rs);
 	sigchain_pop(SIGPIPE);
 	refspec_clear(&rs);
-	transport_disconnect(gtransport);
+	disconnect_code = transport_disconnect(gtransport);
 	gtransport = NULL;
-	return exit_code;
+	return exit_code || disconnect_code;
 }
 
 int cmd_fetch(int argc, const char **argv, const char *prefix)
-- 
2.33.0

