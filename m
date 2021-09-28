Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E46BC433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 12:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B2B360F21
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 12:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240525AbhI1M2s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 08:28:48 -0400
Received: from kitenet.net ([66.228.36.95]:38440 "EHLO kitenet.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240426AbhI1M2r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 08:28:47 -0400
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Sep 2021 08:28:47 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1632831416; bh=UTeClpKp497L3xT1N4Zx9iGGVHhUPpVf8LDNnVqbFAk=;
        h=From:To:Cc:Subject:Date:From;
        b=XKwqJKNzNuZlaLV7usEiaw9eOE/cUdD4r2MjN10RCzetbGGuQDsjk648kiyGC2RgQ
         PQoEm1zhfb6rARL7jNnX1hTEqUy1Z+jRZnXzoRx2K+1jdqNJ3xscwZQt6i7ba+a4t0
         eXSpNQ3WtVr6kASTle82TsTg08hc1jhrNragTri8=
X-Question: 42
From:   Joey Hess <joeyh@joeyh.name>
To:     git@vger.kernel.org
Cc:     Joey Hess <joeyh@joeyh.name>
Subject: [PATCH] avoid insecure use of mail in man page example
Date:   Tue, 28 Sep 2021 08:16:48 -0400
Message-Id: <20210928121648.1390915-1-joeyh@joeyh.name>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As recently seen in fail2ban's security hole (CVE-2021-32749),
piping user controlled input to mail is exploitable,
since a line starting with "~! foo" in the input will run command foo.

This example on the man page pipes to mail. It may not be exploitable.
git rev-list --pretty indents commit messages, which prevents the escape
sequence working there. It's less clear if it might be possible to embed
the escape sequence in a signed push certificate. The user reading the
man page might alter the example to do something more exploitable.
To encourage safe use of mail, add -E 'set escape'

Signed-off-by: Joey Hess <joeyh@joeyh.name>
---
 Documentation/git-receive-pack.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 014a78409b..cdaae75365 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -183,7 +183,7 @@ do
 		echo "New commits:"
 		git rev-list --pretty "$nval" "^$oval"
 	fi |
-	mail -s "Changes to ref $ref" commit-list@mydomain
+	mail -E 'set escape' -s "Changes to ref $ref" commit-list@mydomain
 done
 # log signed push certificate, if any
 if test -n "${GIT_PUSH_CERT-}" && test ${GIT_PUSH_CERT_STATUS} = G
@@ -191,7 +191,7 @@ then
 	(
 		echo expected nonce is ${GIT_PUSH_NONCE}
 		git cat-file blob ${GIT_PUSH_CERT}
-	) | mail -s "push certificate from $GIT_PUSH_CERT_SIGNER" push-log@mydomain
+	) | mail -E 'set escape' -s "push certificate from $GIT_PUSH_CERT_SIGNER" push-log@mydomain
 fi
 exit 0
 ----
-- 
2.33.0

