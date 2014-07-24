From: Jeff King <peff@peff.net>
Subject: [PATCH 3/5] transport: fix leaks in refs_from_alternate_cb
Date: Thu, 24 Jul 2014 00:41:30 -0400
Message-ID: <20140724044130.GC32355@peff.net>
References: <20140724043940.GA31282@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <stefanbeller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 24 06:41:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAAqf-0002vX-Hd
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 06:41:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934133AbaGXElk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 00:41:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:39359 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934043AbaGXEli (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 00:41:38 -0400
Received: (qmail 20582 invoked by uid 102); 24 Jul 2014 04:41:38 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Jul 2014 23:41:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jul 2014 00:41:30 -0400
Content-Disposition: inline
In-Reply-To: <20140724043940.GA31282@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254146>

The function starts by creating a copy of the static buffer
returned by real_path, but forgets to free it in the error
code paths. We can solve this by jumping to the cleanup code
that is already there.

Signed-off-by: Jeff King <peff@peff.net>
---
 transport.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/transport.c b/transport.c
index 3e42570..297e981 100644
--- a/transport.c
+++ b/transport.c
@@ -1359,11 +1359,11 @@ static int refs_from_alternate_cb(struct alternate_object_database *e,
 	while (other[len-1] == '/')
 		other[--len] = '\0';
 	if (len < 8 || memcmp(other + len - 8, "/objects", 8))
-		return 0;
+		goto out;
 	/* Is this a git repository with refs? */
 	memcpy(other + len - 8, "/refs", 6);
 	if (!is_directory(other))
-		return 0;
+		goto out;
 	other[len - 8] = '\0';
 	remote = remote_get(other);
 	transport = transport_get(remote, other);
@@ -1372,6 +1372,7 @@ static int refs_from_alternate_cb(struct alternate_object_database *e,
 	     extra = extra->next)
 		cb->fn(extra, cb->data);
 	transport_disconnect(transport);
+out:
 	free(other);
 	return 0;
 }
-- 
2.0.0.566.gfe3e6b2
