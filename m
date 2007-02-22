From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-bundle: move objects and references by archive
Date: Thu, 22 Feb 2007 21:25:41 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702222119010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702220157130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xeqllxk.fsf@assigned-by-dhcp.cox.net> <7v4ppellev.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702221719030.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vr6sif1ox.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702222015040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vy7mqdklr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Mark Levedahl <mdl123@verizon.net>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 22 21:25:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKKVe-000137-FW
	for gcvg-git@gmane.org; Thu, 22 Feb 2007 21:25:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbXBVUZn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Feb 2007 15:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751847AbXBVUZn
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Feb 2007 15:25:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:45460 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751845AbXBVUZm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Feb 2007 15:25:42 -0500
Received: (qmail invoked by alias); 22 Feb 2007 20:25:41 -0000
X-Provags-ID: V01U2FsdGVkX1/rU/1LqDDrvyEZuwKOXNfzvXy/1xswLUxE4G/E1s
	gwnQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vy7mqdklr.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40380>

Hi,

On Thu, 22 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> The only worry I would have is if that exact number is too large
> >> that you cannot pass them sensibly in argv[].
> >
> > I thought there is only a limitation in bash?
> 
> I am sure kernel folks on the list would correct me, but my
> understanding is that is execve(2) limitation and you would get
> E2BIG.

Okay. So how about this (on top of my previous fixup):

-- snipsnap --
[PATCH] git-bundle: avoid fork() in verify_bundle()

We can use the revision walker easily for checking if the
prerequisites are met, instead of fork()ing off a rev-list,
which would list only the first unmet prerequisite.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-bundle.c |   75 ++++++++++++++++++++++++++++++++++-------------------
 1 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/builtin-bundle.c b/builtin-bundle.c
index 521bbda..4ac06f9 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -19,7 +19,7 @@ static const char bundle_signature[] = "# v2 git bundle\n";
 
 struct ref_list {
 	unsigned int nr, alloc;
-	struct {
+	struct ref_list_entry {
 		unsigned char sha1[20];
 		char *name;
 	} *list;
@@ -167,33 +167,54 @@ static int verify_bundle(struct bundle_header *header)
 	 * to be verbose about the errors
 	 */
 	struct ref_list *p = &header->prerequisites;
-	char **argv;
-	int pid, out, i, ret = 0;
-	char buffer[1024];
+	struct rev_info revs;
+	const char *argv[] = {NULL, "--all"};
+	struct object_array refs;
+	struct commit *commit;
+	int i, ret = 0, req_nr;
+	const char *message = "The bundle requires these lacking revs:";
 
-	argv = xmalloc((p->nr + 4) * sizeof(const char *));
-	argv[0] = "rev-list";
-	argv[1] = "--not";
-	argv[2] = "--all";
-	for (i = 0; i < p->nr; i++)
-		argv[i + 3] = xstrdup(sha1_to_hex(p->list[i].sha1));
-	argv[p->nr + 3] = NULL;
-	out = -1;
-	pid = fork_with_pipe((const char **)argv, NULL, &out);
-	if (pid < 0)
-		return error("Could not fork rev-list");
-	while (read_string(out, buffer, sizeof(buffer)) > 0)
-		; /* do nothing */
-	close(out);
-	for (i = 0; i < p->nr; i++)
-		free(argv[i + 3]);
-	free(argv);
-
-	while (waitpid(pid, &i, 0) < 0)
-		if (errno != EINTR)
-			return -1;
-	if (!ret && (!WIFEXITED(i) || WEXITSTATUS(i)))
-		return error("At least one prerequisite is lacking.");
+	init_revisions(&revs, NULL);
+	for (i = 0; i < p->nr; i++) {
+		struct ref_list_entry *e = p->list + i;
+		struct object *o = parse_object(e->sha1);
+		if (o) {
+			o->flags |= BOUNDARY_SHOW;
+			add_pending_object(&revs, o, e->name);
+			continue;
+		}
+		if (++ret == 1)
+			error(message);
+		error("%s %s", sha1_to_hex(e->sha1), e->name);
+	}
+	if (revs.pending.nr == 0)
+		return ret;
+	req_nr = revs.pending.nr;
+	setup_revisions(2, argv, &revs, NULL);
+
+	memset(&refs, 0, sizeof(struct object_array));
+	for (i = 0; i < revs.pending.nr; i++) {
+		struct object_array_entry *e = revs.pending.objects + i;
+		add_object_array(e->item, e->name, &refs);
+	}
+
+	prepare_revision_walk(&revs);
+
+	i = req_nr;
+	while (i && (commit = get_revision(&revs)))
+		if (commit->object.flags & BOUNDARY_SHOW)
+			i--;
+
+	for (i = 0; i < req_nr; i++)
+		if (!(refs.objects[i].item->flags & SHOWN)) {
+			if (++ret == 1)
+				error(message);
+			error("%s %s", sha1_to_hex(refs.objects[i].item->sha1),
+				refs.objects[i].name);
+		}
+
+	for (i = 0; i < refs.nr; i++)
+		clear_commit_marks((struct commit *)refs.objects[i].item, -1);
 
 	return ret;
 }
-- 
1.5.0.1.2214.gf22e-dirty
