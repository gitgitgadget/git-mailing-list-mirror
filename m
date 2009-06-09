From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 4/5] builtin-remote: Show push urls as well
Date: Tue,  9 Jun 2009 18:01:37 +0200
Message-ID: <1244563298-15479-5-git-send-email-git@drmicha.warpmail.net>
References: <1244563298-15479-1-git-send-email-git@drmicha.warpmail.net>
 <1244563298-15479-2-git-send-email-git@drmicha.warpmail.net>
 <1244563298-15479-3-git-send-email-git@drmicha.warpmail.net>
 <1244563298-15479-4-git-send-email-git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 18:02:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME3lu-00008m-JF
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 18:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756078AbZFIQBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 12:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755739AbZFIQBu
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 12:01:50 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:60162 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755897AbZFIQBt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2009 12:01:49 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 4C3C935EB67;
	Tue,  9 Jun 2009 12:01:51 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 09 Jun 2009 12:01:51 -0400
X-Sasl-enc: jg9xb60dJM/b7PD3wMcLsbuV0z2EKdkmYJGX13CDoe+Q 1244563310
Received: from localhost (p54859AE3.dip0.t-ipconnect.de [84.133.154.227])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 532332F080;
	Tue,  9 Jun 2009 12:01:50 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.2.278.gb6431.dirty
In-Reply-To: <1244563298-15479-4-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121183>

Teach builtin remote to show push urls also when asked to
"show" a specific remote.

This improves upon the standard display mode: multiple specified "url"s
mean that the first one is for fetching, all are used for pushing. We
make this clearer now by displaying the first one prefixed with "Fetch
URL", and all "url"s (or, if present, all "pushurl"s) prefixed with
"Push  URL".

Also, adjust t5505 accordingly and make it test for the new output.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin-remote.c  |   20 +++++++++++++++-----
 t/t5505-remote.sh |   10 +++++++---
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index dfc0b9e..b350b18 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -999,15 +999,25 @@ static int show(int argc, const char **argv)
 	info.list = &info_list;
 	for (; argc; argc--, argv++) {
 		int i;
+		const char **url;
+		int url_nr;
 
 		get_remote_ref_states(*argv, &states, query_flag);
 
 		printf("* remote %s\n", *argv);
-		if (states.remote->url_nr) {
-			for (i=0; i < states.remote->url_nr; i++)
-				printf("  URL: %s\n", states.remote->url[i]);
-		} else
-			printf("  URL: %s\n", "(no URL)");
+		printf("  Fetch URL: %s\n", states.remote->url_nr > 0 ?
+			states.remote->url[0] : "(no URL)");
+		if (states.remote->pushurl_nr) {
+			url = states.remote->pushurl;
+			url_nr = states.remote->pushurl_nr;
+		} else {
+			url = states.remote->url;
+			url_nr = states.remote->url_nr;
+		}
+		for (i=0; i < url_nr; i++)
+			printf("  Push  URL: %s\n", url[i]);
+		if (!i)
+			printf("  Push  URL: %s\n", "(no URL)");
 		if (no_query)
 			printf("  HEAD branch: (not queried)\n");
 		else if (!states.heads.nr)
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index e70246b..852ccb5 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -135,7 +135,8 @@ EOF
 
 cat > test/expect << EOF
 * remote origin
-  URL: $(pwd)/one
+  Fetch URL: $(pwd)/one
+  Push  URL: $(pwd)/one
   HEAD branch: master
   Remote branches:
     master new (next fetch will store in remotes/origin)
@@ -151,7 +152,8 @@ cat > test/expect << EOF
     master pushes to master   (local out of date)
     master pushes to upstream (create)
 * remote two
-  URL: ../two
+  Fetch URL: ../two
+  Push  URL: ../three
   HEAD branch (remote HEAD is ambiguous, may be one of the following):
     another
     master
@@ -173,6 +175,7 @@ test_expect_success 'show' '
 	 git branch --track rebase origin/master &&
 	 git branch -d -r origin/master &&
 	 git config --add remote.two.url ../two &&
+	 git config --add remote.two.pushurl ../three &&
 	 git config branch.rebase.rebase true &&
 	 git config branch.octopus.merge "topic-a topic-b topic-c" &&
 	 (cd ../one &&
@@ -191,7 +194,8 @@ test_expect_success 'show' '
 
 cat > test/expect << EOF
 * remote origin
-  URL: $(pwd)/one
+  Fetch URL: $(pwd)/one
+  Push  URL: $(pwd)/one
   HEAD branch: (not queried)
   Remote branches: (status not queried)
     master
-- 
1.6.3.2.278.gb6431.dirty
