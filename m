From: Jeff King <peff@peff.net>
Subject: [PATCH] remote-curl: don't pass back fake refs
Date: Sat, 17 Dec 2011 05:45:39 -0500
Message-ID: <20111217104539.GA23844@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 11:46:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbrmF-0002Ad-OF
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 11:46:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925Ab1LQKpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Dec 2011 05:45:43 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44784
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751856Ab1LQKpm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2011 05:45:42 -0500
Received: (qmail 12077 invoked by uid 107); 17 Dec 2011 10:52:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 17 Dec 2011 05:52:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Dec 2011 05:45:39 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187373>

When receive-pack advertises its list of refs, it generally
hides the capabilities information after a NUL at the end of
the first ref. However, when we have an empty repository,
there are no refs, and therefore receive-pack writes a fake
ref "capabilities^{}" with the capabilities afterwards.

On the client side, git reads the result with
get_remote_heads. We pick the capabilities from the end of
the line, and then call check_ref to make sure the ref name
is valid. We see that it isn't, and don't bother adding it
to our list of refs.

However, the call to check_ref is enabled by passing the
REF_NORMAL flag to get_remote_heads. For the regular git
transport, we pass REF_NORMAL in get_refs_via_connect if we
are doing a push (since only receive-pack uses this fake
ref).  But in remote-curl, we never use this flag, and we
accept the fake ref as a real one, passing it back from the
helper to the parent git-push.

Most of the time this bug goes unnoticed, as the fake ref
won't match our refspecs. However, if "--mirror" is used,
then we see it as remote cruft to be pruned, and try to pass
along a deletion refspec for it. Of course this refspec has
bogus syntax (because of the ^{}), and the helper complains,
aborting the push.

Let's have remote-curl mirror what the builtin
get_refs_via_connect does (at least for the case of using
git protocol; we can leave the dumb info/refs reader as it
is).

Signed-off-by: Jeff King <peff@peff.net>
---
 remote-curl.c        |    7 ++++---
 t/t5541-http-push.sh |   14 ++++++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 0e720ee..b780ba5 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -188,7 +188,7 @@ static int write_discovery(int in, int out, void *data)
 	return err;
 }
 
-static struct ref *parse_git_refs(struct discovery *heads)
+static struct ref *parse_git_refs(struct discovery *heads, int for_push)
 {
 	struct ref *list = NULL;
 	struct async async;
@@ -200,7 +200,8 @@ static struct ref *parse_git_refs(struct discovery *heads)
 
 	if (start_async(&async))
 		die("cannot start thread to parse advertised refs");
-	get_remote_heads(async.out, &list, 0, NULL, 0, NULL);
+	get_remote_heads(async.out, &list, 0, NULL,
+			for_push ? REF_NORMAL : 0, NULL);
 	close(async.out);
 	if (finish_async(&async))
 		die("ref parsing thread failed");
@@ -268,7 +269,7 @@ static struct ref *get_refs(int for_push)
 		heads = discover_refs("git-upload-pack");
 
 	if (heads->proto_git)
-		return parse_git_refs(heads);
+		return parse_git_refs(heads, for_push);
 	return parse_info_refs(heads);
 }
 
diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index a73c826..89232b2 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -154,5 +154,19 @@ test_expect_success 'push (chunked)' '
 	 test $HEAD = $(git rev-parse --verify HEAD))
 '
 
+test_expect_success 'push --all can push to empty repo' '
+	d=$HTTPD_DOCUMENT_ROOT_PATH/empty-all.git &&
+	git init --bare "$d" &&
+	git --git-dir="$d" config http.receivepack true &&
+	git push --all "$HTTPD_URL"/smart/empty-all.git
+'
+
+test_expect_success 'push --mirror can push to empty repo' '
+	d=$HTTPD_DOCUMENT_ROOT_PATH/empty-mirror.git &&
+	git init --bare "$d" &&
+	git --git-dir="$d" config http.receivepack true &&
+	git push --mirror "$HTTPD_URL"/smart/empty-mirror.git
+'
+
 stop_httpd
 test_done
-- 
1.7.7.4.13.g57bf4
