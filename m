From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/2] treat_directory(): do not declare submodules to be untracked
Date: Mon,  1 Jul 2013 14:59:10 -0700
Message-ID: <1372715951-3224-2-git-send-email-gitster@pobox.com>
References: <20130628150532.GD12252@machine.or.cz>
 <1372715951-3224-1-git-send-email-gitster@pobox.com>
Cc: Petr Baudis <pasky@ucw.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 01 23:59:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Utm85-0002db-LT
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 23:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755494Ab3GAV7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 17:59:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37800 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754808Ab3GAV7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 17:59:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D539D2DC30;
	Mon,  1 Jul 2013 21:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=RRFf
	HyJGIZ0W3+4lTXL9OmNVdJ4=; b=FGEBWzTAqnnRvrRPIbXfCcxkIvkxJSQnUX0M
	bi8zTGubAGGigSA0rXrdwQNZsa5HYNwQJq5DYjlJBLjaB2VmIB4W+VxOmapOQ99t
	dfS2zDJTRC2HY/T91scphGd0b5qCYB8pWGWJDdWaEAsRDwIhODmZYpLj3rfqJTIS
	qI6PaCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	qMe2s1TATViznGpUYGfqp1fKIMrzQVO3NPLrRJti0PxiHFBsEGrd9eRbUms7t9P1
	/J5TFAV0mFr9XT51TcDGf41PzQGZGhNlGO0ZdcgG8duo1xSOzGR7oO8hGhneT67m
	N9L6rbcPqYY3n4TVaGyMoyMbFCIe9K6rjBOsXfJl7LI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAFAC2DC2E;
	Mon,  1 Jul 2013 21:59:15 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0BED82DC2B;
	Mon,  1 Jul 2013 21:59:14 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.2-795-g615e8f0
In-Reply-To: <1372715951-3224-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 784ACF80-E299-11E2-ABCA-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229331>

When the working tree walker encounters a directory, it asks the
function treat_directory() if it should descend into it, show it as
an untracked directory, or do something else.  When the directory is
the top of the submodule working tree, we used to say "That is an
untracked directory", which was bogus.

It is an entity that is tracked in the index of the repository we
are looking at, and that is not to be descended into it.  Return
path_none, not path_untracked, to report that.

The existing case that path_untracked is returned for a newly
discovered submodule that is not tracked in the index (this only
happens when DIR_NO_GITLINKS option is not used) is unchanged, but
that is exactly because the submodule is not tracked in the index.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c                               |  4 +---
 t/t3010-ls-files-killed-modified.sh | 23 ++++++++++++++++++++---
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/dir.c b/dir.c
index 897c874..0480419 100644
--- a/dir.c
+++ b/dir.c
@@ -1036,9 +1036,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 		return path_recurse;
 
 	case index_gitdir:
-		if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
-			return path_none;
-		return path_untracked;
+		return path_none;
 
 	case index_nonexistent:
 		if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
diff --git a/t/t3010-ls-files-killed-modified.sh b/t/t3010-ls-files-killed-modified.sh
index 262e617..f611d79 100755
--- a/t/t3010-ls-files-killed-modified.sh
+++ b/t/t3010-ls-files-killed-modified.sh
@@ -11,6 +11,8 @@ This test prepares the following in the cache:
     path1       - a symlink
     path2/file2 - a file in a directory
     path3/file3 - a file in a directory
+    submod1/	- a submodule
+    submod2/	- another submodule
 
 and the following on the filesystem:
 
@@ -21,9 +23,11 @@ and the following on the filesystem:
     path4	- a file
     path5	- a symlink
     path6/file6 - a file in a directory
+    submod1/	- a submodule (modified from the cache)
+    submod2/	- a submodule (matches the cache)
 
-git ls-files -k should report that existing filesystem
-objects except path4, path5 and path6/file6 to be killed.
+git ls-files -k should report that existing filesystem objects
+path0/*, path1/*, path2 and path3 to be killed.
 
 Also for modification test, the cache and working tree have:
 
@@ -33,7 +37,7 @@ Also for modification test, the cache and working tree have:
     path10	- a non-empty file, cache dirtied.
 
 We should report path0, path1, path2/file2, path3/file3, path7 and path8
-modified without reporting path9 and path10.
+modified without reporting path9 and path10.  submod1 is also modified.
 '
 . ./test-lib.sh
 
@@ -48,6 +52,18 @@ test_expect_success 'git update-index --add to add various paths.' '
 	: >path9 &&
 	date >path10 &&
 	git update-index --add -- path0 path?/file? path7 path8 path9 path10 &&
+	for i in 1 2
+	do
+		git init submod$i &&
+		(
+			cd submod$i && git commit --allow-empty -m "empty $i"
+		) || break
+	done &&
+	git update-index --add submod[12]
+	(
+		cd submod1 &&
+		git commit --allow-empty -m "empty 1 (updated)"
+	) &&
 	rm -fr path?	# leave path10 alone
 '
 
@@ -94,6 +110,7 @@ test_expect_success 'validate git ls-files -m output.' '
 	path3/file3
 	path7
 	path8
+	submod1
 	EOF
 	test_cmp .expected .output
 '
-- 
1.8.3.2-798-g923e168
