From: Jeff King <peff@peff.net>
Subject: [PATCH 1/7] for_each_packed_object: automatically open pack index
Date: Mon, 22 Jun 2015 06:40:50 -0400
Message-ID: <20150622104049.GA14475@peff.net>
References: <20150622103321.GB12584@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Mon Jun 22 12:41:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6z9u-00043B-9Q
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 12:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173AbbFVKky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 06:40:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:49758 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753341AbbFVKkx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 06:40:53 -0400
Received: (qmail 17187 invoked by uid 102); 22 Jun 2015 10:40:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Jun 2015 05:40:53 -0500
Received: (qmail 7454 invoked by uid 107); 22 Jun 2015 10:40:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Jun 2015 06:40:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Jun 2015 06:40:50 -0400
Content-Disposition: inline
In-Reply-To: <20150622103321.GB12584@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272324>

When for_each_packed_object is called, we call
prepare_packed_git() to make sure we have the actual list of
packs. But the latter does not actually open the pack
indices, meaning that pack->nr_objects may simply be 0 if
the pack has not otherwise been used since the program
started.

In practice, this didn't come up for the current callers,
because they iterate the packed objects only after iterating
all reachable objects (so for it to matter you would have to
have a pack consisting only of unreachable objects). But it
is a dangerous and confusing interface that should be fixed
for future callers.

Note that we do not end the iteration when a pack cannot be
opened, but we do return an error. That lets you complete
the iteration even in actively-repacked repository where an
.idx file may racily go away, but it also lets callers know
that they may not have gotten the complete list (which the
current reachability-check caller does care about).

We have to tweak one of the prune tests due to the changed
return value; an earlier test creates bogus .idx files and
does not clean them up. Having to make this tweak is a good
thing; it means we will not prune in a broken repository,
and the test confirms that we do not negatively impact a
more lenient caller, count-objects.

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1_file.c      | 7 ++++++-
 t/t5304-prune.sh | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index 5038475..f1f0efb 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3573,14 +3573,19 @@ int for_each_packed_object(each_packed_object_fn cb, void *data, unsigned flags)
 {
 	struct packed_git *p;
 	int r = 0;
+	int pack_errors = 0;
 
 	prepare_packed_git();
 	for (p = packed_git; p; p = p->next) {
 		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
 			continue;
+		if (open_pack_index(p)) {
+			pack_errors = 1;
+			continue;
+		}
 		r = for_each_object_in_pack(p, cb, data);
 		if (r)
 			break;
 	}
-	return r;
+	return r ? r : pack_errors;
 }
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 0794d33..023d7c6 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -218,6 +218,7 @@ test_expect_success 'gc: prune old objects after local clone' '
 '
 
 test_expect_success 'garbage report in count-objects -v' '
+	test_when_finished "rm -f .git/objects/pack/fake*" &&
 	: >.git/objects/pack/foo &&
 	: >.git/objects/pack/foo.bar &&
 	: >.git/objects/pack/foo.keep &&
-- 
2.4.4.719.g3984bc6
