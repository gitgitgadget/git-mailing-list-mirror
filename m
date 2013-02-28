From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH v2] contrib/subtree: allow addition of remote branch with name
 not locally present
Date: Thu, 28 Feb 2013 21:41:51 +0000
Message-ID: <CALeLG_m3A_52z=+NDrpttmTavzw68hnuWJZk8XHcN-smsQJupg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Adam Tkac <atkac@redhat.com>, David Greene <greened@obbligato.org>,
	Jesper Lyager Nielsen <lyager@gmail.com>,
	Michael Schubert <mschub@elegosoft.com>,
	Techlive Zheng <techlivezheng@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 28 22:42:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBBF3-0000t6-MM
	for gcvg-git-2@plane.gmane.org; Thu, 28 Feb 2013 22:42:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759855Ab3B1Vlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2013 16:41:52 -0500
Received: from mail-oa0-f47.google.com ([209.85.219.47]:44958 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753331Ab3B1Vlw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2013 16:41:52 -0500
Received: by mail-oa0-f47.google.com with SMTP id o17so4509560oag.6
        for <git@vger.kernel.org>; Thu, 28 Feb 2013 13:41:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:date:message-id:subject
         :from:to:cc:content-type:x-gm-message-state;
        bh=sZeIlMj7leSiyGJydX1Y2YBMc/uNM0LklI9hLIeOXyA=;
        b=BJwfWE1EbbLlpfx9KV3wj1cCBGMdBSz1d0cKXVyi3sud2fOcAadqQXaOS3puxG8il4
         E2/ieV9HCb5EXO//lzFkv6gV57qcptMjkSbm6E1czkR9Vjz4ZIFGwNMHGiP4Cy9NL2LH
         PPqyTsUSmux2IhwGUstBuVlv/7XNas0vlI7zk6Vxk5nGluc4bIHl8W9zjjVpx/1x/8bV
         joDJ6hfoEMuVa+LRVNTp/f/bSW5ij+kzg2hTDcyrzEKVrKgoB6JxC7dIeuFLtPrQtsFW
         dWWk87qvWtRxEjS5KDVJYn8t9eadq7D9XULSX4o+18awlLQPUn3IbWRKMiHqaultrOm7
         a/eg==
X-Received: by 10.182.15.5 with SMTP id t5mr6789314obc.40.1362087711675; Thu,
 28 Feb 2013 13:41:51 -0800 (PST)
Received: by 10.76.132.234 with HTTP; Thu, 28 Feb 2013 13:41:51 -0800 (PST)
X-Originating-IP: [92.28.176.38]
X-Gm-Message-State: ALoCoQmx0FmWPme51GqZkNPk0LhMCyruGRkmyyZMGw7MA1ajELZnAvBziTl084PelL8Cql7mnNDN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217257>

cmd_add() attempts to check for the validity of refspec for the repository
it is about to add as a subtree. It tries to do so before contacting the
repository. If the refspec happens to exist locally (say 'master') then
the test passes and the repo is fetched. If the refspec doesn't exist
locally then the test fails and the remote repo is never contacted.

Removing the tests still works as the git fetch command fails with the
perfectly accurate error:

  fatal: Couldn't find remote ref <refspec>

New tests check to prevent pulling in multiple branches or creating a local
branch for the subtree.

Signed-off-by: Paul Campbell <pcampbell@carnegiecollege.ac.uk>
---

I've rerolled this with alternate tests.

Is there anything else that should be tested for?

 contrib/subtree/git-subtree.sh | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 8a23f58..d04bd25 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -503,13 +503,14 @@ cmd_add()

 	    "cmd_add_commit" "$@"
 	elif [ $# -eq 2 ]; then
-	    # Technically we could accept a refspec here but we're
-	    # just going to turn around and add FETCH_HEAD under the
-	    # specified directory.  Allowing a refspec might be
-	    # misleading because we won't do anything with any other
-	    # branches fetched via the refspec.
-	    git rev-parse -q --verify "$2^{commit}" >/dev/null ||
-	    die "'$2' does not refer to a commit"
+	    case "$2" in
+		*\**) # Avoid pulling in multiple branches
+			die "'$2' contains a wildcard"
+			;;
+		*\:*) # Don't create a local branch for the subtree
+			die "'$2' contains a local branch name"
+			;;
+	    esac

 	    "cmd_add_repository" "$@"
 	else
-- 
1.8.2.rc1
