Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09754202A5
	for <e@80x24.org>; Sat, 23 Sep 2017 05:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750766AbdIWFza (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 01:55:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:47810 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750738AbdIWFz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 01:55:29 -0400
Received: (qmail 26890 invoked by uid 109); 23 Sep 2017 05:55:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 23 Sep 2017 05:55:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11082 invoked by uid 111); 23 Sep 2017 05:56:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 23 Sep 2017 01:56:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Sep 2017 01:55:26 -0400
Date:   Sat, 23 Sep 2017 01:55:26 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Adam Dinwoodie <adam@dinwoodie.org>
Subject: [PATCH] doc: put literal block delimiter around table
Message-ID: <20170923055526.audcysedpxdst6tm@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git-read-tree manpage has a table that is meant to
be shown with its spacing exactly as it is in the source. We
mark it as a "literal paragraph" by indenting each line by
at least one space. This renders OK with asciidoc for both
the HTML and manpage versions.

But there are two problems when we render it with
asciidoctor.

The first is that some lines mix tabs and spaces.  Even if
asciidoctor is correctly configured for 8-space tabs, it
seems to handle this case differently, soaking up some of
the initial literal-paragraph spaces and mis-aligning the
table text.

The second problem is that the table uses blank lines to
group rows. But as blank lines separate paragraphs in
asciidoc, this actually means that each chunk of the table
is rendered in its own pre-formatted <div> block. This
happens even with vanilla asciidoc, but there's no visible
result because the literal paragraphs aren't styled in any
special way. But with asciidoctor (or at least the styles
used on git-scm.com), literal paragraphs are styled with a
different background.  This breaks the table into a visually
distracting sequence of chunks.

We can fix both by adding a literal-paragraph block
delimiter. That turns the whole table into a single block
(for both implementations) and causes asciidoctor to render
the indentation as it is in the source.

Reported-at: https://github.com/git/git-scm.com/issues/1023
Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-read-tree.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 02576d8c0a..72bd809fb8 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -179,6 +179,7 @@ Here are the "carry forward" rules, where "I" denotes the index,
 "clean" means that index and work tree coincide, and "exists"/"nothing"
 refer to the presence of a path in the specified commit:
 
+....
 	I                   H        M        Result
        -------------------------------------------------------
      0  nothing             nothing  nothing  (does not happen)
@@ -217,6 +218,7 @@ refer to the presence of a path in the specified commit:
      19 no    no    yes     exists   exists   keep index
      20 yes   yes   no      exists   exists   use M
      21 no    yes   no      exists   exists   fail
+....
 
 In all "keep index" cases, the index entry stays as in the
 original index file.  If the entry is not up to date,
-- 
2.14.1.1053.gacbfefb3f2
