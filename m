From: Jeff King <peff@peff.net>
Subject: Re: [BUG] A part of an edge from an octopus merge gets colored, even
 with --color=never
Date: Tue, 17 May 2016 15:51:37 -0400
Message-ID: <20160517195136.GB11289@sigill.intra.peff.net>
References: <CAM-tV-_Easz+HA0GX0YkY4FZ2LithQy0+omq64D-OoHKkRe55A@mail.gmail.com>
 <573B6BF5.1090004@kdbg.org>
 <20160517194533.GA11289@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Noam Postavsky <npostavs@users.sourceforge.net>,
	git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue May 17 21:51:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2l1s-0007AV-J9
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 21:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbcEQTvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 15:51:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:40932 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750758AbcEQTvk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 15:51:40 -0400
Received: (qmail 11169 invoked by uid 102); 17 May 2016 19:51:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 May 2016 15:51:39 -0400
Received: (qmail 17417 invoked by uid 107); 17 May 2016 19:51:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 May 2016 15:51:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 May 2016 15:51:37 -0400
Content-Disposition: inline
In-Reply-To: <20160517194533.GA11289@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294906>

On Tue, May 17, 2016 at 03:45:34PM -0400, Jeff King wrote:

> Note that we set up f90, fa0, and fb0, but then pass fc0 into
> strbuf_write_column (and it has bogus color values). It looks like we're
> reading one past the end of our array, but I haven't figured out where
> or why.

Looking at the valgrind output reveals that. Here's an assert() that
catches it reliably for me:

diff --git a/graph.c b/graph.c
index 1350bdd..964bbd1 100644
--- a/graph.c
+++ b/graph.c
@@ -794,9 +794,11 @@ static int graph_draw_octopus_merge(struct git_graph *graph,
 		((graph->num_parents - dashless_commits) * 2) - 1;
 	for (i = 0; i < num_dashes; i++) {
 		col_num = (i / 2) + dashless_commits + graph->commit_index;
+		assert(col_num < graph->num_new_columns);
 		strbuf_write_column(sb, &graph->new_columns[col_num], '-');
 	}
 	col_num = (i / 2) + dashless_commits + graph->commit_index;
+	assert(col_num < graph->num_new_columns);
 	strbuf_write_column(sb, &graph->new_columns[col_num], '.');
 	return num_dashes + 1;
 }

(It's actually the first one which triggers). I'm not familiar enough
with the code to know whether the col_num computation is bogus, or
whether we needed to earlier increase the size of the "new_columns"
field.

-Peff
