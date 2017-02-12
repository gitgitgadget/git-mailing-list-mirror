Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D3531FCC7
	for <e@80x24.org>; Sun, 12 Feb 2017 00:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751038AbdBLAef (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Feb 2017 19:34:35 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:52844 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751014AbdBLAee (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2017 19:34:34 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id EB7D01FAF4;
        Sun, 12 Feb 2017 00:34:32 +0000 (UTC)
Date:   Sun, 12 Feb 2017 00:34:32 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [RFC] send-email: avoid duplicate In-Reply-To and References headers
Message-ID: <20170212003432.GA19519@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When parsing an mbox, it is possible to get existing In-Reply-To
and References headers blindly appended into the headers of
message we generate.   This is probably the wrong thing to do
and we should prioritize what was given in the command-line,
cover letter, and previously-sent messages.

One example I've noticed in the wild was:

https://public-inbox.org/git/20161111124541.8216-17-vascomalmeida@sapo.pt/raw
---
 I'm not completely sure this is what Vasco was doing in that
 message, so it's an RFC for now...

 git-send-email.perl | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 068d60b3e6..5ab3d8585c 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1543,7 +1543,13 @@ foreach my $t (@files) {
 			elsif (!/^Date:\s/i && /^[-A-Za-z]+:\s+\S/) {
 				push @xh, $_;
 			}
-
+			elsif (/^(?:References|In-Reply-To):/i) {
+				if (defined $initial_reply_to || $thread) {
+					warn
+"Ignoring $_ header in mbox body since it conflicts with\n
+--in-reply-to and --thread switches\n"
+				}
+			}
 		} else {
 			# In the traditional
 			# "send lots of email" format,
-- 
EW

