Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566B7C3DA7A
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 08:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjAFIsa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 03:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjAFIs1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 03:48:27 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E4F54724
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 00:48:26 -0800 (PST)
Received: (qmail 12799 invoked by uid 109); 6 Jan 2023 08:48:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Jan 2023 08:48:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12588 invoked by uid 111); 6 Jan 2023 08:48:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Jan 2023 03:48:28 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 6 Jan 2023 03:48:23 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason via
         GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Victoria Dye <vdye@github.com>
Subject: [PATCH] test-bundle-uri: drop unused variables
Message-ID: <Y7fgV5eFx78BHdQ4@coredump.intra.peff.net>
References: <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
 <pull.1400.v4.git.1671722058.gitgitgadget@gmail.com>
 <13e4c82e3380d8b91583550e61671bd8eac69ab1.1671722058.git.gitgitgadget@gmail.com>
 <Y68Sc3V5x6xSucZW@coredump.intra.peff.net>
 <9bc96719-d6c7-a127-d80e-a42ecaa0803c@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9bc96719-d6c7-a127-d80e-a42ecaa0803c@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 05, 2023 at 02:09:34PM -0500, Derrick Stolee wrote:

> > Not a huge deal, but I noticed that Coverity complained about the
> > uploadpack one because this hit 'next' (the server_options one I found
> > manually, but it was kind of obvious when looking at the other).
> 
> Yes, removing these lines would be fine. Perhaps there were
> uses for these in an earlier version that were dropped. But
> we can remove them now and then add them back when they
> actually connect to functionality.

Thanks for confirming. Here's a patch that can go on top of
ds/bundle-uri-4 (or just on master, as that topic has now graduated).

-- >8 --
Subject: [PATCH] test-bundle-uri: drop unused variables

Commit 70b9c10373 (bundle-uri client: add helper for testing server,
2022-12-22) added a cmd_ls_remote() function which contains "uploadpack"
and "server_options" variables. Neither of these variables is ever
modified after being initialized, so the code to handle non-NULL and
non-empty values is impossible to reach.

While in theory we might add command-line parsing to set these, let's
drop the dead code for now in the name of cleanliness. It's easy enough
to add it back later if need be.

Noticed by Coverity.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-bundle-uri.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/t/helper/test-bundle-uri.c b/t/helper/test-bundle-uri.c
index 5df5bc3b89..b18e760310 100644
--- a/t/helper/test-bundle-uri.c
+++ b/t/helper/test-bundle-uri.c
@@ -76,8 +76,6 @@ static int cmd__bundle_uri_parse(int argc, const char **argv, enum input_mode mo
 
 static int cmd_ls_remote(int argc, const char **argv)
 {
-	const char *uploadpack = NULL;
-	struct string_list server_options = STRING_LIST_INIT_DUP;
 	const char *dest;
 	struct remote *remote;
 	struct transport *transport;
@@ -95,11 +93,6 @@ static int cmd_ls_remote(int argc, const char **argv)
 		die(_("remote '%s' has no configured URL"), dest);
 
 	transport = transport_get(remote, NULL);
-	if (uploadpack)
-		transport_set_option(transport, TRANS_OPT_UPLOADPACK, uploadpack);
-	if (server_options.nr)
-		transport->server_options = &server_options;
-
 	if (transport_get_remote_bundle_uri(transport) < 0) {
 		error(_("could not get the bundle-uri list"));
 		status = 1;
-- 
2.39.0.463.g3774f23bc9

