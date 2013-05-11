From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 01/10] t7900: Start testing usability of namespaced remote refs
Date: Sat, 11 May 2013 18:21:11 +0200
Message-ID: <1368289280-30337-2-git-send-email-johan@herland.net>
References: <1368289280-30337-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, gitster@pobox.com, jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 11 18:21:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbCY8-0007L1-50
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 18:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316Ab3EKQV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 12:21:28 -0400
Received: from mail-wg0-f53.google.com ([74.125.82.53]:63099 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722Ab3EKQV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 12:21:27 -0400
Received: by mail-wg0-f53.google.com with SMTP id y10so5094136wgg.20
        for <git@vger.kernel.org>; Sat, 11 May 2013 09:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=C4TLbwUAdIyEdAUdE/PyJRyj3KAs+sfZaV4PeR4Y8iA=;
        b=LveLZdz/WJL3g/KY9OX+hAb2euSQMn6BANzu6P2qUOGqnTHbKX2RVqvNbKK7SoGIvf
         aOwGTnJ41v7tenT6RkcXGkbrNZj/tEL98F7TatZw00X4k7iuoQIpqEgHgDq9Z1yiM2Cs
         ZB+VjSqkpSUvKHItlwEdXcWPySdAIMH6e5tCYy0gyIjf6j8s99GdyCxqnW89cCu1XBQB
         jB5NyuuxBdxOHQZJVTASADtWTjnEVRnrbKhADN0e+rLOt/sQtEu6R/iHy9w8MjZcP1eR
         St57+0SISJ/EQrBFLdSkyqoR9OGfFkCLrwCQTJtewOOTJigCFFu2u68OUa29Z9N+y7GX
         A70Q==
X-Received: by 10.180.105.231 with SMTP id gp7mr9757217wib.23.1368289286377;
        Sat, 11 May 2013 09:21:26 -0700 (PDT)
Received: from localhost.localdomain ([213.221.117.228])
        by mx.google.com with ESMTPSA id er17sm4722405wic.0.2013.05.11.09.21.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 11 May 2013 09:21:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1368289280-30337-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223982>

Some users are interested in fetching remote refs into a separate namespace
in the local repo. E.g. instead of the usual remote config:

  [remote "origin"]
	fetch = +refs/heads/*:refs/remotes/origin/*
	url = ...

they want to keep remote tags separate from local tags, and they may also
want to fetch other ref types:

  [remote "origin"]
	fetch = +refs/heads/*:refs/peers/origin/heads/*
	fetch = +refs/tags/*:refs/peers/origin/tags/*
	fetch = +refs/notes/*:refs/peers/origin/notes/*
	fetch = +refs/replace/*:refs/peers/origin/replace/*
	tagopt = "--no-tags"
	url = ...

This configuration creates a separate namespace under refs/peers/origin/*
mirroring the structure of local refs (under refs/*) where all the relevant
refs from the 'origin' remote can be found. The reason for renaming the
refs/remotes/ prefix to refs/peers/ is to allow Git to treat the two
hierarchies somewhat differently with respect to how shorthand names are
expanded by the ref machinery.

This patch introduces a test whose main purpose is to verify that git will
work comfortably with this kind of setup. For now, we only verify that it
is possible (though not exactly easy) to establish a clone with the above
configuration, and that fetching into it yields the expected result.

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t7900-working-with-namespaced-remote-refs.sh | 82 ++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)
 create mode 100755 t/t7900-working-with-namespaced-remote-refs.sh

diff --git a/t/t7900-working-with-namespaced-remote-refs.sh b/t/t7900-working-with-namespaced-remote-refs.sh
new file mode 100755
index 0000000..dfd916b
--- /dev/null
+++ b/t/t7900-working-with-namespaced-remote-refs.sh
@@ -0,0 +1,82 @@
+#!/bin/sh
+
+test_description='testing end-user usability of namespaced remote refs
+
+Set up a local repo with namespaced remote refs, like this:
+
+[remote "origin"]
+	fetch = +refs/heads/*:refs/peers/origin/heads/*
+	fetch = +refs/tags/*:refs/peers/origin/tags/*
+	fetch = +refs/notes/*:refs/peers/origin/notes/*
+	fetch = +refs/replace/*:refs/peers/origin/replace/*
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
+cat >expect.refspecs << EOF
++refs/heads/*:refs/peers/origin/heads/*
++refs/tags/*:refs/peers/origin/tags/*
++refs/notes/*:refs/peers/origin/notes/*
++refs/replace/*:refs/peers/origin/replace/*
+EOF
+
+cat >expect.show-ref << EOF
+$server_master_b refs/heads/master
+$server_master_b refs/peers/origin/heads/master
+$server_other_b refs/peers/origin/heads/other
+$server_master_a refs/peers/origin/tags/server_master_a
+$server_master_b refs/peers/origin/tags/server_master_b
+$server_other_b refs/peers/origin/tags/server_other_b
+EOF
+
+test_clone() {
+	( cd $1 && git config --get-all remote.origin.fetch ) >actual.refspecs &&
+	test_cmp expect.refspecs actual.refspecs &&
+	( cd $1 && git show-ref ) >actual.show-ref &&
+	test_cmp expect.show-ref actual.show-ref
+}
+
+test_expect_failure 'clone with namespaced remote refs' '
+	git clone --layout=peers server client &&
+	test_clone client
+'
+
+# Work-around for the not-yet-existing clone option used above
+test_expect_success 'work-around "clone" with namespaced remote refs' '
+	rm -rf client &&
+	git init client &&
+	(
+		cd client &&
+		git config remote.origin.url ../server &&
+		git config --add remote.origin.fetch "+refs/heads/*:refs/peers/origin/heads/*" &&
+		git config --add remote.origin.fetch "+refs/tags/*:refs/peers/origin/tags/*" &&
+		git config --add remote.origin.fetch "+refs/notes/*:refs/peers/origin/notes/*" &&
+		git config --add remote.origin.fetch "+refs/replace/*:refs/peers/origin/replace/*" &&
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
