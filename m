From: "Nathan W. Panike" <nathan.panike@gmail.com>
Subject: [PATCH/RFC] Add a --bouquet option to git rev-list
Date: Mon, 30 Nov 2009 14:55:14 -0600
Message-ID: <4b143a9c.c401be0a.364f.ffffba5b@mx.google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 30 22:35:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFDuC-0002Ha-C9
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 22:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447AbZK3VfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 16:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753398AbZK3VfT
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 16:35:19 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:48373 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075AbZK3VfS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 16:35:18 -0500
Received: by ywh12 with SMTP id 12so4426966ywh.21
        for <git@vger.kernel.org>; Mon, 30 Nov 2009 13:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:date
         :subject;
        bh=HG8uBnbYiebFIMYFRD11H2uPh5eeFqh1LeM9ZCJciNA=;
        b=mv6Qs54dAxRkkH5lptw2xkoNEBfMGR8uMYW5Hh9+LloQS2KLgTfTSaECkhD7mXLTCq
         gRvI3Mel3O7uguvQaruqZYKJXZgH7R+phZQbwrML8R2p8Qwbh5wyzj62/cdyBbm/hDYQ
         u4hkdlE5bZY2OzL7I++k+vG/fXLmC+iYtrWYg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:date:subject;
        b=oqgxSrdTZFpKY0Rn0DL8J/ljZXSl/x4Jg2RBoiotth3rRIMB80dnpKbdSVYnID7sof
         3aRjby4N5mMXATiAxcVf7kAAYKdAYyS/yaEMLIYGops9gu3YYdnVA3FstA1yI2aVc48q
         Lxx7Zhgs+/u0Z2o4G2byxT764RjufLlgajXiU=
Received: by 10.101.88.12 with SMTP id q12mr2160120anl.76.1259616924861;
        Mon, 30 Nov 2009 13:35:24 -0800 (PST)
Received: from localhost ([144.92.149.206])
        by mx.google.com with ESMTPS id 4sm2215495yxd.52.2009.11.30.13.35.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Nov 2009 13:35:24 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134143>

Add a command line option to rev-list so the command 'git rev-list --bouquet'
shows all revisions that are ancestors of refs which share history with HEAD.

Signed-off-by: Nathan W. Panike <nathan.panike@gmail.com>
---
I have a repository with the following structure:

      B
     /
A'--A--C
     \
      D

E'--E

Thus the command 'git merge base E A' returns nothing, as there is no common
history.  The E history contains stuff that is derived from the other history
(A, B, C, or D).  Often I find myself doing the following:

git checkout C
gitk $(include_forks) &
<View history, make changes, merges, et cetera>
git checkout E
<go back to gitk, only see history for B, C, etc>

Now the 'include_forks' command is a bash function in my .bashrc:

include_forks () 
{ 
    local head="$(git show -s --pretty=format:'%H' HEAD)";
    echo "HEAD $(git for-each-ref --format='%(refname)' \
	refs/heads refs/remotes | while read ref; do \
	if test "$(git merge-base HEAD ${ref}^{commit})" != ""; \
		then echo ${ref}; fi; done)"
}

The shell thus intercepts my command and I must restart gitk to see the history
of E. 

With this patch, I can issue the command 'gitk --bouquet' and when I checkout
E, I can 'reload' in gitk and see the history of E automatically.

If there is an easier way to do this in git, please let me know.  Otherwise,
please let me know how to improve this patch.

 revision.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index a8a3c3a..ba367cc 100644
--- a/revision.c
+++ b/revision.c
@@ -699,6 +699,31 @@ static int handle_one_ref(const char *path, const unsigned char *sha1, int flag,
 	return 0;
 }
 
+static int handle_one_connected_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+{
+	struct all_refs_cb *cb = cb_data;
+	struct object *object = get_reference(cb->all_revs, path, sha1,
+					      cb->all_flags);
+	struct commit *r;
+	static int got_head = 1;
+	static struct commit *head_commit;
+	static int head_nr = 0;
+	if(got_head) {
+		got_head=head_ref(handle_one_ref,cb);
+		if(got_head)
+			return 1;
+		if(cb && cb->all_revs && cb->all_revs->pending.nr > 0) {
+			head_nr = cb->all_revs->pending.nr - 1;
+			head_commit = (struct commit*)&cb->all_revs->pending.objects->item[head_nr];
+		}
+	}
+	r = lookup_commit_reference_gently(sha1,1);
+	if(r != NULL && head_commit)
+		if(get_merge_bases_many(head_commit,1,&r,1)) 
+			add_pending_object(cb->all_revs, object, path);
+	return 0;
+}
+
 static void handle_refs(struct rev_info *revs, unsigned flags,
 		int (*for_each)(each_ref_fn, void *))
 {
@@ -708,6 +733,15 @@ static void handle_refs(struct rev_info *revs, unsigned flags,
 	for_each(handle_one_ref, &cb);
 }
 
+static void handle_connected_refs(struct rev_info *revs, unsigned flags,
+		int (*for_each)(each_ref_fn, void *))
+{
+	struct all_refs_cb cb;
+	cb.all_revs = revs;
+	cb.all_flags = flags;
+	for_each(handle_one_connected_ref, &cb);
+}
+
 static void handle_one_reflog_commit(unsigned char *sha1, void *cb_data)
 {
 	struct all_refs_cb *cb = cb_data;
@@ -1352,6 +1386,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				handle_refs(revs, flags, for_each_remote_ref);
 				continue;
 			}
+			if (!strcmp(arg, "--bouquet")) {
+				handle_connected_refs(revs, flags, for_each_ref);
+				continue;
+			}
 			if (!strcmp(arg, "--reflog")) {
 				handle_reflog(revs, flags);
 				continue;
-- 
1.6.5.3
