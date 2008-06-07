From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Introduce get_octopus_merge_bases() in commit.c
Date: Sat,  7 Jun 2008 23:38:40 +0200
Message-ID: <1212874720-22324-1-git-send-email-vmiklos@frugalware.org>
References: <7vmylzw1l4.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 23:39:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K568U-0005ZI-5r
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 23:39:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757307AbYFGVin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 17:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757384AbYFGVin
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 17:38:43 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:48722 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757307AbYFGVik (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 17:38:40 -0400
Received: from vmobile.example.net (dsl5401CF9A.pool.t-online.hu [84.1.207.154])
	by yugo.frugalware.org (Postfix) with ESMTP id 677591DDC5B;
	Sat,  7 Jun 2008 23:38:38 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 259E118E2A7; Sat,  7 Jun 2008 23:38:40 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc0.dirty
In-Reply-To: <7vmylzw1l4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84229>

This is like get_merge_bases() but it works for multiple heads.
Internally it uses merge_bases_many() but it has the ability to clear
commit marks like get_merge_bases().

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Thu, Jun 05, 2008 at 10:53:59PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Something like this might be enough to get us started.  Instead of
> finding
> out the merge bases between two commits, "one" and "two", this would
> find
> merge base between "one" and a commit that would be a merge across all
> the
> "two"s.  To apply it to the above example, you would give "C" as
> "one",
> and "A" and "B" as "twos" to it, to compute "2".

Here is what I pushed to my working branch, on top of your patch.

BTW: How should I credit your patch? Add a Signed-off-by? If I make you
the author I don't know how send-email handles the situation.

Thanks.

 commit.c |   17 +++++++++++++++++
 commit.h |    1 +
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/commit.c b/commit.c
index 1dba717..685a144 100644
--- a/commit.c
+++ b/commit.c
@@ -618,6 +618,23 @@ static struct commit_list *merge_bases(struct commit *one, struct commit *two)
 	return merge_bases_many(one, 1, &two);
 }
 
+struct commit_list *get_octopus_merge_bases(struct commit_list *in, int cleanup)
+{
+	struct commit *head = in->item;
+	int n = 0;
+	struct commit **commits = xmalloc(n*sizeof(struct commit *));
+	struct commit_list *ret, *i;
+
+	for(i = in; i; i = i->next, n++)
+		commits[n] = i->item;
+	ret = merge_bases_many(head, n, commits);
+	free(commits);
+	if (cleanup)
+		for(i = in; i; i = i->next)
+			clear_commit_marks(i->item, all_flags);
+	return ret;
+}
+
 struct commit_list *get_merge_bases(struct commit *one,
 					struct commit *two, int cleanup)
 {
diff --git a/commit.h b/commit.h
index 7f8c5ee..ca858ed 100644
--- a/commit.h
+++ b/commit.h
@@ -121,6 +121,7 @@ int read_graft_file(const char *graft_file);
 struct commit_graft *lookup_commit_graft(const unsigned char *sha1);
 
 extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2, int cleanup);
+extern struct commit_list *get_octopus_merge_bases(struct commit_list *in, int cleanup);
 
 extern int register_shallow(const unsigned char *sha1);
 extern int unregister_shallow(const unsigned char *sha1);
-- 
1.5.6.rc0.dirty
