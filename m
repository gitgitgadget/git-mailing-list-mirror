From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 7/9] remote.c: teach branch_get() to treat symrefs other than HEAD
Date: Thu,  2 May 2013 19:09:32 +0530
Message-ID: <1367501974-6879-8-git-send-email-artagnon@gmail.com>
References: <1367501974-6879-1-git-send-email-artagnon@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 02 15:38:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXtiS-0002D0-6r
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 15:38:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759617Ab3EBNiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 09:38:22 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:62971 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611Ab3EBNiT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 09:38:19 -0400
Received: by mail-pd0-f182.google.com with SMTP id 3so362670pdj.13
        for <git@vger.kernel.org>; Thu, 02 May 2013 06:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=L8BMQzu0FcremJqNqzFzeC0MXZyge7wQC+FRTAq367M=;
        b=Hu7uqWOR7Yxe7sJPXIwf0+/i/7HY8XAvhzn2xkz9Z2BRJyXDzn/74XEPJwXlT8N+Zw
         hix7vjyonbXRAyHyR/q2mqXaYyM09u/oi1f5ccaO0s+zsQZCSQkxYYT8dZ+GtQoGuea9
         f6bOXMxN7dYDCg0/3GGGWQ4eI0ntHDf0++ay8+muwhloQG+EPwiqZxNHY1xJYdkmSXut
         Zd13K2Kq06lLlyrlpKz9x4KC2TcNksesDHtjc4usbvM+GiF9yjVBlD/UCIPZS/x9UqtX
         o0JRTXo6G6KP9DYxM88bupu4GtQFnm8IHUB+FjO0u2wzgdEeOzJ6IUMNLZUSBFqNxtt6
         Maiw==
X-Received: by 10.68.129.10 with SMTP id ns10mr7392856pbb.13.1367501898866;
        Thu, 02 May 2013 06:38:18 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id wi6sm7392889pbc.22.2013.05.02.06.38.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 May 2013 06:38:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.40.g09a0447
In-Reply-To: <1367501974-6879-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223202>

Broadly, there are two ways to resolve a command-line argument.  The
first approach is to treat it as a revision and resolve it using the
revision-parsing mechanism get_sha1().  The other approach is to treat
it as a ref, and use a reduced mechanism like branch_get().

Compare and contrast the implementations of @{N} and @{u} in
sha1_name.c to see where exactly branch_get() is useful:

In <...>@{N}, the <...> is passed through dwim_log() which first calls
substitute_branch_name() and then resolve_ref_unsafe() on that.  The
resolved ref could be any ref (symbolic/ non-symbolic), and not just a
refs/heads/* ref (branch).

However, in the <...>@{u} case, the <...> can only be a ref/heads/*
ref or a symbolic ref pointing to a refs/heads/* ref.  It uses
branch_get() to find the relevant ref.

Unfortunately, branch_get() doesn't call resolve_ref_unsafe() on what
is passed to it at all.  Instead it hard-codes the special four-letter
word "HEAD" (which is resolved by read_config() which is called
first), and rejects any other symbolic ref.  This is a historical
mistake because of which some callers of branch_get() suffer.  To put
it another way, the commands that accept "HEAD" (and resolve it into a
branch) can benefit from accepting any other symbolic ref that
resolves to a branch.  For example, the following fail:

    $ git symbolic-ref M refs/heads/master
    $ git show M@{u}
    $ git branch -u ram/master M

This patch fixes branch_get() directly, making these work.

Notice that branch_get() calls read_config(), which in turn
preemptively calls resolve_ref_unsafe() on "HEAD", when the caller
might not even be requesting the current branch.  After copying out
two critical tasks that are required for make_remote() to work
properly:

    git_config(handle_config, NULL);
    alias_all_urls();

we can remove read_config() and call resolve_ref_unsafe() on the
argument that is passed ourselves.  HEAD is therefore not a special
case anymore.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 remote.c                   | 23 ++++++++++++++++++++---
 t/t1508-at-combinations.sh |  2 +-
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/remote.c b/remote.c
index 68eb99b..3ac302f 100644
--- a/remote.c
+++ b/remote.c
@@ -1463,13 +1463,30 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 
 struct branch *branch_get(const char *name)
 {
-	struct branch *ret;
+	struct branch *ret = NULL;
+
+	/* Setup */
+	git_config(handle_config, NULL);
+	alias_all_urls();
 
-	read_config();
 	if (!name || !*name || !strcmp(name, "HEAD"))
-		ret = current_branch;
+		name = "HEAD";
 	else
 		ret = make_branch(name, 0);
+
+	if (!ret || !ret->remote_name) {
+		/* Is this a symbolic-ref like HEAD, pointing to a
+		 * valid branch?
+		 */
+		const char *this_ref;
+		unsigned char sha1[20];
+		int flag;
+
+		this_ref = resolve_ref_unsafe(name, sha1, 0, &flag);
+		if (this_ref && (flag & REF_ISSYMREF) &&
+			!prefixcmp(this_ref, "refs/heads/"))
+			ret = make_branch(this_ref + strlen("refs/heads/"), 0);
+	}
 	if (ret && ret->remote_name) {
 		ret->remote = remote_get(ret->remote_name);
 		if (ret->merge_nr) {
diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index bb86c79..424caf5 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -63,7 +63,7 @@ nonsense "@{-1}@{-1}"
 git symbolic-ref H HEAD
 check "H@{1}" commit new-one
 check "H@{now}" commit new-two
-check "H@{u}" ref refs/heads/upstream-branch failure
+check "H@{u}" refs/heads/upstream-branch
 
 # To make sure that the @-parser isn't buggy, check things with the
 # symbolic-ref @
-- 
1.8.3.rc0.40.g09a0447
