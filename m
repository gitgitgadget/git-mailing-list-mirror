From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] graph: output padding for merge subsequent parents
Date: Wed, 6 Feb 2013 19:57:02 +0000
Message-ID: <20130206195702.GA1342@serenity.lan>
References: <201302051700.r15H0GXx031004@freeze.ariadne.com>
 <7vtxpqslpm.fsf@alter.siamese.dyndns.org>
 <vpqmwvia2n7.fsf@grenoble-inp.fr>
 <201302061503.r16F30UA016375@freeze.ariadne.com>
 <20130206151447.GZ1342@serenity.lan>
 <vpqbobxwavv.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Dale R. Worley" <worley@alum.mit.edu>, gitster@pobox.com,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 06 20:57:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3B7k-0005Uj-2a
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 20:57:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758502Ab3BFT5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 14:57:16 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:33874 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758277Ab3BFT5M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 14:57:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 49B3ECDA59C;
	Wed,  6 Feb 2013 19:57:11 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6kWQZaV2ENKq; Wed,  6 Feb 2013 19:57:10 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id EAB29CDA580;
	Wed,  6 Feb 2013 19:57:04 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <vpqbobxwavv.fsf@grenoble-inp.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215630>

On Wed, Feb 06, 2013 at 07:33:08PM +0100, Matthieu Moy wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > I would argue that the line should start with "| | ", since it really is
> > just a continuation of the same commit.
> >
> > | | 
> > | | commit a393ed598e9fb11436f85bd58f1a38c82f2cadb7 (from 33e70e70c0173d634826b998bdc304f93c0966b8)
> > | | Merge: 2c1e6a3 33e70e7
> > | | Author: Matthieu Moy <Matthieu.Moy@imag.fr>
> > | | Date:   Tue Feb 5 22:05:33 2013 +0100
> 
> Yes.
> 
> I had a look at the code, I guess the call to graph_show_commit() in
> show_log() (in log-tree.c) should have called graph_show_padding() but
> didn't in this case. Then I got lost in graph.c :-(.

I think this is the correct answer.  But now I've found that "git log
--graph -c -p" doesn't indent the diff - that seems to be a separate
issue.

-- >8 --

When showing merges in git-log, the same commit is shown once for each
parent.  Combined with "--graph" this results in graph_show_commit()
being called once for each parent without graph_update() being called.

Currently graph_show_commit() does not print anything on subsequent
invocations for the same commit (this was changed by commit 656197a -
"graph.c: infinite loop in git whatchanged --graph -m" from the previous
behaviour of looping infinitely).

Change this so that if the graph code believes it has already shown the
commit it prints a single padding line.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 graph.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/graph.c b/graph.c
index 391a712..2a3fc5c 100644
--- a/graph.c
+++ b/graph.c
@@ -1227,6 +1227,16 @@ void graph_show_commit(struct git_graph *graph)
 	if (!graph)
 		return;
 
+	/*
+	 * When showing a diff of a merge against each of its parents, we
+	 * are called once for each parent without graph_update having been
+	 * called.  In this case, simply output a single padding line.
+	 */
+	if (graph_is_commit_finished(graph)) {
+		graph_show_padding(graph);
+		shown_commit_line = 1;
+	}
+
 	while (!shown_commit_line && !graph_is_commit_finished(graph)) {
 		shown_commit_line = graph_next_line(graph, &msgbuf);
 		fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
-- 
1.8.1.2
