From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] checkout_entry: only try to create directories when no file
 existed there
Date: Wed, 8 Aug 2007 22:00:53 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708082200240.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 23:01:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIsev-0005QE-QE
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 23:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757680AbXHHVBf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 17:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756207AbXHHVBf
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 17:01:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:50818 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757566AbXHHVBe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 17:01:34 -0400
Received: (qmail invoked by alias); 08 Aug 2007 21:01:32 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp011) with SMTP; 08 Aug 2007 23:01:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Hx9F6+9HHa/1T92q/VVn5sCEepLqDLwFfhne2bT
	OblxmNZvOzKxcu
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55365>


It is obvious that we do not have to create directories when the file we
want to check out already existed.

Besides, it fixes the obscure use case, where you want to track a file which
is _outside_ of your working tree, by creating a symbolic link to the directory
it lives in, and adding the file with something like "git add symlink/file".
Without this patch, "git checkout symlink/file" would actually _replace_
"symlink" by a directory of the same name.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 entry.c                     |    8 +++++---
 t/t2007-checkout-symlink.sh |   11 +++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/entry.c b/entry.c
index 0625112..eacdba2 100644
--- a/entry.c
+++ b/entry.c
@@ -223,8 +223,10 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *t
 				return error("%s is a directory", path);
 			remove_subtree(path);
 		}
-	} else if (state->not_new)
-		return 0;
-	create_directories(path, state);
+	} else {
+		if (state->not_new)
+			return 0;
+		create_directories(path, state);
+	}
 	return write_entry(ce, path, state, 0);
 }
diff --git a/t/t2007-checkout-symlink.sh b/t/t2007-checkout-symlink.sh
index 0526fce..02224eb 100755
--- a/t/t2007-checkout-symlink.sh
+++ b/t/t2007-checkout-symlink.sh
@@ -47,4 +47,15 @@ test_expect_success 'switch from dir to symlink' '
 
 '
 
+test_expect_success 'checkout does not replace symlink/file with dir/file' '
+	mkdir 123 &&
+	ln -s 123 abc &&
+	echo 1 > abc/1 &&
+	echo 2 > abc/2 &&
+	echo 3 > abc/3 &&
+	git add abc/? &&
+	echo 0 > abc/3 &&
+	git checkout abc/3 &&
+	test -h abc
+'
 test_done
-- 
1.5.3.rc4.26.g782e
