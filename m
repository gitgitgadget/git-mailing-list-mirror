From: Philip Pokorny <ppokorny@mindspring.com>
Subject: Re: PATCH[1/4]: Allow tree-id to return the ID of a tree object
Date: Thu, 28 Apr 2005 00:14:13 -0700
Message-ID: <42708D45.8070303@mindspring.com>
References: <426FBBE7.1090806@mindspring.com> <20050427232223.GM22956@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020607080608090808030502"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 09:12:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR3Bo-00014P-6q
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 09:12:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbVD1HQn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 03:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261837AbVD1HP2
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 03:15:28 -0400
Received: from smtpauth07.mail.atl.earthlink.net ([209.86.89.67]:3768 "EHLO
	smtpauth07.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S261862AbVD1HOT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 03:14:19 -0400
Received: from [68.164.169.208] (helo=[172.16.1.11])
	by smtpauth07.mail.atl.earthlink.net with asmtp (TLSv1:RC4-MD5:128)
	(Exim 4.34)
	id 1DR3Dy-0008UH-R8; Thu, 28 Apr 2005 03:14:15 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050427232223.GM22956@pasky.ji.cz>
X-ELNK-Trace: 662518af21fc89ef9c7f779228e2f6aeda0071232e20db4d0466520703f220d61fb92f62fe49309c350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 68.164.169.208
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------020607080608090808030502
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Patch to re-introduce cg-Xnormid for common ID normalizing.

Signed-off-by: Philip Pokorny <ppokorny@mindspring.com>



--------------020607080608090808030502
Content-Type: text/plain;
 name="cogito-0.8-cg-Xnormid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cogito-0.8-cg-Xnormid.patch"

Index: cg-Xnormid
===================================================================
--- /dev/null  (tree:6ad600e20c89323c1d3049f75b8ca9b0a2d72167)
+++ uncommitted/cg-Xnormid  (mode:100755 sha1:6dc089c8d571f330e2e01d96f79616d6146840ee)
@@ -0,0 +1,47 @@
+#!/usr/bin/env bash
+#
+# Normalize an ID to an SHA1 hash value
+#    Strings resolve in order:
+#       NULL, this, HEAD  => .git/HEAD
+#       <tags>
+#       <heads>
+#       short SHA1 (4 or more hex digits)
+#
+# Copyright (c) Philip Pokorny, 2005
+
+id="$1"
+
+if [ ! "$id" ] || [ "$id" = "this" ] || [ "$id" = "HEAD" ]; then
+	read id < .git/HEAD
+
+elif [ -r ".git/refs/tags/$id" ]; then
+	read id < ".git/refs/tags/$id"
+
+elif [ -r ".git/refs/heads/$id" ]; then
+	read id < ".git/refs/heads/$id"
+
+# Short id's must be lower case and at least 4 digits.
+elif [[ "$id" == [0-9a-z][0-9a-z][0-9a-z][0-9a-z]* ]]; then
+	idpost=${id#??}
+	idpref=${id%$idpost}
+
+	# Assign array elements to matching names
+	idmatch=(.git/objects/$idpref/$idpost*)
+
+	if [ ${#idmatch[*]} -eq 1 ] && [ -r "$idmatch" ]; then
+		id=$idpref${idmatch#.git/objects/$idpref/}
+	elif [ ${#idmatch[*]} -gt 1 ]; then
+		echo "Ambiguous id: $id" >&2
+		exit 1
+	fi
+fi
+
+# FIXME? Should we verify the existance of the ID in the object cache?
+
+# If we don't have a 40-char ID by now, it's an error
+if [ ${#id} -ne 40 ]; then
+	echo "Invalid id: $id" >&2
+	exit 1
+fi
+
+echo $id
Index: Makefile
===================================================================
--- 6ad600e20c89323c1d3049f75b8ca9b0a2d72167/Makefile  (mode:100644 sha1:d73bea1cbb9451a89b03d6066bf2ed7fec32fd31)
+++ uncommitted/Makefile  (mode:100664)
@@ -44,7 +44,7 @@
 	cg-add cg-admin-lsobj cg-cancel cg-clone cg-commit cg-diff \
 	cg-export cg-help cg-init cg-log cg-ls cg-merge cg-mkpatch \
 	cg-patch cg-pull cg-branch-add cg-branch-ls cg-rm cg-seek cg-status \
-	cg-tag cg-update cg-Xlib
+	cg-tag cg-update cg-Xlib cg-Xnormid
 
 COMMON=	read-cache.o
 

--------------020607080608090808030502--
