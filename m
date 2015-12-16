From: Victor Leschuk <vleschuk@gmail.com>
Subject: [PATCH 2/2] git-svn: test for git-svn prefixed globs
Date: Wed, 16 Dec 2015 16:01:09 +0300
Message-ID: <1450270869-29822-3-git-send-email-vleschuk@accesssoftek.com>
References: <1450270869-29822-1-git-send-email-vleschuk@accesssoftek.com>
Cc: vleschuk@accesssoftek.com, normalperson@yhbt.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 14:01:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9Bhx-0001dk-L6
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 14:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934025AbbLPNBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 08:01:20 -0500
Received: from mail-lb0-f182.google.com ([209.85.217.182]:34928 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932972AbbLPNBS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 08:01:18 -0500
Received: by mail-lb0-f182.google.com with SMTP id u9so24822478lbp.2
        for <git@vger.kernel.org>; Wed, 16 Dec 2015 05:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GpoZI0suMlPOsv1OuCDmiJAm2uTLDHXq0ACeG0+DOvo=;
        b=qGx35VromJ0QC5bEHf8fF2/bFrqBX90rSvoYnXU9gZkM8lwzwvud8YlbIdf+XWxdnz
         CODVFZjibQfYeKcl93qDPnFVFRm04dhFHTFyYpGBIvZqQSEzJHRgFa75XMMK8a7ZzxiU
         O+IFRPvHktVmwKc34XrkEKgfwQn1vUNjwH2v3zpLF/rRXlx5+SSqV6mtfqupH4Bo+3tR
         Xe6Q5f6Iz7A6Xgi00KGcdM58zK92PD/6aVsDx5Ko/mOLRx1+Hts2u86PGsM6WS/W9E5g
         J9vRYdxfGVFgyScgA4kl3iUsAxmAhvuKN+n8P2xFD4nHrFeoudfm6Ua6MILj/RIR22Ym
         uvEw==
X-Received: by 10.112.172.130 with SMTP id bc2mr18019648lbc.132.1450270876227;
        Wed, 16 Dec 2015 05:01:16 -0800 (PST)
Received: from del-debian (93-80-35-229.broadband.corbina.ru. [93.80.35.229])
        by smtp.gmail.com with ESMTPSA id bm8sm981087lbb.35.2015.12.16.05.01.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Dec 2015 05:01:15 -0800 (PST)
X-Google-Original-From: Victor Leschuk <vleschuk@accesssoftek.com>
Received: from del by del-debian with local (Exim 4.86)
	(envelope-from <vleschuk@gmail.com>)
	id 1a9Bhh-0007lq-As; Wed, 16 Dec 2015 16:01:13 +0300
X-Mailer: git-send-email 2.7.0.rc0.21.gb793f61
In-Reply-To: <1450270869-29822-1-git-send-email-vleschuk@accesssoftek.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282559>

Add test for git-svn prefixed globs.

Signed-off-by: Victor Leschuk <vleschuk@accesssoftek.com>
---
 t/t9168-git-svn-prefixed-glob.sh | 136 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)
 create mode 100755 t/t9168-git-svn-prefixed-glob.sh

diff --git a/t/t9168-git-svn-prefixed-glob.sh b/t/t9168-git-svn-prefixed-glob.sh
new file mode 100755
index 0000000..979ecd9
--- /dev/null
+++ b/t/t9168-git-svn-prefixed-glob.sh
@@ -0,0 +1,136 @@
+#!/bin/sh
+test_description='git svn globbing refspecs with prefixed globs'
+. ./lib-git-svn.sh
+
+cat > expect.end <<EOF
+the end
+hi
+start a new branch
+initial
+EOF
+
+test_expect_success 'test refspec prefixed globbing' '
+	mkdir -p trunk/src/a trunk/src/b trunk/doc &&
+	echo "hello world" > trunk/src/a/readme &&
+	echo "goodbye world" > trunk/src/b/readme &&
+	svn_cmd import -m "initial" trunk "$svnrepo"/trunk &&
+	svn_cmd co "$svnrepo" tmp &&
+	(
+		cd tmp &&
+		mkdir branches tags &&
+		svn_cmd add branches tags &&
+		svn_cmd cp trunk branches/b_start &&
+		svn_cmd commit -m "start a new branch" &&
+		svn_cmd up &&
+		echo "hi" >> branches/b_start/src/b/readme &&
+		poke branches/b_start/src/b/readme &&
+		echo "hey" >> branches/b_start/src/a/readme &&
+		poke branches/b_start/src/a/readme &&
+		svn_cmd commit -m "hi" &&
+		svn_cmd up &&
+		svn_cmd cp branches/b_start tags/t_end &&
+		echo "bye" >> tags/t_end/src/b/readme &&
+		poke tags/t_end/src/b/readme &&
+		echo "aye" >> tags/t_end/src/a/readme &&
+		poke tags/t_end/src/a/readme &&
+		svn_cmd commit -m "the end" &&
+		echo "byebye" >> tags/t_end/src/b/readme &&
+		poke tags/t_end/src/b/readme &&
+		svn_cmd commit -m "nothing to see here"
+	) &&
+	git config --add svn-remote.svn.url "$svnrepo" &&
+	git config --add svn-remote.svn.fetch \
+	                 "trunk/src/a:refs/remotes/trunk" &&
+	git config --add svn-remote.svn.branches \
+	                 "branches/b_*/src/a:refs/remotes/branches/b_*" &&
+	git config --add svn-remote.svn.tags\
+	                 "tags/t_*/src/a:refs/remotes/tags/t_*" &&
+	git svn multi-fetch &&
+	git log --pretty=oneline refs/remotes/tags/t_end | \
+	    sed -e "s/^.\{41\}//" > output.end &&
+	test_cmp expect.end output.end &&
+	test "`git rev-parse refs/remotes/tags/t_end~1`" = \
+		"`git rev-parse refs/remotes/branches/b_start`" &&
+	test "`git rev-parse refs/remotes/branches/b_start~2`" = \
+		"`git rev-parse refs/remotes/trunk`" &&
+	test_must_fail git rev-parse refs/remotes/tags/t_end@3
+	'
+
+echo try to try > expect.two
+echo nothing to see here >> expect.two
+cat expect.end >> expect.two
+
+test_expect_success 'test left-hand-side only prefixed globbing' '
+	git config --add svn-remote.two.url "$svnrepo" &&
+	git config --add svn-remote.two.fetch trunk:refs/remotes/two/trunk &&
+	git config --add svn-remote.two.branches \
+	                 "branches/b_*:refs/remotes/two/branches/*" &&
+	git config --add svn-remote.two.tags \
+	                 "tags/t_*:refs/remotes/two/tags/*" &&
+	(
+		cd tmp &&
+		echo "try try" >> tags/t_end/src/b/readme &&
+		poke tags/t_end/src/b/readme &&
+		svn_cmd commit -m "try to try"
+	) &&
+	git svn fetch two &&
+	test `git rev-list refs/remotes/two/tags/t_end | wc -l` -eq 6 &&
+	test `git rev-list refs/remotes/two/branches/b_start | wc -l` -eq 3 &&
+	test `git rev-parse refs/remotes/two/branches/b_start~2` = \
+	     `git rev-parse refs/remotes/two/trunk` &&
+	test `git rev-parse refs/remotes/two/tags/t_end~3` = \
+	     `git rev-parse refs/remotes/two/branches/b_start` &&
+	git log --pretty=oneline refs/remotes/two/tags/t_end | \
+	    sed -e "s/^.\{41\}//" > output.two &&
+	test_cmp expect.two output.two
+	'
+
+test_expect_success 'test prefixed globs do not match just prefix' '
+	git config --add svn-remote.three.url "$svnrepo" &&
+	git config --add svn-remote.three.fetch \
+	                 trunk:refs/remotes/three/trunk &&
+	git config --add svn-remote.three.branches \
+	                 "branches/b_*:refs/remotes/three/branches/*" &&
+	git config --add svn-remote.three.tags \
+	                 "tags/t_*:refs/remotes/three/tags/*" &&
+	(
+		cd tmp &&
+		svn_cmd cp trunk branches/b_ &&
+		echo "You should never see me" >> branches/b_/src/a/readme &&
+		poke branches/b_/src/a/readme &&
+		svn_cmd commit -m "Never seen branch commit" &&
+		svn_cmd up &&
+		svn_cmd cp branches/b_ tags/t_ &&
+		echo "You should never see mee too" >> tags/t_/src/a/readme &&
+		poke tags/t_/src/a/readme &&
+		svn_cmd commit -m "Never seen tag commit" &&
+		svn_cmd up
+	) &&
+	git svn fetch three &&
+	test_path_is_missing refs/remotes/three/branches/b_ &&
+	test_path_is_missing refs/remotes/three/tags/t_
+	'
+
+echo "Only one set of wildcard directories" \
+     "(e.g. '*' or '*/*/*') is supported: 'branches/b_*/t/*'" > expect.four
+echo "" >> expect.four
+
+test_expect_success 'test disallow prefixed multi-globs' '
+	git config --add svn-remote.four.url "$svnrepo" &&
+	git config --add svn-remote.four.fetch \
+	                 trunk:refs/remotes/four/trunk &&
+	git config --add svn-remote.four.branches \
+	                 "branches/b_*/t/*:refs/remotes/four/branches/*" &&
+	git config --add svn-remote.four.tags \
+	                 "tags/t_*/*:refs/remotes/four/tags/*" &&
+	(
+		cd tmp &&
+		echo "try try" >> tags/t_end/src/b/readme &&
+		poke tags/t_end/src/b/readme &&
+		svn_cmd commit -m "try to try"
+	) &&
+	test_must_fail git svn fetch four 2> stderr.four &&
+	test_cmp expect.four stderr.four
+	'
+
+test_done
-- 
2.7.0.rc0.21.gb793f61
