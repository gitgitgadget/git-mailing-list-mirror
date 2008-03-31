From: Adam Simpkins <adam@adamsimpkins.net>
Subject: Re: [PATCH] Add new git-graph command
Date: Mon, 31 Mar 2008 11:47:38 -0700
Message-ID: <20080331184737.GA28412@adamsimpkins.net>
References: <20080330195840.GA8695@adamsimpkins.net> <200803312017.28354.tlikonen@iki.fi>
Reply-To: Adam Simpkins <adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Mon Mar 31 20:48:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgP3f-0007qu-7R
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 20:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757502AbYCaSrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 14:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757463AbYCaSrw
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 14:47:52 -0400
Received: from smtp182.iad.emailsrvr.com ([207.97.245.182]:35449 "EHLO
	smtp182.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757305AbYCaSrv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 14:47:51 -0400
Received: from relay8.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay8.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 2BC641B5A5C;
	Mon, 31 Mar 2008 14:47:45 -0400 (EDT)
Received: by relay8.relay.iad.mlsrvr.com (Authenticated sender: simpkins-AT-adamsimpkins.net) with ESMTP id C64711B5A4E;
	Mon, 31 Mar 2008 14:47:44 -0400 (EDT)
Received: by sleipnir.adamsimpkins.net (Postfix, from userid 1000)
	id 560DC14100B8; Mon, 31 Mar 2008 11:47:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200803312017.28354.tlikonen@iki.fi>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78597>

On Mon, Mar 31, 2008 at 08:17:28PM +0300, Teemu Likonen wrote:
> Adam Simpkins kirjoitti:
> 
> > Ultimately, it would probably be better to integrate this
> > functionality into git-log, instead of having it as a standalone
> > command.  For example, a new --graph option could be added to cause
> > the graph to be displayed alongside the existing git log output.
> > However, this would require tighter integration between the graphing
> > code and the log_tree.c and pretty.c code, which I'm not all that
> > familiar with.
> 
> I just want to say that I really like your 'git graph'. I would like to 
> see it integrated to 'git log', perhaps as 'git log --pretty=graph' 
> or 'git log --graph'.

Thanks!

I was thinking more about how to add it to 'git log', and it might not
be all that difficult.  Instead of providing the graphing
functionality as a standalone command, it could be wrapped up in the
following API:

  struct graph;
  void graph_update(struct graph *graph, struct commit *commit);
  void graph_next_line(struct graph *graph, struct strbuf *sb);
  bool graph_is_commit_finished(struct graph *graph);

While walking through the commit list, graph_update() should be called
once for each commit.  After graph_update() has been called,
graph_next_line() can then be called to format the next line of the
graph into the strbuf.  It should be called multiple times, until
graph_is_commit_finished() returns true.  Then graph_update() can be
called with the next commit.

If graph_next_line() is called when graph_is_commit_finished()
returns, it would simply format straight lines for each column.  For
example, if there were currently 3 columns, it would format "| | |".
This allows graph_next_line() to be used to vertically pad the graph.

This API would allow the 'git log' code to format each line of the
graph into a strbuf, and print it out in front of each line of normal
log output.  This way, it could work even with something like
"git log --graph --pretty=full".  The graph would be prefixed to the
normal output, and padded vertically for as long as necessary.

I'm just not sure how difficult it will be to change the log-tree.c
code to invoke graph_next_line() before each individual line of
output.  It certainly shouldn't be that difficult just to implement
'git log --pretty=graph', but it may be more complicated if we want to
make the graphing be a boolean option that can be enabled with any
--pretty format.

I might try coding it up next weekend.

-- 
Adam Simpkins
adam@adamsimpkins.net
