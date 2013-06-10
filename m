From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/4] log: --author-date-order
Date: Mon, 10 Jun 2013 01:50:14 -0400
Message-ID: <20130610055014.GF3621@sigill.intra.peff.net>
References: <1370581872-31580-1-git-send-email-gitster@pobox.com>
 <1370820277-30158-1-git-send-email-gitster@pobox.com>
 <1370820277-30158-5-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Elliott Cable <me@ell.io>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 07:50:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uluzn-0006H2-7f
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 07:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667Ab3FJFuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 01:50:18 -0400
Received: from cloud.peff.net ([50.56.180.127]:41983 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751124Ab3FJFuR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 01:50:17 -0400
Received: (qmail 20892 invoked by uid 102); 10 Jun 2013 05:51:07 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Jun 2013 00:51:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Jun 2013 01:50:14 -0400
Content-Disposition: inline
In-Reply-To: <1370820277-30158-5-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227242>

On Sun, Jun 09, 2013 at 04:24:37PM -0700, Junio C Hamano wrote:

> Sometimes people would want to view the commits in parallel
> histories in the order of author dates, not committer dates.
> 
> Teach "topo-order" sort machinery to do so, using a commit-info slab
> to record the author dates of each commit, and commit-queue to sort
> them.

Nice, this is basically what I was envisioning when I mentioned the
slabs. However, I don't think the code works. :(

> +static void record_author_date(struct author_date_slab *author_date,
> +			       struct commit *commit)
> +{
> +	const char *buf, *line_end;
> +	struct ident_split ident;
> +	char *date_end;
> +	unsigned long date;
> +
> +	for (buf = commit->buffer; buf; buf = line_end + 1) {
> +		line_end = strchrnul(buf, '\n');
> +		if (prefixcmp(buf, "author ")) {
> +			if (!line_end[0] || line_end[1] == '\n')
> +				return; /* end of header */
> +			continue;
> +		}
> +		if (split_ident_line(&ident,
> +				     buf + strlen("author "),
> +				     line_end - (buf + strlen("author "))) ||
> +		    !ident.date_begin || !ident.date_end)
> +			return; /* malformed "author" line */
> +		break;
> +	}
> +
> +	date = strtoul(ident.date_begin, &date_end, 10);
> +	if (date_end != ident.date_end)
> +		return; /* malformed date */
> +	*(author_date_slab_at(author_date, commit)) = date;
> +}

I'm not excited about introducing yet another place that parses commit
objects (mostly not for correctness, but because we have had
inconsistency in how malformed objects are treated). It is at least
using split_ident_line which covers the hard bits. I wonder how much
slower it would be to simply call format_commit_message to do the
parsing.

>  	/* Mark them and clear the indegree */
>  	for (next = orig; next; next = next->next) {
>  		struct commit *commit = next->item;
>  		*(indegree_slab_at(&indegree, commit)) = 1;
> +		/* also record the author dates, if needed */
> +		if (sort_order == REV_SORT_BY_AUTHOR_DATE)
> +			record_author_date(&author_date, commit);

The record_author_date function assumes that commit->buffer is valid
(i.e., not NULL).  We seem to assume that the commits are parsed already
(for looking at parents, and at the committer date).  But if
"save_commit_buffer" is set to 0 (as it is for rev-list), we would not
have a buffer at all.

It's hard to notice the problem because a NULL buffer will cause
record_author_date to simply leave the slab entry at 0. That would give
the same output as regular "--topo-order" (because everybody has the
same timestamp), except that the priority queue heap is not stable.
With this patch:

diff --git a/commit.c b/commit.c
index f3a2f09..5e62ae8 100644
--- a/commit.c
+++ b/commit.c
@@ -521,6 +521,9 @@ static void record_author_date(struct author_date_slab *author_date,
 	char *date_end;
 	unsigned long date;
 
+	if (!commit->buffer)
+		die("whooops!");
+
 	for (buf = commit->buffer; buf; buf = line_end + 1) {
 		line_end = strchrnul(buf, '\n');
 		if (prefixcmp(buf, "author ")) {

you can see the problem more clearly with "git rev-list
--author-date-order HEAD".

-Peff
