Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 824D11FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 21:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751636AbdBHVBc (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 16:01:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:51794 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751305AbdBHVBX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 16:01:23 -0500
Received: (qmail 28472 invoked by uid 109); 8 Feb 2017 20:53:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 20:53:22 +0000
Received: (qmail 7312 invoked by uid 111); 8 Feb 2017 20:53:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Feb 2017 15:53:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Feb 2017 15:53:19 -0500
Date:   Wed, 8 Feb 2017 15:53:19 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 11/11] receive-pack: avoid duplicates between our refs and
 alternates
Message-ID: <20170208205319.6ebuwv23bqxjuktz@sigill.intra.peff.net>
References: <20170208205219.twgm5rggovqbepte@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170208205219.twgm5rggovqbepte@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We de-duplicate ".have" refs among themselves, but never
check if they are duplicates of our local refs. It's not
unreasonable that they would be if we are a "--shared" or
"--reference" clone of a similar repository; we'd have all
the same tags.

We can handle this by inserting our local refs into the
oidset, but obviously not suppressing duplicates (since the
refnames are important).

Note that this also switches the order in which we advertise
refs, processing ours first and then any alternates. The
order shouldn't matter (and arguably showing our refs first
makes more sense).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/receive-pack.c |  4 +++-
 t/t5400-send-pack.sh   | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c23b0cce8..9ed8fbbfa 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -268,6 +268,8 @@ static int show_ref_cb(const char *path_full, const struct object_id *oid,
 		if (oidset_insert(seen, oid))
 			return 0;
 		path = ".have";
+	} else {
+		oidset_insert(seen, oid);
 	}
 	show_ref(path, oid->hash);
 	return 0;
@@ -289,9 +291,9 @@ static void write_head_info(void)
 {
 	static struct oidset seen = OIDSET_INIT;
 
+	for_each_ref(show_ref_cb, &seen);
 	for_each_alternate_ref(show_one_alternate_ref, &seen);
 	oidset_clear(&seen);
-	for_each_ref(show_ref_cb, &seen);
 	if (!sent_capabilities)
 		show_ref("capabilities^{}", null_sha1);
 
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 305ca7a93..3331e0f53 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -255,4 +255,42 @@ test_expect_success 'deny pushing to delete current branch' '
 	)
 '
 
+extract_ref_advertisement () {
+	perl -lne '
+		# \\ is there to skip capabilities after \0
+		/push< ([^\\]+)/ or next;
+		exit 0 if $1 eq "0000";
+		print $1;
+	'
+}
+
+test_expect_success 'receive-pack de-dupes .have lines' '
+	git init shared &&
+	git -C shared commit --allow-empty -m both &&
+	git clone -s shared fork &&
+	(
+		cd shared &&
+		git checkout -b only-shared &&
+		git commit --allow-empty -m only-shared &&
+		git update-ref refs/heads/foo HEAD
+	) &&
+
+	# Notable things in this expectation:
+	#  - local refs are not de-duped
+	#  - .have does not duplicate locals
+	#  - .have does not duplicate itself
+	local=$(git -C fork rev-parse HEAD) &&
+	shared=$(git -C shared rev-parse only-shared) &&
+	cat >expect <<-EOF &&
+	$local refs/heads/master
+	$local refs/remotes/origin/HEAD
+	$local refs/remotes/origin/master
+	$shared .have
+	EOF
+
+	GIT_TRACE_PACKET=$(pwd)/trace git push fork HEAD:foo &&
+	extract_ref_advertisement <trace >refs &&
+	test_cmp expect refs
+'
+
 test_done
-- 
2.12.0.rc0.371.ga6cf8653b
