From: Jeff King <peff@peff.net>
Subject: Re: How can git pull be up-to-date and git push fail?
Date: Sat, 7 Apr 2007 13:07:02 -0400
Message-ID: <20070407170702.GC18972@coredump.intra.peff.net>
References: <17940.59514.150325.738141@lisa.zopyra.com> <20070405134954.GA18402@coredump.intra.peff.net> <17941.655.192938.792088@lisa.zopyra.com> <20070405204604.GA24779@coredump.intra.peff.net> <7vodm2o6yl.fsf@assigned-by-dhcp.cox.net> <20070406025255.GA31909@coredump.intra.peff.net> <7vbqi1jhzx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 07 19:20:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaEO1-0002Kj-MI
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 19:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966109AbXDGRHJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Apr 2007 13:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966115AbXDGRHJ
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Apr 2007 13:07:09 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4179 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966109AbXDGRHG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2007 13:07:06 -0400
Received: (qmail 11913 invoked from network); 7 Apr 2007 17:07:40 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 7 Apr 2007 17:07:40 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 07 Apr 2007 13:07:02 -0400
Content-Disposition: inline
In-Reply-To: <7vbqi1jhzx.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43977>

On Fri, Apr 06, 2007 at 02:44:02PM -0700, Junio C Hamano wrote:

> was no "git push" wrapper).  Back then, the expected use was
> really:

Thanks for this for the historical information.

> So I'd suspect "git push" (not limited to git-send-pack) without
> explicit refspecs should only do "matching branch heads" these
> days, to keep the original spirit but yet to adjust to today's
> reality.  In other words, instead of treating remotes/ specially
> (in a negative sense), like your patch does, I think we should
> do only "matching refs in heads/" hierarchy.

Agreed. That was actually my initial feeling, but it meant changing the
semantics of all of the other parts of the refs/* hierarchy with respect
to publishing, which I was a bit nervous about.

A patch is attached below for comment; it's the same as my previous
patch, except:
  - matching only refs/heads/
  - rename local_ref to local_head for consistency (one of the functions
    was already get_local_heads, but the other's didn't match)
  - avoid calling strlen if we're just going to return immediately
  - add a test to simulate Bill's problem
  - update documentation for git-push

But it looks like I have broken pushing of existing tags using --tags,
so I think I might have to put the ref-culling in a different spot. Let
me look in that.

BTW, my gut feeling is that send-pack is plumbing, and git-push is
porcelain, and therefore the decisions about what to push should be made
at the push layer, and send-pack should only push what it is explicitly
told to push. But changing the defaults of send-pack at this point is
probably a bad idea.

---
 Documentation/git-push.txt      |    4 ++--
 Documentation/git-send-pack.txt |    4 ++--
 send-pack.c                     |   15 +++++++++------
 t/t5400-send-pack.sh            |   18 ++++++++++++++++++
 4 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index f8cc2b5..0b21306 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -46,7 +46,7 @@ even if it does not result in a fast forward update.
 Note: If no explicit refspec is found, (that is neither
 on the command line nor in any Push line of the
 corresponding remotes file---see below), then all the
-refs that exist both on the local side and on the remote
+heads that exist both on the local side and on the remote
 side are updated.
 +
 `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
@@ -60,7 +60,7 @@ the remote repository.
 
 \--all::
 	Instead of naming each ref to push, specifies that all
-	refs be pushed.
+	refs under `$GIT_DIR/refs/heads/` be pushed.
 
 \--tags::
 	All refs under `$GIT_DIR/refs/tags` are pushed, in
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index 205bfd2..3271e88 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -32,7 +32,7 @@ OPTIONS
 
 \--all::
 	Instead of explicitly specifying which refs to update,
-	update all refs that locally exist.
+	update all heads that locally exist.
 
 \--force::
 	Usually, the command refuses to update a remote ref that
@@ -70,7 +70,7 @@ With '--all' flag, all refs that exist locally are transferred to
 the remote side.  You cannot specify any '<ref>' if you use
 this flag.
 
-Without '--all' and without any '<ref>', the refs that exist
+Without '--all' and without any '<ref>', the heads that exist
 both on the local side and on the remote side are updated.
 
 When one or more '<ref>' are specified explicitly, it can be either a
diff --git a/send-pack.c b/send-pack.c
index d5b5162..b2b6886 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -124,13 +124,16 @@ static int ref_newer(const unsigned char *new_sha1,
 	return found;
 }
 
-static struct ref *local_refs, **local_tail;
+static struct ref *local_heads, **local_tail;
 static struct ref *remote_refs, **remote_tail;
 
-static int one_local_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
+static int one_local_head(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	struct ref *ref;
-	int len = strlen(refname) + 1;
+	int len;
+	if (prefixcmp(refname, "refs/heads/"))
+		return 0;
+	len = strlen(refname) + 1;
 	ref = xcalloc(1, sizeof(*ref) + len);
 	hashcpy(ref->new_sha1, sha1);
 	memcpy(ref->name, refname, len);
@@ -141,8 +144,8 @@ static int one_local_ref(const char *refname, const unsigned char *sha1, int fla
 
 static void get_local_heads(void)
 {
-	local_tail = &local_refs;
-	for_each_ref(one_local_ref, NULL);
+	local_tail = &local_heads;
+	for_each_ref(one_local_head, NULL);
 }
 
 static int receive_status(int in)
@@ -198,7 +201,7 @@ static int send_pack(int in, int out, int nr_refspec, char **refspec)
 	/* match them up */
 	if (!remote_tail)
 		remote_tail = &remote_refs;
-	if (match_refs(local_refs, remote_refs, &remote_tail,
+	if (match_refs(local_heads, remote_refs, &remote_tail,
 		       nr_refspec, refspec, send_all))
 		return -1;
 
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 477b267..ca4485a 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -113,4 +113,22 @@ test_expect_success \
 	! git diff .git/refs/heads/master victim/.git/refs/heads/master
 '
 
+test_expect_success \
+	'pushing does not include non-head refs' '
+	mkdir parent && cd parent &&
+	  git-init && touch file && git-add file && git-commit -m add &&
+	cd .. &&
+	git-clone parent child1 &&
+	git-clone parent child2 &&
+	cd parent &&
+	  echo parent >file && git-commit -a -m change &&
+	cd .. &&
+	cd child1 && git-pull && cd .. &&
+	cd child2 &&
+	  touch >file2 git-add file2 && git-add file2 && git-commit -m add2 &&
+	  git-pull ../child1 &&
+	  git-push ../child1 2>err &&
+	  ! grep ^error err
+'
+
 test_done
