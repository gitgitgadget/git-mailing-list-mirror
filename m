Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44766C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 10:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F0FD61932
	for <git@archiver.kernel.org>; Tue, 11 May 2021 10:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhEKKii (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 06:38:38 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:60454 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230166AbhEKKih (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 06:38:37 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id ED0211F5AE;
        Tue, 11 May 2021 10:37:30 +0000 (UTC)
Date:   Tue, 11 May 2021 10:37:30 +0000
From:   Eric Wong <e@80x24.org>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] remote-curl: fix clone on sha256 repos
Message-ID: <20210511103730.GA15003@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm not very familiar with the way some of this stuff works, but
the patch below seems to fix clone for me.

I originally tried changing the cmd_main->set_option code path,
but value is always set to "true" for object-format because
it only sees "option object-format" with no arg

		} else if (skip_prefix(buf.buf, "option ", &arg)) {
			char *value = strchr(arg, ' ');
			int result;

			if (value)
				*value++ = '\0';
			else
				value = "true";

			result = set_option(arg, value);

So when set_option gets called, hash_algo_by_name isn't:

	} else if (!strcmp(name, "object-format")) {
		int algo;
		options.object_format = 1;
		if (strcmp(value, "true")) {
			/* XXX this branch is never taken: */
			algo = hash_algo_by_name(value);
			if (algo == GIT_HASH_UNKNOWN)
				die("unknown object format '%s'", value);
			options.hash_algo = &hash_algos[algo];
		}
		return 0;

So I'm not sure if the above is incomplete or dead code.
Anyways, I arrived at the following and it works for me:

-----------8<---------
Subject: [PATCH] remote-curl: fix clone on sha256 repos

The remote-https process needs to update it's own instance of
`the_repository' when it sees an HTTP(S) remote is using sha256.
Without this, parse_oid_hex() fails to handle sha256 OIDs when
it's eventually called by parse_fetch().

Tested with:

	git clone https://yhbt.net/sha256test.git
	GIT_SMART_HTTP=0 git clone https://yhbt.net/sha256test.git
	(plain http:// also works)

Cloning the URL via git:// required no changes

Signed-off-by: Eric Wong <e@80x24.org>
---
 remote-curl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/remote-curl.c b/remote-curl.c
index 0290b04891..9d432c299a 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -555,6 +555,8 @@ static void output_refs(struct ref *refs)
 	struct ref *posn;
 	if (options.object_format && options.hash_algo) {
 		printf(":object-format %s\n", options.hash_algo->name);
+		repo_set_hash_algo(the_repository,
+				hash_algo_by_ptr(options.hash_algo));
 	}
 	for (posn = refs; posn; posn = posn->next) {
 		if (posn->symref)
