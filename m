From: Jeff King <peff@peff.net>
Subject: [PATCH] clone: disconnect transport after fetching
Date: Wed, 2 Sep 2009 02:36:47 -0400
Message-ID: <20090902063647.GA29559@coredump.intra.peff.net>
References: <alpine.LNX.2.00.0909020159080.28290@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Sitaram Chamarty <sitaramc@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 08:36:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MijSi-0002BL-Cn
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 08:36:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755907AbZIBGgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 02:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755901AbZIBGgt
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 02:36:49 -0400
Received: from peff.net ([208.65.91.99]:45791 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755897AbZIBGgs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 02:36:48 -0400
Received: (qmail 5248 invoked by uid 107); 2 Sep 2009 06:37:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 02 Sep 2009 02:37:02 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Sep 2009 02:36:47 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0909020159080.28290@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127587>

The current code just leaves the transport in whatever state
it was in after performing the fetch.  For a non-empty clone
over the git protocol, the transport code already
disconnects at the end of the fetch.

But for an empty clone, we leave the connection hanging, and
eventually close the socket when clone exits. This causes
the remote upload-pack to complain "the remote end hung up
unexpectedly". While this message is harmless to the clone
itself, it is unnecessarily scary for a user to see and may
pollute git-daemon logs.

This patch just explicitly calls disconnect after we are
done with the remote end, which sends a flush packet to
upload-pack and cleanly disconnects, avoiding the error
message.

Other transports are unaffected or slightly improved:

 - for a non-empty repo over the git protocol, the second
   disconnect is a no-op (since we are no longer connected)

 - for "walker" transports (like HTTP or FTP), we actually
   free some used memory (which previously just sat until
   the clone process exits)

 - for "rsync", disconnect is always a no-op anyway

Signed-off-by: Jeff King <peff@peff.net>
---
This was suggested by Daniel, so theoretically

  Acked-by: Daniel Barkalow <barkalow@iabervon.org>

:)

As you can see from the commit message, I did a little extra hunting to
make sure we are not going to impact any other code paths, and I am
pretty sure we are fine.

 builtin-clone.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 991a7ae..0f231d8 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -580,8 +580,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		option_no_checkout = 1;
 	}
 
-	if (transport)
+	if (transport) {
 		transport_unlock_pack(transport);
+		transport_disconnect(transport);
+	}
 
 	if (!option_no_checkout) {
 		struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
-- 
1.6.4.2.401.ga275f.dirty
