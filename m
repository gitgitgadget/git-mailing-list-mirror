Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B6AC20229
	for <e@80x24.org>; Fri, 21 Oct 2016 22:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935519AbcJUWjk (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 18:39:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58863 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935082AbcJUWji (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 18:39:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 619C948E75;
        Fri, 21 Oct 2016 18:39:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=h++o
        mFrKenxf1Z61Z8gUZkRFRd8=; b=f+433YDJhuqY0Wev4RG3ZEd6SK3+x0i/20eK
        O8A8cjGADviW2Copgc8UWmO8LCdUMUdWKO+sMcPgTDP/wCUQJ8iRZ+JCt1CUXLHe
        O3jwcAV6Mx4801kFOkkZJSmHzjYU4LNMKO/1IczBAzgtjM82Nun7JmIcdRjiQ4y9
        SwYemlM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=fXym2a
        PQAztIIzONmEoNZOjdYVSjK4KJ/529fNggUKe+W3j6Al/mnufg5hlxbckO1kNhRT
        I72p3bC267EVnSl6jRWpxSGk1ED99MmzCvAGW/Db7jTSDpVM+rKVv9pRsuycGsAw
        Pif3RwSQ0c8IJLd/rPQaAzQM8p8mIO5Wz5nac=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 596FE48E74;
        Fri, 21 Oct 2016 18:39:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CCD2A48E71;
        Fri, 21 Oct 2016 18:39:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH 3/3] transport: allow summary-width to be computed dynamically
Date:   Fri, 21 Oct 2016 15:39:27 -0700
Message-Id: <20161021223927.26364-4-gitster@pobox.com>
X-Mailer: git-send-email 2.10.1-723-g2384e83bc3
In-Reply-To: <20161021223927.26364-1-gitster@pobox.com>
References: <xmqqa8dxbb9r.fsf@gitster.mtv.corp.google.com>
 <20161021223927.26364-1-gitster@pobox.com>
X-Pobox-Relay-ID: 3ECD4AD6-97DF-11E6-855A-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now we have identified three callchains that have a set of refs that
they want to show their <old, new> object names in an aligned output,
we can replace their reference to the constant TRANSPORT_SUMMARY_WIDTH
with a helper function call to transport_summary_width() that takes
the set of ref as a parameter.  This step does not yet iterate over
the refs and compute, which is left as an exercise to the readers.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fetch.c | 4 ++--
 transport.c     | 7 ++++++-
 transport.h     | 2 +-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 40696e5338..09813cd826 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -722,7 +722,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	char *url;
 	const char *filename = dry_run ? "/dev/null" : git_path_fetch_head();
 	int want_status;
-	int summary_width = TRANSPORT_SUMMARY_WIDTH;
+	int summary_width = transport_summary_width(ref_map);
 
 	fp = fopen(filename, "a");
 	if (!fp)
@@ -906,7 +906,7 @@ static int prune_refs(struct refspec *refs, int ref_count, struct ref *ref_map,
 	int url_len, i, result = 0;
 	struct ref *ref, *stale_refs = get_stale_heads(refs, ref_count, ref_map);
 	char *url;
-	int summary_width = TRANSPORT_SUMMARY_WIDTH;
+	int summary_width = transport_summary_width(stale_refs);
 	const char *dangling_msg = dry_run
 		? _("   (%s will become dangling)")
 		: _("   (%s has become dangling)");
diff --git a/transport.c b/transport.c
index ec02b78924..d4b8bf5f25 100644
--- a/transport.c
+++ b/transport.c
@@ -429,6 +429,11 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count,
 	return 1;
 }
 
+int transport_summary_width(const struct ref *refs)
+{
+	return (2 * FALLBACK_DEFAULT_ABBREV + 3);
+}
+
 void transport_print_push_status(const char *dest, struct ref *refs,
 				  int verbose, int porcelain, unsigned int *reject_reasons)
 {
@@ -436,7 +441,7 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 	int n = 0;
 	unsigned char head_sha1[20];
 	char *head;
-	int summary_width = TRANSPORT_SUMMARY_WIDTH;
+	int summary_width = transport_summary_width(refs);
 
 	head = resolve_refdup("HEAD", RESOLVE_REF_READING, head_sha1, NULL);
 
diff --git a/transport.h b/transport.h
index e783377e40..706d99e818 100644
--- a/transport.h
+++ b/transport.h
@@ -142,7 +142,7 @@ struct transport {
 #define TRANSPORT_PUSH_ATOMIC 8192
 #define TRANSPORT_PUSH_OPTIONS 16384
 
-#define TRANSPORT_SUMMARY_WIDTH (2 * FALLBACK_DEFAULT_ABBREV + 3)
+extern int transport_summary_width(const struct ref *refs);
 
 /* Returns a transport suitable for the url */
 struct transport *transport_get(struct remote *, const char *);
-- 
2.10.1-723-g2384e83bc3

