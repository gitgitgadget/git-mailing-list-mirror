Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F8AC61DA4
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 12:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjBIM3P (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 07:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjBIM27 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 07:28:59 -0500
Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00B186AD
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 04:28:58 -0800 (PST)
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id CAB121F5A0;
        Thu,  9 Feb 2023 12:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
        s=selector1; t=1675945738;
        bh=Vu9/Af9hZ/H0i8fMT8OafYf8nkn/ExLo774YB72gbkk=;
        h=Date:From:To:Cc:Subject:From;
        b=3fqvQgOMjOtJexicoHm5iR1xJr9UM8f28p5Vh5RB5qKjjouToCbpSPl1VyCE4n+IW
         C/dbvGw4u8X3ojvyZ+K53xU5rOmHzQ59mKNPH3GMt9ggCJ3ntvvd9G+EEYq40gbYps
         mmdBI7DuH2ccksy/KAfQT0b4ZEJ/M+T+8Fqzc7Tg=
Date:   Thu, 9 Feb 2023 12:28:57 +0000
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>
Subject: [RFC] fetch: support hideRefs to speed up connectivity checks
Message-ID: <20230209122857.M669733@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Not sure if this is the right way to go about this...
If it's close, maybe --exclude-hidden=fetch can be supported.
I'm using `receive' for now to minimize the change.

With roughly 800 remotes all fetching to their own refs/remotes/$REMOTE/*
island, the connectivity check[1] gets expensive for each fetch.

To do a no-op fetch on one $REMOTE out of hundreds, hideRefs now
allows the no-op fetch to take ~30 seconds instead of ~20 minutes
on a noisy, RAM-constrained machine (localhost, so no network latency):

   git -c transfer.hideRefs=refs \
	-c transfer.hideRefs='!refs/remotes/$REMOTE/' \
	fetch $REMOTE

I initially considered passing --negotiation-tip OIDs, but this seems
like an easier solution as I'm not yet familiar with this code
and prefer to avoid writing too much C.

[1] `git rev-list --objects --stdin --not --all --quiet --alternate-refs'
    gets painful w/o enough RAM to cache the repo, even on a SATA-2 SSD.
---
 builtin/fetch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 12978622d5..473d99fd26 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1131,6 +1131,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	if (!connectivity_checked) {
 		struct check_connected_options opt = CHECK_CONNECTED_INIT;
 
+		opt.exclude_hidden_refs_section = "receive";
 		rm = ref_map;
 		if (check_connected(iterate_ref_map, &rm, &opt)) {
 			rc = error(_("%s did not send all necessary objects\n"), url);
@@ -1324,6 +1325,7 @@ static int check_exist_and_connected(struct ref *ref_map)
 	}
 
 	opt.quiet = 1;
+	opt.exclude_hidden_refs_section = "receive";
 	return check_connected(iterate_ref_map, &rm, &opt);
 }
 
