From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/3] t7400: split setup into multiple tests
Date: Sat, 10 Apr 2010 00:38:37 -0500
Message-ID: <20100410053837.GA17649@progeny.tock>
References: <20100410053729.GA17595@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 10 07:38:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0TOb-0003Bz-EN
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 07:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896Ab0DJFiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 01:38:13 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:60903 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701Ab0DJFiL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 01:38:11 -0400
Received: by gwj19 with SMTP id 19so138559gwj.19
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 22:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=dkjFlusCVwVkCG7xu9hTCDsFZwaiSKDEnYVbSQwZGI0=;
        b=IFIzOC/2csw52dUCHT+k/KfqotC9tB/r0g0o6OgKgZFvB7Jl3LwTXxuy5+8t7bqWvN
         uisTh59wmG4nyLNgGZa24xkommgobimbTx4EhitF0GZyHRue9z6dnC0ITlSzktQJhUW2
         9YYoxXih596Rvh80bwcIGMGCJZbMq/rcGxLKU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=l0B5Whb2wcYy5qxjIUWhMmTrG8KtjsZMS7hm9AU2sOvBmRl6FhVrc4j9qmB4E6Sx+e
         P2/1EoHodrr59ge70wA6H11TxoL9qoM84m+Ba5P0SuG++tAYgiaNy4DLT1zW/0O0DIyN
         d3YytFgF/KRZpvD+xJVSMXw4Y70dOMsQrYGE8=
Received: by 10.101.170.2 with SMTP id x2mr1809062ano.209.1270877890278;
        Fri, 09 Apr 2010 22:38:10 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm1504691iwn.5.2010.04.09.22.38.09
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 Apr 2010 22:38:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100410053729.GA17595@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144509>

The setup in t7400-submodule-basic does a number of different
things to support different tests.  Splitting it up makes the
test a little easier to read and should provide an opportunity
to move each piece of setup closer to the tests that require it.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t7400-submodule-basic.sh |   58 ++++++++++++++++++++++---------------------
 1 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 1a4dc5f..1f468e5 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -11,40 +11,42 @@ subcommands of git submodule.
 
 . ./test-lib.sh
 
-#
-# Test setup:
-#  -create a repository in directory init
-#  -add a couple of files
-#  -add directory init to 'superproject', this creates a DIRLINK entry
-#  -add a couple of regular files to enable testing of submodule filtering
-#  -mv init subrepo
-#  -add an entry to .gitmodules for submodule 'example'
-#
-test_expect_success 'Prepare submodule testing' '
-	: > t &&
+test_expect_success 'setup - initial commit' '
+	>t &&
 	git add t &&
 	git commit -m "initial commit" &&
-	git branch initial HEAD &&
+	git branch initial
+'
+
+test_expect_success 'setup - repository in init subdirectory' '
 	mkdir init &&
-	cd init &&
-	git init &&
-	echo a >a &&
-	git add a &&
-	git commit -m "submodule commit 1" &&
-	git tag -a -m "rev-1" rev-1 &&
-	rev1=$(git rev-parse HEAD) &&
-	if test -z "$rev1"
-	then
-		echo "[OOPS] submodule git rev-parse returned nothing"
-		false
-	fi &&
-	cd .. &&
+	(
+		cd init &&
+		git init &&
+		echo a >a &&
+		git add a &&
+		git commit -m "submodule commit 1" &&
+		git tag -a -m "rev-1" rev-1
+	)
+	rev1=$(cd init && git rev-parse HEAD) &&
+	printf "rev1: %s\n" "$rev1" &&
+	test -n "$rev1"
+'
+
+test_expect_success 'setup - commit with gitlink' '
 	echo a >a &&
 	echo z >z &&
 	git add a init z &&
-	git commit -m "super commit 1" &&
-	mv init .subrepo &&
-	GIT_CONFIG=.gitmodules git config submodule.example.url git://example.com/init.git
+	git commit -m "super commit 1"
+'
+
+test_expect_success 'setup - hide init subdirectory' '
+	mv init .subrepo
+'
+
+test_expect_success 'setup - add an example entry to .gitmodules' '
+	GIT_CONFIG=.gitmodules \
+	git config submodule.example.url git://example.com/init.git
 '
 
 test_expect_success 'Prepare submodule add testing' '
-- 
1.7.0.4
