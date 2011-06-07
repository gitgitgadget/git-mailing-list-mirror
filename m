From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] clone: always fetch remote HEAD
Date: Tue, 7 Jun 2011 19:03:22 -0400
Message-ID: <20110607230322.GB23753@sigill.intra.peff.net>
References: <20110607230013.GA23409@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 01:03:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU5J7-0005pk-Qd
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 01:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932639Ab1FGXD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 19:03:28 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46807
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753982Ab1FGXDZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 19:03:25 -0400
Received: (qmail 23116 invoked by uid 107); 7 Jun 2011 23:03:32 -0000
Received: from 70-36-146-246.dsl.dynamic.sonic.net (HELO sigill.intra.peff.net) (70.36.146.246)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jun 2011 19:03:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jun 2011 19:03:22 -0400
Content-Disposition: inline
In-Reply-To: <20110607230013.GA23409@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175280>

In most cases, fetching the remote HEAD explicitly is
unnecessary. It's just a symref pointing to a branch which
we are already fetching, so we will already ask for its sha1.

However, if the remote has a detached HEAD, things are less
certain. We do not ask for HEAD's sha1, but we do try to
write it into a local detached HEAD. In most cases this is
fine, as the remote HEAD is pointing to some part of the
history graph that we will fetch via the refs.

But if the remote HEAD points to an "orphan" commit (one
which was is not an ancestor of any refs), then we will not
have the object, and update_ref will complain when we try to
write the detached HEAD, aborting the whole clone.

This patch makes clone always explicitly ask the remote for
the sha1 of its HEAD commit. In the non-detached case, this
is a no-op, as we were going to ask for that sha1 anyway. In
the regular detached case, this will add an extra "want" to
the protocol negotiation, but will not change the history
that gets sent. And in the detached orphan case, we will
fetch the orphaned history so that we can write it into our
local detached HEAD.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/clone.c           |   10 +++++++---
 t/t5707-clone-detached.sh |    6 +++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index f579794..f134ff8 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -343,8 +343,9 @@ static void remove_junk_on_signal(int signo)
 static struct ref *wanted_peer_refs(const struct ref *refs,
 		struct refspec *refspec)
 {
-	struct ref *local_refs = NULL;
-	struct ref **tail = &local_refs;
+	struct ref *head = copy_ref(find_ref_by_name(refs, "HEAD"));
+	struct ref *local_refs = head;
+	struct ref **tail = head ? &head->next : &local_refs;
 
 	get_fetch_map(refs, refspec, &tail, 0);
 	if (!option_mirror)
@@ -357,8 +358,11 @@ static void write_remote_refs(const struct ref *local_refs)
 {
 	const struct ref *r;
 
-	for (r = local_refs; r; r = r->next)
+	for (r = local_refs; r; r = r->next) {
+		if (!r->peer_ref)
+			continue;
 		add_extra_ref(r->peer_ref->name, r->old_sha1, 0);
+	}
 
 	pack_refs(PACK_REFS_ALL);
 	clear_extra_refs();
diff --git a/t/t5707-clone-detached.sh b/t/t5707-clone-detached.sh
index db4af95..82ecbce 100755
--- a/t/t5707-clone-detached.sh
+++ b/t/t5707-clone-detached.sh
@@ -58,18 +58,18 @@ test_expect_success 'cloned HEAD is detached' '
 	head_is_detached detached-history
 '
 
-test_expect_failure 'clone repo (orphan detached HEAD)' '
+test_expect_success 'clone repo (orphan detached HEAD)' '
 	git checkout --detach master &&
 	echo four >file &&
 	git commit -a -m four &&
 	git clone "file://$PWD" detached-orphan
 '
-test_expect_failure 'cloned HEAD matches' '
+test_expect_success 'cloned HEAD matches' '
 	echo four >expect &&
 	git --git-dir=detached-orphan/.git log -1 --format=%s >actual &&
 	test_cmp expect actual
 '
-test_expect_failure 'cloned HEAD is detached' '
+test_expect_success 'cloned HEAD is detached' '
 	head_is_detached detached-orphan
 '
 
-- 
1.7.6.rc0.39.g6b091.dirty
