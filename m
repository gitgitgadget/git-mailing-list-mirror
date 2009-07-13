From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Make 'git show' more useful
Date: Mon, 13 Jul 2009 14:41:12 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907131425490.13838@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 13 23:42:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQTHa-00044v-8b
	for gcvg-git-2@gmane.org; Mon, 13 Jul 2009 23:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbZGMVlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2009 17:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932065AbZGMVlq
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 17:41:46 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44473 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756454AbZGMVlq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jul 2009 17:41:46 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6DLfCtu021732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 13 Jul 2009 14:41:14 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6DLfCaC026881;
	Mon, 13 Jul 2009 14:41:12 -0700
X-X-Sender: torvalds@localhost.localdomain
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.466 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123205>


For some reason, I ended up doing

	git show HEAD~5..

as an odd way of asking for a log. I realize I should just have used "git 
log", but at the same time it does make perfect conceptual sense. After 
all, you _could_ have done

	git show HEAD HEAD~1 HEAD~2 HEAD~3 HEAD~4

and saying "git show HEAD~5.." is pretty natural. It's not like "git show" 
only ever showed a single commit (or other object) before either! So 
conceptually, giving a commit range is a very sensible operation, even 
though you'd traditionally have used "git log" for that.

However, doing that currently results in an error

	fatal: object ranges do not make sense when not walking revisions

which admittedly _also_ makes perfect sense - from an internal git 
implementation standpoint in 'revision.c'.

However, I think that asking to show a range makes sense to a user, while 
saying "object ranges no not make sense when not walking revisions" only 
makes sense to a git developer.

So on the whole, of the two different "makes perfect sense" behaviors, I 
think I originally picked the wrong one. And quite frankly, I don't really 
see anybody actually _depending_ on that error case. So why not change it?

So rather than error out, just turn that non-walking error case into a 
"silently turn on walking" instead.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This is a total throw-away patch. I'm not going to re-send. Take it or 
not, I don't care, I spent more time writing this discussion than I did on 
the patch. I just happened to notice this behavior, and decided I probably 
would prefer this behavior. But it doesn't really matter in any kind of 
big picture.

And, admittedly, you can _already_ do this by just adding "--do-walk" 
whenever you specify a range. And equally admittedly, you can already 
confuse git by adding the "--no-walk" _after_ specifying the range, ie you 
can do this:

	git log HEAD~5.. --no-walk

and it will actually turn into a really odd way of saying "git show HEAD" 
(notice: _not_ "HEAD~5". HEAD). And even with this change you can do the 
reverse:

	git show HEAD~5.. --no-walk

it it will first implicitly turn off walking ("git show"), then it will 
implicitly turn it on again (the commit range triggers the code in this 
patch), and then _after_ it has seen the commit range it will explicitly 
turn off walking again.

In other words, regardless of this patch you can do crazy things. I really 
don't think anybody cares. This patch is not meant to disable crazy 
things, it's meant to enable a reasonably sane user behavior.

 revision.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/revision.c b/revision.c
index a31434b..9f5dac5 100644
--- a/revision.c
+++ b/revision.c
@@ -133,7 +133,7 @@ void mark_parents_uninteresting(struct commit *commit)
 static void add_pending_object_with_mode(struct rev_info *revs, struct object *obj, const char *name, unsigned mode)
 {
 	if (revs->no_walk && (obj->flags & UNINTERESTING))
-		die("object ranges do not make sense when not walking revisions");
+		revs->no_walk = 0;
 	if (revs->reflog_info && obj->type == OBJ_COMMIT &&
 			add_reflog_for_walk(revs->reflog_info,
 				(struct commit *)obj, name))
