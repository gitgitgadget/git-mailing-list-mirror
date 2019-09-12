Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7A381F463
	for <e@80x24.org>; Thu, 12 Sep 2019 14:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732807AbfILO4k (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 10:56:40 -0400
Received: from sym2.noone.org ([178.63.92.236]:49378 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732727AbfILO4j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 10:56:39 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 46ThgB2XNgzvjcX; Thu, 12 Sep 2019 16:56:38 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2] git-svn: trim leading and trailing whitespaces in author name
Date:   Thu, 12 Sep 2019 16:56:38 +0200
Message-Id: <20190912145638.32192-1-tklauser@distanz.ch>
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
v2:
 - move whitespace trimming below defined'ness check as per Eric Sunshine's
   review comment

 perl/Git/SVN.pm | 1 +
 1 file changed, 1 insertion(+)

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 76b29659057d..d8c07419f51c 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -1494,6 +1494,7 @@ sub check_author {
 	if (!defined $author || length $author == 0) {
 		$author = '(no author)';
 	}
+	$author =~ s/^\s+|\s+$//g;
 	if (!defined $::users{$author}) {
 		if (defined $::_authors_prog) {
 			$::users{$author} = call_authors_prog($author);
-- 
2.23.0.dirty

