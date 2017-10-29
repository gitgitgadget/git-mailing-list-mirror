Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DDCA202A0
	for <e@80x24.org>; Sun, 29 Oct 2017 18:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbdJ2SPU (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Oct 2017 14:15:20 -0400
Received: from marcos.anarc.at ([206.248.172.91]:52622 "EHLO marcos.anarc.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751681AbdJ2SPU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Oct 2017 14:15:20 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])      (Authenticated sender: anarcat) with ESMTPSA id 1CB811A00A8
From:   =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>
Subject: [PATCH v3] remote-mediawiki: limit filenames to legal
Date:   Sun, 29 Oct 2017 14:15:11 -0400
Message-Id: <20171029181511.29148-2-anarcat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20171029181511.29148-1-anarcat@debian.org>
References: <20171029163714.4818-1-anarcat@debian.org>
 <20171029181511.29148-1-anarcat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Signed-off-by: Antoine Beaupré <anarcat@debian.org>
---
 contrib/mw-to-git/Git/Mediawiki.pm | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/mw-to-git/Git/Mediawiki.pm b/contrib/mw-to-git/Git/Mediawiki.pm
index d13c4dfa7..917d9e2d3 100644
--- a/contrib/mw-to-git/Git/Mediawiki.pm
+++ b/contrib/mw-to-git/Git/Mediawiki.pm
@@ -2,6 +2,7 @@ package Git::Mediawiki;
 
 use 5.008;
 use strict;
+use POSIX;
 use Git;
 
 BEGIN {
@@ -52,7 +53,7 @@ sub smudge_filename {
 	$filename =~ s/ /_/g;
 	# Decode forbidden characters encoded in clean_filename
 	$filename =~ s/_%_([0-9a-fA-F][0-9a-fA-F])/sprintf('%c', hex($1))/ge;
-	return $filename;
+	return substr($filename, 0, NAME_MAX-length('.mw'));
 }
 
 sub connect_maybe {
-- 
2.11.0

