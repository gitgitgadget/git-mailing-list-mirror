From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 2/7] git-rebase--interactive.sh: extract function for adding "pick" line
Date: Wed, 18 Jul 2012 00:27:30 -0700
Message-ID: <1342596455-17046-3-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1342596455-17046-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1342596455-17046-2-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 18 09:28:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrOft-0008JJ-LS
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jul 2012 09:27:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764Ab2GRH1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jul 2012 03:27:53 -0400
Received: from mail-vb0-f74.google.com ([209.85.212.74]:52165 "EHLO
	mail-vb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948Ab2GRH1u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2012 03:27:50 -0400
Received: by vbnl22 with SMTP id l22so130930vbn.1
        for <git@vger.kernel.org>; Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=OKi/UIdkL30fj7SVN90SwmZj7jc8UqolAazm2oTkROU=;
        b=YXsA+4eRtVonZbMOFQxugvLhNgGM4473bPmZOI3w9tCbbuy7JdQPCbu5AzxwGz0KTe
         DGx0WC0T7lGDHhfd2kxshtrw5Gw2RpBIg0KosFHEHvh1+Iiy7ll2+i7x4dq5pv3v1oYo
         NMdiV3IKj2anuf+AMvz0U+MBVBHWMExX6sroDr4XfClDhI/q2ncuN4yCzXhLBrnSUjVE
         TT793rXE4AjUtFOU8inYPlTWFriWdCxQtTf8gFypUB4W5eWVYXGRH1qAb7rSYo/e8jXs
         QN42/dUhxz87PlkXhZjQG0B8SOd3qUivrpniVGuCeH7Va6ciC3fX+nh37G8mqD+w7sDM
         qSjA==
Received: by 10.236.138.193 with SMTP id a41mr865148yhj.30.1342596469422;
        Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
Received: by 10.236.138.193 with SMTP id a41mr865141yhj.30.1342596469375;
        Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id r48si5977018yhm.3.2012.07.18.00.27.49
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.98.93])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 4753E1E0043;
	Wed, 18 Jul 2012 00:27:49 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id CDC00C151D; Wed, 18 Jul 2012 00:27:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.104.ge7b44f1
In-Reply-To: <1342596455-17046-2-git-send-email-martin.von.zweigbergk@gmail.com>
X-Gm-Message-State: ALoCoQkzDXZIWRYrgd+T438OzCw1iJf+/NWh8/yqVdRC1Tw8qON3xB+3saEgQG2qEdz4+7TpQy4kA/qpiBnLBS+fGt31fYvcXmOmi0fZkEunjNTlPquFLlANDgDCyH9h7hlxPHy71gHunLnYsuIbfSNhCyahPUgR2vOmVCdICh4hdkZdcUjOut1VV6mX7lRK2TOBtUjErMDH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201659>

Extract the code that adds a possibly commented-out "pick" line to the
todo file. This lets us reuse it more easily later.
---
 git-rebase--interactive.sh | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index bef7bc0..fa722b6 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -828,23 +828,26 @@ else
 	revisions=$onto...$orig_head
 	shortrevisions=$shorthead
 fi
-git rev-list $merges_option --pretty=oneline --abbrev-commit \
-	--abbrev=7 --reverse --left-right --topo-order \
-	$revisions | \
-	sed -n "s/^>//p" |
-while read -r shortsha1 rest
-do
 
-	if test -z "$keep_empty" && is_empty_commit $shortsha1
+add_pick_line () {
+	if test -z "$keep_empty" && is_empty_commit $1
 	then
 		comment_out="# "
 	else
 		comment_out=
 	fi
+	printf '%s\n' "${comment_out}pick $1 $2" >>"$todo"
+}
 
+git rev-list $merges_option --pretty=oneline --abbrev-commit \
+	--abbrev=7 --reverse --left-right --topo-order \
+	$revisions | \
+	sed -n "s/^>//p" |
+while read -r shortsha1 rest
+do
 	if test t != "$preserve_merges"
 	then
-		printf '%s\n' "${comment_out}pick $shortsha1 $rest" >>"$todo"
+		add_pick_line $shortsha1 "$rest"
 	else
 		sha1=$(git rev-parse $shortsha1)
 		if test -z "$rebase_root"
@@ -863,7 +866,7 @@ do
 		if test f = "$preserve"
 		then
 			touch "$rewritten"/$sha1
-			printf '%s\n' "${comment_out}pick $shortsha1 $rest" >>"$todo"
+			add_pick_line $shortsha1 "$rest"
 		fi
 	fi
 done
-- 
1.7.11.1.104.ge7b44f1
