From: Jeff King <peff@peff.net>
Subject: [PATCH] fsck: return non-zero status on missing ref tips
Date: Thu, 11 Sep 2014 23:38:30 -0400
Message-ID: <20140912033830.GA5507@peff.net>
References: <1409177412.15185.3.camel@leckie>
 <20140829185325.GC29456@peff.net>
 <xmqqha0v5cgn.fsf@gitster.dls.corp.google.com>
 <1409343480.19256.2.camel@leckie>
 <20140829203145.GA510@peff.net>
 <xmqq4mwgjvt6.fsf_-_@gitster.dls.corp.google.com>
 <20140909220709.GA14029@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>,
	git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 05:38:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSHh0-0006ff-U4
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 05:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbaILDie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 23:38:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:47298 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751605AbaILDid (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 23:38:33 -0400
Received: (qmail 29418 invoked by uid 102); 12 Sep 2014 03:38:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Sep 2014 22:38:33 -0500
Received: (qmail 31430 invoked by uid 107); 12 Sep 2014 03:38:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Sep 2014 23:38:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Sep 2014 23:38:30 -0400
Content-Disposition: inline
In-Reply-To: <20140909220709.GA14029@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256895>

> On Tue, Sep 09, 2014 at 03:03:33PM -0700, Junio C Hamano wrote:
> 
> > Upon finding a corrupt loose object, we forgot to note the error to
> > signal it with the exit status of the entire process.
> > 
> > [jc: adjusted t1450 and added another test]
> > 
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > ---
> > 
> >  * I think your fix is a right one that catches all the "we can
> >    parse minimally for the purpose of 'struct object' class system,
> >    but the object is semantically broken" cases, as fsck_obj() is
> >    where such a validation should all happen.

Here's another structural case that we should catch but do not:

-- >8 --
Subject: fsck: return non-zero status on missing ref tips

Fsck tries hard to detect missing objects, and will complain
(and exit non-zero) about any inter-object links that are
missing. However, it will not exit non-zero for any missing
ref tips, meaning that a severely broken repository may
still pass "git fsck && echo ok".

The problem is that we use for_each_ref to iterate over the
ref tips, which hides broken tips. It does at least print an
error from the refs.c code, but fsck does not ever see the
ref and cannot note the problem in its exit code. We can solve
this by using for_each_rawref and noting the error ourselves.

In addition to adding tests for this case, we add tests for
all types of missing-object links (all of which worked, but
which we were not testing).

Signed-off-by: Jeff King <peff@peff.net>
---
Just below here we check that refs/heads/* points only to commit
objects. That's also sort-of-structural, but is pretty easy to recover
from without data loss, so I don't think it is as obvious a candidate
for a non-zero exit.

 builtin/fsck.c  |  3 ++-
 t/t1450-fsck.sh | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 29de901..0928a98 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -489,6 +489,7 @@ static int fsck_handle_ref(const char *refname, const unsigned char *sha1, int f
 	obj = parse_object(sha1);
 	if (!obj) {
 		error("%s: invalid sha1 pointer %s", refname, sha1_to_hex(sha1));
+		errors_found |= ERROR_REACHABLE;
 		/* We'll continue with the rest despite the error.. */
 		return 0;
 	}
@@ -505,7 +506,7 @@ static void get_default_heads(void)
 {
 	if (head_points_at && !is_null_sha1(head_sha1))
 		fsck_handle_ref("HEAD", head_sha1, 0, NULL);
-	for_each_ref(fsck_handle_ref, NULL);
+	for_each_rawref(fsck_handle_ref, NULL);
 	if (include_reflogs)
 		for_each_reflog(fsck_handle_reflog, NULL);
 
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 0de755c..b52397a 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -302,4 +302,60 @@ test_expect_success 'fsck notices ".git" in trees' '
 	)
 '
 
+# create a static test repo which is broken by omitting
+# one particular object ($1, which is looked up via rev-parse
+# in the new repository).
+create_repo_missing () {
+	rm -rf missing &&
+	git init missing &&
+	(
+		cd missing &&
+		git commit -m one --allow-empty &&
+		mkdir subdir &&
+		echo content >subdir/file &&
+		git add subdir/file &&
+		git commit -m two &&
+		unrelated=$(echo unrelated | git hash-object --stdin -w) &&
+		git tag -m foo tag $unrelated &&
+		sha1=$(git rev-parse --verify "$1") &&
+		path=$(echo $sha1 | sed 's|..|&/|') &&
+		rm .git/objects/$path
+	)
+}
+
+test_expect_success 'fsck notices missing blob' '
+	create_repo_missing HEAD:subdir/file &&
+	test_must_fail git -C missing fsck
+'
+
+test_expect_success 'fsck notices missing subtree' '
+	create_repo_missing HEAD:subdir &&
+	test_must_fail git -C missing fsck
+'
+
+test_expect_success 'fsck notices missing root tree' '
+	create_repo_missing HEAD^{tree} &&
+	test_must_fail git -C missing fsck
+'
+
+test_expect_success 'fsck notices missing parent' '
+	create_repo_missing HEAD^ &&
+	test_must_fail git -C missing fsck
+'
+
+test_expect_success 'fsck notices missing tagged object' '
+	create_repo_missing tag^{blob} &&
+	test_must_fail git -C missing fsck
+'
+
+test_expect_success 'fsck notices ref pointing to missing commit' '
+	create_repo_missing HEAD &&
+	test_must_fail git -C missing fsck
+'
+
+test_expect_success 'fsck notices ref pointing to missing tag' '
+	create_repo_missing tag &&
+	test_must_fail git -C missing fsck
+'
+
 test_done
-- 
2.1.0.373.g91ca799
