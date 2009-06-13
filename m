From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 4/5] builtin-remote: Show push urls as well
Date: Sat, 13 Jun 2009 18:29:10 +0200
Message-ID: <1244910551-4420-2-git-send-email-git@drmicha.warpmail.net>
References: <7vtz2pmf98.fsf@alter.siamese.dyndns.org>
 <1244910551-4420-1-git-send-email-git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 13 18:30:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFW7a-00067D-2Y
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 18:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760302AbZFMQaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 12:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760172AbZFMQaO
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 12:30:14 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:57307 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755575AbZFMQaI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jun 2009 12:30:08 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 250AA35FA85;
	Sat, 13 Jun 2009 12:30:11 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Sat, 13 Jun 2009 12:30:11 -0400
X-Sasl-enc: 2BrQU/zVopqG2xzSyoh+22Ll1fsG8XZWzYG1QSc19B6k 1244910610
Received: from localhost (p5485A135.dip0.t-ipconnect.de [84.133.161.53])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 29D2639C03;
	Sat, 13 Jun 2009 12:30:10 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.2.367.gf0de
In-Reply-To: <1244910551-4420-1-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121507>

Teach builtin remote to show push urls also when asked to
"show" a specific remote.

This improves upon the standard display mode: multiple specified "url"s
mean that the first one is for fetching, all are used for pushing. We
make this clearer now by displaying the first one prefixed with "Fetch
URL", and all "url"s (or, if present, all "pushurl"s) prefixed with
"Push  URL".

Example with "one" having one url, "two" two urls, "three" one url and
one pushurl (URL part only):

* remote one
  Fetch URL: hostone.com:/somepath/repoone.git
  Push  URL: hostone.com:/somepath/repoone.git
* remote two
  Fetch URL: hosttwo.com:/somepath/repotwo.git
  Push  URL: hosttwo.com:/somepath/repotwo.git
  Push  URL: hosttwobackup.com:/somewheresafe/repotwo.git
* remote three
  Fetch URL: http://hostthree.com/otherpath/repothree.git
  Push  URL: hostthree.com:/pathforpushes/repothree.git

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
1.6.3.2.367.gf0de
