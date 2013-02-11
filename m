From: Jeff King <peff@peff.net>
Subject: Re: segfault for git log --graph --no-walk --grep a
Date: Mon, 11 Feb 2013 14:16:07 -0500
Message-ID: <20130211191607.GA21269@sigill.intra.peff.net>
References: <201302090052.22053.thom311@gmail.com>
 <7vsj56xsg5.fsf@alter.siamese.dyndns.org>
 <7vobfuxrns.fsf@alter.siamese.dyndns.org>
 <20130209002710.GA5570@sigill.intra.peff.net>
 <7vfw16xqvj.fsf@alter.siamese.dyndns.org>
 <7va9rexqii.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Haller <thom311@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 20:16:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4yrs-0005er-0R
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 20:16:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758941Ab3BKTQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 14:16:17 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44500 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758164Ab3BKTQO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 14:16:14 -0500
Received: (qmail 25674 invoked by uid 107); 11 Feb 2013 19:17:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Feb 2013 14:17:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2013 14:16:07 -0500
Content-Disposition: inline
In-Reply-To: <7va9rexqii.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216078>

On Fri, Feb 08, 2013 at 04:47:01PM -0800, Junio C Hamano wrote:

> > Yeah, that actually is a good point.  We should be using logmsg_reencode
> > so that we look for strings in the user's encoding.
> 
> Perhaps like this.  Just like the previous one (which should be
> discarded), this makes the function always use the temporary strbuf,
> so doing this upfront actually loses more code than it adds ;-)

I didn't see this in What's Cooking or pu. We should probably pick an
approach and go with it.

I think using logmsg_reencode makes sense. I'd be in favor of avoiding
the extra copy in the common case, so something like the patch below. If
you feel strongly about the code cleanup at the minor run-time expense,
I won't argue too much, though.

---
diff --git a/revision.c b/revision.c
index d7562ee..a08d0a5 100644
--- a/revision.c
+++ b/revision.c
@@ -2268,7 +2268,10 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 static int commit_match(struct commit *commit, struct rev_info *opt)
 {
 	int retval;
+	const char *encoding;
+	const char *message;
 	struct strbuf buf = STRBUF_INIT;
+
 	if (!opt->grep_filter.pattern_list && !opt->grep_filter.header_list)
 		return 1;
 
@@ -2279,13 +2282,23 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 		strbuf_addch(&buf, '\n');
 	}
 
+	/*
+	 * We grep in the user's output encoding, under the assumption that it
+	 * is the encoding they are most likely to write their grep pattern
+	 * for. In addition, it means we will match the "notes" encoding below,
+	 * so we will not end up with a buffer that has two different encodings
+	 * in it.
+	 */
+	encoding = get_log_output_encoding();
+	message = logmsg_reencode(commit, encoding);
+
 	/* Copy the commit to temporary if we are using "fake" headers */
 	if (buf.len)
-		strbuf_addstr(&buf, commit->buffer);
+		strbuf_addstr(&buf, message);
 
 	if (opt->grep_filter.header_list && opt->mailmap) {
 		if (!buf.len)
-			strbuf_addstr(&buf, commit->buffer);
+			strbuf_addstr(&buf, message);
 
 		commit_rewrite_person(&buf, "\nauthor ", opt->mailmap);
 		commit_rewrite_person(&buf, "\ncommitter ", opt->mailmap);
@@ -2294,18 +2307,18 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 	/* Append "fake" message parts as needed */
 	if (opt->show_notes) {
 		if (!buf.len)
-			strbuf_addstr(&buf, commit->buffer);
-		format_display_notes(commit->object.sha1, &buf,
-				     get_log_output_encoding(), 1);
+			strbuf_addstr(&buf, message);
+		format_display_notes(commit->object.sha1, &buf, encoding, 1);
 	}
 
-	/* Find either in the commit object, or in the temporary */
+	/* Find either in the original commit message, or in the temporary */
 	if (buf.len)
 		retval = grep_buffer(&opt->grep_filter, buf.buf, buf.len);
 	else
 		retval = grep_buffer(&opt->grep_filter,
-				     commit->buffer, strlen(commit->buffer));
+				     message, strlen(message));
 	strbuf_release(&buf);
+	logmsg_free(message, commit);
 	return retval;
 }
 
