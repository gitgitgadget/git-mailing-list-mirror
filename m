From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 15/15] commit: record buffer length in cache
Date: Tue, 10 Jun 2014 16:33:49 -0400
Message-ID: <20140610203349.GG14974@sigill.intra.peff.net>
References: <20140609180236.GA24644@sigill.intra.peff.net>
 <20140609181538.GO20315@sigill.intra.peff.net>
 <20140610.071237.852310668484562387.chriscool@tuxfamily.org>
 <20140610052713.GA2978@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
	sunshine@sunshineco.com
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Jun 10 22:33:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuSk0-00008y-Du
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 22:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754968AbaFJUdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 16:33:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:41274 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753815AbaFJUdu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 16:33:50 -0400
Received: (qmail 14668 invoked by uid 102); 10 Jun 2014 20:33:50 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jun 2014 15:33:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jun 2014 16:33:49 -0400
Content-Disposition: inline
In-Reply-To: <20140610052713.GA2978@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251233>

On Tue, Jun 10, 2014 at 01:27:13AM -0400, Jeff King wrote:

> > I find the above strange. I would have done something like:
> > 
> > -	set_commit_buffer(commit, strbuf_detach(&msg, NULL));
> > +	size_t size;
> > +	char *buf = strbuf_detach(&msg, &size);
> > +	set_commit_buffer(commit, buf, size);
> 
> It is a little strange. You can't do:
> 
>   set_commit_buffer(commit, strbuf_detach(&msg, NULL), msg.len);
> 
> because the second argument resets msg.len as a side effect. Doing it
> your way is longer, but perhaps is a bit more canonical. In general, one
> should call strbuf_detach to ensure that the buffer is allocated (and
> does not point to slopbuf). That's guaranteed here, because we just put
> contents into the buffer, but it's probably more hygienic to use the
> more verbose form.

I was trying to avoid cluttering up the function with the extra variable
definitions. I ended up with the change below, which I think is clear,
correct, and pushes the complexity outside of the function.

diff --git a/builtin/blame.c b/builtin/blame.c
index cde19eb..53f43ab 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2266,6 +2266,18 @@ static void append_merge_parents(struct commit_list **tail)
 }
 
 /*
+ * This isn't as simple as passing sb->buf and sb->len, because we
+ * want to transfer ownership of the buffer to the commit (so we
+ * must use detach).
+ */
+static void set_commit_buffer_from_strbuf(struct commit *c, struct strbuf *sb)
+{
+	size_t len;
+	void *buf = strbuf_detach(sb, &len);
+	set_commit_buffer(c, buf, len);
+}
+
+/*
  * Prepare a dummy commit that represents the work tree (or staged) item.
  * Note that annotating work tree item never works in the reverse.
  */
@@ -2313,7 +2325,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 		    ident, ident, path,
 		    (!contents_from ? path :
 		     (!strcmp(contents_from, "-") ? "standard input" : contents_from)));
-	set_commit_buffer(commit, strbuf_detach(&msg, NULL));
+	set_commit_buffer_from_strbuf(commit, &msg);
 
 	if (!contents_from || strcmp("-", contents_from)) {
 		struct stat st;
