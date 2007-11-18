From: Jeff King <peff@peff.net>
Subject: [PATCH] send-pack: improve error reporting for total remote unpack
Date: Sun, 18 Nov 2007 00:58:06 -0500
Message-ID: <20071118055804.GA19313@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 06:58:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItdAy-0006uq-Ha
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 06:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbXKRF6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 00:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbXKRF6M
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 00:58:12 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4286 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750914AbXKRF6L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 00:58:11 -0500
Received: (qmail 8464 invoked by uid 111); 18 Nov 2007 05:58:09 -0000
Received: from ppp-216-106-96-70.storm.ca (HELO sigill.intra.peff.net) (216.106.96.70)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 18 Nov 2007 00:58:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Nov 2007 00:58:06 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65341>

If the remote doesn't give us per-ref status reports, then
we pessimistically assume that all refs failed. However,
instead of just exiting the function, we now mark them
individually as failed.

This lets us print the usual status table, but refs which
failed in this way are marked individually (alongside refs
which may have failed for other reasons, like being rejected
for non-ff status).

Signed-off-by: Jeff King <peff@peff.net>
---
On Sat, Nov 17, 2007 at 08:47:11PM -0800, Junio C Hamano wrote:

> Hmm.  When we did not receive status, we cannot tell what
> succeeded or failed, but what we _can_ tell the user is which
> refs we attempted to push.  I wonder if robbing that information
> from the user with this "return -1" is a good idea.  Perhaps we
> would instead want to set the status of all the refs to error
> and call print_push_status() anyway?  I dunno.

I think this is a bit nicer. However, I noticed that it's hard to follow
these error paths, anyway. packet_read_line likes to die on bad input
anyway. And I couldn't get receive_pack to give me a bad unpack status;
instead, it just died with a fatal error and reported nothing.

> > OK. Since it is already in next, do you want a style fixup patch [for
> > the comment]?
> I do not think it is particularly a big deal -- perhaps clean it
> before we touch the vicinity of the code next time.  The same
> goes for the "} else {" stuff.

Well, it fixed itself here (and it looks like you tweaked the else
cuddling when you applied to next).

One other thing I noticed while doing this patch is that our remote ref
status reporting isn't foolproof.  We set every ref we send to 'OK' with
the nice effect that if status reporting isn't enabled, we just assume
that it worked. However, if the status coming back is truncated (i.e.,
some refs are missing in receive_status), we will just fail to notice and
assume all is well. So to be perfect, we would need a
REF_STATUS_EXPECTING_REPORT.

I can implement this if desired. OTOH, this isn't a new bug at all, and it
would be pretty tricky to trigger it (you would need to die exactly on a
line boundary).

 builtin-send-pack.c |   31 +++++++++++++++++++++----------
 cache.h             |    1 +
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 5fadd0b..602e196 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -165,9 +165,14 @@ static struct ref *set_ref_error(struct ref *refs, const char *line)
 	return NULL;
 }
 
-/* a return value of -1 indicates that an error occurred,
- * but we were able to set individual ref errors. A return
- * value of -2 means we couldn't even get that far. */
+static void set_ref_error_all(struct ref *refs)
+{
+	struct ref *ref;
+	for (ref = refs; ref; ref = ref->next)
+		if (ref->status == REF_STATUS_OK)
+			ref->status = REF_STATUS_REMOTE_FAILURE;
+}
+
 static int receive_status(int in, struct ref *refs)
 {
 	struct ref *hint;
@@ -175,11 +180,15 @@ static int receive_status(int in, struct ref *refs)
 	int ret = 0;
 	int len = packet_read_line(in, line, sizeof(line));
 	if (len < 10 || memcmp(line, "unpack ", 7)) {
-		fprintf(stderr, "did not receive status back\n");
-		return -2;
+		error("did not receive remote status");
+		set_ref_error_all(refs);
+		return -1;
 	}
 	if (memcmp(line, "unpack ok\n", 10)) {
-		fputs(line, stderr);
+		char *p = line + strlen(line) - 1;
+		if (*p == '\n')
+			*p = '\0';
+		error("unpack failed: %s", line + 7);
 		ret = -1;
 	}
 	hint = NULL;
@@ -329,6 +338,11 @@ static void print_push_status(const char *dest, struct ref *refs)
 			else
 				print_ref_status('!', "[remote rejected]", ref, ref->peer_ref, ref->error);
 			break;
+		case REF_STATUS_REMOTE_FAILURE:
+			print_ref_status('!', "[remote failure]", ref,
+					ref->deletion ? ref->peer_ref : NULL,
+					NULL);
+			break;
 		case REF_STATUS_OK:
 			print_ok_ref_status(ref);
 			break;
@@ -462,11 +476,8 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 	}
 	close(out);
 
-	if (expect_status_report) {
+	if (expect_status_report)
 		ret = receive_status(in, remote_refs);
-		if (ret == -2)
-			return -1;
-	}
 	else
 		ret = 0;
 
diff --git a/cache.h b/cache.h
index ba9178f..de011bf 100644
--- a/cache.h
+++ b/cache.h
@@ -511,6 +511,7 @@ struct ref {
 		REF_STATUS_REJECT_NODELETE,
 		REF_STATUS_UPTODATE,
 		REF_STATUS_REMOTE_REJECT,
+		REF_STATUS_REMOTE_FAILURE,
 	} status;
 	char *error;
 	struct ref *peer_ref; /* when renaming */
-- 
1.5.3.5.1815.g9445b-dirty
