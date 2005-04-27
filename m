From: Philip Pokorny <ppokorny@mindspring.com>
Subject: PATCH: Allow tree-id to return the ID of a tree object
Date: Wed, 27 Apr 2005 09:20:55 -0700
Message-ID: <426FBBE7.1090806@mindspring.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020001040200050607070401"
X-From: git-owner@vger.kernel.org Wed Apr 27 18:19:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQpDq-0007WP-ER
	for gcvg-git@gmane.org; Wed, 27 Apr 2005 18:17:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbVD0QWT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 12:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbVD0QWT
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 12:22:19 -0400
Received: from smtpauth04.mail.atl.earthlink.net ([209.86.89.64]:55217 "EHLO
	smtpauth04.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S261793AbVD0QVA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2005 12:21:00 -0400
Received: from [68.164.169.208] (helo=[172.16.1.11])
	by smtpauth04.mail.atl.earthlink.net with asmtp (TLSv1:RC4-MD5:128)
	(Exim 4.34)
	id 1DQpHU-0003E4-2i
	for git@vger.kernel.org; Wed, 27 Apr 2005 12:20:56 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-ELNK-Trace: 662518af21fc89ef9c7f779228e2f6aeda0071232e20db4df72b0bc5d90078951a493785f04f23ea350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 68.164.169.208
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------020001040200050607070401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

While playing with cg-ls, I tried:

% cg-ls
... snip ...
100644  blob    bc607fd55f6ce4e56ce87766369b5d4d55ec79af        object.h
100755  blob    f35877a6aa5b68d2fb4a388dcfa9b3e64262604e        parent-id
040000  tree    bfb75011c32589b282dd9c86621dadb0f0bb3866        ppc
100644  blob    d922305ee0f5583bdfcb629f6d4061e11e0fa859        read-cache.c
100644  blob    1ad7ffc555b635fe57fa7834b12d71ff576be065        read-tree.c
... snip ...
% cg-ls bfb75011c32589b282dd9c86621dadb0f0bb3866       <-- the ppc tree ID
Invalid id: bfb75011c32589b282dd9c86621dadb0f0bb3866
usage: cat-file [-t | tagname] <sha1>
usage: cat-file [-t | tagname] <sha1>
Invalid id:


Shouldn't cg-ls give a listing of a sub-tree?  The cg-help says it takes
a TREE-ID?

The problem seems to be that tree-id really only accepts a commit-id and
returns the TREE-ID of that commit.

So I modified commit-id, tree-id and parent-id to make them more similar
in coding style, force "short-id" names to be at least 4 lower case
letters, and have tree-id accept short, unambiguous ID's and bare SHA1-ID's.

Patch attached.




--------------020001040200050607070401
Content-Type: text/plain;
 name="cogito-0.8-idparse.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cogito-0.8-idparse.patch"

Index: commit-id
===================================================================
--- 6ad600e20c89323c1d3049f75b8ca9b0a2d72167/commit-id  (mode:100755 sha1:4efcb6bdfdb2b2c5744f5d4d47d92beb7777ed59)
+++ uncommitted/commit-id  (mode:100775)
@@ -9,22 +9,30 @@
 SHA1ONLY="^$SHA1$"
 
 id=$1
+
 if [ ! "$id" ] || [ "$id" = "this" ] || [ "$id" = "HEAD" ]; then
 	id=$(cat .git/HEAD)
-fi
 
-if (echo $id | egrep -vq "$SHA1ONLY") && [ -r ".git/refs/tags/$id" ]; then
+elif [ -r ".git/refs/tags/$id" ]; then
 	id=$(cat ".git/refs/tags/$id")
-fi
 
-if (echo $id | egrep -vq "$SHA1ONLY") && [ -r ".git/refs/heads/$id" ]; then
+elif [ -r ".git/refs/heads/$id" ]; then
 	id=$(cat ".git/refs/heads/$id")
-fi
 
-idpref=$(echo "$id" | cut -c -2)
-idpost=$(echo "$id" | cut -c 3-)
-if [ $(find ".git/objects/$idpref" -name "$idpost*" 2>/dev/null | wc -l) -eq 1 ]; then
-	id=$idpref$(basename $(echo .git/objects/$idpref/$idpost*))
+# Short id's must be lower case and at least 4 digits.
+elif [[ "$id" == [0-9a-z][0-9a-z][0-9a-z][0-9a-z]* ]]; then
+	idpost=${id#??}
+	idpref=${id%$idpost}
+
+	# Assign array elements to matching names
+	idmatch=($(echo .git/objects/$idpref/$idpost*))
+
+	if [ ${#idmatch[*]} -eq 1 ] && [ -r "$idmatch" ]; then
+		id=$idpref${idmatch#.git/objects/$idpref/}
+	elif [ ${#idmatch[*]} -gt 1 ]; then
+		echo "Ambiguous id: $id" >&2
+		exit 1
+	fi
 fi
 
 if echo $id | egrep -vq "$SHA1ONLY"; then
Index: tree-id
===================================================================
--- 6ad600e20c89323c1d3049f75b8ca9b0a2d72167/tree-id  (mode:100755 sha1:1495ff78af71b57e21653512932bcda88fe05454)
+++ uncommitted/tree-id  (mode:100775)
@@ -7,8 +7,35 @@
 
 SHA1="[A-Za-z0-9]{40}"
 TREE="^tree $SHA1$"
+SHA1ONLY="^$SHA1$"
 
-id=$(cat-file commit $(commit-id "$1") | egrep "$TREE" | cut -d ' ' -f 2)
+id=$1
+
+# Is it a commit?
+commit=$(commit-id $id 2>/dev/null)
+if [ "$commit" ]; then
+	id=$(cat-file commit "$commit") | egrep "$TREE" | cut -d ' ' -f 2)
+
+# Short id's must be lower case and at least 4 digits.
+elif [[ "$id" == [0-9a-z][0-9a-z][0-9a-z][0-9a-z]* ]]; then
+	idpost=${id#??}
+	idpref=${id%$idpost}
+
+	# Assign array elements to matching names
+	idmatch=($(echo .git/objects/$idpref/$idpost*))
+
+	if [ ${#idmatch[*]} -eq 1 ] && [ -r "$idmatch" ]; then
+		id=$idpref${idmatch#.git/objects/$idpref/}
+	elif [ ${#idmatch[*]} -gt 1 ]; then
+		echo "Ambiguous id: $id" >&2
+		exit 1
+	fi
+fi
+
+if echo $id | egrep -vq "$SHA1ONLY"; then
+	echo "Invalid id: $id" >&2
+	exit 1
+fi
 
 if [ "$(cat-file -t "$id")" != "tree" ]; then
 	echo "Invalid id: $id" >&2
Index: parent-id
===================================================================
--- 6ad600e20c89323c1d3049f75b8ca9b0a2d72167/parent-id  (mode:100755 sha1:f35877a6aa5b68d2fb4a388dcfa9b3e64262604e)
+++ uncommitted/parent-id  (mode:100775)
@@ -5,7 +5,8 @@
 #
 # Takes ID of the current commit, defaults to HEAD.
 
-PARENT="^parent [A-Za-z0-9]{40}$"
+SHA1="[A-Za-z0-9]{40}"
+PARENT="^parent $SHA1$"
 
 id=$(commit-id $1) || exit 1
 


--------------020001040200050607070401--
