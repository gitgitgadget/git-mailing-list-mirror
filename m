X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Fast access git-rev-list output: some OS knowledge required
Date: Thu, 7 Dec 2006 17:01:54 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612071649590.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <e5bfff550612061124jcd0d94em47793710866776e7@mail.gmail.com>
 <20061206192800.GC20320@spearce.org> <e5bfff550612061134r3725dcbu2ff2dd6284fcd651@mail.gmail.com>
 <20061206194258.GD20320@spearce.org> <20061206195142.GE20320@spearce.org>
 <45781639.1050208@op5.se> <Pine.LNX.4.63.0612071553090.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <4578330C.9070208@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 7 Dec 2006 16:02:07 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>,
	Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <4578330C.9070208@op5.se>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33597>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsLhC-0004Qf-Js for gcvg-git@gmane.org; Thu, 07 Dec
 2006 17:02:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1032341AbWLGQB6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 11:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032350AbWLGQB6
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 11:01:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:38170 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1032341AbWLGQB5
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006 11:01:57 -0500
Received: (qmail invoked by alias); 07 Dec 2006 16:01:55 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp041) with SMTP; 07 Dec 2006 17:01:55 +0100
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 7 Dec 2006, Andreas Ericsson wrote:

> Johannes Schindelin wrote:
> > Hi,
> > 
> > On Thu, 7 Dec 2006, Andreas Ericsson wrote:
> > 
> > > Shawn Pearce wrote:
> > > > Perhaps there is some fast IPC API supported by Qt that you could use to
> > > > run the revision listing outside of the main UI process, to eliminate
> > > > the bottlenecks you are seeing and remove the problems noted above?  One
> > > > that doesn't involve reading from a pipe I mean...
> > > > 
> > > Why not just fork() + exec() and read from the filedescriptor? You can up
> > > the output buffer of the forked program to something suitable, which means
> > > the OS will cache it for you until you copy it to a buffer in qgit (i.e.,
> > > read from the descriptor).
> > 
> > Could somebody remind me why different processes are needed? I thought that
> > the revision machinery should be used directly, by linking to libgit.a...
> > 
> 
> You wrote:
> --%<--%<--%<--
> Because, depending on what you do, the revision machinery is not
> reentrable. For example, if you filter by filename, the history is
> rewritten in-memory to simulate a history where just that filename was
> tracked, and nothing else. These changes are not cleaned up after calling the
> internal revision machinery.
> --%<--%<--%<--
> 
> When I wrote the above suggestion, I hadn't read the posts following the 
> email where I cut this text from (where Linus said "we can add a 'reset' 
> thingie to the revision walking machinery" and Marco replied with some 
> more questions).

Yes. The reset thingie is already in place: clear_commit_marks(). It would 
have to be enhanced a little, though:

1) the function rewrite_parents(), should add another flag, HALFORPHANED, 
   and
2) clear_commit_marks() should unset the "parsed" flag of the commits for 
   which HALFORPHANED is reset.

-- snip --
diff --git a/commit.c b/commit.c
index d5103cd..fd225c8 100644
--- a/commit.c
+++ b/commit.c
@@ -431,6 +431,10 @@ void clear_commit_marks(struct commit *commit, unsigned int mark)
 {
 	struct commit_list *parents;
 
+	/* were parents rewritten? */
+	if ((mark & commit->object.flags) & HALFORPHANED)
+		commit->object.parsed = 0;
+
 	commit->object.flags &= ~mark;
 	parents = commit->parents;
 	while (parents) {
diff --git a/revision.c b/revision.c
index 993bb66..461ee06 100644
--- a/revision.c
+++ b/revision.c
@@ -1097,6 +1097,7 @@ static void rewrite_parents(struct rev_info *revs, struct commit *commit)
 		struct commit_list *parent = *pp;
 		if (rewrite_one(revs, &parent->item) < 0) {
 			*pp = parent->next;
+			commit->object.flags |= HALFORPHANED;
 			continue;
 		}
 		pp = &parent->next;
diff --git a/revision.h b/revision.h
index 3adab95..544238c 100644
--- a/revision.h
+++ b/revision.h
@@ -9,6 +9,7 @@
 #define BOUNDARY	(1u<<5)
 #define BOUNDARY_SHOW	(1u<<6)
 #define ADDED		(1u<<7)	/* Parents already parsed and added? */
+#define HALFORPHANED	(1u<<8) /* parents were rewritten */
 
 struct rev_info;
 struct log_info;
-- snap --

Note that this is just the idea. This particular implementation opens a 
gaping memory leak, since the buffer of the commit is not free()d, and a 
reparse would probably not pick up on the fact that the parent commits are 
already in memory.

Ciao,
Dscho
