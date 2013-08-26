From: Phil Hord <hordp@cisco.com>
Subject: [PATCHv2] grep: use slash for path delimiter, not colon
Date: Mon, 26 Aug 2013 10:46:12 -0400
Message-ID: <1377528372-31206-1-git-send-email-hordp@cisco.com>
Cc: phil.hord@gmail.com, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Phil Hord <hordp@cisco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 26 16:46:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDy40-0005b4-6Z
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 16:46:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936Ab3HZOqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 10:46:36 -0400
Received: from rcdn-iport-9.cisco.com ([173.37.86.80]:32493 "EHLO
	rcdn-iport-9.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694Ab3HZOqf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 10:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3064; q=dns/txt; s=iport;
  t=1377528395; x=1378737995;
  h=from:to:cc:subject:date:message-id;
  bh=n5XYFPwxDeun1WHxV7rl3Y+z5IkTTQlN1swXGmXlCac=;
  b=XVU7P+8UQboIAC1IWDsGnnMjIASdUcstog1DT8RmjvCXiUaozAQUInL0
   uLlXin9UqGC6MT2Obz/8qf1THH/GT7H8Rxi/yt8vBsb92wRU0hAuAbkN6
   /PFII5s2Qk9NdkkP60iZy3xzH4dATeidEFw78ccvBI1P1+U9X0vvXGJ1F
   Y=;
X-IronPort-AV: E=Sophos;i="4.89,958,1367971200"; 
   d="scan'208";a="248695869"
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by rcdn-iport-9.cisco.com with ESMTP; 26 Aug 2013 14:46:34 +0000
Received: from ipsn-lnx-hordp.cisco.com (rtp-hordp-8914.cisco.com [10.117.80.101])
	by rcdn-core-5.cisco.com (8.14.5/8.14.5) with ESMTP id r7QEkXCr020769;
	Mon, 26 Aug 2013 14:46:33 GMT
X-Mailer: git-send-email 1.8.4.557.g34b3a2e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232996>

When a commit is grepped and matching filenames are printed, grep-objects
creates the filename by prefixing the original cmdline argument to the
matched path separated by a colon.  Normally this forms a valid blob
reference to the filename, like this:

  git grep -l foo HEAD
  HEAD:some/path/to/foo.txt
      ^

But a tree path may be given to grep instead; in this case the colon is
not a valid delimiter to use since it is placed inside a path.

  git grep -l foo HEAD:some
  HEAD:some:path/to/foo.txt
           ^

The slash path delimiter should be used instead.  Fix git grep to
discern the correct delimiter so it can report valid object names.

  git grep -l foo HEAD:some
  HEAD:some/path/to/foo.txt
           ^

Also, prevent the delimiter being added twice, as happens now in these
examples:

  git grep -l foo HEAD:
  HEAD::some/path/to/foo.txt
       ^
  git grep -l foo HEAD:some/
  HEAD:some/:path/to/foo.txt
            ^

Add a test to confirm correct path forming.
---
This version is a bit more deterministic and also adds a test.

It accepts the expense of examining the path argument again to 
determine if it is a tree-ish + path rather than just a tree (commit).
The get_sha1 call occurs one extra time for each tree-ish argument,
so it's not expensive. We avoid mucking with the object_array API this
way, and also do not rely on the object-type to tell us anything about
the way the object name was spelled.

This one also adds a check to avoid duplicating an extant delimiter.

 builtin/grep.c  |  9 ++++++++-
 t/t7810-grep.sh | 15 +++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 03bc442..6fc418f 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -480,8 +480,15 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 		len = name ? strlen(name) : 0;
 		strbuf_init(&base, PATH_MAX + len + 1);
 		if (len) {
+			struct object_context ctx;
+			unsigned char sha1[20];
+			char delimiter = ':';
+			if (!get_sha1_with_context(name, 0, sha1, &ctx) &&
+				ctx.path[0]!=0)
+				delimiter='/';
 			strbuf_add(&base, name, len);
-			strbuf_addch(&base, ':');
+			if (name[len-1] != delimiter)
+				strbuf_addch(&base, delimiter);
 		}
 		init_tree_desc(&tree, data, size);
 		hit = grep_tree(opt, pathspec, &tree, &base, base.len,
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index f698001..2494bfc 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -886,6 +886,21 @@ test_expect_success 'grep -e -- -- path' '
 '
 
 cat >expected <<EOF
+HEAD:t/a/v:1:vvv
+HEAD:t/v:1:vvv
+EOF
+
+test_expect_success "grep HEAD -- path/" '
+	git grep -n -e vvv HEAD -- t/ >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success "grep HEAD:path" '
+	git grep -n -e vvv HEAD:t/ >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<EOF
 hello.c:int main(int argc, const char **argv)
 hello.c:	printf("Hello world.\n");
 EOF
-- 
1.8.4.557.g34b3a2e
