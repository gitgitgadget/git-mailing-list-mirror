From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Do not show "diff --git" metainfo with --no-prefix
Date: Thu, 17 Jan 2008 10:03:06 -0500
Message-ID: <20080117150306.GB2816@coredump.intra.peff.net>
References: <alpine.LFD.1.00.0801151919440.2806@woody.linux-foundation.org> <alpine.LNX.1.00.0801152256480.13593@iabervon.org> <alpine.LFD.1.00.0801152017490.2806@woody.linux-foundation.org> <7v1w8hploy.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0801161524390.13593@iabervon.org> <7vprw1mfpr.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801170108440.17650@racer.site> <7vabn5mdz7.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801170147350.17650@racer.site> <20080117144914.GA2816@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Chris Ortman <chrisortman@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 17 16:03:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFWHN-0002FU-Ro
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 16:03:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbYAQPDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 10:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752212AbYAQPDL
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 10:03:11 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3879 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751908AbYAQPDK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 10:03:10 -0500
Received: (qmail 3805 invoked by uid 111); 17 Jan 2008 15:03:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 17 Jan 2008 10:03:07 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Jan 2008 10:03:06 -0500
Content-Disposition: inline
In-Reply-To: <20080117144914.GA2816@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70864>

On Thu, Jan 17, 2008 at 09:49:14AM -0500, Jeff King wrote:

> Hmm. I happen to set my "meta" color to something a little less
> attention-grabbing (magenta), and I find the alternate coloring to be a
> nice visual indicator of "nothing happened on this line". I can see how
> bold would be very distracting, though. Perhaps there should be a
> color.diff.unimportant?

BTW, here is the fix to at least color it as plain (it is a little
larger than the one line it needs to be because it cleans up the
variable name "set", which is what caused this confusion in the first
place).

-- >8 --
color unchanged lines as "plain" in "diff --color-words"

These were mistakenly being colored in "meta" color.

---
diff --git a/diff.c b/diff.c
index b18c140..9b02e79 100644
--- a/diff.c
+++ b/diff.c
@@ -552,7 +552,8 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	int i;
 	int color;
 	struct emit_callback *ecbdata = priv;
-	const char *set = diff_get_color(ecbdata->color_diff, DIFF_METAINFO);
+	const char *meta = diff_get_color(ecbdata->color_diff, DIFF_METAINFO);
+	const char *plain = diff_get_color(ecbdata->color_diff, DIFF_PLAIN);
 	const char *reset = diff_get_color(ecbdata->color_diff, DIFF_RESET);
 
 	*(ecbdata->found_changesp) = 1;
@@ -564,9 +565,9 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		name_b_tab = strchr(ecbdata->label_path[1], ' ') ? "\t" : "";
 
 		printf("%s--- %s%s%s\n",
-		       set, ecbdata->label_path[0], reset, name_a_tab);
+		       meta, ecbdata->label_path[0], reset, name_a_tab);
 		printf("%s+++ %s%s%s\n",
-		       set, ecbdata->label_path[1], reset, name_b_tab);
+		       meta, ecbdata->label_path[1], reset, name_b_tab);
 		ecbdata->label_path[0] = ecbdata->label_path[1] = NULL;
 	}
 
@@ -586,7 +587,6 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	}
 
 	if (len < ecbdata->nparents) {
-		set = reset;
 		emit_line(reset, reset, line, len);
 		return;
 	}
@@ -610,7 +610,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 			diff_words_show(ecbdata->diff_words);
 		line++;
 		len--;
-		emit_line(set, reset, line, len);
+		emit_line(plain, reset, line, len);
 		return;
 	}
 	for (i = 0; i < ecbdata->nparents && len; i++) {
