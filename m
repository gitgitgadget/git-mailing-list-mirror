From: Johan Herland <johan@herland.net>
Subject: [PATCH 2/7] t7900: Start testing usability of namespaced remote refs
Date: Sun,  5 May 2013 01:55:44 +0200
Message-ID: <1367711749-8812-3-git-send-email-johan@herland.net>
References: <1367711749-8812-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 05 01:56:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYmJL-0005n7-04
	for gcvg-git-2@plane.gmane.org; Sun, 05 May 2013 01:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750998Ab3EDX4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 May 2013 19:56:00 -0400
Received: from mail-bk0-f54.google.com ([209.85.214.54]:50274 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705Ab3EDXz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 May 2013 19:55:58 -0400
Received: by mail-bk0-f54.google.com with SMTP id y8so1149991bkt.41
        for <git@vger.kernel.org>; Sat, 04 May 2013 16:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=ZKnBuF83/VB02eyX+cUSazlZyVwLifPYdlEGDOVhV5Y=;
        b=IYH05WRKItBGyC6MzNNgUajs9zxS2EYlhYPj/BMY9WZXbFadISTQ1bOArPM1fgcH3F
         9a+8Jq9LVJ96/4gxm/rjEuQw5hqtaz9Ze5+4+ClAgXSHXz7NEGHF/x3C2TGhXhXNkyvO
         56inJGDf7TG9v9TQwTNvh0q4/Q1A1RcngJtxTe1v/6aEjqB9d3ehn1eUTL5J+adLqI/l
         QAda4ehNBkorbHg+ayw+LRTvISwOpWj0zUV3P5fj6kHs+FUXpIhkf39HKWCGWFIJ5gce
         Wize9FTAJnnVgyjgy0D3MD54KsT+rQPnKMcqrz9N1KfPIeiB3YXiXydbDauXmoG5L5/L
         Yilw==
X-Received: by 10.205.68.195 with SMTP id xz3mr5862564bkb.41.1367711757133;
        Sat, 04 May 2013 16:55:57 -0700 (PDT)
Received: from localhost.localdomain (p5DC5A30A.dip0.t-ipconnect.de. [93.197.163.10])
        by mx.google.com with ESMTPSA id iy11sm3810775bkb.11.2013.05.04.16.55.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 04 May 2013 16:55:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1367711749-8812-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223383>

Some users are interested in fetching remote refs into a separate namespace
in the local repo. E.g. instead of the usual remote config:

  [remote "origin"]
	fetch = +refs/heads/*:refs/remotes/origin/*
	url = ...

they want to keep remote tags separate from local tags, and they may also
want to fetch other ref types:

  [remote "origin"]
	fetch = +refs/heads/*:refs/remotes/origin/heads/*
	fetch = +refs/tags/*:refs/remotes/origin/tags/*
	fetch = +refs/notes/*:refs/remotes/origin/notes/*
	fetch = +refs/replace/*:refs/remotes/origin/replace/*
	tagopt = "--no-tags"
	url = ...

This configuration creates a separate namespace under refs/remotes/origin/*
mirroring the structure of local refs (under refs/*) where all the relevant
refs from the 'origin' remote can be found.

This patch introduces a test whose main purpose is to verify that git will
work comfortably with this kind of setup. For now, we only verify that it
is possible (though not exactly easy) to establish a clone with the above
configuration, and that fetching into it yields the expected result.

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t7900-working-with-namespaced-remote-refs.sh | 88 ++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100755 t/t7900-working-with-namespaced-remote-refs.sh

diff --git a/t/t7900-working-with-namespaced-remote-refs.sh b/t/t7900-working-with-namespaced-remote-refs.sh
new file mode 100755
index 0000000..af03ac9
--- /dev/null
+++ b/t/t7900-working-with-namespaced-remote-refs.sh
@@ -0,0 +1,88 @@
+#!/bin/sh
+
+test_description='testing end-user usability of namespaced remote refs
+
+Set up a local repo with namespaced remote refs, like this:
+
+[remote "origin"]
+	fetch = +refs/heads/*:refs/remotes/origin/heads/*
+	fetch = +refs/tags/*:refs/remotes/origin/tags/*
+	fetch = +refs/notes/*:refs/remotes/origin/notes/*
+	fetch = +refs/replace/*:refs/remotes/origin/replace/*
+	tagopt = "--no-tags"
+	url = ...
+
+Test that the usual end-user operations work as expected with this setup.
+'
+
+. ./test-lib.sh
+
+test_expect_success 'setup server repo' '
+	git init server &&
+	(
+		cd server &&
+		test_commit server_master_a &&
+		git checkout -b other &&
+		test_commit server_other_b &&
+		git checkout master &&
+		test_commit server_master_b
+	)
+'
+
+server_master_a=$(git --git-dir=server/.git rev-parse --verify server_master_a)
+server_master_b=$(git --git-dir=server/.git rev-parse --verify server_master_b)
+server_other_b=$(git --git-dir=server/.git rev-parse --verify server_other_b)
+
+cat > expect.refspecs << EOF
++refs/heads/*:refs/remotes/origin/heads/*
++refs/tags/*:refs/remotes/origin/tags/*
++refs/notes/*:refs/remotes/origin/notes/*
++refs/replace/*:refs/remotes/origin/replace/*
+EOF
+
+cat > expect.show-ref << EOF
+$server_master_b refs/heads/master
+$server_master_b refs/remotes/origin/heads/master
+$server_other_b refs/remotes/origin/heads/other
+$server_master_a refs/remotes/origin/tags/server_master_a
+$server_master_b refs/remotes/origin/tags/server_master_b
+$server_other_b refs/remotes/origin/tags/server_other_b
+EOF
+
+test_clone() {
+	( cd $1 && git config --get-all remote.origin.fetch ) > actual.refspecs &&
+	test_cmp expect.refspecs actual.refspecs &&
+	( cd $1 && git show-ref ) > actual.show-ref &&
+	test_cmp expect.show-ref actual.show-ref
+}
+
+test_expect_failure 'clone with namespaced remote refs' '
+	git clone server client \
+		--config remote.origin.fetch="+refs/heads/*:refs/remotes/origin/heads/*" \
+		--config remote.origin.fetch="+refs/tags/*:refs/remotes/origin/tags/*" \
+		--config remote.origin.fetch="+refs/notes/*:refs/remotes/origin/notes/*" \
+		--config remote.origin.fetch="+refs/replace/*:refs/remotes/origin/replace/*" \
+		--config remote.origin.tagopt "--no-tags" &&
+	test_clone client
+'
+
+# Work-around for the above failure
+test_expect_success 'work-around "clone" with namespaced remote refs' '
+	rm -rf client &&
+	git init client &&
+	(
+		cd client &&
+		git remote add origin ../server &&
+		git config --unset-all remote.origin.fetch &&
+		git config --add remote.origin.fetch "+refs/heads/*:refs/remotes/origin/heads/*" &&
+		git config --add remote.origin.fetch "+refs/tags/*:refs/remotes/origin/tags/*" &&
+		git config --add remote.origin.fetch "+refs/notes/*:refs/remotes/origin/notes/*" &&
+		git config --add remote.origin.fetch "+refs/replace/*:refs/remotes/origin/replace/*" &&
+		git config remote.origin.tagopt "--no-tags" &&
+		git fetch &&
+		git checkout master
+	) &&
+	test_clone client
+'
+
+test_done
-- 
1.8.1.3.704.g33f7d4f
