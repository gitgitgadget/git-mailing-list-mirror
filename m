From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: name-rev does not show the shortest path
Date: Mon, 27 Aug 2007 12:18:13 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708271216330.28586@racer.site>
References: <20070823103817.GF6573@informatik.uni-freiburg.de>
 <Pine.LNX.4.64.0708241253050.8987@reaper.quantumfyre.co.uk>
 <20070824125230.GA12030@informatik.uni-freiburg.de>
 <Pine.LNX.4.64.0708241615040.7313@reaper.quantumfyre.co.uk>
 <7v6434eq9o.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0708251701150.16728@wbgn129.biozentrum.uni-wuerzburg.de>
 <20070826092323.GB30474@coredump.intra.peff.net>
 <Pine.LNX.4.64.0708261733400.16728@wbgn129.biozentrum.uni-wuerzburg.de>
 <20070827092422.GA20340@coredump.intra.peff.net> <Pine.LNX.4.64.0708271049000.28586@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 27 13:16:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPcZn-0003Ux-06
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 13:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754629AbXH0LQH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 07:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754585AbXH0LQG
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 07:16:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:60505 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754576AbXH0LQF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 07:16:05 -0400
Received: (qmail invoked by alias); 27 Aug 2007 11:16:02 -0000
Received: from ppp-82-135-74-69.dynamic.mnet-online.de (EHLO [192.168.1.4]) [82.135.74.69]
  by mail.gmx.net (mp044) with SMTP; 27 Aug 2007 13:16:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+yDg8EeQqyliLnaKfA7EngOXAD4EsVyWjEEonf0E
	uEAoRAilGWLxq5
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0708271049000.28586@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56815>

Hi,

On Mon, 27 Aug 2007, Johannes Schindelin wrote:

> On Mon, 27 Aug 2007, Jeff King wrote:
> 
> > On Sun, Aug 26, 2007 at 05:38:22PM +0200, Johannes Schindelin wrote:
> > 
> > > The old code _should_ have worked; it is more likely that your 
> > > different metric just hides the bug.  The old metric tried to favour 
> > > less merge traversals over more traversals, but at the same time, it 
> > > favoured smaller numbers over larger ones (but as you found out, only 
> > > in the last component).
> > 
> > Right, the problem is that we have effectively _thrown away_ the
> > "smaller numbers over larger ones" information for components other than
> > the last.
> 
> You're right.  I misremembered name-rev to use a fifo instead of stupid 
> recursion.
> 
> Will fix.

Seems that this is not really good (having a fifo):

-- snip --
 builtin-name-rev.c |  108 +++++++++++++++++++++++++++++++---------------------
 1 files changed, 65 insertions(+), 43 deletions(-)

diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index 61eba34..e42e436 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -11,19 +11,22 @@ static const char name_rev_usage[] =
 
 typedef struct rev_name {
 	const char *tip_name;
-	int merge_traversals;
 	int generation;
 } rev_name;
 
 static long cutoff = LONG_MAX;
 
+/* The parents of these refs are potentially unnamed */
+static struct commit_list *rev_queue, *rev_queue_end;
+
 static void name_rev(struct commit *commit,
-		const char *tip_name, int merge_traversals, int generation,
+		const char *tip_name, int generation,
 		int deref)
 {
 	struct rev_name *name = (struct rev_name *)commit->util;
-	struct commit_list *parents;
-	int parent_number = 1;
+
+	if (commit->util)
+		return;
 
 	if (!commit->object.parsed)
 		parse_commit(commit);
@@ -41,46 +44,20 @@ static void name_rev(struct commit *commit,
 			die("generation: %d, but deref?", generation);
 	}
 
-	if (name == NULL) {
-		name = xmalloc(sizeof(rev_name));
-		commit->util = name;
-		goto copy_data;
-	} else if (name->merge_traversals > merge_traversals ||
-			(name->merge_traversals == merge_traversals &&
-			 name->generation > generation)) {
-copy_data:
-		name->tip_name = tip_name;
-		name->merge_traversals = merge_traversals;
-		name->generation = generation;
-	} else
-		return;
-
-	for (parents = commit->parents;
-			parents;
-			parents = parents->next, parent_number++) {
-		if (parent_number > 1) {
-			int len = strlen(tip_name);
-			char *new_name = xmalloc(len +
-				1 + decimal_length(generation) +  /* ~<n> */
-				1 + 2 +				  /* ^NN */
-				1);
+	name = xmalloc(sizeof(rev_name));
+	commit->util = name;
+	name->tip_name = tip_name;
+	name->generation = generation;
 
-			if (len > 2 && !strcmp(tip_name + len - 2, "^0"))
-				len -= 2;
-			if (generation > 0)
-				sprintf(new_name, "%.*s~%d^%d", len, tip_name,
-						generation, parent_number);
-			else
-				sprintf(new_name, "%.*s^%d", len, tip_name,
-						parent_number);
+	if (rev_queue_end)
+		rev_queue_end = rev_queue_end->next =
+			xmalloc(sizeof(struct commit_list));
+	else
+		rev_queue = rev_queue_end =
+			xmalloc(sizeof(struct commit_list));
 
-			name_rev(parents->item, new_name,
-				merge_traversals + 1 , 0, 0);
-		} else {
-			name_rev(parents->item, tip_name, merge_traversals,
-				generation + 1, 0);
-		}
-	}
+	rev_queue_end->item = commit;
+	rev_queue_end->next = NULL;
 }
 
 struct name_ref_data {
@@ -120,11 +97,46 @@ static int name_ref(const char *path, const unsigned char *sha1, int flags, void
 		else if (!prefixcmp(path, "refs/"))
 			path = path + 5;
 
-		name_rev(commit, xstrdup(path), 0, 0, deref);
+		name_rev(commit, xstrdup(path), 0, deref);
 	}
 	return 0;
 }
 
+static void name_parents(struct commit *commit)
+{
+	struct rev_name *n = commit->util;
+	int parent_number = 1;
+	struct commit_list *parents;
+
+	if (!n)
+		die("Huh?");
+	for (parents = commit->parents;
+			parents;
+			parents = parents->next, parent_number++) {
+		if (parent_number > 1) {
+			int len = strlen(n->tip_name);
+			char *new_name = xmalloc(len +
+				1 + decimal_length(n->generation) +  /* ~<n> */
+				1 + 2 +				     /* ^NN */
+				1);
+
+			if (len > 2 && !strcmp(n->tip_name + len - 2, "^0"))
+				len -= 2;
+			if (n->generation > 0)
+				sprintf(new_name, "%.*s~%d^%d", len,
+						n->tip_name, n->generation,
+						parent_number);
+			else
+				sprintf(new_name, "%.*s^%d", len,
+						n->tip_name, parent_number);
+
+			name_rev(parents->item, new_name, 0, 0);
+		} else
+			name_rev(parents->item, n->tip_name,
+					n->generation + 1, 0);
+	}
+}
+
 /* returns a static buffer */
 static const char* get_rev_name(struct object *o)
 {
@@ -135,6 +147,16 @@ static const char* get_rev_name(struct object *o)
 	if (o->type != OBJ_COMMIT)
 		return "undefined";
 	c = (struct commit *) o;
+	while (c->util == NULL) {
+		struct commit_list *current = rev_queue;
+
+		name_parents(current->item);
+		rev_queue = current->next;
+		if (!rev_queue)
+			rev_queue_end = NULL;
+		free(current);
+	}
+
 	n = c->util;
 	if (!n)
 		return "undefined";
-- snap --

It outputs this:

git name-rev --tags 0567a0c022d5b343370a343121f38fd89925de55
0567a0c[...] tags/v2.6.22-rc1~1^2^2^2~11^2~13^2~8^2~1^3~5

Not really nice.

Ciao,
Dscho
