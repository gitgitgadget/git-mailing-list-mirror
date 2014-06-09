From: Jeff King <peff@peff.net>
Subject: [PATCH 09/15] use get_cached_commit_buffer where appropriate
Date: Mon, 9 Jun 2014 14:12:33 -0400
Message-ID: <20140609181233.GI20315@sigill.intra.peff.net>
References: <20140609180236.GA24644@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 09 20:12:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu43i-0008D7-Ff
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 20:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753910AbaFISMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 14:12:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:40377 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753820AbaFISMe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 14:12:34 -0400
Received: (qmail 15870 invoked by uid 102); 9 Jun 2014 18:12:34 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 Jun 2014 13:12:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jun 2014 14:12:33 -0400
Content-Disposition: inline
In-Reply-To: <20140609180236.GA24644@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251095>

Some call sites check commit->buffer to see whether we have
a cached buffer, and if so, do some work with it. In the
long run we may want to switch these code paths to make
their decision on a different boolean flag (because checking
the cache may get a little more expensive in the future).
But for now, we can easily support them by converting the
calls to use get_cached_commit_buffer.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/rev-list.c | 2 +-
 log-tree.c         | 2 +-
 object.c           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index e012ebe..3fcbf21 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -106,7 +106,7 @@ static void show_commit(struct commit *commit, void *data)
 	else
 		putchar('\n');
 
-	if (revs->verbose_header && commit->buffer) {
+	if (revs->verbose_header && get_cached_commit_buffer(commit)) {
 		struct strbuf buf = STRBUF_INIT;
 		struct pretty_print_context ctx = {0};
 		ctx.abbrev = revs->abbrev;
diff --git a/log-tree.c b/log-tree.c
index cf2f86c..e9ef8ab 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -588,7 +588,7 @@ void show_log(struct rev_info *opt)
 		show_mergetag(opt, commit);
 	}
 
-	if (!commit->buffer)
+	if (!get_cached_commit_buffer(commit))
 		return;
 
 	if (opt->show_notes) {
diff --git a/object.c b/object.c
index 44ca657..67b6e35 100644
--- a/object.c
+++ b/object.c
@@ -197,7 +197,7 @@ struct object *parse_object_buffer(const unsigned char *sha1, enum object_type t
 		if (commit) {
 			if (parse_commit_buffer(commit, buffer, size))
 				return NULL;
-			if (!commit->buffer) {
+			if (!get_cached_commit_buffer(commit)) {
 				set_commit_buffer(commit, buffer);
 				*eaten_p = 1;
 			}
-- 
2.0.0.729.g520999f
