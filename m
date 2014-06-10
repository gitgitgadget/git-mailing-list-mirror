From: Jeff King <peff@peff.net>
Subject: [PATCH 16/17] commit: convert commit->buffer to a slab
Date: Tue, 10 Jun 2014 17:43:02 -0400
Message-ID: <20140610214302.GP19147@sigill.intra.peff.net>
References: <20140610213509.GA26979@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 23:43:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuToz-0007DX-Aq
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 23:43:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753548AbaFJVnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 17:43:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:41442 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753354AbaFJVnE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 17:43:04 -0400
Received: (qmail 19986 invoked by uid 102); 10 Jun 2014 21:43:03 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jun 2014 16:43:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jun 2014 17:43:02 -0400
Content-Disposition: inline
In-Reply-To: <20140610213509.GA26979@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251260>

This will make it easier to manage the buffer cache
independently of the "struct commit" objects. It also
shrinks "struct commit" by one pointer, which may be
helpful.

Unfortunately it does not reduce the max memory size of
something like "rev-list", because rev-list uses
get_cached_commit_buffer() to decide not to show each
commit's output (and due to the design of slab_at, accessing
the slab requires us to extend it, allocating exactly the
same number of buffer pointers we dropped from the commit
structs).

Signed-off-by: Jeff King <peff@peff.net>
---
 commit.c | 20 +++++++++++++-------
 commit.h |  1 -
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/commit.c b/commit.c
index 1903dde..e289c78 100644
--- a/commit.c
+++ b/commit.c
@@ -245,14 +245,17 @@ int unregister_shallow(const unsigned char *sha1)
 	return 0;
 }
 
+define_commit_slab(buffer_slab, void *);
+static struct buffer_slab buffer_slab = COMMIT_SLAB_INIT(1, buffer_slab);
+
 void set_commit_buffer(struct commit *commit, void *buffer)
 {
-	commit->buffer = buffer;
+	*buffer_slab_at(&buffer_slab, commit) = buffer;
 }
 
 const void *get_cached_commit_buffer(const struct commit *commit)
 {
-	return commit->buffer;
+	return *buffer_slab_at(&buffer_slab, commit);
 }
 
 const void *get_commit_buffer(const struct commit *commit)
@@ -274,20 +277,23 @@ const void *get_commit_buffer(const struct commit *commit)
 
 void unuse_commit_buffer(const struct commit *commit, const void *buffer)
 {
-	if (commit->buffer != buffer)
+	void *cached = *buffer_slab_at(&buffer_slab, commit);
+	if (cached != buffer)
 		free((void *)buffer);
 }
 
 void free_commit_buffer(struct commit *commit)
 {
-	free(commit->buffer);
-	commit->buffer = NULL;
+	void **b = buffer_slab_at(&buffer_slab, commit);
+	free(*b);
+	*b = NULL;
 }
 
 const void *detach_commit_buffer(struct commit *commit)
 {
-	void *ret = commit->buffer;
-	commit->buffer = NULL;
+	void **b = buffer_slab_at(&buffer_slab, commit);
+	void *ret = *b;
+	*b = NULL;
 	return ret;
 }
 
diff --git a/commit.h b/commit.h
index 5ce5ce7..e1c2569 100644
--- a/commit.h
+++ b/commit.h
@@ -20,7 +20,6 @@ struct commit {
 	unsigned long date;
 	struct commit_list *parents;
 	struct tree *tree;
-	char *buffer;
 };
 
 extern int save_commit_buffer;
-- 
2.0.0.729.g520999f
