From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] fetch-pack: match refs exactly
Date: Mon, 12 Dec 2011 19:48:08 -0500
Message-ID: <20111213004808.GC3699@sigill.intra.peff.net>
References: <20111213003925.GA28403@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kevin Sawicki <kevin@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 01:48:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaGXY-0004jE-So
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 01:48:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753642Ab1LMAsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 19:48:12 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48430
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753420Ab1LMAsL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 19:48:11 -0500
Received: (qmail 8368 invoked by uid 107); 13 Dec 2011 00:54:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Dec 2011 19:54:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Dec 2011 19:48:08 -0500
Content-Disposition: inline
In-Reply-To: <20111213003925.GA28403@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186992>

When we are determining the list of refs to fetch via
fetch-pack, we have two sets of refs to compare: those on
the remote side, and a "match" list of things we want to
fetch. We iterate through the remote refs alphabetically,
seeing if each one is wanted by the "match" list.

Since def88e9 (Commit first cut at "git-fetch-pack",
2005-07-04), we have used the "path_match" function to do a
suffix match, where a remote ref is considered wanted if
any of the "match" elements is a suffix of the remote
refname.

This enables callers of fetch-pack to specify unqualified
refs and have them matched up with remote refs (e.g., ask
for "A" and get remote's "refs/heads/A"). However, if you
provide a fully qualified ref, then there are corner cases
where we provide the wrong answer. For example, given a
remote with two refs:

   refs/foo/refs/heads/master
   refs/heads/master

asking for "refs/heads/master" will first match
"refs/foo/refs/heads/master" by the suffix rule, and we will
erroneously fetch it instead of refs/heads/master.

As it turns out, all callers of fetch_pack do provide
fully-qualified refs for the match list. There are two ways
fetch_pack can get match lists:

  1. Through the transport code (i.e., via git-fetch)

  2. On the command-line of git-fetch-pack

In the first case, we will always be providing the names of
fully-qualified refs from "struct ref" objects. We will have
pre-matched those ref objects already (since we have to
handle more advanced matching, like wildcard refspecs), and
are just providing a list of the refs whose objects we need.

In the second case, users could in theory be providing
non-qualified refs on the command-line. However, the
fetch-pack documentation claims that refs should be fully
qualified (and has always done so since it was written in
2005).

Let's change this path_match call to simply check for string
equality, matching what the callers of fetch_pack are
expecting.

Signed-off-by: Jeff King <peff@peff.net>
---
This is obviously the one that can break existing fetch-pack users. I
doubt they exist. If they do, there are a few alternatives:

  1. Come up with some more sane rules for path_match (e.g., try full
     strings first, use full-string matching for things starting with
     "refs/", etc).

  2. Leave the matching in-place for git-fetch-pack, but use exact
     matching for internal users that will always provide qualified refs
     (i.e., "git fetch").

I don't personally think it's worth the trouble.

 builtin/fetch-pack.c      |   13 +++++++++----
 t/t5527-fetch-odd-refs.sh |   29 +++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 4 deletions(-)
 create mode 100755 t/t5527-fetch-odd-refs.sh

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 46688dc..6207ecd 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -556,11 +556,16 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
 			continue;
 		}
 		else {
-			int order = path_match(ref->name, nr_match, match);
-			if (order) {
-				return_refs[order-1] = ref;
-				continue; /* we will link it later */
+			int i;
+			for (i = 0; i < nr_match; i++) {
+				if (!strcmp(ref->name, match[i])) {
+					match[i][0] = '\0';
+					return_refs[i] = ref;
+					break;
+				}
 			}
+			if (i < nr_match)
+				continue; /* we will link it later */
 		}
 		free(ref);
 	}
diff --git a/t/t5527-fetch-odd-refs.sh b/t/t5527-fetch-odd-refs.sh
new file mode 100755
index 0000000..edea9f9
--- /dev/null
+++ b/t/t5527-fetch-odd-refs.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+
+test_description='test fetching of oddly-named refs'
+. ./test-lib.sh
+
+# afterwards we will have:
+#  HEAD - two
+#  refs/for/refs/heads/master - one
+#  refs/heads/master - three
+test_expect_success 'setup repo with odd suffix ref' '
+	echo content >file &&
+	git add . &&
+	git commit -m one &&
+	git update-ref refs/for/refs/heads/master HEAD &&
+	echo content >>file &&
+	git commit -a -m two &&
+	echo content >>file &&
+	git commit -a -m three &&
+	git checkout HEAD^
+'
+
+test_expect_success 'suffix ref is ignored during fetch' '
+	git clone --bare file://"$PWD" suffix &&
+	echo three >expect &&
+	git --git-dir=suffix log -1 --format=%s refs/heads/master >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
1.7.8.13.g74677
