From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5] format-patch --signature-file <file>
Date: Wed, 21 May 2014 16:47:39 -0400
Message-ID: <20140521204739.GA8381@sigill.intra.peff.net>
References: <1400572806-21092-1-git-send-email-jmmahler@gmail.com>
 <1400572806-21092-2-git-send-email-jmmahler@gmail.com>
 <20140520082740.GB27590@sigill.intra.peff.net>
 <xmqq61l01gmw.fsf@gitster.dls.corp.google.com>
 <20140520182443.GA30533@sigill.intra.peff.net>
 <xmqq7g5gz3s4.fsf@gitster.dls.corp.google.com>
 <20140521164255.GA2040@sigill.intra.peff.net>
 <xmqq61kzqbi6.fsf@gitster.dls.corp.google.com>
 <20140521175930.GA4588@sigill.intra.peff.net>
 <xmqqsio3ounp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeremiah Mahler <jmmahler@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 21 22:47:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnDQP-0007J9-OG
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 22:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294AbaEUUrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 16:47:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:56766 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751786AbaEUUrl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 16:47:41 -0400
Received: (qmail 2203 invoked by uid 102); 21 May 2014 20:47:41 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 May 2014 15:47:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 May 2014 16:47:39 -0400
Content-Disposition: inline
In-Reply-To: <xmqqsio3ounp.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249827>

On Wed, May 21, 2014 at 11:26:18AM -0700, Junio C Hamano wrote:

> Yeah, I agree with the last sentence.  My mention of "cleansing"
> took into account your "do we want to omit the leading blank as
> well?" as well.  In any case, wouldn't reusing stripspace() make the
> fix-up shorter?

Not really. Doing stripspace() on the file we read would be a one-liner,
but it doesn't address the extra line. We _already_ have
stripspace-compatible output in the file, with a trailing newline. It's
the one we add for the cmdline arg or default (which lack a newline
generally) that causes the doubling.

So I think it would be something like:

diff --git a/builtin/log.c b/builtin/log.c
index 39e8836..0312402 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -844,8 +844,13 @@ static void gen_message_id(struct rev_info *info, char *base)
 
 static void print_signature(void)
 {
-	if (signature && *signature)
-		printf("-- \n%s\n\n", signature);
+	if (signature && *signature) {
+		struct strbuf buf = STRBUF_INIT;
+		strbuf_addstr(&buf, signature);
+		stripspace(&buf, 0);
+		printf("-- \n%s\n", buf.buf);
+		strbuf_release(&buf);
+	}
 }
 
 static void add_branch_description(struct strbuf *buf, const char *branch_name)

I.e., make sure we have consistent stripspace output, and then stop
adding the extra newline in the printf (notice we still include the
"extra" blank at the end, though we can obviously easily drop it here).
Compare to the previous patch I sent, or to the shortest possible:

diff --git a/builtin/log.c b/builtin/log.c
index 39e8836..16b8771 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -845,7 +845,8 @@ static void gen_message_id(struct rev_info *info, char *base)
 static void print_signature(void)
 {
 	if (signature && *signature)
-		printf("-- \n%s\n\n", signature);
+		printf("-- \n%s%s\n", signature,
+		       ends_with(signature, "\n") ? "" : "\n");
 }
 
 static void add_branch_description(struct strbuf *buf, const char *branch_name)

But I'm not sure "length of code" is the right metric. They're all
pretty easy to do, if we can decide on which.

I think the ratio of usefulness to number of words in this sub-thread is
getting off. I'd be OK with any of:

  1. Leave it as-is. Files get two blank lines.

  2. Conditional newline

  3. Stripspace.

-Peff
