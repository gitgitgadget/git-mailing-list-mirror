From: Jeff King <peff@peff.net>
Subject: [PATCH] send-pack: respect '+' on wildcard refspecs
Date: Fri, 19 Oct 2007 05:04:00 -0400
Message-ID: <20071019090400.GA8944@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, dan@archlinux.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 11:04:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IinmI-0006Yf-Vh
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 11:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764009AbXJSJEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 05:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763453AbXJSJEG
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 05:04:06 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3826 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756192AbXJSJEF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 05:04:05 -0400
Received: (qmail 10880 invoked by uid 111); 19 Oct 2007 09:04:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 19 Oct 2007 05:04:02 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Oct 2007 05:04:00 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61679>

When matching source and destination refs, we were failing
to pull the 'force' parameter from wildcard respects (but
not explicit ones) and attach it to the ref struct.

This adds a test for explicit and wildcard refspecs; the
latter fails without this patch.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c             |    2 ++
 t/t5400-send-pack.sh |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/remote.c b/remote.c
index b20e2be..170015a 100644
--- a/remote.c
+++ b/remote.c
@@ -762,6 +762,8 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 			hashcpy(dst_peer->new_sha1, src->new_sha1);
 		}
 		dst_peer->peer_ref = src;
+		if (pat)
+			dst_peer->force = pat->force;
 	free_name:
 		free(dst_name);
 	}
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 57c6397..2d0c07f 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -123,4 +123,52 @@ test_expect_success \
 	git-branch -a >branches && ! grep -q origin/master branches
 '
 
+rewound_push_setup() {
+	rm -rf parent child &&
+	mkdir parent && cd parent &&
+	git-init && echo one >file && git-add file && git-commit -m one &&
+	echo two >file && git-commit -a -m two &&
+	cd .. &&
+	git-clone parent child && cd child && git-reset --hard HEAD^
+}
+
+rewound_push_succeeded() {
+	cmp ../parent/.git/refs/heads/master .git/refs/heads/master
+}
+
+rewound_push_failed() {
+	if rewound_push_succeeded
+	then
+		false
+	else
+		true
+	fi
+}
+
+test_expect_success \
+	'pushing explicit refspecs respects forcing' '
+	rewound_push_setup &&
+	if git-send-pack ../parent/.git refs/heads/master:refs/heads/master
+	then
+		false
+	else
+		true
+	fi && rewound_push_failed &&
+	git-send-pack ../parent/.git +refs/heads/master:refs/heads/master &&
+	rewound_push_succeeded
+'
+
+test_expect_success \
+	'pushing wildcard refspecs respects forcing' '
+	rewound_push_setup &&
+	if git-send-pack ../parent/.git refs/heads/*:refs/heads/*
+	then
+		false
+	else
+		true
+	fi && rewound_push_failed &&
+	git-send-pack ../parent/.git +refs/heads/*:refs/heads/* &&
+	rewound_push_succeeded
+'
+
 test_done
-- 
1.5.3.4.1254.gc1ca9-dirty
