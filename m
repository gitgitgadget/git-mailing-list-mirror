Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17BE71F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 14:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbeKMAkk (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 19:40:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:35668 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726385AbeKMAkk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 19:40:40 -0500
Received: (qmail 29239 invoked by uid 109); 12 Nov 2018 14:47:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Nov 2018 14:47:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11210 invoked by uid 111); 12 Nov 2018 14:46:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Nov 2018 09:46:25 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2018 09:47:04 -0500
Date:   Mon, 12 Nov 2018 09:47:04 -0500
From:   Jeff King <peff@peff.net>
To:     Geert Jansen <gerardu@amazon.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Takuto Ikuta <tikuta@chromium.org>
Subject: [PATCH 2/9] submodule--helper: prefer strip_suffix() to ends_with()
Message-ID: <20181112144703.GB7400@sigill.intra.peff.net>
References: <20181112144627.GA2478@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181112144627.GA2478@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using strip_suffix() lets us avoid repeating ourselves. It also makes
the handling of "/" a bit less subtle (we strip one less character than
we matched in order to leave it in place, but we can just as easily
include the "/" when we add more path components).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/submodule--helper.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 676175b9be..28b9449e82 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1268,16 +1268,17 @@ static int add_possible_reference_from_superproject(
 		struct alternate_object_database *alt, void *sas_cb)
 {
 	struct submodule_alternate_setup *sas = sas_cb;
+	size_t len;
 
 	/*
 	 * If the alternate object store is another repository, try the
 	 * standard layout with .git/(modules/<name>)+/objects
 	 */
-	if (ends_with(alt->path, "/objects")) {
+	if (strip_suffix(alt->path, "/objects", &len)) {
 		char *sm_alternate;
 		struct strbuf sb = STRBUF_INIT;
 		struct strbuf err = STRBUF_INIT;
-		strbuf_add(&sb, alt->path, strlen(alt->path) - strlen("objects"));
+		strbuf_add(&sb, alt->path, len);
 
 		/*
 		 * We need to end the new path with '/' to mark it as a dir,
@@ -1285,7 +1286,7 @@ static int add_possible_reference_from_superproject(
 		 * as the last part of a missing submodule reference would
 		 * be taken as a file name.
 		 */
-		strbuf_addf(&sb, "modules/%s/", sas->submodule_name);
+		strbuf_addf(&sb, "/modules/%s/", sas->submodule_name);
 
 		sm_alternate = compute_alternate_path(sb.buf, &err);
 		if (sm_alternate) {
-- 
2.19.1.1577.g2c5b293d4f

