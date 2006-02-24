From: Junio C Hamano <junkio@cox.net>
Subject: Re: FYI: git-am allows creation of empty commits.
Date: Fri, 24 Feb 2006 04:04:43 -0800
Message-ID: <7vy8019d44.fsf@assigned-by-dhcp.cox.net>
References: <m1slqahyxt.fsf@ebiederm.dsl.xmission.com>
	<7v1wxtgv02.fsf@assigned-by-dhcp.cox.net>
	<m18xs1dmp3.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 13:04:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCbgn-0008HK-Gy
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 13:04:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWBXMEq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 07:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWBXMEq
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 07:04:46 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:17905 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932099AbWBXMEp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 07:04:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060224120449.FUYI25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 24 Feb 2006 07:04:49 -0500
To: ebiederm@xmission.com (Eric W. Biederman)
In-Reply-To: <m18xs1dmp3.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
	message of "Fri, 24 Feb 2006 04:24:08 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16697>

ebiederm@xmission.com (Eric W. Biederman) writes:

> Is this something that we always want to test for in the porcelain
> or do we want to move a check into git-commit-tree?
>
> For getting a reasonable error message where you have the test
> seems to be the only sane place, but having the check deeper
> down would be more likely to catch this kind of thing.

I think 99.9% of the time it is a mistake if a single-parented
commit has the same tree as its parent commit has, so having a
check in commit-tree may not be a bad idea.

If you want to do it, however, you need to be a bit careful
about merges.  In a multi-parented commit, it is legitimate if
the merge result exactly match one of the parents (in fact
"git-merge -s ours" can be used to create a merge that matches
its first parent).

The commit-tree program is one of the oldest part of the system,
and as a mechanism, does not set nor enforce policies like this.
It has been more liberal than the best current practice, such as
(1) don't do single-parent empty commit; (2) don't list the same
parent twice.  The second one was introduced in mid-June last
year, which is "long after it was invented" in git timescale.

On the other hand, it is more anal than it could be.  It does
not take a tag that points to a commit to its -p parameter.
That's because we did not have tag objects in the beginning, and
by the time tags were introduced, nobody ran commit-tree by hand
anymore.

-- >8 --
[PATCH] commit-tree: disallow an empty single-parent commit.

Also allow "git-commit-tree -p v2.6.16-rc2", instead of having
to say "git-commit-tree -p v2.6.16-rc2^0".

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/commit-tree.c b/commit-tree.c
index 88871b0..14a7552 100644
--- a/commit-tree.c
+++ b/commit-tree.c
@@ -45,12 +45,14 @@ static void check_valid(unsigned char *s
 {
 	void *buf;
 	char type[20];
+	unsigned char real_sha1[20];
 	unsigned long size;
 
-	buf = read_sha1_file(sha1, type, &size);
-	if (!buf || strcmp(type, expect))
+	buf = read_object_with_reference(sha1, expect, &size, real_sha1);
+	if (!buf)
 		die("%s is not a valid '%s' object", sha1_to_hex(sha1), expect);
 	free(buf);
+	memcpy(sha1, real_sha1, 20);
 }
 
 /*
@@ -75,6 +77,19 @@ static int new_parent(int idx)
 	return 1;
 }
 
+static int check_empty_commit(const unsigned char *tree_sha1,
+			      const unsigned char *parent_sha1)
+{
+	unsigned char sha1[20];
+	char refit[50];
+	sprintf(refit, "%s^{tree}", sha1_to_hex(parent_sha1));
+	if (get_sha1(refit, sha1))
+		die("cannot determine tree in parent commit.");
+	if (!memcmp(sha1, tree_sha1, 20))
+		return error ("empty commit?  aborting.");
+	return 0;
+}
+
 int main(int argc, char **argv)
 {
 	int i;
@@ -105,6 +120,9 @@ int main(int argc, char **argv)
 	}
 	if (!parents)
 		fprintf(stderr, "Committing initial tree %s\n", argv[1]);
+	if (parents == 1)
+		if (check_empty_commit(tree_sha1, parent_sha1[0]))
+			exit(1);
 
 	init_buffer(&buffer, &size);
 	add_buffer(&buffer, &size, "tree %s\n", sha1_to_hex(tree_sha1));
