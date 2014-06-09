From: Jeff King <peff@peff.net>
Subject: [PATCH 07/15] provide a helper to set the commit buffer
Date: Mon, 9 Jun 2014 14:11:17 -0400
Message-ID: <20140609181117.GG20315@sigill.intra.peff.net>
References: <20140609180236.GA24644@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 09 20:11:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu42V-0007Ny-9Q
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 20:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753994AbaFISLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 14:11:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:40365 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753764AbaFISLS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 14:11:18 -0400
Received: (qmail 15770 invoked by uid 102); 9 Jun 2014 18:11:18 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 Jun 2014 13:11:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jun 2014 14:11:17 -0400
Content-Disposition: inline
In-Reply-To: <20140609180236.GA24644@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251093>

Right now this is just a one-liner, but abstracting it will
make it easier to change later.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/blame.c | 2 +-
 commit.c        | 7 ++++++-
 commit.h        | 6 ++++++
 object.c        | 2 +-
 4 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 6ce3c6d..0af3a18 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2313,7 +2313,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 		    ident, ident, path,
 		    (!contents_from ? path :
 		     (!strcmp(contents_from, "-") ? "standard input" : contents_from)));
-	commit->buffer = strbuf_detach(&msg, NULL);
+	set_commit_buffer(commit, strbuf_detach(&msg, NULL));
 
 	if (!contents_from || strcmp("-", contents_from)) {
 		struct stat st;
diff --git a/commit.c b/commit.c
index d7b6836..5cc52e0 100644
--- a/commit.c
+++ b/commit.c
@@ -245,6 +245,11 @@ int unregister_shallow(const unsigned char *sha1)
 	return 0;
 }
 
+void set_commit_buffer(struct commit *commit, void *buffer)
+{
+	commit->buffer = buffer;
+}
+
 void free_commit_buffer(struct commit *commit)
 {
 	free(commit->buffer);
@@ -335,7 +340,7 @@ int parse_commit(struct commit *item)
 	}
 	ret = parse_commit_buffer(item, buffer, size);
 	if (save_commit_buffer && !ret) {
-		item->buffer = buffer;
+		set_commit_buffer(item, buffer);
 		return 0;
 	}
 	free(buffer);
diff --git a/commit.h b/commit.h
index daccf46..5cc0bf3 100644
--- a/commit.h
+++ b/commit.h
@@ -52,6 +52,12 @@ int parse_commit(struct commit *item);
 void parse_commit_or_die(struct commit *item);
 
 /*
+ * Associate an object buffer with the commit. The ownership of the
+ * memory is handed over to the commit, and must be free()-able.
+ */
+void set_commit_buffer(struct commit *, void *buffer);
+
+/*
  * Free any cached object buffer associated with the commit.
  */
 void free_commit_buffer(struct commit *);
diff --git a/object.c b/object.c
index 57a0890..44ca657 100644
--- a/object.c
+++ b/object.c
@@ -198,7 +198,7 @@ struct object *parse_object_buffer(const unsigned char *sha1, enum object_type t
 			if (parse_commit_buffer(commit, buffer, size))
 				return NULL;
 			if (!commit->buffer) {
-				commit->buffer = buffer;
+				set_commit_buffer(commit, buffer);
 				*eaten_p = 1;
 			}
 			obj = &commit->object;
-- 
2.0.0.729.g520999f
