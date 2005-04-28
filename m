From: Philip Pokorny <ppokorny@mindspring.com>
Subject: Re: PATCH[3/4]: Allow tree-id to return the ID of a tree object
Date: Thu, 28 Apr 2005 00:16:27 -0700
Message-ID: <42708DCB.1040007@mindspring.com>
References: <426FBBE7.1090806@mindspring.com> <20050427232223.GM22956@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080309050200050205000708"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 09:12:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR3C6-00017t-AW
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 09:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbVD1HRW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 03:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVD1HRW
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 03:17:22 -0400
Received: from smtpauth04.mail.atl.earthlink.net ([209.86.89.64]:65429 "EHLO
	smtpauth04.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S261893AbVD1HQe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 03:16:34 -0400
Received: from [68.164.169.208] (helo=[172.16.1.11])
	by smtpauth04.mail.atl.earthlink.net with asmtp (TLSv1:RC4-MD5:128)
	(Exim 4.34)
	id 1DR3G8-00063T-Lo; Thu, 28 Apr 2005 03:16:28 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050427232223.GM22956@pasky.ji.cz>
X-ELNK-Trace: 662518af21fc89ef9c7f779228e2f6aeda0071232e20db4d42d3b4be55a7349e92a20c82234e39de350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 68.164.169.208
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------080309050200050205000708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Convert tree-id to use cg-Xnormid to normalize an ID

Signed-off-by: Philip Pokorny <ppokorny@mindspring.com>

--------------080309050200050205000708
Content-Type: text/plain;
 name="cogito-0.8-tree-id.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cogito-0.8-tree-id.patch"

Index: tree-id
===================================================================
--- 6ad600e20c89323c1d3049f75b8ca9b0a2d72167/tree-id  (mode:100755 sha1:1495ff78af71b57e21653512932bcda88fe05454)
+++ uncommitted/tree-id  (mode:100775)
@@ -1,17 +1,31 @@
 #!/usr/bin/env bash
 #
 # Get ID of tree associated with given commit or HEAD.
+#
 # Copyright (c) Petr Baudis, 2005
 #
-# Takes ID of the appropriate commit, defaults to HEAD.
 
-SHA1="[A-Za-z0-9]{40}"
-TREE="^tree $SHA1$"
+# Save for later error message
+orig="$1"
 
-id=$(cat-file commit $(commit-id "$1") | egrep "$TREE" | cut -d ' ' -f 2)
+# Normalize to SHA1 form
+id=$(cg-Xnormid "$1")
+if [ ! "$id" ]; then
+	# cg-Xnormid already reported the error
+	exit 1
+fi
+
+# Is it a commit?
+idtype=$(cat-file -t $id 2>/dev/null)
+if [ "$idtype" = "commit" ]; then
+	# Get the tree
+	id=$(cat-file commit "$id" | sed -e 's/tree //;q')
+fi
 
-if [ "$(cat-file -t "$id")" != "tree" ]; then
-	echo "Invalid id: $id" >&2
+# cat-file will verify that $id is a valid SHA1 ID for us
+# If it isn't, we'll get '' back
+if [ "$(cat-file -t "$id" 2>/dev/null)" != "tree" ]; then
+	echo "Invalid tree id: $orig" >&2
 	exit 1
 fi
 

--------------080309050200050205000708--
