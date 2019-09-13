Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D74581F463
	for <e@80x24.org>; Fri, 13 Sep 2019 12:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbfIMMIy (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 08:08:54 -0400
Received: from sym2.noone.org ([178.63.92.236]:48836 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbfIMMIx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 08:08:53 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 46VDv80rbzzvjc1; Fri, 13 Sep 2019 14:08:51 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3] git-svn: trim leading and trailing whitespaces in author name
Date:   Fri, 13 Sep 2019 14:08:51 +0200
Message-Id: <20190913120851.23656-1-tklauser@distanz.ch>
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

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
v3:
 - check author string length after whitespace trimming
 - trim leading and trailing whitespaces in two separate steps

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
2.23.0.1.g588b4aa4a322.dirty

