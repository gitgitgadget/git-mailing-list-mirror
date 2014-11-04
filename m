From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] ignore stale directories when checking reflog existence
Date: Tue, 4 Nov 2014 08:24:53 -0500
Message-ID: <20141104132452.GB23608@peff.net>
References: <20141104131006.GA1077@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 04 14:24:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xle6U-0006hs-EE
	for gcvg-git-2@plane.gmane.org; Tue, 04 Nov 2014 14:24:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234AbaKDNYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2014 08:24:54 -0500
Received: from cloud.peff.net ([50.56.180.127]:36641 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750985AbaKDNYy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2014 08:24:54 -0500
Received: (qmail 26189 invoked by uid 102); 4 Nov 2014 13:24:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Nov 2014 07:24:53 -0600
Received: (qmail 17846 invoked by uid 107); 4 Nov 2014 13:25:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Nov 2014 08:25:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Nov 2014 08:24:53 -0500
Content-Disposition: inline
In-Reply-To: <20141104131006.GA1077@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we update a ref, we have two rules for whether or not
we actually update the reflog:

  1. If the reflog already exists, we will always append to
     it.

  2. If log_all_ref_updates is set, we will create a new
     reflog file if necessary.

We do the existence check by trying to open the reflog file,
either with or without O_CREAT (depending on log_all_ref_updates).
If it fails, then we check errno to see what happened.

If we were not using O_CREAT and we got ENOENT, the file
doesn't exist, and we return success (there isn't a reflog
already, and we were not told to make a new one).

If we get EISDIR, then there is likely a stale directory
that needs to be removed (e.g., there used to be "foo/bar",
it was deleted, and the directory "foo" was left. Now we
want to create the ref "foo"). If O_CREAT is set, then we
catch this case, try to remove the directory, and retry our
open. So far so good.

But if we get EISDIR and O_CREAT is not set, then we treat
this as any other error, which is not right. Like ENOENT,
EISDIR is an indication that we do not have a reflog, and we
should silently return success (we were not told to create
it). Instead, the current code reports this as an error, and
we fail to update the ref at all.

Note that this is relatively unlikely to happen, as you
would have to have had reflogs turned on, and then later
turned them off (it could also happen due to a bug in fetch,
but that was fixed in the previous commit). However, it's
quite easy to fix: we just need to treat EISDIR like ENOENT
for the non-O_CREAT case, and silently return (note that
this early return means we can also simplify the O_CREAT
case).

Our new tests cover both cases (O_CREAT and non-O_CREAT).
The first one already worked, of course.

Signed-off-by: Jeff King <peff@peff.net>
---
Note that rs/ref-transaction-reflog tweaks this area a bit; it
introduces a separate reflog_exists() check that runs before we even get
to the first open(). Which would make the tests I introduce here run
correctly even without this patch. However, the code I am changing does
still exist in that series, and I think would handle cases where
logallrefupdates was turned on, but the ref was outside of refs/heads/.
So even with that series, we do still need this fix (and of course there
is the obvious benefit that we can probably merge this fix sooner than
that series).

 refs.c            |  4 ++--
 t/t1410-reflog.sh | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 0368ed4..5ff457e 100644
--- a/refs.c
+++ b/refs.c
@@ -2962,10 +2962,10 @@ int log_ref_setup(const char *refname, char *logfile, int bufsize)
 
 	logfd = open(logfile, oflags, 0666);
 	if (logfd < 0) {
-		if (!(oflags & O_CREAT) && errno == ENOENT)
+		if (!(oflags & O_CREAT) && (errno == ENOENT || errno == EISDIR))
 			return 0;
 
-		if ((oflags & O_CREAT) && errno == EISDIR) {
+		if (errno == EISDIR) {
 			if (remove_empty_directories(logfile)) {
 				int save_errno = errno;
 				error("There are still logs under '%s'",
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 8cab06f..485f1a7 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -253,4 +253,38 @@ test_expect_success 'checkout should not delete log for packed ref' '
 	test $(git reflog master | wc -l) = 4
 '
 
+test_expect_success 'stale dirs do not cause d/f conflicts (reflogs on)' '
+	test_when_finished "git branch -d a || git branch -d a/b" &&
+
+	git branch a/b &&
+	echo "a/b@{0} branch: Created from foo" >expect &&
+	git log -g --format="%gd %gs" a/b >actual &&
+	test_cmp expect actual &&
+	git branch -d a/b &&
+
+	# now logs/refs/heads/a is a stale directory, but
+	# we should move it out of the way to create "a" reflog
+	git branch a &&
+	echo "a@{0} branch: Created from foo" >expect &&
+	git log -g --format="%gd %gs" a >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stale dirs do not cause d/f conflicts (reflogs off)' '
+	test_when_finished "git branch -d a || git branch -d a/b" &&
+
+	git branch a/b &&
+	echo "a/b@{0} branch: Created from foo" >expect &&
+	git log -g --format="%gd %gs" a/b >actual &&
+	test_cmp expect actual &&
+	git branch -d a/b &&
+
+	# same as before, but we only create a reflog for "a" if
+	# it already exists, which it does not
+	git -c core.logallrefupdates=false branch a &&
+	: >expect &&
+	git log -g --format="%gd %gs" a >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.1.2.596.g7379948
