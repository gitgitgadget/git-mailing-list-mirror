From: Philip Pokorny <ppokorny@mindspring.com>
Subject: Re: PATCH[2/4]: Allow tree-id to return the ID of a tree object
Date: Thu, 28 Apr 2005 00:15:26 -0700
Message-ID: <42708D8E.10003@mindspring.com>
References: <426FBBE7.1090806@mindspring.com> <20050427232223.GM22956@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090501020707070801020204"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 09:13:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR3Cb-0001B7-MS
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 09:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbVD1HSC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 03:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbVD1HSC
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 03:18:02 -0400
Received: from smtpauth07.mail.atl.earthlink.net ([209.86.89.67]:47033 "EHLO
	smtpauth07.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S261862AbVD1HPa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 03:15:30 -0400
Received: from [68.164.169.208] (helo=[172.16.1.11])
	by smtpauth07.mail.atl.earthlink.net with asmtp (TLSv1:RC4-MD5:128)
	(Exim 4.34)
	id 1DR3F9-0000Z3-DJ; Thu, 28 Apr 2005 03:15:27 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050427232223.GM22956@pasky.ji.cz>
X-ELNK-Trace: 662518af21fc89ef9c7f779228e2f6aeda0071232e20db4d42d3b4be55a7349e99e70fea2c386ab3350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 68.164.169.208
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------090501020707070801020204
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Convert commit-id to use the new cg-Xnormid internal script

Signed-off-by: Philip Pokorny <ppokorny@mindspring.com>

--------------090501020707070801020204
Content-Type: text/plain;
 name="cogito-0.8-commit-id.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cogito-0.8-commit-id.patch"

Index: commit-id
===================================================================
--- 6ad600e20c89323c1d3049f75b8ca9b0a2d72167/commit-id  (mode:100755 sha1:4efcb6bdfdb2b2c5744f5d4d47d92beb7777ed59)
+++ uncommitted/commit-id  (mode:100775)
@@ -1,39 +1,25 @@
 #!/usr/bin/env bash
 #
 # Get ID of commit associated with given id or HEAD.
+#
 # Copyright (c) Petr Baudis, 2005
 #
-# Takes the appropriate ID, defaults to HEAD.
-
-SHA1="[A-Za-z0-9]{40}"
-SHA1ONLY="^$SHA1$"
-
-id=$1
-if [ ! "$id" ] || [ "$id" = "this" ] || [ "$id" = "HEAD" ]; then
-	id=$(cat .git/HEAD)
-fi
 
-if (echo $id | egrep -vq "$SHA1ONLY") && [ -r ".git/refs/tags/$id" ]; then
-	id=$(cat ".git/refs/tags/$id")
-fi
-
-if (echo $id | egrep -vq "$SHA1ONLY") && [ -r ".git/refs/heads/$id" ]; then
-	id=$(cat ".git/refs/heads/$id")
-fi
+# Save for later error message
+orig="$1"
 
-idpref=$(echo "$id" | cut -c -2)
-idpost=$(echo "$id" | cut -c 3-)
-if [ $(find ".git/objects/$idpref" -name "$idpost*" 2>/dev/null | wc -l) -eq 1 ]; then
-	id=$idpref$(basename $(echo .git/objects/$idpref/$idpost*))
-fi
+# Normalize to SHA1 form
+id=$(cg-Xnormid "$orig")
 
-if echo $id | egrep -vq "$SHA1ONLY"; then
-	echo "Invalid id: $id" >&2
+if [ ! "$id" ]; then
+	# cg-Xnormid already reported the error
 	exit 1
 fi
 
-if [ "$(cat-file -t "$id")" != "commit" ]; then
-	echo "Invalid id: $id" >&2
+# cat-file will verify that $id is a valid SHA1 ID for us
+# If it isn't, we'll get '' back
+if [ "$(cat-file -t "$id" 2>/dev/null)" != "commit" ]; then
+	echo "Invalid commit id: $orig" >&2
 	exit 1
 fi
 

--------------090501020707070801020204--
