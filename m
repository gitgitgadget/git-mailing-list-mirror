Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A09231FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 19:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755826AbdC1TrB (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 15:47:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:53164 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755801AbdC1TrB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 15:47:01 -0400
Received: (qmail 11801 invoked by uid 109); 28 Mar 2017 19:46:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 19:46:46 +0000
Received: (qmail 6716 invoked by uid 111); 28 Mar 2017 19:47:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 15:47:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 15:46:44 -0400
Date:   Tue, 28 Mar 2017 15:46:44 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 11/18] name-rev: replace static buffer with strbuf
Message-ID: <20170328194644.jbgf3do2dp6m2a3w@sigill.intra.peff.net>
References: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When name-rev needs to format an actual name, we do so into
a fixed-size buffer. That includes the actual ref tip, as
well as any traversal information. Since refs can exceed
1024 bytes, this means you can get a bogus result. E.g.,
doing:

   git tag $(perl -e 'print join("/", 1..1024)')
   git describe --contains HEAD^

results in ".../282/283", when it should be
".../1023/1024~1".

We can solve this by using a heap buffer. We'll use a
strbuf, which lets us write into the same buffer from our
loop without having to reallocate.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/name-rev.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 8bdc3eaa6..92a5d8a5d 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -238,10 +238,9 @@ static const char *get_exact_ref_match(const struct object *o)
 	return NULL;
 }
 
-/* returns a static buffer */
-static const char *get_rev_name(const struct object *o)
+/* may return a constant string or use "buf" as scratch space */
+static const char *get_rev_name(const struct object *o, struct strbuf *buf)
 {
-	static char buffer[1024];
 	struct rev_name *n;
 	struct commit *c;
 
@@ -258,10 +257,9 @@ static const char *get_rev_name(const struct object *o)
 		int len = strlen(n->tip_name);
 		if (len > 2 && !strcmp(n->tip_name + len - 2, "^0"))
 			len -= 2;
-		snprintf(buffer, sizeof(buffer), "%.*s~%d", len, n->tip_name,
-				n->generation);
-
-		return buffer;
+		strbuf_reset(buf);
+		strbuf_addf(buf, "%.*s~%d", len, n->tip_name, n->generation);
+		return buf->buf;
 	}
 }
 
@@ -271,10 +269,11 @@ static void show_name(const struct object *obj,
 {
 	const char *name;
 	const struct object_id *oid = &obj->oid;
+	struct strbuf buf = STRBUF_INIT;
 
 	if (!name_only)
 		printf("%s ", caller_name ? caller_name : oid_to_hex(oid));
-	name = get_rev_name(obj);
+	name = get_rev_name(obj, &buf);
 	if (name)
 		printf("%s\n", name);
 	else if (allow_undefined)
@@ -283,6 +282,7 @@ static void show_name(const struct object *obj,
 		printf("%s\n", find_unique_abbrev(oid->hash, DEFAULT_ABBREV));
 	else
 		die("cannot describe '%s'", oid_to_hex(oid));
+	strbuf_release(&buf);
 }
 
 static char const * const name_rev_usage[] = {
@@ -294,6 +294,7 @@ static char const * const name_rev_usage[] = {
 
 static void name_rev_line(char *p, struct name_ref_data *data)
 {
+	struct strbuf buf = STRBUF_INIT;
 	int forty = 0;
 	char *p_start;
 	for (p_start = p; *p; p++) {
@@ -314,7 +315,7 @@ static void name_rev_line(char *p, struct name_ref_data *data)
 				struct object *o =
 					lookup_object(sha1);
 				if (o)
-					name = get_rev_name(o);
+					name = get_rev_name(o, &buf);
 			}
 			*(p+1) = c;
 
@@ -332,6 +333,8 @@ static void name_rev_line(char *p, struct name_ref_data *data)
 	/* flush */
 	if (p_start != p)
 		fwrite(p_start, p - p_start, 1, stdout);
+
+	strbuf_release(&buf);
 }
 
 int cmd_name_rev(int argc, const char **argv, const char *prefix)
-- 
2.12.2.845.g55fcf8b10

