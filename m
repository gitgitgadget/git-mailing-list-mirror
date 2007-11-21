From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] send-pack: cluster ref status reporting
Date: Wed, 21 Nov 2007 02:37:01 -0500
Message-ID: <20071121073700.GA10742@sigill.intra.peff.net>
References: <20071120111317.GA4120@sigill.intra.peff.net> <20071120111801.GA7814@sigill.intra.peff.net> <7v1wakhxh4.fsf@gitster.siamese.dyndns.org> <20071121073332.GA10244@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 08:37:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iuk9e-0007Qd-2N
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 08:37:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756938AbXKUHhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 02:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757035AbXKUHhG
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 02:37:06 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2732 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756871AbXKUHhE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 02:37:04 -0500
Received: (qmail 4887 invoked by uid 111); 21 Nov 2007 07:37:02 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 21 Nov 2007 02:37:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Nov 2007 02:37:01 -0500
Content-Disposition: inline
In-Reply-To: <20071121073332.GA10244@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65612>

On Wed, Nov 21, 2007 at 02:33:32AM -0500, Jeff King wrote:

> > > +	case REF_STATUS_REMOTE_REJECT:
> > > +		print_ref_status('!', "[remote rejected]", ref,
> > > +				ref->deletion ? ref->peer_ref : NULL,
> > > +				ref->remote_status);
> > > +		break;
> 
> Gah, sorry. This crept in because I based it on the previous, broken
> version of the other patch series which had the same problem (and
> obviously this chunk is just a pure code move + reindent).

You will also find that it doesn't apply cleanly to 'next', since it
attempts to remove the bogus version of the lines (while you correctly
fixed them up when you applied to 'next').

Below is a fixed version of the patch for convenience.

-- >8 --
send-pack: cluster ref status reporting

Instead of intermingling success and failure, we now print:

  1. all uptodate refs (if args.verbose is enabled)
  2. successfully pushed refs
  3. failed refs

with the assumption that the user is most likely to see the
ones at the end, and therefore we order them from "least
interesting" to "most interesting."
---
 builtin-send-pack.c |   93 +++++++++++++++++++++++++++++----------------------
 1 files changed, 53 insertions(+), 40 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 3aab89c..25ae1fe 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -298,52 +298,65 @@ static void print_ok_ref_status(struct ref *ref)
 	}
 }
 
+static int print_one_push_status(struct ref *ref, const char *dest, int count)
+{
+	if (!count)
+		fprintf(stderr, "To %s\n", dest);
+
+	switch(ref->status) {
+	case REF_STATUS_NONE:
+		print_ref_status('X', "[no match]", ref, NULL, NULL);
+		break;
+	case REF_STATUS_REJECT_NODELETE:
+		print_ref_status('!', "[rejected]", ref, NULL,
+				"remote does not support deleting refs");
+		break;
+	case REF_STATUS_UPTODATE:
+		print_ref_status('=', "[up to date]", ref,
+				ref->peer_ref, NULL);
+		break;
+	case REF_STATUS_REJECT_NONFASTFORWARD:
+		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
+				"non-fast forward");
+		break;
+	case REF_STATUS_REMOTE_REJECT:
+		print_ref_status('!', "[remote rejected]", ref,
+				ref->deletion ? NULL : ref->peer_ref,
+				ref->remote_status);
+		break;
+	case REF_STATUS_EXPECTING_REPORT:
+		print_ref_status('!', "[remote failure]", ref,
+				ref->deletion ? NULL : ref->peer_ref,
+				"remote failed to report status");
+		break;
+	case REF_STATUS_OK:
+		print_ok_ref_status(ref);
+		break;
+	}
+
+	return 1;
+}
+
 static void print_push_status(const char *dest, struct ref *refs)
 {
 	struct ref *ref;
-	int shown_dest = 0;
+	int n = 0;
 
-	for (ref = refs; ref; ref = ref->next) {
-		if (!ref->status)
-			continue;
-		if (ref->status == REF_STATUS_UPTODATE && !args.verbose)
-			continue;
+	if (args.verbose) {
+		for (ref = refs; ref; ref = ref->next)
+			if (ref->status == REF_STATUS_UPTODATE)
+				n += print_one_push_status(ref, dest, n);
+	}
 
-		if (!shown_dest) {
-			fprintf(stderr, "To %s\n", dest);
-			shown_dest = 1;
-		}
+	for (ref = refs; ref; ref = ref->next)
+		if (ref->status == REF_STATUS_OK)
+			n += print_one_push_status(ref, dest, n);
 
-		switch(ref->status) {
-		case REF_STATUS_NONE:
-			print_ref_status('X', "[no match]", ref, NULL, NULL);
-			break;
-		case REF_STATUS_REJECT_NODELETE:
-			print_ref_status('!', "[rejected]", ref, NULL,
-					"remote does not support deleting refs");
-			break;
-		case REF_STATUS_UPTODATE:
-			print_ref_status('=', "[up to date]", ref,
-					ref->peer_ref, NULL);
-			break;
-		case REF_STATUS_REJECT_NONFASTFORWARD:
-			print_ref_status('!', "[rejected]", ref, ref->peer_ref,
-					"non-fast forward");
-			break;
-		case REF_STATUS_REMOTE_REJECT:
-			print_ref_status('!', "[remote rejected]", ref,
-					ref->deletion ? NULL : ref->peer_ref,
-					ref->remote_status);
-			break;
-		case REF_STATUS_EXPECTING_REPORT:
-			print_ref_status('!', "[remote failure]", ref,
-					ref->deletion ? NULL : ref->peer_ref,
-					"remote failed to report status");
-			break;
-		case REF_STATUS_OK:
-			print_ok_ref_status(ref);
-			break;
-		}
+	for (ref = refs; ref; ref = ref->next) {
+		if (ref->status != REF_STATUS_NONE &&
+		    ref->status != REF_STATUS_UPTODATE &&
+		    ref->status != REF_STATUS_OK)
+			n += print_one_push_status(ref, dest, n);
 	}
 }
 
-- 
1.5.3.6.1786.g2e199
