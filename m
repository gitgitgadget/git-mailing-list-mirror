From: Junio C Hamano <junkio@cox.net>
Subject: Re: git fsck and new repos / backup repos
Date: Wed, 11 Apr 2007 01:25:43 -0700
Message-ID: <7vr6qrpbaw.fsf@assigned-by-dhcp.cox.net>
References: <loom.20070410T200901-466@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergio Callegari <scallegari@arces.unibo.it>
X-From: git-owner@vger.kernel.org Wed Apr 11 15:00:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbY9F-0002eE-DN
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 10:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbXDKIZp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 04:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbXDKIZp
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 04:25:45 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:41012 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbXDKIZo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 04:25:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070411082543.VCDQ1235.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 11 Apr 2007 04:25:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id lkRj1W00N1kojtg0000000; Wed, 11 Apr 2007 04:25:44 -0400
In-Reply-To: <loom.20070410T200901-466@post.gmane.org> (Sergio Callegari's
	message of "Tue, 10 Apr 2007 18:27:05 +0000 (UTC)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44216>

Sergio Callegari <scallegari@arces.unibo.it> writes:

> Hi, 
> just posting a very very minor thing, that anyway might be easy to improve...
>
> consider the following cases:
>
> 1) Empty repo
>
> mkdir Foo
> cd Foo
> git --bare init
> git --bare fsck
>
> error: HEAD is not a symbolic ref
> error: No default references
>
> Should this be an error...?  Of course fsck is not happy: HEAD points to master,
> but master does not exist.  However, the newbie might find it weird that git
> complains over a brand new repo it has just made.
>
> BTW also gitk dies badly in this case.
>
> 2) Backup repo
>
> mkdir Foo-Backup
> cd Foo-Backup
> git --bare init
>
> cd <path>/Foo-Workingtree
> git config --add remote.foobackup.url <url pointing to Foo Backup>
> git config --add remote.foobackup.push +refs/heads/*:refs/remotes/workplace1/*
> git push foobackup
>
> cd <path>/Foo-Backup
> git --bare fsck
> error: HEAD is not a symbolic ref
>
> Of course... again head points to master, but master does not exist.

I personally do not care too much about empty repository case.
Either we say error, or we say everything is cruft (if you did
"git add; rm -f .git/index").  So I do not think it matters too
much if the second error from (1) says "No default references"
or did not trigger.  That "error" is not about your repository
being corrupt, but is about your use of fsck when you know you
do not have anything is, eh, suboptimal ;-).  If you look at the
comment before the line that emits that error message you would
know.

"HEAD is not a symbolic ref" should not even be an error, as we
support detached HEAD, which is another case fsck does not yet
know about.  The error message you got should be at least worded
as an informational message that says it is pointing at a
yet-to-be-born branch.

I think it *is* an error if:

 (1) $GIT_DIR/HEAD does _not_ exist;
 (2) $GIT_DIR/HEAD is a symref, but points outside refs/heads;
 (3) $GIT_DIR/HEAD is _not_ a symref, but does not contain a
     40-byte object name.

but (1) or (3) are covered by not even considering such $GIT_DIR
as a valid repository, and we already check (2).  So I think
something like the following patch to loosen restriction is good
enough.

---

 builtin-fsck.c |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index 21f1f9e..7c3b0a5 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -532,7 +532,7 @@ static void get_default_heads(void)
 	 * "show_unreachable" flag.
 	 */
 	if (!default_refs) {
-		error("No default references");
+		fprintf(stderr, "notice: No default references\n");
 		show_unreachable = 0;
 	}
 }
@@ -552,15 +552,23 @@ static int fsck_head_link(void)
 {
 	unsigned char sha1[20];
 	int flag;
-	const char *head_points_at = resolve_ref("HEAD", sha1, 1, &flag);
-
-	if (!head_points_at || !(flag & REF_ISSYMREF))
-		return error("HEAD is not a symbolic ref");
-	if (prefixcmp(head_points_at, "refs/heads/"))
+	int null_is_error = 0;
+	const char *head_points_at = resolve_ref("HEAD", sha1, 0, &flag);
+
+	if (!head_points_at)
+		return error("Invalid HEAD");
+	if (!strcmp(head_points_at, "HEAD"))
+		/* detached HEAD */
+		null_is_error = 1;
+	else if (prefixcmp(head_points_at, "refs/heads/"))
 		return error("HEAD points to something strange (%s)",
 			     head_points_at);
-	if (is_null_sha1(sha1))
-		return error("HEAD: not a valid git pointer");
+	if (is_null_sha1(sha1)) {
+		if (null_is_error)
+			return error("HEAD: detached HEAD points at nothing");
+		fprintf(stderr, "notice: HEAD points to an unborn branch (%s)\n",
+			head_points_at + 11);
+	}
 	return 0;
 }
 
