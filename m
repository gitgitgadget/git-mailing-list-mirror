Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0A5FA373D
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 09:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbiKAJif (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 05:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbiKAJiT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 05:38:19 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA11193D7
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 02:36:19 -0700 (PDT)
Received: (qmail 5457 invoked by uid 109); 1 Nov 2022 09:35:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Nov 2022 09:35:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21247 invoked by uid 111); 1 Nov 2022 09:35:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Nov 2022 05:35:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Nov 2022 05:35:55 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [RFC PATCH] fetch: stop emitting duplicate
 transfer.credentialsInUrl=warn warnings
Message-ID: <Y2Doe0ZGb3Zmmmen@coredump.intra.peff.net>
References: <pull.1399.git.1667245638.gitgitgadget@gmail.com>
 <RFC-patch-1.1-0266485bc6c-20221031T204149Z-avarab@gmail.com>
 <Y2CFRJLFRXvGwFBC@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y2CFRJLFRXvGwFBC@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2022 at 10:32:36PM -0400, Jeff King wrote:

> On Mon, Oct 31, 2022 at 09:47:08PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> >  * When we invoke e.g. "git-remote-https" (aka. "git-remote-curl")
> >    from "git fetch". For those cases let's pass down the equivalent of a
> >    "-c transfer.credentialsInUrl=allow", since we know that we've already
> >    inspected our remotes in the parent process.
> > 
> >    See 7390f05a3c6 (fetch: after refetch, encourage auto gc repacking,
> >    2022-03-28) for prior use of git_config_push_parameter() for this
> >    purpose, i.e. to push config parameters before invoking a
> >    sub-process.
> 
> So I guess I don't have any _specific_ thing that goes wrong with this
> approach, but it really feels sketchy to me. We are lying to
> sub-processes about the config the user asked for. And again, I see how
> it works, but I wonder if this kind of approach would ever backfire on
> us. For example, if transfer.credentialsInUrl=warn ever ended up having
> any side effects besides the warning, and the sub-processes ended up
> skipping those effects.
> 
> I know that's a hypothetical, and probably not even a likely one, but it
> just gets my spider sense tingling.

So inherently this is going to be ugly because it's crossing process
boundaries. But the more minimal fix I was thinking of would be
something like this:

diff --git a/remote.c b/remote.c
index 60869beebe..af5f95c719 100644
--- a/remote.c
+++ b/remote.c
@@ -615,6 +615,14 @@ const char *remote_ref_for_branch(struct branch *branch, int for_push)
 	return NULL;
 }
 
+static int test_and_set_env(const char *var)
+{
+	int ret = git_env_bool(var, 0);
+	if (!ret)
+		setenv(var, "1", 0);
+	return ret;
+}
+
 static void validate_remote_url(struct remote *remote)
 {
 	int i;
@@ -634,6 +642,9 @@ static void validate_remote_url(struct remote *remote)
 	else
 		die(_("unrecognized value transfer.credentialsInUrl: '%s'"), value);
 
+	if (test_and_set_env("GIT_CHECKED_CREDENTIALS_IN_URL"))
+		return;
+
 	for (i = 0; i < remote->url_nr; i++) {
 		struct url_info url_info = { 0 };
 

You can also put it lower in the function, when we actually warn, which
saves adding to the environment when there is nothing to warn about
(though this way, we avoid doing the redundant work).

Compared to munging the config, this seems shorter and simpler, and
there's no chance of us ever getting confused between the fake
"suppress" value and something the user actually asked for.

-Peff
