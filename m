From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] transport: don't show push status if --quiet is given
Date: Wed, 5 Aug 2009 16:23:26 -0400
Message-ID: <20090805202326.GC23226@coredump.intra.peff.net>
References: <20090805201937.GB9004@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Albert Astals Cid <aacid@kde.org>,
	Junio C Hamano <gitster@pobox.com>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 22:23:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYn1Y-0001v0-O6
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 22:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558AbZHEUXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 16:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752539AbZHEUXb
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 16:23:31 -0400
Received: from peff.net ([208.65.91.99]:37869 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752488AbZHEUXa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 16:23:30 -0400
Received: (qmail 12271 invoked by uid 107); 5 Aug 2009 20:25:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 05 Aug 2009 16:25:42 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Aug 2009 16:23:26 -0400
Content-Disposition: inline
In-Reply-To: <20090805201937.GB9004@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124966>

When --quiet is given, the user generally only wants to see
errors. So let's suppress printing the ref status table
unless there is an error, in which case we print out the
whole table.

Signed-off-by: Jeff King <peff@peff.net>
---
We could get fancier here and print out only the refs with errors if
quiet is given, but I went for simplicity.

 transport.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/transport.c b/transport.c
index 2d0c491..afec5b7 100644
--- a/transport.c
+++ b/transport.c
@@ -667,6 +667,21 @@ static int fetch_refs_via_pack(struct transport *transport,
 	return (refs ? 0 : -1);
 }
 
+static int push_had_errors(struct ref *ref)
+{
+	for (; ref; ref = ref->next) {
+		switch (ref->status) {
+		case REF_STATUS_NONE:
+		case REF_STATUS_UPTODATE:
+		case REF_STATUS_OK:
+			break;
+		default:
+			return 1;
+		}
+	}
+	return 0;
+}
+
 static int refs_pushed(struct ref *ref)
 {
 	for (; ref; ref = ref->next) {
@@ -996,6 +1011,7 @@ int transport_push(struct transport *transport,
 		struct ref *local_refs = get_local_heads();
 		int match_flags = MATCH_REFS_NONE;
 		int verbose = flags & TRANSPORT_PUSH_VERBOSE;
+		int quiet = flags & TRANSPORT_PUSH_QUIET;
 		int porcelain = flags & TRANSPORT_PUSH_PORCELAIN;
 		int ret;
 
@@ -1011,7 +1027,9 @@ int transport_push(struct transport *transport,
 
 		ret = transport->push_refs(transport, remote_refs, flags);
 
-		print_push_status(transport->url, remote_refs, verbose | porcelain, porcelain);
+		if (!quiet || push_had_errors(remote_refs))
+			print_push_status(transport->url, remote_refs,
+					verbose | porcelain, porcelain);
 
 		if (!(flags & TRANSPORT_PUSH_DRY_RUN)) {
 			struct ref *ref;
-- 
1.6.4.218.g9f65c.dirty
