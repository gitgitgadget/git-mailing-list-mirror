From: Jeff King <peff@peff.net>
Subject: [RFC PATCH 4/5] pack-objects: avoid reading uninitalized data
Date: Wed, 22 Oct 2008 16:31:03 -0400
Message-ID: <20081022203103.GD4547@coredump.intra.peff.net>
References: <20081022202810.GA4439@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 22 22:32:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KskNi-0008NY-T9
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 22:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755790AbYJVUbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 16:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755651AbYJVUbL
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 16:31:11 -0400
Received: from peff.net ([208.65.91.99]:3573 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755240AbYJVUbG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 16:31:06 -0400
Received: (qmail 4177 invoked by uid 111); 22 Oct 2008 20:31:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 22 Oct 2008 16:31:05 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Oct 2008 16:31:03 -0400
Content-Disposition: inline
In-Reply-To: <20081022202810.GA4439@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98902>

In the main loop of find_deltas, we do:

  struct object_entry *entry = *list++;
  ...
  if (!*list_size)
	  ...
	  break

Because we look at and increment *list _before_ the check of
list_size, in the very last iteration of the loop we will
look at uninitialized data, and increment the pointer beyond
one past the end of the allocated space. Since we don't
actually do anything with the data until after the check,
this is not a problem in practice.

But since it technically violates the C standard, and
because it provokes a spurious valgrind warning, let's just
move the initialization of entry to a safe place.

This fixes valgrind errors in t5300, t5301, t5302, t303, and
t9400.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-pack-objects.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 59c30d1..15b80db 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1375,7 +1375,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 	array = xcalloc(window, sizeof(struct unpacked));
 
 	for (;;) {
-		struct object_entry *entry = *list++;
+		struct object_entry *entry;
 		struct unpacked *n = array + idx;
 		int j, max_depth, best_base = -1;
 
@@ -1384,6 +1384,7 @@ static void find_deltas(struct object_entry **list, unsigned *list_size,
 			progress_unlock();
 			break;
 		}
+		entry = *list++;
 		(*list_size)--;
 		if (!entry->preferred_base) {
 			(*processed)++;
-- 
1.6.0.2.825.g6d19d
