From: Adam Roben <aroben@apple.com>
Subject: [PATCH 01/11] Add tests for git cat-file
Date: Wed, 23 Apr 2008 15:17:43 -0400
Message-ID: <1208978273-98146-2-git-send-email-aroben@apple.com>
References: <1208978273-98146-1-git-send-email-aroben@apple.com>
Cc: Adam Roben <aroben@apple.com>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 21:20:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JokUP-0004sm-0X
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 21:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753947AbYDWTSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 15:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753925AbYDWTR7
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 15:17:59 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:50289 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753563AbYDWTR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 15:17:57 -0400
Received: from relay13.apple.com (relay13.apple.com [17.128.113.29])
	by mail-out4.apple.com (Postfix) with ESMTP id 80CFC2A6A251;
	Wed, 23 Apr 2008 12:17:57 -0700 (PDT)
Received: from relay13.apple.com (unknown [127.0.0.1])
	by relay13.apple.com (Symantec Mail Security) with ESMTP id 5E14B28094;
	Wed, 23 Apr 2008 12:17:57 -0700 (PDT)
X-AuditID: 1180711d-a9b93bb000000ed7-18-480f8b642211
Received: from localhost.localdomain (unknown [17.151.126.45])
	by relay13.apple.com (Apple SCV relay) with ESMTP id 6D9EC28085;
	Wed, 23 Apr 2008 12:17:56 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.1.152.g9aeb7
In-Reply-To: <1208978273-98146-1-git-send-email-aroben@apple.com>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80237>


Signed-off-by: Adam Roben <aroben@apple.com>
---
 t/t1006-cat-file.sh |  101 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 101 insertions(+), 0 deletions(-)
 create mode 100755 t/t1006-cat-file.sh

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
new file mode 100755
index 0000000..15741d9
--- /dev/null
+++ b/t/t1006-cat-file.sh
@@ -0,0 +1,101 @@
+#!/bin/sh
+
+test_description='git cat-file'
+
+. ./test-lib.sh
+
+function echo_without_newline()
+{
+    echo "$@\c"
+}
+
+function strlen()
+{
+    echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
+}
+
+function maybe_remove_timestamp()
+{
+    if test -z "$2"; then
+        echo_without_newline "$1"
+    else
+        echo_without_newline "$1" | sed -e 's/ [0-9]\{10\} [+-][0-9]\{4\}$//'
+    fi
+}
+
+function run_tests()
+{
+    type=$1
+    sha1=$2
+    size=$3
+    content=$4
+    pretty_content=$5
+    no_timestamp=$6
+
+    test_expect_success \
+        "$type exists" \
+        "git cat-file -e $sha1"
+    test_expect_success \
+        "Type of $type is correct" \
+        "test $type = \"\$(git cat-file -t $sha1)\""
+    test_expect_success \
+        "Size of $type is correct" \
+        "test $size = \"\$(git cat-file -s $sha1)\""
+    test -z "$content" || test_expect_success \
+        "Content of $type is correct" \
+        "test \"\$(maybe_remove_timestamp '$content' $no_timestamp)\" = \"\$(maybe_remove_timestamp \"\$(git cat-file $type $sha1)\" $no_timestamp)\""
+    test_expect_success \
+        "Pretty content of $type is correct" \
+        "test \"\$(maybe_remove_timestamp '$pretty_content' $no_timestamp)\" = \"\$(maybe_remove_timestamp \"\$(git cat-file -p $sha1)\" $no_timestamp)\""
+}
+
+hello_content="Hello World"
+hello_size=$(strlen "$hello_content")
+hello_sha1=$(echo_without_newline "$hello_content" | git hash-object --stdin)
+
+test_expect_success \
+    "setup" \
+    "echo_without_newline \"$hello_content\" > hello &&
+     git update-index --add hello"
+
+run_tests 'blob' $hello_sha1 $hello_size "$hello_content" "$hello_content"
+
+tree_sha1=$(git write-tree)
+tree_size=33
+tree_pretty_content="100644 blob $hello_sha1	hello"
+
+run_tests 'tree' $tree_sha1 $tree_size "" "$tree_pretty_content"
+
+commit_message="Intial commit"
+commit_sha1=$(echo_without_newline "$commit_message" | git commit-tree $tree_sha1)
+commit_size=176
+commit_content="tree $tree_sha1
+author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> 0000000000 +0000
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 0000000000 +0000
+
+$commit_message"
+
+run_tests 'commit' $commit_sha1 $commit_size "$commit_content" "$commit_content" 1
+
+tag_header_without_timestamp="object $hello_sha1
+type blob
+tag hellotag
+tagger $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
+tag_description="This is a tag"
+tag_content="$tag_header_without_timestamp 0000000000 +0000
+
+$tag_description"
+tag_pretty_content="$tag_header_without_timestamp Thu Jan 1 00:00:00 1970 +0000
+
+$tag_description"
+
+tag_sha1=$(echo_without_newline "$tag_content" | git mktag)
+tag_size=$(strlen "$tag_content")
+
+run_tests 'tag' $tag_sha1 $tag_size "$tag_content" "$tag_pretty_content" 1
+
+test_expect_success \
+    "Reach a blob from a tag pointing to it" \
+    "test '$hello_content' = \"\$(git cat-file blob $tag_sha1)\""
+
+test_done
-- 
1.5.5.1.152.g9aeb7
