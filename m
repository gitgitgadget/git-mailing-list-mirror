From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] t3010: update to demonstrate "ls-files -k" optimization pitfalls
Date: Thu, 15 Aug 2013 14:28:10 -0700
Message-ID: <1376602090-19142-4-git-send-email-gitster@pobox.com>
References: <7v8v02rb2g.fsf@alter.siamese.dyndns.org>
 <1376602090-19142-1-git-send-email-gitster@pobox.com>
Cc: Petr Baudis <pasky@ucw.cz>, Josh Triplett <josh@joshtriplett.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 15 23:28:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA55o-0000iF-Ly
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 23:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523Ab3HOV2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 17:28:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37176 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134Ab3HOV2V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 17:28:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3617F397E6;
	Thu, 15 Aug 2013 21:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=9eS5
	AGShkHqiAIDUrT92ydWT1EE=; b=eDbsOc+Flr63dEkyd6b6dJOqSbE3vuY0MMbd
	JBgqogOuo3vjSQaQ8TpWPrQlfPrwsaKgt24J/pW9qGPCXyJgKJE6gY7Wq40lB6bt
	08/YQj0PPuX5I0A7AZFT0jLqsN2QvKDs6y5L7PaQS7r7FEfVUdty3S3Po9GdTfsP
	XMKXS6k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	hOHRqB4e6LSPb72Hnuf5v+xJO9vJvjybjMvEHdZslYzxas5qA17KhPfCl1Y0sseJ
	S0nvFbPqfIENTrCTyYk/1HdcDxlIfuFiB/Q8b1sedeKFgTW16z9p4hPapPB85vqG
	sCYm+2Ih7F1GTJkmZ73RXgmrsgSkNQHO9pJCSHpnBtQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29BEA397E5;
	Thu, 15 Aug 2013 21:28:20 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE24F397E4;
	Thu, 15 Aug 2013 21:28:18 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-rc3-232-ga8053f8
In-Reply-To: <1376602090-19142-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9A9BCDFC-05F1-11E3-9C2C-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232372>

An earlier draft of the previous step used cache_name_exists() to
check the directory we were looking at, which missed the second case
described in its log message.  Demonstrate why it is not sufficient.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3010-ls-files-killed-modified.sh | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/t/t3010-ls-files-killed-modified.sh b/t/t3010-ls-files-killed-modified.sh
index 95671c2..6ea7ca8 100755
--- a/t/t3010-ls-files-killed-modified.sh
+++ b/t/t3010-ls-files-killed-modified.sh
@@ -11,6 +11,7 @@ This test prepares the following in the cache:
     path1       - a symlink
     path2/file2 - a file in a directory
     path3/file3 - a file in a directory
+    pathx/ju    - a file in a directory
 
 and the following on the filesystem:
 
@@ -21,6 +22,7 @@ and the following on the filesystem:
     path4	- a file
     path5	- a symlink
     path6/file6 - a file in a directory
+    pathx/ju/nk - a file in a directory to be killed
 
 git ls-files -k should report that existing filesystem
 objects except path4, path5 and path6/file6 to be killed.
@@ -44,16 +46,17 @@ then
 else
 	date > path1
 fi
-mkdir path2 path3
+mkdir path2 path3 pathx
 date >path2/file2
 date >path3/file3
+>pathx/ju
 : >path7
 date >path8
 : >path9
 date >path10
 test_expect_success \
     'git update-index --add to add various paths.' \
-    "git update-index --add -- path0 path1 path?/file? path7 path8 path9 path10"
+    "git update-index --add -- path0 path1 path?/file? pathx/ju path7 path8 path9 path10"
 
 rm -fr path? ;# leave path10 alone
 date >path2
@@ -65,7 +68,7 @@ else
 	date > path3
 	date > path5
 fi
-mkdir path0 path1 path6
+mkdir -p path0 path1 path6 pathx/ju
 date >path0/file0
 date >path1/file1
 date >path6/file6
@@ -73,6 +76,7 @@ date >path7
 : >path8
 : >path9
 touch path10
+>pathx/ju/nk
 
 test_expect_success \
     'git ls-files -k to show killed files.' \
@@ -82,6 +86,7 @@ path0/file0
 path1/file1
 path2
 path3
+pathx/ju/nk
 EOF
 
 test_expect_success \
@@ -98,6 +103,7 @@ path2/file2
 path3/file3
 path7
 path8
+pathx/ju
 EOF
 
 test_expect_success \
-- 
1.8.4-rc3-232-ga8053f8
