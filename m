From: Marcus Comstedt <marcus@mc.pp.se>
Subject: [PATCH v3 3/4] t0021: test checkout and commit of foreign idents
Date: Tue, 7 Sep 2010 21:16:03 +0200
Message-ID: <8221caee454ac58983c657e306341059061218aa.1284820251.git.marcus@mc.pp.se>
References: <cover.1284820251.git.marcus@mc.pp.se>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 18 16:47:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Owyhj-0008C7-3u
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 16:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755559Ab0IROrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Sep 2010 10:47:47 -0400
Received: from ua-85-227-1-6.cust.bredbandsbolaget.se ([85.227.1.6]:46089 "EHLO
	bahamut.mc.pp.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755404Ab0IROr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Sep 2010 10:47:28 -0400
Received: from chiyo.mc.pp.se (chiyo [192.168.42.32])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bahamut.mc.pp.se (Postfix) with ESMTPS id 3D160F8C5;
	Sat, 18 Sep 2010 16:37:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mc.pp.se; s=hedgehog;
	t=1284820668; bh=MEz6LdjKk/L6lzdvABKj21Rs8k62C946+EXIKV+TEnU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:To:Cc; b=rVt5
	5uDeSVfRwgXoU21A4RWqyYBXSM6EiriNgqa+dJX7stzNsWN2wZgUcBdUEGXH6FtOUdp
	q63hFkc+ZYDx2qjUovkBVrVrW3nwBwqF6VE3V2gxPuqJItGFYYC9G/GJUT8UCFkVmkI
	YOuZ0VoZ2h4axA/vLTYY+kXyECm05t9hk=
Received: from marcus by chiyo.mc.pp.se with local (Exim 4.71)
	(envelope-from <8221caee454ac58983c657e306341059061218aa@chiyo>)
	id 1OwyXz-0002NH-Ma; Sat, 18 Sep 2010 16:37:47 +0200
In-Reply-To: <cover.1284820251.git.marcus@mc.pp.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156458>

Add test cases for the following behaviors:

  * Checking out a file with a foreign ident should not flag
    the file as modified.  This is to prevent a mess when checking
    out old versions, and to allow a migration model where files
    are allowed to keep their foreign ident as long as their
    content is also "foreign", i.e. not modified since the migration
    to git.

  * Committing to a file with a foreign ident should replace the
    foreign ident with a native ident.  This is simply to get
    the normal behavior of ident:  When the contents of the file is
    updated, so is the ident.

Signed-off-by: Marcus Comstedt <marcus@mc.pp.se>
---
 t/t0021-conversion.sh |   58 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 828e35b..cf83c02 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -93,4 +93,62 @@ test_expect_success expanded_in_repo '
 	cmp expanded-keywords expected-output
 '
 
+# Check that a file containing idents (native or foreign) is not
+# spuriously flagged as modified on checkout
+test_expect_success 'ident pristine after checkout' '
+	{
+		echo "File with foreign ident"
+		echo "\$Id\$"
+		echo "\$Id: Foreign Commit With Spaces \$"
+	} > native-and-foreign-idents &&
+
+	{
+		echo "File with foreign ident"
+		echo "\$Id: c389f8936d7baa13f463254d55b72e00e5496e3f \$"
+		echo "\$Id: Foreign Commit With Spaces \$"
+	} > expected-output &&
+
+	git add native-and-foreign-idents &&
+	git commit -m "File with native and foreign idents" &&
+
+	echo "native-and-foreign-idents ident" >> .gitattributes &&
+
+	rm -f native-and-foreign-idents &&
+	git checkout -- native-and-foreign-idents &&
+	cat native-and-foreign-idents &&
+	cmp native-and-foreign-idents expected-output &&
+	touch native-and-foreign-idents &&
+	git status --porcelain native-and-foreign-idents > output &&
+	test ! -s output &&
+	git diff -- native-and-foreign-idents > output &&
+	test ! -s output
+'
+
+# Check that actually modifying the file and committing it produces a
+# new ident on checkout
+test_expect_success 'foreign ident replaced on commit' '
+	{
+		echo "File with foreign ident"
+		echo "\$Id: cc874844b7868ce341059e6a87c50b6f37b75807 \$"
+		echo "\$Id: cc874844b7868ce341059e6a87c50b6f37b75807 \$"
+		echo "Some new content"
+	} > expected-output &&
+
+	echo "1	0	native-and-foreign-idents" > expected-stat1 &&
+	echo "2	1	native-and-foreign-idents" > expected-stat2 &&
+
+	echo "Some new content" >> native-and-foreign-idents &&
+	git diff --numstat -- native-and-foreign-idents > output &&
+	cmp output expected-stat1 &&
+	git add native-and-foreign-idents &&
+	git commit -m "Modified file" &&
+	git diff --numstat HEAD^ HEAD -- native-and-foreign-idents > output &&
+	cmp output expected-stat2 &&
+	rm -f native-and-foreign-idents &&
+	git checkout -- native-and-foreign-idents &&
+	cat native-and-foreign-idents &&
+	cmp native-and-foreign-idents expected-output
+'
+
+
 test_done
-- 
1.7.2
