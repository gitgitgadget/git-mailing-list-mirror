From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 09/13] Allow helpers to report in "list" command that the
 ref is unchanged
Date: Wed, 5 Aug 2009 01:02:15 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908050056000.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 07:03:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYYeB-0007Gg-FJ
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 07:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbZHEFCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 01:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755362AbZHEFCU
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 01:02:20 -0400
Received: from iabervon.org ([66.92.72.58]:37018 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755316AbZHEFCP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 01:02:15 -0400
Received: (qmail 18312 invoked by uid 1000); 5 Aug 2009 05:02:15 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Aug 2009 05:02:15 -0000
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Helpers may use a line like "? name unchanged" to specify that there
is nothing new at that name, without any git-specific code to
determine the correct response.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 Documentation/git-remote-helpers.txt |    4 +++-
 transport-helper.c                   |    6 ++++++
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index e9aa67e..2c5130f 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -70,7 +70,9 @@ CAPABILITIES
 REF LIST ATTRIBUTES
 -------------------
 
-None are defined yet, but the caller must accept any which are supplied.
+'unchanged'::
+	This ref is unchanged since the last import or fetch, although
+	the helper cannot necessarily determine what value that produced.
 
 Documentation
 -------------
diff --git a/transport-helper.c b/transport-helper.c
index 6eee0da..956cece 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -193,6 +193,12 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 			(*tail)->symref = xstrdup(buf.buf + 1);
 		else if (buf.buf[0] != '?')
 			get_sha1_hex(buf.buf, (*tail)->old_sha1);
+		if (eon) {
+			if (strstr(eon + 1, "unchanged")) {
+				(*tail)->status |= REF_STATUS_UPTODATE;
+				read_ref((*tail)->name, (*tail)->old_sha1);
+			}
+		}
 		tail = &((*tail)->next);
 	}
 	strbuf_release(&buf);
-- 
1.6.4.rc3.27.g95032.dirty
