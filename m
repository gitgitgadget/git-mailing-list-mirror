From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Introduce filter_independent() in commit.c
Date: Sat, 21 Jun 2008 02:23:04 +0200
Message-ID: <1214007784-4801-1-git-send-email-vmiklos@frugalware.org>
References: <7vabhgq02p.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 21 02:24:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9qtw-0007Tc-Fg
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 02:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021AbYFUAXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 20:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752385AbYFUAXY
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 20:23:24 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:56292 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719AbYFUAXX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 20:23:23 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id 389161DDC5B;
	Sat, 21 Jun 2008 02:23:16 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 747DC18E0E5; Sat, 21 Jun 2008 02:23:04 +0200 (CEST)
X-Mailer: git-send-email 1.5.6
In-Reply-To: <7vabhgq02p.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85682>

This is similar to git-show-branch --independent: It filters out commits
which are reachable from any other item from the input list.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Thu, Jun 19, 2008 at 08:03:58PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> > +   for (i = heads; i; i = i->next)
> > +           if (!(i->item->object.flags & RESULT))
> > +                   pptr = &commit_list_insert(i->item, pptr)->next;
>
> Hmm.  How well was this function tested?

As Dscho pointed out in an other mail there was no testcase for it, I
wrote one and it pointed out what you said: it was buggy.

> Because RESULT is an implementation detail of merge_bases(), I do not
> think we would want to expose it outside of it.

The new version does not have this problem, either.

> More worryingly, the flag is supposed to be cleaned from the objects
> after get_merge_bases() returns.  I am not sure what you'll learn by
> looking at the flag here.

Yes, you are right. In fact the idea to use get_octopus_merge_bases()
was wrong, since it does not do what we need.

Here is an example:

	A - B
	  \ C
	  \ D
	  \ E - F

In this case get_octopus_merge_bases() will return only A, which is what
it should do, but we need E in filter_indepenent() as well.

Below is what I pushed to my working branch.

This version now passes the test that was failed for the previous one.

 commit.c |   32 ++++++++++++++++++++++++++++++++
 commit.h |    1 +
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/commit.c b/commit.c
index 6052ca3..17e18d7 100644
--- a/commit.c
+++ b/commit.c
@@ -705,3 +705,35 @@ int in_merge_bases(struct commit *commit, struct commit **reference, int num)
 	free_commit_list(bases);
 	return ret;
 }
+
+struct commit_list *filter_independent(unsigned char *head,
+	struct commit_list *heads)
+{
+	struct commit_list *b, *i, *j, *k, *bases = NULL, *ret = NULL;
+	struct commit_list **pptr = &ret;
+
+	commit_list_insert(lookup_commit(head), &heads);
+
+	for (i = heads; i; i = i->next) {
+		for (j = heads; j; j = j->next) {
+			if (i == j)
+				continue;
+			b = get_merge_bases(i->item, j->item, 1);
+			for (k = b; k; k = k->next)
+				commit_list_insert(k->item, &bases);
+		}
+	}
+
+	for (i = heads; i; i = i->next) {
+		int found = 0;
+		for (b = bases; b; b = b->next) {
+			if (!hashcmp(i->item->object.sha1, b->item->object.sha1)) {
+				found = 1;
+				break;
+			}
+		}
+		if (!found)
+			pptr = &commit_list_insert(i->item, pptr)->next;
+	}
+	return ret;
+}
diff --git a/commit.h b/commit.h
index dcec7fb..0aef7e4 100644
--- a/commit.h
+++ b/commit.h
@@ -131,6 +131,7 @@ extern struct commit_list *get_shallow_commits(struct object_array *heads,
 		int depth, int shallow_flag, int not_shallow_flag);
 
 int in_merge_bases(struct commit *, struct commit **, int);
+struct commit_list *filter_independent(unsigned char *head, struct commit_list *heads);
 
 extern int interactive_add(int argc, const char **argv, const char *prefix);
 extern int rerere(void);
-- 
1.5.6
