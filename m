Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 100EF1F463
	for <e@80x24.org>; Mon, 23 Sep 2019 09:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407372AbfIWJz5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 05:55:57 -0400
Received: from sym2.noone.org ([178.63.92.236]:49076 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406222AbfIWJz5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 05:55:57 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 46cKT70DNrzvjc1; Mon, 23 Sep 2019 11:55:54 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] git-svn: trim leading and trailing whitespaces in author name
Date:   Mon, 23 Sep 2019 11:55:54 +0200
Message-Id: <20190923095554.579-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In some cases, the svn author names might contain leading or trailing
whitespaces, leading to messages such as:

  Author: user1
   not defined in authors.txt

(the trailing newline leads to the line break). The user "user1" is
defined in authors.txt though, e.g.

  user1 = User <user1@example.com>

Fix this by trimming the author name retreived from svn before using it
in check_author.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 perl/Git/SVN.pm | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 76b29659057d..4b28b8778474 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1491,6 +1491,10 @@ sub call_authors_prog {
 
 sub check_author {
 	my ($author) = @_;
+	if (defined $author) {
+		$author =~ s/^\s+//g;
+		$author =~ s/\s+$//g;
+	}
 	if (!defined $author || length $author == 0) {
 		$author = '(no author)';
 	}
-- 
2.23.0.257.gbff4bb1fe750

