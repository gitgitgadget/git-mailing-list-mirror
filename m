From: David Greaves <david@dgreaves.com>
Subject: Add + Status patches
Date: Mon, 18 Apr 2005 21:39:00 +0100
Message-ID: <42641AE4.9050700@dgreaves.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000106090201000101040800"
X-From: git-owner@vger.kernel.org Mon Apr 18 22:36:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNcyI-0003aB-4w
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 22:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVDRUjk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 16:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVDRUjk
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 16:39:40 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:38026 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261163AbVDRUjF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 16:39:05 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id CE142E6D6F; Mon, 18 Apr 2005 21:37:28 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 02380-12; Mon, 18 Apr 2005 21:37:28 +0100 (BST)
Received: from oak.dgreaves.com (modem-2514.lemur.dialup.pol.co.uk [217.135.137.210])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 739B3E6D49; Mon, 18 Apr 2005 21:37:27 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DNd1I-0005Bh-En; Mon, 18 Apr 2005 21:39:00 +0100
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------000106090201000101040800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Petr

Thankyou for the help earlier - problem resolved.

I have a trivial patch (attached).

It allows:
 find src -type f | git add -

and fixes git status not reporting added files properly (on my debian 
system it only reported the first file in .git/add-queue)

Should I send this as a patch or as some kind of git object?
(I'm still trying to figure out git workflow)

David

-- 


--------------000106090201000101040800
Content-Type: text/x-patch;
 name="add_status.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="add_status.patch"

Index: README
===================================================================
--- c0aff9b98c4242ab8965c428241df1d8f7a1d4bb/README  (mode:100644 sha1:798476ad292cc6edf5a2f5782e1de82f6052abe2)
+++ 1c3349b813d463ce194be06f14ccfbcc3fc2ba30/README  (mode:100644 sha1:4282af1604e429dd767fe721751b5ac4a87c410e)
@@ -89,6 +89,10 @@
 Of course you will want to commit. If you added any new files, do
 
 	git add newfile1 newfile2 ...
+	
+or even
+
+	find src -type f | git add -
 
 first. Then feel free to commit by
 
Index: git
===================================================================
--- c0aff9b98c4242ab8965c428241df1d8f7a1d4bb/git  (mode:100755 sha1:b648169640025bd68d1b27a0fcc85b65d85e4440)
+++ 1c3349b813d463ce194be06f14ccfbcc3fc2ba30/git  (mode:100755 sha1:5f3d4d04a0adfdc26bfc6aaef5cd29eea6e5c459)
@@ -25,7 +25,7 @@
 Usage: git COMMAND [ARG]...
 
 Available commands:
-	add		FILE...
+	add		FILE...  | -    < files on stdin
 	addremote	RNAME RSYNC_URL
 	apply				< patch on stdin
 	cancel
Index: gitadd.sh
===================================================================
--- c0aff9b98c4242ab8965c428241df1d8f7a1d4bb/gitadd.sh  (mode:100755 sha1:3ed93ea0fcb995673ba9ee1982e0e7abdbe35982)
+++ 1c3349b813d463ce194be06f14ccfbcc3fc2ba30/gitadd.sh  (mode:100755 sha1:d010d14c0c14e0ea7a2e448b667d938fe92a3bc2)
@@ -9,10 +9,14 @@
 # FIXME: Those files are omitted from show-diff output!
 
 if [ ! "$1" ]; then
-	echo "gitadd.sh: usage: git add FILE..." >&2
+	echo "gitadd.sh: usage: git add - | FILE..." >&2
 	exit 1;
 fi
 
-for file in "$@"; do
-	echo $file >>.git/add-queue
-done
+if [ $1 == "-" ]; then
+	cat - >> .git/add-queue
+else
+	for file in "$@"; do
+		echo $file >>.git/add-queue
+	done
+fi
Index: gitstatus.sh
===================================================================
--- c0aff9b98c4242ab8965c428241df1d8f7a1d4bb/gitstatus.sh  (mode:100755 sha1:6c33f805ebc2630b14a88a07dfc891a9196d66a5)
+++ 1c3349b813d463ce194be06f14ccfbcc3fc2ba30/gitstatus.sh  (mode:100755 sha1:e2c7f9d56b6967c529453de675ffffaaeeff3d1c)
@@ -5,8 +5,8 @@
 
 {
 	show-files -z -t --others --deleted --unmerged
-	[ -s .git/add-queue ] && cat .git/add-queue | sed 's/^/A /' | { read x; echo -ne $x'\0'; }
-	[ -s .git/rm-queue ] && cat .git/rm-queue | sed 's/^/D /' | { read x; echo -ne $x'\0'; }
+	[ -s .git/add-queue ] && cat .git/add-queue | sed 's/^/A /' | tr '\n' '\0'
+	[ -s .git/rm-queue ] && cat .git/rm-queue | sed 's/^/D /' | tr '\n' '\0'
 } | sort -z -k 2 | xargs -0 sh -c '
 while [ "$1" ]; do
 	tag=$(echo "$1" | cut -d " " -f 1);

--------------000106090201000101040800--
