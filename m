From: Jeff King <peff@peff.net>
Subject: [PATCH] pack-objects: turn off bitmaps when we see --shallow lines
Date: Tue, 12 Aug 2014 00:34:53 -0400
Message-ID: <20140812043452.GA11784@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 12 06:35:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XH3nv-00081d-UD
	for gcvg-git-2@plane.gmane.org; Tue, 12 Aug 2014 06:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018AbaHLEfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2014 00:35:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:50551 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751995AbaHLEfD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2014 00:35:03 -0400
Received: (qmail 2231 invoked by uid 102); 12 Aug 2014 04:35:02 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (204.237.18.137)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Aug 2014 23:35:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Aug 2014 00:34:53 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255145>

Reachability bitmaps do not work with shallow operations,
because they cache a view of the object reachability that
represents the true objects. Whereas a shallow repository
(or a shallow operation in a repository) is inherently
cutting off the object graph with a graft.

We explicitly disallow the use of bitmaps in shallow
repositories by checking is_repository_shallow(), and we
should continue to do that. However, we also want to
disallow bitmaps when we are serving a fetch to a shallow
client, since we momentarily take on their grafted view of
the world.

It used to be enough to call is_repository_shallow at the
start of pack-objects.  Upload-pack wrote the other side's
shallow state to a temporary file and pointed the whole
pack-objects process at this state with "git --shallow-file",
and from the perspective of pack-objects, we really were
in a shallow repo.  But since b790e0f (upload-pack: send
shallow info over stdin to pack-objects, 2014-03-11), we do
it differently: we send --shallow lines to pack-objects over
stdin, and it registers them itself.

This means that our is_repository_shallow check is way too
early (we have not been told about the shallowness yet), and
that it is insufficient (calling is_repository_shallow is
not enough, as the shallow grafts we register do not change
its return value). Instead, we can just turn off bitmaps
explicitly when we see these lines.

Signed-off-by: Jeff King <peff@peff.net>
---
Sorry not to catch this earlier. The bug is in v2.0, and I only noticed
the regression because a very small percentage of shallow fetches from
GitHub started failing after we deployed v2.0 a few weeks ago. It took
me a while to figure out the reproduction recipe below. :)

Arguably is_repository_shallow should return 1 if anybody has registered
a shallow graft, but that wouldn't be enough to fix this (we'd still
need to check it again _after_ reading the --shallow lines). So I think
this fix is fine here. I don't know if any other parts of the code would
care, though.

 builtin/pack-objects.c          |  1 +
 t/t5311-pack-bitmaps-shallow.sh | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100755 t/t5311-pack-bitmaps-shallow.sh

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 238b502..b59f5d8 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2494,6 +2494,7 @@ static void get_object_list(int ac, const char **av)
 				if (get_sha1_hex(line + 10, sha1))
 					die("not an SHA-1 '%s'", line + 10);
 				register_shallow(sha1);
+				use_bitmap_index = 0;
 				continue;
 			}
 			die("not a rev '%s'", line);
diff --git a/t/t5311-pack-bitmaps-shallow.sh b/t/t5311-pack-bitmaps-shallow.sh
new file mode 100755
index 0000000..872a95d
--- /dev/null
+++ b/t/t5311-pack-bitmaps-shallow.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+
+test_description='check bitmap operation with shallow repositories'
+. ./test-lib.sh
+
+# We want to create a situation where the shallow, grafted
+# view of reachability does not match reality in a way that
+# might cause us to send insufficient objects.
+#
+# We do this with a history that repeats a state, like:
+#
+#      A    --   B    --   C
+#    file=1    file=2    file=1
+#
+# and then create a shallow clone to the second commit, B.
+# In a non-shallow clone, that would mean we already have
+# the tree for A. But in a shallow one, we've grafted away
+# A, and fetching A to B requires that the other side send
+# us the tree for file=1.
+test_expect_success 'setup shallow repo' '
+	echo 1 >file &&
+	git add file &&
+	git commit -m orig &&
+	echo 2 >file &&
+	git commit -a -m update &&
+	git clone --no-local --bare --depth=1 . shallow.git &&
+	echo 1 >file &&
+	git commit -a -m repeat
+'
+
+test_expect_success 'turn on bitmaps in the parent' '
+	git repack -adb
+'
+
+test_expect_success 'shallow fetch from bitmapped repo' '
+	(cd shallow.git && git fetch)
+'
+
+test_done
-- 
2.1.0.rc0.286.g5c67d74
