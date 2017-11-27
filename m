Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7396120A40
	for <e@80x24.org>; Mon, 27 Nov 2017 04:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751045AbdK0E1u (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 23:27:50 -0500
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:54962
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750841AbdK0E1t (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2017 23:27:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1511756868;
        h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=klUV8hFIjeoY9x72HI00+VoEvhEEGdgo1hrQsx0fBeA=;
        b=GIYGiEon2jEnsCAsIA9QT4SvMF8GBsKLlHQQ32cQbKwEuM9wUb3YKP7M/ltddznd
        WNdlrtgmFnqy13B/5U1frc61YFyf9wM3H4ZD68a8ZpIgX6wj4ttyJ+biQRUBXkJWxxR
        84hjJjp1bzf2450r0Q15bxnK9n3vQDhsSl9hItSo=
From:   Takuto Ikuta <tikuta@google.com>
To:     git@vger.kernel.org
Message-ID: <0102015ffbbb2905-570eadd1-6b5c-46af-a3a9-bddfbd01c242-000000@eu-west-1.amazonses.com>
Subject: [PATCH] Use OBJECT_INFO_QUICK to speedup git fetch-pack
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 27 Nov 2017 04:27:47 +0000
X-SES-Outgoing: 2017.11.27-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do not call prepare_packed_git for every refs.
In fetch-pack, git list ups entries in .git/objects/pack
directory for each refs.
Such behavior makes git fetch-pack slow for the repository having the
large number of refs, especially for windows.

For chromium repository, having more than 300000 remote refs, git fetch
takes more than 3 minutes if fetch-pack runs on my windows workstation.
This patch improves the time to around 17 seconds in the same machine.

Signed-off-by: Takuto Ikuta <tikuta@google.com>
---
 fetch-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 008b25d3db087..0184584e80599 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -716,7 +716,7 @@ static int everything_local(struct fetch_pack_args *args,
 	for (ref = *refs; ref; ref = ref->next) {
 		struct object *o;
 
-		if (!has_object_file(&ref->old_oid))
+		if (!has_object_file_with_flags(&ref->old_oid, OBJECT_INFO_QUICK))
 			continue;
 
 		o = parse_object(&ref->old_oid);

--
https://github.com/git/git/pull/437
