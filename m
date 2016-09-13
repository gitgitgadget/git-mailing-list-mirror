Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D229D207DF
	for <e@80x24.org>; Tue, 13 Sep 2016 03:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754767AbcIMDX6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 23:23:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:42310 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750975AbcIMDXz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 23:23:55 -0400
Received: (qmail 20363 invoked by uid 109); 13 Sep 2016 03:23:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Sep 2016 03:23:56 +0000
Received: (qmail 18548 invoked by uid 111); 13 Sep 2016 03:24:05 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Sep 2016 23:24:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Sep 2016 20:23:52 -0700
Date:   Mon, 12 Sep 2016 20:23:52 -0700
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 10/16] pager: use callbacks instead of configset
Message-ID: <20160913032352.khrhkxpa3y4k22vz@sigill.intra.peff.net>
References: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While the cached configset interface is more pleasant to
use, it is not appropriate for "early" config like pager
setup, which must sometimes do tricky things like reading
from ".git/config" even when we have not set up the
repository.

As a preparatory step to handling these cases better, let's
switch back to using the callback interface, which gives us
more control.

Note that this is essentially a revert of 586f414 (pager.c:
replace `git_config()` with `git_config_get_value()`,
2014-08-07), but with some minor style fixups and
modernizations.

Signed-off-by: Jeff King <peff@peff.net>
---
 pager.c | 47 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/pager.c b/pager.c
index 8aa0a82..46cc411 100644
--- a/pager.c
+++ b/pager.c
@@ -183,23 +183,42 @@ int decimal_width(uintmax_t number)
 	return width;
 }
 
-/* returns 0 for "no pager", 1 for "use pager", and -1 for "not specified" */
-int check_pager_config(const char *cmd)
+struct pager_command_config_data {
+	const char *cmd;
+	int want;
+	char *value;
+};
+
+static int pager_command_config(const char *var, const char *value, void *vdata)
 {
-	int want = -1;
-	struct strbuf key = STRBUF_INIT;
-	const char *value = NULL;
-	strbuf_addf(&key, "pager.%s", cmd);
-	if (git_config_key_is_valid(key.buf) &&
-	    !git_config_get_value(key.buf, &value)) {
-		int b = git_config_maybe_bool(key.buf, value);
+	struct pager_command_config_data *data = vdata;
+	const char *cmd;
+
+	if (skip_prefix(var, "pager.", &cmd) && !strcmp(cmd, data->cmd)) {
+		int b = git_config_maybe_bool(var, value);
 		if (b >= 0)
-			want = b;
+			data->want = b;
 		else {
-			want = 1;
-			pager_program = xstrdup(value);
+			data->want = 1;
+			data->value = xstrdup(value);
 		}
 	}
-	strbuf_release(&key);
-	return want;
+
+	return 0;
+}
+
+/* returns 0 for "no pager", 1 for "use pager", and -1 for "not specified" */
+int check_pager_config(const char *cmd)
+{
+	struct pager_command_config_data data;
+
+	data.cmd = cmd;
+	data.want = -1;
+	data.value = NULL;
+
+	git_config(pager_command_config, &data);
+
+	if (data.value)
+		pager_program = data.value;
+	return data.want;
 }
-- 
2.10.0.230.g6f8d04b

