From: Victor Leschuk <vleschuk@gmail.com>
Subject: [PATCH 1/2] git-svn: support for prefixed globs in config
Date: Wed, 16 Dec 2015 16:01:08 +0300
Message-ID: <1450270869-29822-2-git-send-email-vleschuk@accesssoftek.com>
References: <1450270869-29822-1-git-send-email-vleschuk@accesssoftek.com>
Cc: vleschuk@accesssoftek.com, normalperson@yhbt.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 14:01:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9Bhp-0001Ph-9L
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 14:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933935AbbLPNBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 08:01:17 -0500
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33599 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932843AbbLPNBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 08:01:16 -0500
Received: by mail-lf0-f54.google.com with SMTP id p203so28898208lfa.0
        for <git@vger.kernel.org>; Wed, 16 Dec 2015 05:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X/1U8SVv7TklYZ4HeV1NQqE7c4oeXqCHbQ3UzRjvukE=;
        b=xvslOhroItvCx5ZSvs7w/NmsrbrWA3Auyj6cvQ3UFKMk3WAMvtKTherA4W7cO7gvdX
         Q6MjGJoU70FhhsmESxn/6DeTK6Z8nHE0K3JxeBuF3veVgeuEiTNnpNFHMm1MeTtIKCJV
         ogXBHY+JP+1Y9ewnCa1cB+nG+wmtsecFwAZLvbmT/NryDuI9nc83irUnAGgA0r9qiVUY
         baQJQalhEfjhodPwDAeLirX30/vwLSa/yPtDLWMt70T+EjTgpxuIw0PiyL1ptevg5k+k
         U+oiZuhTmlmiDmDCHwfdstDYx5F4Go/uSPusf4g/FMFSDxzXJBhdIOeBoLiRPkck2qLY
         V/JQ==
X-Received: by 10.25.20.198 with SMTP id 67mr4796828lfu.65.1450270875016;
        Wed, 16 Dec 2015 05:01:15 -0800 (PST)
Received: from del-debian (93-80-35-229.broadband.corbina.ru. [93.80.35.229])
        by smtp.gmail.com with ESMTPSA id ki2sm978325lbc.15.2015.12.16.05.01.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Dec 2015 05:01:13 -0800 (PST)
X-Google-Original-From: Victor Leschuk <vleschuk@accesssoftek.com>
Received: from del by del-debian with local (Exim 4.86)
	(envelope-from <vleschuk@gmail.com>)
	id 1a9Bhg-0007ll-Bq; Wed, 16 Dec 2015 16:01:12 +0300
X-Mailer: git-send-email 2.7.0.rc0.21.gb793f61
In-Reply-To: <1450270869-29822-1-git-send-email-vleschuk@accesssoftek.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282557>

Introduce prefixed globs for branches and tags in git-svn.

Signed-off-by: Victor Leschuk <vleschuk@accesssoftek.com>
---
 Documentation/git-svn.txt | 5 +++++
 perl/Git/SVN/GlobSpec.pm  | 9 ++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 0c0f60b..529cffe 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -1034,6 +1034,7 @@ listed below are allowed:
 	url = http://server.org/svn
 	fetch = trunk/project-a:refs/remotes/project-a/trunk
 	branches = branches/*/project-a:refs/remotes/project-a/branches/*
+	branches = branches/release_*:refs/remotes/project-a/branches/release_*
 	tags = tags/*/project-a:refs/remotes/project-a/tags/*
 ------------------------------------------------------------------------
 
@@ -1044,6 +1045,10 @@ independent path component (surrounded by '/' or EOL).   This
 type of configuration is not automatically created by 'init' and
 should be manually entered with a text-editor or using 'git config'.
 
+Also note that prefixed globs (e.g. 'release_*') match everything after prefix
+but do not match exact prefix. For example:
+'release_*' will match 'release_1' or 'release_v1' but will not match 'release_'.
+
 It is also possible to fetch a subset of branches or tags by using a
 comma-separated list of names within braces. For example:
 
diff --git a/perl/Git/SVN/GlobSpec.pm b/perl/Git/SVN/GlobSpec.pm
index c95f5d7..a136090 100644
--- a/perl/Git/SVN/GlobSpec.pm
+++ b/perl/Git/SVN/GlobSpec.pm
@@ -11,16 +11,15 @@ sub new {
 	my $die_msg = "Only one set of wildcard directories " .
 				"(e.g. '*' or '*/*/*') is supported: '$glob'\n";
 	for my $part (split(m|/|, $glob)) {
-		if ($part =~ /\*/ && $part ne "*") {
-			die "Invalid pattern in '$glob': $part\n";
-		} elsif ($pattern_ok && $part =~ /[{}]/ &&
+		if ($pattern_ok && $part =~ /[{}]/ &&
 			 $part !~ /^\{[^{}]+\}/) {
 			die "Invalid pattern in '$glob': $part\n";
 		}
-		if ($part eq "*") {
+		if ($part =~ /(\w*)\*/) {
 			die $die_msg if $state eq "right";
 			$state = "pattern";
-			push(@patterns, "[^/]*");
+			my $pat = $1 ? "${1}[^/]+" : "[^/]*";
+			push(@patterns, $pat);
 		} elsif ($pattern_ok && $part =~ /^\{(.*)\}$/) {
 			die $die_msg if $state eq "right";
 			$state = "pattern";
-- 
2.7.0.rc0.21.gb793f61
