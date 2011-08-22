From: Jason Gross <jgross@MIT.EDU>
Subject: [PATCH] Add tests for handling corrupted caches
Date: Mon, 22 Aug 2011 00:10:10 -0400
Message-ID: <1313986210-6536-1-git-send-email-jgross@mit.edu>
References: <1313979422-21286-1-git-send-email-jgross@mit.edu>
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jason Gross <jgross@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 22 06:11:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvLql-0006vs-9y
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 06:10:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750863Ab1HVEKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 00:10:55 -0400
Received: from DMZ-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.35]:44565 "EHLO
	dmz-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750806Ab1HVEKy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Aug 2011 00:10:54 -0400
X-AuditID: 12074423-b7b31ae000000a3c-65-4e51d6ceb3d3
Received: from mailhub-auth-2.mit.edu ( [18.7.62.36])
	by dmz-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 3F.67.02620.EC6D15E4; Mon, 22 Aug 2011 00:10:54 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-2.mit.edu (8.13.8/8.9.2) with ESMTP id p7M4Arap022842;
	Mon, 22 Aug 2011 00:10:53 -0400
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
	(authenticated bits=0)
        (User authenticated as jgross@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id p7M4AqWd003084;
	Mon, 22 Aug 2011 00:10:52 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.558.g4b2f
In-Reply-To: <1313979422-21286-1-git-send-email-jgross@mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsUixG6nonvuWqCfwZz5WhZdV7qZLP7saGGz
	eHtzCaMDs8fOWXfZPT5vkgtgiuKySUnNySxLLdK3S+DKmPn5AmPBUf6KM1snMzYwbuTpYuTk
	kBAwkdgw+QIThC0mceHeerYuRi4OIYF9jBLX266BJYQENjBK3NplCpH4yigxY/dKNpAEm4CS
	xO2NixhBbBEBcYm3x2eyg9jMAm4Srz40gcWFBSwkzt3cwwxiswioSlxpbwKr4RWwlfi0fQI7
	xGYNiYlz57CA2JwC9hIHXvxhhFhsJzH96CemCYx8CxgZVjHKpuRW6eYmZuYUpybrFicn5uWl
	Fuma6eVmluilppRuYgQHjovyDsY/B5UOMQpwMCrx8D4wCfQTYk0sK67MPcQoycGkJMq7+SpQ
	iC8pP6UyI7E4I76oNCe1+BCjBAezkghvz0qgHG9KYmVValE+TEqag0VJnFdmp4OfkEB6Yklq
	dmpqQWoRTFaGg0NJgvcDyFDBotT01Iq0zJwShDQTByfIcB6g4TIgNbzFBYm5xZnpEPlTjIpS
	4rz/QBICIImM0jy4Xlhkv2IUB3pFmPc1SBUPMCnAdb8CGswENHjCygCQwSWJCCmpBsYGru6t
	XD91+hSrfjwTMngRav5LYOPdKzbCa7co14Y0nDj+ffnSll+8KXIXJn/8HHfCW0gw7KnUwmvH
	H+95ppLv8E5s7f8YTp4JJdXPcte9uf7hwCzP00va52XLzDsctao890PXkbpTKjtnVb7g3rdS
	qfjFtf+fL3xwYo5c+j7Xh1v3+67Fa7eaKrEUZyQaajEXFScCAMLB3+LHAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179840>

There might be a more straightforward way to generate an svn repository
with mergeinfo, but I'm not very familiar with svn.

Signed-off-by: Jason Gross <jgross@mit.edu>
---
 t/t9160-git-svn-caches.sh |   59 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)
 create mode 100755 t/t9160-git-svn-caches.sh

diff --git a/t/t9160-git-svn-caches.sh b/t/t9160-git-svn-caches.sh
new file mode 100755
index 0000000..bba437a
--- /dev/null
+++ b/t/t9160-git-svn-caches.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+
+test_description='git svn handling of .git/svn/.caches'
+
+. ./lib-git-svn.sh
+
+say 'define NO_SVN_TESTS to skip git svn tests'
+
+test_expect_success 'initialize source svn repo' '
+	svn_cmd mkdir -m x "$svnrepo"/trunk "$svnrepo"/branches &&
+	svn_cmd co "$svnrepo" "$SVN_TREE"
+'
+
+test_expect_success 'make a change that gives mergeinfo' '
+	(
+		cd "$SVN_TREE" &&
+		touch trunk/foo &&
+		svn_cmd add trunk/foo &&
+		svn_cmd commit -m "foo" &&
+		svn_cmd up &&
+		svn_cmd cp trunk branches/1
+		svn_cmd commit -m "make branch" &&
+		svn_cmd up &&
+		touch branches/1/bar &&
+		svn_cmd add branches/1/bar &&
+		svn_cmd commit -m bar &&
+		svn_cmd up &&
+		cd trunk &&
+		svn_cmd merge ../branches/1 &&
+		svn_cmd commit -m merge &&
+		svn_cmd up
+	)
+'
+
+test_expect_success 'clone svn repo and corrupt .caches' '
+	git svn init "$svnrepo" -T trunk -b branches &&
+	git svn fetch &&
+	echo corrupted > .git/svn/.caches/lookup_svn_merge.db
+'
+
+test_expect_success 'make another change that generates mergeinfo' '
+	(
+		cd "$SVN_TREE" &&
+		touch branches/1/baz &&
+		svn_cmd commit -m baz &&
+		svn_cmd up &&
+		cd trunk &&
+		svn_cmd merge ../branches/1 &&
+		svn_cmd commit -m merge2 &&
+		svn_cmd up
+	) &&
+	rm -rf "$SVN_TREE"
+'
+
+test_expect_success 'fetch change with mergeinfo with a corrupted cache' '
+	git svn fetch
+'
+
+test_done
-- 
1.7.6.558.g4b2f
