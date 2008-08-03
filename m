From: Johan Herland <johan@herland.net>
Subject: [PATCH 5/5] Teach 'git submodule' to rewrite submodule URLs according
 to super-repo's rules
Date: Mon, 04 Aug 2008 01:02:58 +0200
Message-ID: <200808040102.58275.johan@herland.net>
References: <200808040057.00221.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 04 01:05:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPmdI-0001ev-HI
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 01:05:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758257AbYHCXD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 19:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758074AbYHCXD6
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 19:03:58 -0400
Received: from smtp.getmail.no ([84.208.20.33]:45638 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754486AbYHCXD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 19:03:57 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K5100L3PS2LVR00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Aug 2008 01:03:57 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K5100HUGS0ZZ240@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Aug 2008 01:02:59 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K5100CBTS0YUOVP@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Aug 2008 01:02:59 +0200 (CEST)
In-reply-to: <200808040057.00221.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91289>

When a 'url.*.insteadOf' rule in the superrepo matches a submodule URL, we
should rewrite the submodule URL accordingly, so that we don't request the
submodule from location that is inaccessible (or unwanted by the user for
some other reason).

Signed-off-by: Johan Herland <johan@herland.net>
---
 git-submodule.sh           |    6 ++++++
 t/t7400-submodule-basic.sh |    2 +-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index b40f876..ea2aa3b 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -96,6 +96,12 @@ module_clone()
 	test -e "$path" &&
 	die "A file already exist at path '$path'"
 
+	# The user may have added url.*.insteadOf rules intending to rewrite
+	# submodule URLs. We must explicitly do this rewrite before calling
+	# 'git clone', since 'git clone' will not consult the super-repo
+	# config and thus never see any url.*.insteadOf rules placed therein.
+	url=$(git config --rewrite-url "$url")
+
 	git-clone -n "$url" "$path" ||
 	die "Clone of '$url' into submodule path '$path' failed"
 }
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index bafc46c..9c56de2 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -209,7 +209,7 @@ test_expect_success 'update --init' '
 
 '
 
-test_expect_failure 'update --init with url.*.insteadOf' '
+test_expect_success 'update --init with url.*.insteadOf' '
 
 	rm -rf init &&
 	git config -f .gitmodules submodule.example.url "http://example.com/init2" &&
-- 
1.6.0.rc1.34.g0fe8c
