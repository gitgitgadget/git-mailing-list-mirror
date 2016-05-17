From: Jeff King <peff@peff.net>
Subject: Re: [BUG] A part of an edge from an octopus merge gets colored, even
 with --color=never
Date: Tue, 17 May 2016 15:45:34 -0400
Message-ID: <20160517194533.GA11289@sigill.intra.peff.net>
References: <CAM-tV-_Easz+HA0GX0YkY4FZ2LithQy0+omq64D-OoHKkRe55A@mail.gmail.com>
 <573B6BF5.1090004@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Noam Postavsky <npostavs@users.sourceforge.net>,
	git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue May 17 21:45:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2kw1-0004F4-RW
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 21:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbcEQTpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 15:45:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:40924 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750729AbcEQTph (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 15:45:37 -0400
Received: (qmail 10908 invoked by uid 102); 17 May 2016 19:45:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 May 2016 15:45:36 -0400
Received: (qmail 17364 invoked by uid 107); 17 May 2016 19:45:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 May 2016 15:45:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 May 2016 15:45:34 -0400
Content-Disposition: inline
In-Reply-To: <573B6BF5.1090004@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294905>

On Tue, May 17, 2016 at 09:07:33PM +0200, Johannes Sixt wrote:

> Am 15.05.2016 um 15:05 schrieb Noam Postavsky:
> > With a certain topology involving an octopus merge, git log --graph
> > --oneline --all --color=never produces output which includes some ANSI
> > escape code coloring. Attached is a script to reproduce the problem
> > (creates a git repository in subdir log-format-test), along with
> > sample graph and valgrind output (indicates some unitialialized memory
> > access).
> > 
> > I've observed the problem with Windows git versions 2.7.0, 2.5.3.
> > I've NOT observed it with 1.9.5,
> > 
> > On GNU/Linux the symptom only appears when running with valgrind, I
> > tried versions
> > 2.8.0, and 2.8.2.402.gedec370 (the last is where the valgrind output comes from)
> > 
> 
> Sorry, I can't reproduce your observation. I ran the script you provided
> with HOME=$PWD and a minimal .gitconfig that only sets user.email. But
> valgrind is happy with both 2.8.0 and v2.8.2-402-gedec370 on my Linux box.

Interesting. It replicates out of the box for me. It looks like the
column pointer we are passing is bogus. If I instrument git like this:

diff --git a/graph.c b/graph.c
index 1350bdd..62a5810 100644
--- a/graph.c
+++ b/graph.c
@@ -76,6 +76,7 @@ static const char *column_get_color_code(unsigned short color)
 static void strbuf_write_column(struct strbuf *sb, const struct column *c,
 				char col_char)
 {
+	warning("c=%p, c->color = %d, max=%d", c, c->color, column_colors_max);
 	if (c->color < column_colors_max)
 		strbuf_addstr(sb, column_get_color_code(c->color));
 	strbuf_addch(sb, col_char);
@@ -390,6 +391,9 @@ static void graph_insert_into_new_columns(struct git_graph *graph,
 	 */
 	graph->new_columns[graph->num_new_columns].commit = commit;
 	graph->new_columns[graph->num_new_columns].color = graph_find_commit_color(graph, commit);
+	warning("assigned %p, %d",
+		&graph->new_columns[graph->num_new_columns],
+		graph->new_columns[graph->num_new_columns].color);
 	graph->mapping[*mapping_index] = graph->num_new_columns;
 	*mapping_index += 2;
 	graph->num_new_columns++;

Then I get this output:

    warning: assigned 0x20d21d0, 12
    * 163b784 (c) c
    warning: assigned 0x20d8f90, 12
    warning: assigned 0x20d8fa0, 12
    warning: assigned 0x20d8fb0, 12
    warning: c=0x20d21d0, c->color = 12, max=12
    warning: c=0x20d8fc0, c->color = 0, max=12
    warning: c=0x20d8fc0, c->color = 0, max=12
    | *-.   a9a6975 (HEAD -> m) merge a b

Note that we set up f90, fa0, and fb0, but then pass fc0 into
strbuf_write_column (and it has bogus color values). It looks like we're
reading one past the end of our array, but I haven't figured out where
or why.

-Peff
