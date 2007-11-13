From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 1/3] send-pack: track errors for each ref
Date: Tue, 13 Nov 2007 06:32:03 -0500
Message-ID: <20071113113202.GA15845@sigill.intra.peff.net>
References: <20071113102500.GA2767@sigill.intra.peff.net> <20071113102709.GA2905@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 12:32:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iru0S-0000ac-8k
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 12:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753634AbXKMLcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 06:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752656AbXKMLcI
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 06:32:08 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4843 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753634AbXKMLcH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 06:32:07 -0500
Received: (qmail 19622 invoked by uid 111); 13 Nov 2007 11:32:05 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 13 Nov 2007 06:32:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Nov 2007 06:32:03 -0500
Content-Disposition: inline
In-Reply-To: <20071113102709.GA2905@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64792>

On Tue, Nov 13, 2007 at 05:27:09AM -0500, Jeff King wrote:

> Instead of keeping the 'ret' variable, we instead have a
> status flag for each ref that tracks what happened to it.
> We then print the ref status after all of the refs have
> been examined.

Argh, this fails t5400 quite badly without the following patch:

---
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 3ac2615..eff84e0 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -421,6 +421,16 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 
 	if (!new_refs)
 		fprintf(stderr, "Everything up-to-date\n");
+	for (ref = remote_refs; ref; ref = ref->next) {
+		switch (ref->status) {
+		case REF_STATUS_NONE:
+		case REF_STATUS_UPTODATE:
+		case REF_STATUS_OK:
+			break;
+		default:
+			return -1;
+		}
+	}
 	return 0;
 }
 
