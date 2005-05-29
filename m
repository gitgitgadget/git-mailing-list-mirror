From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH Cogito] Make cg-Xnormid use $_git and $_git_objects
Date: Sun, 29 May 2005 03:00:57 +0200
Message-ID: <20050529010057.GA7520@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 29 02:59:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcC8o-0002e5-Ip
	for gcvg-git@gmane.org; Sun, 29 May 2005 02:58:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVE2BBF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 May 2005 21:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVE2BBF
	(ORCPT <rfc822;git-outgoing>); Sat, 28 May 2005 21:01:05 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:51671 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261196AbVE2BA6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 May 2005 21:00:58 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 5EF016E1C74; Sun, 29 May 2005 03:00:27 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 1F2116E1B40; Sun, 29 May 2005 03:00:27 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 5855D61FE0; Sun, 29 May 2005 03:00:57 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The recently introduced cg-Xnormid accesses .git and .git/objects
directly which is not consistent with the current behavior so source
cg-Xlib to get access to the $_git and $_git_objects variables.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---

BTW, both commit-id and tree-id needs to be patched to find the
installed cg-Xnormid.

	-normid=$(cg-Xnormid "$id") || exit 1
	+normid=$(${COGITO_LIB}cg-Xnormid "$id") || exit 1
 
--- c8e987e5e4608c1144293cd3f852210d70b572cb/cg-Xnormid  (mode:100755)
+++ uncommitted/cg-Xnormid  (mode:100755)
@@ -13,16 +13,18 @@
 #
 # Takes the ID to normalize and returns the normalized ID.
 
+. ${COGITO_LIB}cg-Xlib
+
 id="$1"
 
 if [ ! "$id" ] || [ "$id" = "this" ] || [ "$id" = "HEAD" ]; then
-	read id < .git/HEAD
+	read id < "$_git/HEAD"
 
-elif [ -r ".git/refs/tags/$id" ]; then
-	read id < ".git/refs/tags/$id"
+elif [ -r "$_git/refs/tags/$id" ]; then
+	read id < "$_git/refs/tags/$id"
 
-elif [ -r ".git/refs/heads/$id" ]; then
-	read id < ".git/refs/heads/$id"
+elif [ -r "$_git/refs/heads/$id" ]; then
+	read id < "$_git/refs/heads/$id"
 
 # Short id's must be lower case and at least 4 digits.
 elif [[ "$id" == [0-9a-z][0-9a-z][0-9a-z][0-9a-z]* ]]; then
@@ -30,10 +32,10 @@
 	idpost=${id:2}
 
 	# Assign array elements to matching names
-	idmatch=(.git/objects/$idpref/$idpost*)
+	idmatch=($_git_objects/$idpref/$idpost*)
 
 	if [ ${#idmatch[*]} -eq 1 ] && [ -r "$idmatch" ]; then
-		id=$idpref${idmatch#.git/objects/$idpref/}
+		id=$idpref${idmatch#$_git_objects/$idpref/}
 	elif [ ${#idmatch[*]} -gt 1 ]; then
 		echo "Ambiguous id: $id" >&2
 		exit 1
@@ -41,7 +43,7 @@
 fi
 
 # If we don't have a 40-char ID by now, it's an error
-if [ ${#id} -ne 40 ] || [ ! -f .git/objects/${id:0:2}/${id:2} ]; then
+if [ ${#id} -ne 40 ] || [ ! -f $_git_objects/${id:0:2}/${id:2} ]; then
 	echo "Invalid id: $id" >&2
 	exit 1
 fi
-- 
Jonas Fonseca
