From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Introduce get_octopus_merge_bases() in commit.c
Date: Tue, 10 Jun 2008 00:43:46 +0200
Message-ID: <1213051426-11530-1-git-send-email-vmiklos@frugalware.org>
References: <alpine.DEB.1.00.0806091458190.1783@racer>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 10 00:44:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5q6f-0006EG-Gj
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 00:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763663AbYFIWnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 18:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763013AbYFIWnt
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 18:43:49 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:54732 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761643AbYFIWnr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 18:43:47 -0400
Received: from vmobile.example.net (dsl5401C409.pool.t-online.hu [84.1.196.9])
	by yugo.frugalware.org (Postfix) with ESMTP id D23C41DDC5B;
	Tue, 10 Jun 2008 00:43:43 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id EB15E18DF8B; Tue, 10 Jun 2008 00:43:46 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc2.dirty
In-Reply-To: <alpine.DEB.1.00.0806091458190.1783@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84436>

This is like get_merge_bases() but it works for multiple heads.
Internally it uses merge_bases_many() but it has the ability to clear
commit marks like get_merge_bases().

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Mon, Jun 09, 2008 at 03:02:07PM +0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > +   int n = 0;
> > +   struct commit **commits = xmalloc(n*sizeof(struct commit *));
>
> Here, n will be 0 and therefore commits will be xmalloc(0), right?
>
> > +   struct commit_list *ret, *i;
> > +
> > +   for(i = in; i; i = i->next, n++)
> > +           commits[n] = i->item;
>
> And here, commits will never be realloc()ed.

Ouch, yes.

> > +   ret = merge_bases_many(head, n, commits);
>
> If merge_bases_many took a commit_list (yes, as I suggested to Junio),
> this transformation would not be necessary.
>
> IIRC nothing in merge_bases_many() needed a commit array.

Exactly. I modified merge_bases_many() to use a commit list.

> Oh, and whose responsibility is it to free "in"?  Caller or callee?
> (Because it is a non-const parameter, I would have expected the
> callee,
> but I think it makes more sense if the caller can do whatever she
> wants
> with the heads after calling octopus_merge_bases()).

The previous. I think using const would be a mistake since we do modify
the flags, but I still would prefer free the list in the caller, since
the list is still usable. That's exactly why the cleanup flag is there:
in case the non-empty objects flags would cause any problem later in the
caller.

 commit.c |   11 +++++++++++
 commit.h |    1 +
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/commit.c b/commit.c
index 033c1e8..f3ca099 100644
--- a/commit.c
+++ b/commit.c
@@ -615,6 +615,17 @@ static struct commit_list *merge_bases(struct commit *one, struct commit *two)
 	return merge_bases_many(one, list);
 }
 
+struct commit_list *get_octopus_merge_bases(struct commit_list *in, int cleanup)
+{
+	struct commit_list *ret, *i;
+
+	ret = merge_bases_many(in->item, in->next);
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
1.5.6.rc2.dirty
