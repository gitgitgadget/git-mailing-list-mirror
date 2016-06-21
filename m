Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E85341F744
	for <e@80x24.org>; Tue, 21 Jun 2016 08:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbcFUI0d (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 04:26:33 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33040 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbcFUI03 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 04:26:29 -0400
Received: by mail-pf0-f195.google.com with SMTP id c74so886353pfb.0
        for <git@vger.kernel.org>; Tue, 21 Jun 2016 01:26:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=EgDTxehC67bmK6QMRChMWy1+KWFdErTtLSykxOw7kCg=;
        b=JUdRN36IzRZwl8Pb00g+nQyNesUj3mg0oxOG/18rKZCYcK7Stdwgh00ZP3ViYqyYow
         jDC0SWeJU2oVPVlcU50jSYKT6nKkK6FkdC+0DD15rS3Kp76YqW2mRo0KwLVuLfkF6eaE
         h+o61iyQLeMQ6RG2UEHSgxz9IPqbVYOXwHFJHszEr2OXGbc2BksjBkL1yGsGID9NkHfV
         m0j8j0Y55LUPZ9byR2EtBBHnXQ2rtxhsUXIgTP8XkKR3C+XmhY9ekO0YZcpgSLFvxak/
         KqqIOSS/RCW7BaZB2JTGSz2Qs+0cGVfvLGDE4hliE2nZBWbf81/woLxrCTpdeYFEdRL2
         lXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EgDTxehC67bmK6QMRChMWy1+KWFdErTtLSykxOw7kCg=;
        b=M5jey1H27h60V+In/k3aiZZFuo4rhg7i0d3P3W6NZSIcfCEDJjM8Hq2Ahvge0bDS3Q
         opPPz+uo7Qhgrl7LUnuCzBr96c9bKI0qX0KMzoBaYjXcQcWUh76XEOu0dHdq/0ceHmEd
         Oqfs998vkUfrhzGNwyNUs8BSBmKh56dr+PPbCoGW0kgXzLvXqeqSkvNgwXEYS6VQXUKn
         095VzmhbtF6w1mNOBgQ1QnfMflzE3Q0rQgiswZlayWgcRwWNr5ITtdpQielAE3XXIQFz
         ss8nTb1r3+mtHYOq3NMIu1VitR3CLO5MtF2MruAqRWHO8659ZcxKdW/BkgjaQm4SWnE2
         vgwA==
X-Gm-Message-State: ALyK8tIK44nyyn7gj0x0J988rm0h7xMdh4fn62/u7qJqq9NGfSAgrw4eORpI6q9w0Gu6mg==
X-Received: by 10.98.130.65 with SMTP id w62mr26257708pfd.5.1466488641334;
        Mon, 20 Jun 2016 22:57:21 -0700 (PDT)
Received: from localhost.localdomain (124-149-99-253.dyn.iinet.net.au. [124.149.99.253])
        by smtp.googlemail.com with ESMTPSA id i68sm38584603pfe.64.2016.06.20.22.57.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 Jun 2016 22:57:20 -0700 (PDT)
From:	Brett Randall <javabrett@gmail.com>
To:	gitster@pobox.com, git@vger.kernel.org
Cc:	Brett Randall <javabrett@gmail.com>
Subject: [PATCH] Improved example "To move the whole tree into a subdirectory..." to not fail when early commits are empty.
Date:	Tue, 21 Jun 2016 15:57:02 +1000
Message-Id: <20160621055702.28044-1-javabrett@gmail.com>
X-Mailer: git-send-email 2.8.4
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Previously this example would fail if the oldest commit(s) in any filtered branch is/are empty (no files) because the index would not change, and the mv would fail with:

	mv: cannot stat <redacted>/index.new': No such file or directory

This commonly occurs with histories created from git-svn-clone.  The updated example checks whether the index file has been created before attempting the mv.  The empty commit is retained.

See http://stackoverflow.com/questions/7798142/error-combining-git-repositories-into-subdirs for an example and explanation.

Signed-off-by: Brett Randall <javabrett@gmail.com>
---
 Documentation/git-filter-branch.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 003731f..271d5b0 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -385,7 +385,7 @@ git filter-branch --index-filter \
 	'git ls-files -s | sed "s-\t\"*-&newsubdir/-" |
 		GIT_INDEX_FILE=$GIT_INDEX_FILE.new \
 			git update-index --index-info &&
-	 mv "$GIT_INDEX_FILE.new" "$GIT_INDEX_FILE"' HEAD
+	 if [ -f "$GIT_INDEX_FILE.new" ]; then mv "$GIT_INDEX_FILE.new" "$GIT_INDEX_FILE"; fi' HEAD
 ---------------------------------------------------------------
 
 
-- 
2.8.4

