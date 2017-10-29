Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E87B202A0
	for <e@80x24.org>; Sun, 29 Oct 2017 16:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751400AbdJ2QhY (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 12:37:24 -0400
Received: from marcos.anarc.at ([206.248.172.91]:51054 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750959AbdJ2QhX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 12:37:23 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])      (Authenticated sender: anarcat) with ESMTPSA id 5357D1A00A8
From:   =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>
Subject: [PATCH] remote-mediawiki: limit filenames to legal
Date:   Sun, 29 Oct 2017 12:37:14 -0400
Message-Id: <20171029163714.4818-1-anarcat@debian.org>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

mediawiki pages can have names longer than NAME_MAX (generally 255)
characters, which will fail on checkout. we simply strip out extra
characters, which may mean one page's content will overwrite another
(the last editing winning).

ideally, we would do a more clever system to find unique names, but
that would be more difficult and error prone for a situation that
should rarely happen in the first place.
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-to-git/git-remote-mediawiki.perl
index e7f857c1a..58870d197 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -18,6 +18,7 @@ use Git::Mediawiki qw(clean_filename smudge_filename connect_maybe
 					EMPTY HTTP_CODE_OK);
 use DateTime::Format::ISO8601;
 use warnings;
+use POSIX;
 
 # By default, use UTF-8 to communicate with Git and the user
 binmode STDERR, ':encoding(UTF-8)';
@@ -703,7 +704,7 @@ sub import_file_revision {
 		%mediafile = %{$mediafile};
 	}
 
-	my $title = $commit{title};
+	my $title = substr($commit{title}, 0, NAME_MAX);
 	my $comment = $commit{comment};
 	my $content = $commit{content};
 	my $author = $commit{author};
-- 
2.11.0

