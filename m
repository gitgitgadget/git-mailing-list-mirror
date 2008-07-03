From: Jeff King <peff@peff.net>
Subject: Re: finding deleted file names
Date: Thu, 3 Jul 2008 06:36:59 -0400
Message-ID: <20080703103658.GA11571@sigill.intra.peff.net>
References: <93c3eada0807021701m13b7adddv51537f4cf9d52533@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 14:36:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEO2g-0007XG-8w
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 14:36:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665AbYGCMXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 08:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752043AbYGCMXh
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 08:23:37 -0400
Received: from peff.net ([208.65.91.99]:4241 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751385AbYGCMXh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 08:23:37 -0400
Received: (qmail 2309 invoked by uid 111); 3 Jul 2008 10:36:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 03 Jul 2008 06:36:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Jul 2008 06:36:59 -0400
Content-Disposition: inline
In-Reply-To: <93c3eada0807021701m13b7adddv51537f4cf9d52533@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87276>

On Thu, Jul 03, 2008 at 09:31:55AM +0930, Geoff Russell wrote:

> git diff --diff-filter=D --name-only HEAD@{'7 days ago'}
> 
> finds files deleted during the last 7 days, but if my repository is
> only 6 days old I get a
> fatal error.
> 
> fatal: bad object HEAD@{7 days ago}

This should issue a warning, but use the oldest reflog entry. However,
there is a slight problem with that. See below for details.

Shawn, does this seem sane to you?

-- >8 --
avoid null SHA1 in oldest reflog

When the user specifies a ref by a reflog entry older than
one we have (e.g., "HEAD@{20 years ago"}), we issue a
warning and give them the "from" value of the oldest reflog
entry. That is, we say "we don't know what happened before
this entry, but before this we know we had some particular
SHA1".

However, the oldest reflog entry is often a creation event
such as clone or branch creation. In this case, the entry
claims that the ref went from "00000..." (the null sha1) to
the new value, and the reflog lookup returns the null sha1.

While this is technically correct (the entry tells us that
the ref didn't exist at the specified time) it is not
terribly useful to the end user. What they probably want
instead is "the oldest useful sha1 that this ref ever had".
This patch changes the behavior such that if the oldest
reflog entry would return the null sha1, it instead returns
the first actual value the ref ever had.

We never discovered this problem in the test scripts because
we created "fake" reflogs that had only a specified segment
of history. This patch updates the tests with a creation
event at the beginning of history.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c                |    4 ++++
 t/t1400-update-ref.sh |    9 ++++++++-
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/refs.c b/refs.c
index 9e8e858..6c6e9e5 100644
--- a/refs.c
+++ b/refs.c
@@ -1412,6 +1412,10 @@ int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *
 	tz = strtoul(tz_c, NULL, 10);
 	if (get_sha1_hex(logdata, sha1))
 		die("Log %s is corrupt.", logfile);
+	if (is_null_sha1(sha1)) {
+		if (get_sha1_hex(logdata + 41, sha1))
+			die("Log %s is corrupt.", logfile);
+	}
 	if (msg)
 		*msg = ref_msg(logdata, logend);
 	munmap(log_mapped, mapsz);
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index f387d46..ca99d37 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -155,7 +155,8 @@ rm -f .git/$m .git/logs/$m expect
 
 git update-ref $m $D
 cat >.git/logs/$m <<EOF
-$C $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150320 -0500
+0000000000000000000000000000000000000000 $C $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150320 -0500
+$C $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150350 -0500
 $A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150380 -0500
 $F $Z $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150680 -0500
 $Z $E $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150980 -0500
@@ -186,6 +187,12 @@ test_expect_success \
 	'Query "master@{May 26 2005 23:32:00}" (exactly history start)' \
 	'rm -f o e
 	 git rev-parse --verify "master@{May 26 2005 23:32:00}" >o 2>e &&
+	 test '"$C"' = $(cat o) &&
+	 test "" = "$(cat e)"'
+test_expect_success \
+	'Query "master@{May 26 2005 23:32:30}" (first non-creation change)' \
+	'rm -f o e
+	 git rev-parse --verify "master@{May 26 2005 23:32:30}" >o 2>e &&
 	 test '"$A"' = $(cat o) &&
 	 test "" = "$(cat e)"'
 test_expect_success \
-- 
1.5.6.1.282.g8aee2.dirty
