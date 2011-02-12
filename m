From: Jeff King <peff@peff.net>
Subject: [PATCH] string_list_append: always set util pointer to NULL
Date: Sat, 12 Feb 2011 00:18:51 -0500
Message-ID: <20110212051850.GA715@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 12 06:18:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Po7sg-0007ZM-QN
	for gcvg-git-2@lo.gmane.org; Sat, 12 Feb 2011 06:18:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355Ab1BLFSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Feb 2011 00:18:46 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:59629 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751129Ab1BLFSp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Feb 2011 00:18:45 -0500
Received: (qmail 30760 invoked by uid 111); 12 Feb 2011 05:18:44 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 12 Feb 2011 05:18:44 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Feb 2011 00:18:51 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166594>

It is not immediately obvious that the util field may
contain random bytes after appending an item. Especially
since the string_list_insert* functions _do_ explicitly zero
the util pointer.

This does not appear to be a bug in any current git code, as
all callers either fill in the util field immediately or
never use it. However, it is worth it to be less surprising
to new users of the string-list API who may expect it to be
intialized to NULL.

Signed-off-by: Jeff King <peff@peff.net>
---
This bit me in some new code I was writing. I consider it a bug fix, but
even if you don't, I think it is still an API improvement. :)

 string-list.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/string-list.c b/string-list.c
index 9b023a2..5168118 100644
--- a/string-list.c
+++ b/string-list.c
@@ -153,6 +153,7 @@ struct string_list_item *string_list_append(struct string_list *list, const char
 	ALLOC_GROW(list->items, list->nr + 1, list->alloc);
 	list->items[list->nr].string =
 		list->strdup_strings ? xstrdup(string) : (char *)string;
+	list->items[list->nr].util = NULL;
 	return list->items + list->nr++;
 }
 
-- 
1.7.4
