From: Adam Roben <aroben@apple.com>
Subject: [PATCH 1/9] Add tests for git cat-file
Date: Mon, 22 Oct 2007 22:46:29 -0700
Message-ID: <1193118397-4696-2-git-send-email-aroben@apple.com>
References: <1193118397-4696-1-git-send-email-aroben@apple.com>
Cc: Junio C Hamano <gitster@pobox.com>, Adam Roben <aroben@apple.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 23 07:47:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkCbu-0007N2-0u
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 07:47:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbXJWFrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 01:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751738AbXJWFrO
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 01:47:14 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:57260 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324AbXJWFrM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 01:47:12 -0400
Received: from relay14.apple.com (relay14.apple.com [17.128.113.52])
	by mail-out4.apple.com (Postfix) with ESMTP id 371E016874AA;
	Mon, 22 Oct 2007 22:47:11 -0700 (PDT)
Received: from relay14.apple.com (unknown [127.0.0.1])
	by relay14.apple.com (Symantec Mail Security) with ESMTP id 1A4EF28085;
	Mon, 22 Oct 2007 22:47:11 -0700 (PDT)
X-AuditID: 11807134-a5659bb000000c52-5c-471d8adeb371
Received: from localhost.localdomain (aroben3.apple.com [17.203.12.72])
	by relay14.apple.com (Apple SCV relay) with ESMTP id ECBF82804D;
	Mon, 22 Oct 2007 22:47:10 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.4.1333.ga2f32
In-Reply-To: <1193118397-4696-1-git-send-email-aroben@apple.com>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62099>


Signed-off-by: Adam Roben <aroben@apple.com>
---
 t/t1005-cat-file.sh |   91 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 91 insertions(+), 0 deletions(-)
 create mode 100755 t/t1005-cat-file.sh

diff --git a/t/t1005-cat-file.sh b/t/t1005-cat-file.sh
new file mode 100755
index 0000000..2fdc446
--- /dev/null
+++ b/t/t1005-cat-file.sh
@@ -0,0 +1,91 @@
+#!/bin/sh
+
+test_description='git cat-file'
+
+. ./test-lib.sh
+
+function maybe_remove_timestamp()
+{
+    if test -z "$2"; then
+        echo "$1"
+    else
+        echo "$1" | sed -e 's/ [0-9]\{10\} [+-][0-9]\{4\}$//'
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
+        "git cat-file -e $hello_sha1"
+    test_expect_success \
+        "Type of $type is correct" \
+        "test $type = \"$(git cat-file -t $sha1)\""
+    test_expect_success \
+        "Size of $type is correct" \
+        "test $size = \"$(git cat-file -s $sha1)\""
+    test -z "$content" || test_expect_success \
+        "Content of $type is correct" \
+        "test \"$(maybe_remove_timestamp "$content" $no_timestamp)\" = \"$(maybe_remove_timestamp "$(git cat-file $type $sha1)" $no_timestamp)\""
+    test_expect_success \
+        "Pretty content of $type is correct" \
+        "test \"$(maybe_remove_timestamp "$pretty_content" $no_timestamp)\" = \"$(maybe_remove_timestamp "$(git cat-file -p $sha1)" $no_timestamp)\""
+}
+
+hello_content="Hello World"
+hello_size=$(echo "$hello_content" | wc -c)
+hello_sha1=557db03de997c86a4a028e1ebd3a1ceb225be238
+
+echo "$hello_content" > hello
+
+git update-index --add hello
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
+commit_sha1=$(echo "$commit_message" | git commit-tree $tree_sha1)
+commit_size=177
+commit_content="tree $tree_sha1
+author $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL> 0000000000 +0000
+committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 0000000000 +0000
+
+$commit_message"
+
+run_tests 'commit' $commit_sha1 $commit_size "$commit_content" "$commit_content" 1
+
+tag_header="object $hello_sha1
+type blob
+tag hellotag
+tagger $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
+tag_description="This is a tag"
+tag_content="$tag_header
+
+$tag_description"
+tag_pretty_content="$tag_header
+Thu Jan 1 00:00:00 1970 +0000
+
+$tag_description"
+
+tag_sha1=$(echo "$tag_content" | git mktag)
+tag_size=$(echo "$tag_content" | wc -c)
+
+run_tests 'tag' $tag_sha1 $tag_size "$tag_content" "$tag_pretty_content"
+
+test_expect_success \
+    "Reach a blob from a tag pointing to it" \
+    "test \"$hello_content\" = \"$(git cat-file blob $tag_sha1)\""
+
+test_done
-- 
1.5.3.4.1333.ga2f32
