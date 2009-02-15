From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] transport: cleanup duplicated ref fetching code
Date: Sun, 15 Feb 2009 15:00:57 -0500
Message-ID: <20090215200057.GA26779@coredump.intra.peff.net>
References: <20090215195826.GA26740@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 21:02:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYnC7-0005jN-1n
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 21:02:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755927AbZBOUBB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 15:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbZBOUBA
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 15:01:00 -0500
Received: from peff.net ([208.65.91.99]:59290 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755915AbZBOUA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 15:00:59 -0500
Received: (qmail 9785 invoked by uid 107); 15 Feb 2009 20:01:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 15 Feb 2009 15:01:19 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Feb 2009 15:00:57 -0500
Content-Disposition: inline
In-Reply-To: <20090215195826.GA26740@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110050>

When fetching refs through the git protocol, the
fetch_refs_via_pack will establish the connection and get
the ref list if it has not already been done.

Since the code is only two lines, it was done inline rather
than calling the transport's get_refs function. However,
calling that function better matches the intent, and is
future-proof against enhancements in get_refs_via_connect.

Signed-off-by: Jeff King <peff@peff.net>
---
Enhancements like the one that is coming in the next patch.

Though I think that fetch_pack doesn't currently care if the HEAD symref
is set up, it makes sense to me to be consistent.

 transport.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/transport.c b/transport.c
index 9ad4a16..c9f31f6 100644
--- a/transport.c
+++ b/transport.c
@@ -646,10 +646,8 @@ static int fetch_refs_via_pack(struct transport *transport,
 	for (i = 0; i < nr_heads; i++)
 		origh[i] = heads[i] = xstrdup(to_fetch[i]->name);
 
-	if (!data->conn) {
-		connect_setup(transport);
-		get_remote_heads(data->fd[0], &refs_tmp, 0, NULL, 0, NULL);
-	}
+	if (!data->conn)
+		refs_tmp = transport->get_refs_list(transport);
 
 	refs = fetch_pack(&args, data->fd, data->conn,
 			  refs_tmp ? refs_tmp : transport->remote_refs,
-- 
1.6.2.rc0.258.gcef3.dirty
