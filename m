From: Jeff King <peff@peff.net>
Subject: [PATCH 5/5] interpret_branch_name: find all possible @-marks
Date: Wed, 15 Jan 2014 03:40:46 -0500
Message-ID: <20140115084045.GE19132@sigill.intra.peff.net>
References: <20140115082528.GA18974@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Keith Derrick <keith.derrick@lge.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 15 09:40:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3M1s-0000nK-Kr
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 09:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbaAOIkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 03:40:49 -0500
Received: from cloud.peff.net ([50.56.180.127]:60928 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750941AbaAOIkr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 03:40:47 -0500
Received: (qmail 9753 invoked by uid 102); 15 Jan 2014 08:40:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Jan 2014 02:40:48 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jan 2014 03:40:46 -0500
Content-Disposition: inline
In-Reply-To: <20140115082528.GA18974@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240442>

When we parse a string like "foo@{upstream}", we look for
the first "@"-sign, and check to see if it is an upstream
mark. However, since branch names can contain an @, we may
also see "@foo@{upstream}". In this case, we check only the
first @, and ignore the second. As a result, we do not find
the upstream.

We can solve this by iterating through all @-marks in the
string, and seeing if any is a legitimate upstream or
empty-at mark.

Another strategy would be to parse from the right-hand side
of the string. However, that does not work for the
"empty_at" case, which allows "@@{upstream}". We need to
find the left-most one in this case (and we then recurse as
"HEAD@{upstream}").

Signed-off-by: Jeff King <peff@peff.net>
---
And this one actually fixes Keith's bug.

The diff is noisy due to indentation changes; try it with "-b" for
increased reading pleasure.

 sha1_name.c                   | 20 +++++++++++---------
 t/t1507-rev-parse-upstream.sh | 21 +++++++++++++++++++++
 2 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index b253a88..6fca869 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1124,6 +1124,7 @@ static int interpret_upstream_mark(const char *name, int namelen,
 int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
 {
 	char *at;
+	const char *start;
 	int len = interpret_nth_prior_checkout(name, namelen, buf);
 
 	if (!namelen)
@@ -1138,17 +1139,18 @@ int interpret_branch_name(const char *name, int namelen, struct strbuf *buf)
 			return reinterpret(name, namelen, len, buf);
 	}
 
-	at = memchr(name, '@', namelen);
-	if (!at)
-		return -1;
+	for (start = name;
+	     (at = memchr(start, '@', namelen - (start - name)));
+	     start = at + 1) {
 
-	len = interpret_empty_at(name, namelen, at - name, buf);
-	if (len > 0)
-		return reinterpret(name, namelen, len, buf);
+		len = interpret_empty_at(name, namelen, at - name, buf);
+		if (len > 0)
+			return reinterpret(name, namelen, len, buf);
 
-	len = interpret_upstream_mark(name, namelen, at - name, buf);
-	if (len > 0)
-		return len;
+		len = interpret_upstream_mark(name, namelen, at - name, buf);
+		if (len > 0)
+			return len;
+	}
 
 	return -1;
 }
diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index cace1ca..178694e 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -17,6 +17,9 @@ test_expect_success 'setup' '
 	 test_commit 4 &&
 	 git branch --track my-side origin/side &&
 	 git branch --track local-master master &&
+	 git branch --track fun@ny origin/side &&
+	 git branch --track @funny origin/side &&
+	 git branch --track funny@ origin/side &&
 	 git remote add -t master master-only .. &&
 	 git fetch master-only &&
 	 git branch bad-upstream &&
@@ -54,6 +57,24 @@ test_expect_success 'my-side@{upstream} resolves to correct full name' '
 	test refs/remotes/origin/side = "$(full_name my-side@{u})"
 '
 
+test_expect_success 'upstream of branch with @ in middle' '
+	full_name fun@ny@{u} >actual &&
+	echo refs/remotes/origin/side >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'upstream of branch with @ at start' '
+	full_name @funny@{u} >actual &&
+	echo refs/remotes/origin/side >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'upstream of branch with @ at end' '
+	full_name funny@@{u} >actual &&
+	echo refs/remotes/origin/side >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'refs/heads/my-side@{upstream} does not resolve to my-side{upstream}' '
 	test_must_fail full_name refs/heads/my-side@{upstream}
 '
-- 
1.8.5.2.500.g8060133
