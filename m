From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Introduce get_octopus_merge_bases() in commit.c
Date: Thu, 12 Jun 2008 18:59:58 +0200
Message-ID: <1213289998-14410-1-git-send-email-vmiklos@frugalware.org>
References: <7vprqna5t6.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 19:00:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6qAQ-0006ke-JQ
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 19:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752269AbYFLQ76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 12:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752487AbYFLQ76
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 12:59:58 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:35423 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205AbYFLQ75 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 12:59:57 -0400
Received: from vmobile.example.net (catv-5062e651.catv.broadband.hu [80.98.230.81])
	by yugo.frugalware.org (Postfix) with ESMTP id AA8B51DDC5B;
	Thu, 12 Jun 2008 18:59:54 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id E547018DFDC; Thu, 12 Jun 2008 18:59:58 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc2.dirty
In-Reply-To: <7vprqna5t6.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84765>

This is like get_merge_bases() but it works for multiple heads, like
show-branch --merge-base.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Wed, Jun 11, 2008 at 04:51:49PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Why is passing "cleanup" through to get_merge_bases() safe, even when you
> are running it more than once?
>
> get_merge_bases() uses PARENT1, PARENT2 and other flags internally, and
> the information necessary to clean them efficiently (i.e. the set of
> commits that could be smudged with these flags due to its operation) is
> known only to it _after it finishes_.  You cannot even say "previous run
> did not clean things up, so please clean-up before starting this round"
> upfront.  That is why we have clean-up loops at the _end_ of the function
> after it finishes computing what it wants to return.
>
> The only reason clean-up is optional to the function is because there are
> one-shot callers such as "git merge-base" that do not want to pay penalty
> for cleaning up (the only time you do not have to tell it to clean up is
> when you know the invocation is the _last_ invocation of the function, iow
> there is no later invocation that will be harmed by leftover flags).

Yes, you have reason, cleanup in get_octopus_merge_bases() should not be
optional. Here is an updated patch that does not have this problem.

(Also available in my working branch where I fixed up 9/10 and 10/10 to
reflect this change.)

 commit.c |   27 +++++++++++++++++++++++++++
 commit.h |    1 +
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/commit.c b/commit.c
index bbf9c75..6052ca3 100644
--- a/commit.c
+++ b/commit.c
@@ -600,6 +600,33 @@ static struct commit_list *merge_bases(struct commit *one, struct commit *two)
 	return result;
 }
 
+struct commit_list *get_octopus_merge_bases(struct commit_list *in)
+{
+	struct commit_list *i, *j, *k, *ret = NULL;
+	struct commit_list **pptr = &ret;
+
+	for (i = in; i; i = i->next) {
+		if (!ret)
+			pptr = &commit_list_insert(i->item, pptr)->next;
+		else {
+			struct commit_list *new = NULL, *end = NULL;
+
+			for (j = ret; j; j = j->next) {
+				struct commit_list *bases;
+				bases = get_merge_bases(i->item, j->item, 1);
+				if (!new)
+					new = bases;
+				else
+					end->next = bases;
+				for (k = bases; k; k = k->next)
+					end = k;
+			}
+			ret = new;
+		}
+	}
+	return ret;
+}
+
 struct commit_list *get_merge_bases(struct commit *one,
 					struct commit *two, int cleanup)
 {
diff --git a/commit.h b/commit.h
index 7f8c5ee..dcec7fb 100644
--- a/commit.h
+++ b/commit.h
@@ -121,6 +121,7 @@ int read_graft_file(const char *graft_file);
 struct commit_graft *lookup_commit_graft(const unsigned char *sha1);
 
 extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2, int cleanup);
+extern struct commit_list *get_octopus_merge_bases(struct commit_list *in);
 
 extern int register_shallow(const unsigned char *sha1);
 extern int unregister_shallow(const unsigned char *sha1);
-- 
1.5.6.rc2.dirty
