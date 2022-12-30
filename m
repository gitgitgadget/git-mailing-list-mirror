Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5031BC4167B
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 16:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiL3Qbz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Dec 2022 11:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiL3Qbx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 11:31:53 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6173FDF
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 08:31:50 -0800 (PST)
Received: (qmail 31915 invoked by uid 109); 30 Dec 2022 16:31:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 30 Dec 2022 16:31:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8782 invoked by uid 111); 30 Dec 2022 16:31:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 30 Dec 2022 11:31:49 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 30 Dec 2022 11:31:47 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason via
         GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, avarab@gmail.com, mjcheetham@outlook.com,
        steadmon@google.com, chooglen@google.com, jonathantanmy@google.com,
        dyroneteng@gmail.com, Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v4 06/11] bundle-uri client: add helper for testing server
Message-ID: <Y68Sc3V5x6xSucZW@coredump.intra.peff.net>
References: <pull.1400.v3.git.1670262639.gitgitgadget@gmail.com>
 <pull.1400.v4.git.1671722058.gitgitgadget@gmail.com>
 <13e4c82e3380d8b91583550e61671bd8eac69ab1.1671722058.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13e4c82e3380d8b91583550e61671bd8eac69ab1.1671722058.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 22, 2022 at 03:14:12PM +0000, Ævar Arnfjörð Bjarmason via GitGitGadget wrote:

> +static int cmd_ls_remote(int argc, const char **argv)
> +{
> +	const char *uploadpack = NULL;
> +	struct string_list server_options = STRING_LIST_INIT_DUP;

These two variables are initialized to NULL and empty respectively, and
then not accessed until here:

> +	transport = transport_get(remote, NULL);
> +	if (uploadpack)
> +		transport_set_option(transport, TRANS_OPT_UPLOADPACK, uploadpack);
> +	if (server_options.nr)
> +		transport->server_options = &server_options;

where neither conditional will trigger, since they will still be NULL
and empty.

Is this function missing some argv parsing that would affect these? Or
if it's not needed, would we want to remove them, like:

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

Not a huge deal, but I noticed that Coverity complained about the
uploadpack one because this hit 'next' (the server_options one I found
manually, but it was kind of obvious when looking at the other).

-Peff
