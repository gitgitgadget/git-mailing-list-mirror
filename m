From: Jeff King <peff@peff.net>
Subject: [PATCH v2 0/6] shortlog fixes and optimizations
Date: Mon, 18 Jan 2016 15:01:36 -0500
Message-ID: <20160118200136.GA9514@sigill.intra.peff.net>
References: <20160115170627.GA20983@sigill.intra.peff.net>
 <20160115170823.GA21102@sigill.intra.peff.net>
 <20160118192621.GA981@sigill.intra.peff.net>
 <xmqqwpr6d5nd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 21:01:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLFzi-0002PE-Em
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 21:01:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756321AbcARUBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 15:01:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:55631 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755979AbcARUBi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 15:01:38 -0500
Received: (qmail 31936 invoked by uid 102); 18 Jan 2016 20:01:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jan 2016 15:01:38 -0500
Received: (qmail 13384 invoked by uid 107); 18 Jan 2016 20:01:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 18 Jan 2016 15:01:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Jan 2016 15:01:36 -0500
Content-Disposition: inline
In-Reply-To: <xmqqwpr6d5nd.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284313>

On Mon, Jan 18, 2016 at 11:55:18AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So it's not wrong, but it's perhaps more complicated than it needs to
> > be. We could scrap this patch in favor of just:
> >
> >   if (!skip_prefix(author, "Author: ", &v) &&
> >       !skip_prefix(author, "author ", &v))
> >           continue;
> >
> > That is technically more strict (it does not take "author: ", which is
> > accepted by the current code), but matches "git log" and "git log --raw"
> > output, and misses nothing that git has ever generated. And it extends
> > naturally to:
> >
> >   if (!skip_prefix(author, "Commit: ", &v) &&
> >       !skip_prefix(author, "committer ", &v))
> >           continue;
> 
> Yeah, I agree that the above long-hand would be more readable.

OK. Here it is again (the whole series, since the change creates minor
conflicts some of the later patches).

The interdiff is:

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 3a0c863..adbf1fd 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -113,27 +113,6 @@ static void insert_one_record(struct shortlog *log,
 	}
 }
 
-/*
- * If header is "author", match candidate against the regex /[Aa]uthor:? /,
- * and return a pointer to the remainder of the string in out_value.
- */
-static int match_ident_header(const char *candidate, const char *header,
-			      const char **out_value)
-{
-	const char *v;
-
-	if (tolower(*candidate++) != tolower(*header++))
-		return 0;
-	if (!skip_prefix(candidate, header, &v))
-		return 0;
-	if (*v == ':')
-		v++;
-	if (*v++ != ' ')
-		return 0;
-	*out_value = v;
-	return 1;
-}
-
 static void read_from_stdin(struct shortlog *log)
 {
 	struct strbuf author = STRBUF_INIT;
@@ -141,7 +120,8 @@ static void read_from_stdin(struct shortlog *log)
 
 	while (strbuf_getline(&author, stdin, '\n') != EOF) {
 		const char *v;
-		if (!match_ident_header(author.buf, "author", &v))
+		if (!skip_prefix(author.buf, "Author: ", &v) &&
+		    !skip_prefix(author.buf, "author ", &v))
 			continue;
 		while (strbuf_getline(&oneline, stdin, '\n') != EOF &&
 		       oneline.len)
