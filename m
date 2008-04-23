From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Probably a GIT bug..
Date: Wed, 23 Apr 2008 09:47:17 -0700
Message-ID: <7v63u8tt62.fsf@gitster.siamese.dyndns.org>
References: <20080422164311.67c3d02b@Vorago>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tomasz bla Fortuna <bla@thera.be>
X-From: git-owner@vger.kernel.org Wed Apr 23 18:48:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Joi8m-00087r-AQ
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 18:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbYDWQra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 12:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751808AbYDWQra
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 12:47:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40789 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbYDWQr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 12:47:29 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 07AE91941;
	Wed, 23 Apr 2008 12:47:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E5123171E; Wed, 23 Apr 2008 12:47:23 -0400 (EDT)
In-Reply-To: <20080422164311.67c3d02b@Vorago> (Tomasz bla Fortuna's message
 of "Tue, 22 Apr 2008 16:43:11 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80228>

Tomasz bla Fortuna <bla@thera.be> writes:

> I guess that GIT should check if he can create a tree link before
> creating a commit.

Thanks.

That's a somewhat contrived example, and I do not know how you found it.

I suspect the same breakage would trigger when you ran out of disk quota
to write out the tree while you still have barely enough quota to create
the commit and update the ref, which would result in corrupt repository.
So in that sense, this breakage is more likely to bite people in reality
than the initial reaction your test may invite which is "don't do that
then".

Here is a possible fix.

-- >8 --
write-tree: properly detect failure to write tree objects

Tomasz Fortuna reported that "git commit" does not error out properly when
it cannot write tree objects out.  "git write-tree" shares the same issue,
as the failure to notice the error is deep in the logic to write tree
objects out recursively.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache-tree.c          |    7 +++-
 t/t0004-unwritable.sh |   67 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/cache-tree.c b/cache-tree.c
index 39da54d..73cb340 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -341,8 +341,11 @@ static int update_one(struct cache_tree *it,
 
 	if (dryrun)
 		hash_sha1_file(buffer.buf, buffer.len, tree_type, it->sha1);
-	else
-		write_sha1_file(buffer.buf, buffer.len, tree_type, it->sha1);
+	else if (write_sha1_file(buffer.buf, buffer.len, tree_type, it->sha1)) {
+		strbuf_release(&buffer);
+		return -1;
+	}
+
 	strbuf_release(&buffer);
 	it->entry_count = i;
 #if DEBUG
diff --git a/t/t0004-unwritable.sh b/t/t0004-unwritable.sh
new file mode 100755
index 0000000..b355a8f
--- /dev/null
+++ b/t/t0004-unwritable.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
+
+test_description='detect unwritable repository and fail correctly'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+
+	>file &&
+	git add file &&
+	git commit -m initial &&
+	echo >file &&
+	git add file
+		
+'
+
+test_expect_success 'write-tree should notice unwritable repository' '
+
+	(
+		chmod a-w .git/objects
+		test_must_fail git write-tree
+	)
+	status=$?
+	chmod 775 .git/objects
+	(exit $status)
+
+'
+
+test_expect_success 'commit should notice unwritable repository' '
+
+	(
+		chmod a-w .git/objects
+		test_must_fail git commit -m second
+	)
+	status=$?
+	chmod 775 .git/objects
+	(exit $status)
+
+'
+
+test_expect_success 'update-index should notice unwritable repository' '
+
+	(
+		echo a >file &&
+		chmod a-w .git/objects
+		test_must_fail git update-index file
+	)
+	status=$?
+	chmod 775 .git/objects
+	(exit $status)
+
+'
+
+test_expect_success 'add should notice unwritable repository' '
+
+	(
+		echo b >file &&
+		chmod a-w .git/objects
+		test_must_fail git add file
+	)
+	status=$?
+	chmod 775 .git/objects
+	(exit $status)
+
+'
+
+test_done
