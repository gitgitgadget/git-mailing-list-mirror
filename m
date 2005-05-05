From: Alexander Beyn <malex-git@fatelectrons.org>
Subject: [PATCH] have commit-id dereference git tags
Date: Thu, 5 May 2005 00:48:23 -0700
Message-ID: <20050505074823.GA9075@fatelectrons.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu May 05 09:42:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTazg-0000O5-Kd
	for gcvg-git@gmane.org; Thu, 05 May 2005 09:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbVEEHs3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 03:48:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbVEEHs3
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 03:48:29 -0400
Received: from adsl-66-51-204-13.dslextreme.com ([66.51.204.13]:40929 "EHLO
	mail.fatelectrons.org") by vger.kernel.org with ESMTP
	id S261959AbVEEHsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2005 03:48:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.fatelectrons.org (Postfix) with ESMTP id 46F5A10FE2A0
	for <git@vger.kernel.org>; Thu,  5 May 2005 00:48:24 -0700 (PDT)
Received: from mail.fatelectrons.org ([127.0.0.1])
 by localhost (hmm [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 07193-08 for <git@vger.kernel.org>; Thu,  5 May 2005 00:48:24 -0700 (PDT)
Received: by mail.fatelectrons.org (Postfix, from userid 1000)
	id 031DE10FE291; Thu,  5 May 2005 00:48:23 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
X-Virus-Scanned: by amavisd-new at fatelectrons.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

With this patch, if commit-id is passed a git tag, it will check to see
if the tag points to a commit. If it does, commit-id will return that
commit's id.

I'm not sure if this is the proper place to handle git tags, but it does
make things like "cg-diff -r v2.6.12-rc2:v2.6.12-rc3" work in the Linus
kernel tree. I've not noticed any problems this introduces, but I didn't 
do a thorough check.

Signed-Off-By: Alexander Beyn <malex-git@fatelectrons.org>


Index: commit-id
===================================================================
--- 6a20fd05c468097d5a5a47cd37b41581c963cf63/commit-id  (mode:100755 sha1:daf0ea1e35f1bee22eb4c4771495b2212d15f4e7)
+++ 66fded2e9d931ecc8b03aa282a7eb9559955c172/commit-id  (mode:100755 sha1:978c3ffeb072422436af7af1ad4a8de0e91c9632)
@@ -32,7 +32,15 @@
 	exit 1
 fi
 
-if [ "$(git-cat-file -t "$id")" != "commit" ]; then
+type="$(git-cat-file -t "$id")"
+
+if [ "$type" = "tag" ]; then
+	id=$(git-cat-file tag "$id" | egrep -m 1 "^object $SHA1")
+	id="${id#object }"
+	type="$(git-cat-file -t "$id")"
+fi
+
+if [ "$type" != "commit" ]; then
 	echo "Invalid id: $id" >&2
 	exit 1
 fi
