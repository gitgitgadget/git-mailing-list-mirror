From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] send-pack: assign remote errors to each ref
Date: Wed, 14 Nov 2007 23:47:16 -0500
Message-ID: <20071115044715.GB9794@sigill.intra.peff.net>
References: <20071113102500.GA2767@sigill.intra.peff.net> <20071113113710.GC15880@sigill.intra.peff.net> <7vbq9xpprg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 05:47:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsWdd-0003lU-Ic
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 05:47:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754800AbXKOErW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 23:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754763AbXKOErW
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 23:47:22 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3809 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754125AbXKOErV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 23:47:21 -0500
Received: (qmail 6026 invoked by uid 111); 15 Nov 2007 04:47:20 -0000
Received: from ppp-216-106-96-30.storm.ca (HELO sigill.intra.peff.net) (216.106.96.30)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 14 Nov 2007 23:47:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Nov 2007 23:47:16 -0500
Content-Disposition: inline
In-Reply-To: <7vbq9xpprg.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65058>

On Tue, Nov 13, 2007 at 05:41:39PM -0800, Junio C Hamano wrote:

> Is it really "arbitrary msg", or just a fixed set of strings?

It is for a fixed version of the remote receive-pack, but I don't want
to start relying on that.

> Also I think we can rely on the order report-status extension
> reports the per-ref result.  It gives back the information the
> same order send-pack side supplies the head information, no?

I considered that, but I didn't want to rely on it without your say-so.
We could also just use it as a hint to boost performance. I.e., track
the last match, and start our linear search there, but if we fail, drop
back to searching the whole list. Something like (on top of my other
patch):

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 7d466d9..8e9580a 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -146,7 +146,8 @@ static void get_local_heads(void)
 	for_each_ref(one_local_ref, NULL);
 }
 
-static void set_ref_error(struct ref *refs, const char *line) {
+static struct ref *set_ref_error(struct ref *refs, const char *line)
+{
 	struct ref *ref;
 
 	for (ref = refs; ref; ref = ref->next) {
@@ -159,8 +160,9 @@ static void set_ref_error(struct ref *refs, const char *line) {
 		ref->status = REF_STATUS_REMOTE_REJECT;
 		ref->error = xstrdup(msg);
 		ref->error[strlen(ref->error)-1] = '\0';
-		return;
+		return ref;
 	}
+	return NULL;
 }
 
 /* a return value of -1 indicates that an error occurred,
@@ -168,6 +170,7 @@ static void set_ref_error(struct ref *refs, const char *line) {
  * value of -2 means we couldn't even get that far. */
 static int receive_status(int in, struct ref *refs)
 {
+	struct ref *hint;
 	char line[1000];
 	int ret = 0;
 	int len = packet_read_line(in, line, sizeof(line));
@@ -179,6 +182,7 @@ static int receive_status(int in, struct ref *refs)
 		fputs(line, stderr);
 		ret = -1;
 	}
+	hint = NULL;
 	while (1) {
 		len = packet_read_line(in, line, sizeof(line));
 		if (!len)
@@ -191,7 +195,10 @@ static int receive_status(int in, struct ref *refs)
 		}
 		if (!memcmp(line, "ok", 2))
 			continue;
-		set_ref_error(refs, line + 3);
+		if (hint)
+			hint = set_ref_error(hint, line + 3);
+		if (!hint)
+			hint = set_ref_error(refs, line + 3);
 		ret = -1;
 	}
 	return ret;
