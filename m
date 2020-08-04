Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50FFC433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 07:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C30F322B40
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 07:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbgHDHny (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 03:43:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:47368 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbgHDHny (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 03:43:54 -0400
Received: (qmail 578 invoked by uid 109); 4 Aug 2020 07:43:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Aug 2020 07:43:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9657 invoked by uid 111); 4 Aug 2020 07:43:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Aug 2020 03:43:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 4 Aug 2020 03:43:53 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 1/3] config: work around gcc-10 -Wstringop-overflow warning
Message-ID: <20200804074353.GA284046@coredump.intra.peff.net>
References: <20200804074146.GA190027@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200804074146.GA190027@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Compiling with gcc-10, -O2, and -fsanitize=undefined results in a
compiler warning:

  config.c: In function ‘git_config_copy_or_rename_section_in_file’:
  config.c:3170:17: error: writing 1 byte into a region of size 0 [-Werror=stringop-overflow=]
   3170 |       output[0] = '\t';
        |       ~~~~~~~~~~^~~~~~
  config.c:3076:7: note: at offset -1 to object ‘buf’ with size 1024 declared here
   3076 |  char buf[1024];
        |       ^~~

This is a false positive. The interesting lines of code are:

  int i;
  char *output = buf;
  ...
  for (i = 0; buf[i] && isspace(buf[i]); i++)
          ; /* do nothing */
  ...
  int offset;
  offset = section_name_match(&buf[i], old_name);
  if (offset > 0) {
          ...
          output += offset + i;
          if (strlen(output) > 0) {
		  /*
		   * More content means there's
		   * a declaration to put on the
		   * next line; indent with a
		   * tab
		   */
		  output -= 1;
		  output[0] = '\t';
	  }
  }

So we do assign output to buf initially. Later we increment it based on
"offset" and "i" and then subtract "1" from it. That latter step is what
the compiler is complaining about; it could lead to going off the left
side of the array if "output == buf" at the moment of the subtraction.
For that to be the case, then "offset + i" would have to be 0. But that
can't happen:

  - we know that "offset" is at least 1, since we're in a conditional
    block that checks that

  - we know that "i" is not negative, since it started at 0 and only
    incremented over whitespace

So the sum must be at least 1, and therefore it's OK to subtract one
from "output".

But that's not quite the whole story. Since "i" is an int, it could in
theory be possible to overflow to negative (when counting whitespace on
a very large string). But we know that's impossible because we're
counting the 1024-byte buffer we just fed to fgets(), so it can never be
larger than that.

Switching the type of "i" to "unsigned" makes the warning go away, so
let's do that.

Arguably size_t is an even better type (for this and for the other
length fields), but switching to it produces a similar but distinct
warning:

  config.c: In function ‘git_config_copy_or_rename_section_in_file’:
  config.c:3170:13: error: array subscript -1 is outside array bounds of ‘char[1024]’ [-Werror=array-bounds]
   3170 |       output[0] = '\t';
        |       ~~~~~~^~~
  config.c:3076:7: note: while referencing ‘buf’
   3076 |  char buf[1024];
        |       ^~~

If we were to ever switch off of fgets() to strbuf_getline() or similar,
we'd probably need to use size_t to avoid other overflow problems. But
for now we know we're safe because of the small fixed size of our
buffer.

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 8db9c77098..2b79fe76ad 100644
--- a/config.c
+++ b/config.c
@@ -3115,7 +3115,7 @@ static int git_config_copy_or_rename_section_in_file(const char *config_filename
 	}
 
 	while (fgets(buf, sizeof(buf), config_file)) {
-		int i;
+		unsigned i;
 		int length;
 		int is_section = 0;
 		char *output = buf;
-- 
2.28.0.536.ga4d8134877

