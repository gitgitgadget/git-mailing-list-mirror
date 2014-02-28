From: Jeff King <peff@peff.net>
Subject: [PATCH v2 1/2] docs: clarify remote restrictions for
 git-upload-archive
Date: Fri, 28 Feb 2014 05:01:29 -0500
Message-ID: <20140228100128.GA13169@sigill.intra.peff.net>
References: <20140228095619.GA11803@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Scott J. Goldman" <scottjg@github.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 11:02:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJKGZ-00007F-6S
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 11:02:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbaB1KBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 05:01:55 -0500
Received: from cloud.peff.net ([50.56.180.127]:58652 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750927AbaB1KBb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 05:01:31 -0500
Received: (qmail 23475 invoked by uid 102); 28 Feb 2014 10:01:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Feb 2014 04:01:31 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Feb 2014 05:01:29 -0500
Content-Disposition: inline
In-Reply-To: <20140228095619.GA11803@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242934>

Commits ee27ca4 and 0f544ee introduced rules by which
git-upload-archive would restrict clients from accessing
unreachable objects. However, we never documented those
rules anywhere, nor their reason for being. Let's do so now.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-archive.txt        |  5 ++++-
 Documentation/git-upload-archive.txt | 26 ++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index b97aaab..cfa1e4e 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -65,7 +65,10 @@ OPTIONS
 
 --remote=<repo>::
 	Instead of making a tar archive from the local repository,
-	retrieve a tar archive from a remote repository.
+	retrieve a tar archive from a remote repository. Note that the
+	remote repository may place restrictions on which sha1
+	expressions may be allowed in `<tree-ish>`. See
+	linkgit:git-upload-archive[1] for details.
 
 --exec=<git-upload-archive>::
 	Used with --remote to specify the path to the
diff --git a/Documentation/git-upload-archive.txt b/Documentation/git-upload-archive.txt
index d09bbb5..8ae65d8 100644
--- a/Documentation/git-upload-archive.txt
+++ b/Documentation/git-upload-archive.txt
@@ -20,6 +20,32 @@ This command is usually not invoked directly by the end user.  The UI
 for the protocol is on the 'git archive' side, and the program pair
 is meant to be used to get an archive from a remote repository.
 
+SECURITY
+--------
+
+In order to protect the privacy of objects that have been removed from
+history but may not yet have been pruned, `git-upload-archive` avoids
+serving archives for commits and trees that are not reachable from the
+repository's refs.  However, because calculating object reachability is
+computationally expensive, `git-upload-archive` implements a stricter
+but easier-to-check set of rules:
+
+  1. Clients may request a commit or tree that is pointed to directly by
+     a ref. E.g., `git archive --remote=origin v1.0`.
+
+  2. Clients may request a sub-tree within a commit or tree using the
+     `ref:path` syntax. E.g., `git archive --remote=origin v1.0:Documentation`.
+
+  3. Clients may _not_ use other sha1 expressions, even if the end
+     result is reachable. E.g., neither a relative commit like `master^`
+     nor a literal sha1 like `abcd1234` is allowed, even if the result
+     is reachable from the refs.
+
+Note that rule 3 disallows many cases that do not have any privacy
+implications. These rules are subject to change in future versions of
+git, and the server accessed by `git archive --remote` may or may not
+follow these exact rules.
+
 OPTIONS
 -------
 <directory>::
-- 
1.8.5.2.500.g8060133
