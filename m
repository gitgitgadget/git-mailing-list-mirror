From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v4 5/6] t7406: Add explicit tests for head attachement after cloning updates
Date: Wed, 15 Jan 2014 20:10:26 -0800
Message-ID: <b1cc110f1a0b68859af89cf8aed28d8a9eedddb5.1389837412.git.wking@tremily.us>
References: <20140114224246.GA13271@book.hvoigt.net>
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 16 05:11:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3eIx-0001c1-M1
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 05:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbaAPELf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 23:11:35 -0500
Received: from qmta01.westchester.pa.mail.comcast.net ([76.96.62.16]:53941
	"EHLO qmta01.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751559AbaAPELb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jan 2014 23:11:31 -0500
Received: from omta02.westchester.pa.mail.comcast.net ([76.96.62.19])
	by qmta01.westchester.pa.mail.comcast.net with comcast
	id ETcV1n0030QuhwU51UBXDp; Thu, 16 Jan 2014 04:11:31 +0000
Received: from odin.tremily.us ([24.18.63.50])
	by omta02.westchester.pa.mail.comcast.net with comcast
	id EUBV1n00Q152l3L3NUBWZ7; Thu, 16 Jan 2014 04:11:31 +0000
Received: from mjolnir.tremily.us (unknown [192.168.0.141])
	by odin.tremily.us (Postfix) with ESMTPS id 62A12EFE48F;
	Wed, 15 Jan 2014 20:11:29 -0800 (PST)
Received: (nullmailer pid 18569 invoked by uid 1000);
	Thu, 16 Jan 2014 04:11:04 -0000
X-Mailer: git-send-email 1.8.5.2.8.g0f6c0d1
In-Reply-To: <20140114224246.GA13271@book.hvoigt.net>
In-Reply-To: <cover.1389837412.git.wking@tremily.us>
References: <cover.1389837412.git.wking@tremily.us>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1389845491;
	bh=NxhtrExjPeuGezlh3wY/i6ao0YFwKuvB7pqfhm19XQY=;
	h=Received:Received:Received:Received:From:To:Subject:Date:
	 Message-Id;
	b=bfOE0Smqq7kyaasb0yax4iyU1+LhNZqsMi+Yyg23P9H8LCrwXCdvfzZjh04to1Cc+
	 WVszA2i0BwLbWrAOJ5yhM2oNi3rR8RdOVzNNKk4HhkusOFVeZx5qd2woZ+FXzoj61Q
	 dtOo7LABJRg4HS+tqLbCKCcZOParecJ8bMSGWEbaVdamYPGYSADL3TOpdBRAFM6K28
	 jUbvoCnRMM2oTVtlY+Q7ho/TQd3nY3gI20RhjeMAL+O49zxpeBbdo5TK9mmzqrwjG/
	 W2me8uL26Lny5XjxSNrEXdpbGPH8Ocy8fyeI7KuN9jSkpBlF9ic65mw6KAGF0H4Ikn
	 XUqdEIFqQ2JUw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240501>

Test that cloning updates checkout the appropriate local branch for
their update-mode:

* Checkout-mode updates get detached HEADs
* Everyone else gets a local branch, matching the configured
  submodule.<name>.branch and defaulting to master.

The 'initial-setup' tag makes it easy to reset the superproject to a
known state, as several earlier tests commit to submodules and commit
the changed gitlinks to the superproject, but don't push the new
submodule commits to the upstream subprojects.  This makes it
impossible to checkout the current super master, because it references
submodule commits that don't exist in the upstream subprojects.  For a
specific example, see the tests that currently generate the
'two_new_submodule_commits' commits.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
 t/t7406-submodule-update.sh | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 5aa9591..f056c01 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -63,6 +63,9 @@ test_expect_success 'setup a submodule tree' '
 	 git submodule add ../none none &&
 	 test_tick &&
 	 git commit -m "none"
+	) &&
+	(cd super &&
+	 git tag initial-setup
 	)
 '
 
@@ -764,4 +767,38 @@ test_expect_success 'submodule update clone shallow submodule' '
 	 )
 	)
 '
+
+test_expect_success 'submodule update --checkout clones detached HEAD' '
+	git clone super super4 &&
+	echo "detached HEAD" >expected &&
+	(cd super4 &&
+	 git reset --hard initial-setup &&
+	 git submodule init submodule &&
+	 git submodule update >> /tmp/log 2>&1 &&
+	 (cd submodule &&
+	  git symbolic-ref HEAD > ../../actual ||
+	  echo "detached HEAD" > ../../actual
+	 )
+	) &&
+	test_cmp actual expected &&
+	rm -rf super4
+'
+
+test_expect_success 'submodule update --merge clones attached HEAD' '
+	git clone super super4 &&
+	echo "refs/heads/master" >expected &&
+	(cd super4 &&
+	 git reset --hard initial-setup &&
+	 git submodule init submodule &&
+	 git config submodule.submodule.update merge &&
+	 git submodule update --merge &&
+	 (cd submodule &&
+	  git symbolic-ref HEAD > ../../actual ||
+	  echo "detached HEAD" > ../../actual
+	 )
+	) &&
+	test_cmp actual expected &&
+	rm -rf super4
+'
+
 test_done
-- 
1.8.5.2.8.g0f6c0d1
