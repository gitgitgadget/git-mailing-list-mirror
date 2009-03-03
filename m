From: Jeff King <peff@peff.net>
Subject: [PATCH] clone: run post-checkout hook when checking out
Date: Tue, 3 Mar 2009 00:37:51 -0500
Message-ID: <20090303053750.GA30201@coredump.intra.peff.net>
References: <20273.1236033817@relay.known.net> <20090303042848.GC18136@coredump.intra.peff.net> <23978.1236056549@relay.known.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: layer <layer@known.net>
X-From: git-owner@vger.kernel.org Tue Mar 03 06:39:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeNLk-0004yy-6J
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 06:39:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbZCCFiB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 00:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbZCCFiA
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 00:38:00 -0500
Received: from peff.net ([208.65.91.99]:60558 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750747AbZCCFh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 00:37:59 -0500
Received: (qmail 12563 invoked by uid 107); 3 Mar 2009 05:37:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 03 Mar 2009 00:37:57 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Mar 2009 00:37:51 -0500
Content-Disposition: inline
In-Reply-To: <23978.1236056549@relay.known.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111999>

The mental model for clone is that the branch is "checked
out" (and it even says this in Documentation/git-clone.txt:
"...creates and checks out an initial branch"). Therefore it
is reasonable for users to expect that any post-checkout
hook would be run.

Signed-off-by: Jeff King <peff@peff.net>
---
On Mon, Mar 02, 2009 at 09:02:29PM -0800, layer wrote:

> The hook in question was in /usr/share/git-core/templates/hooks/, so
> it would get setup on clone.  That works fine.  If I immediately
> switch branches, the hook gets called.  It's just the `post-clone'
> (when I assume something like `checkout' is done), the hook doesn't
> get called.

This should fix it.

Junio, I'm not sure what you want to do with this. It is definitely a
behavior change; we have never respected post-checkout hooks in shell
git-clone.sh or in the builtin version. However, it seems like an
omission rather than an intentional behavior, so I consider this a
bugfix.

 builtin-clone.c               |    7 ++++++-
 t/t5403-post-checkout-hook.sh |   12 ++++++++++++
 2 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 3146ca8..ceffecb 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -21,6 +21,7 @@
 #include "pack-refs.h"
 #include "sigchain.h"
 #include "remote.h"
+#include "run-command.h"
 
 /*
  * Overall FIXMEs:
@@ -341,6 +342,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	struct strbuf branch_top = STRBUF_INIT, reflog_msg = STRBUF_INIT;
 	struct transport *transport = NULL;
 	char *src_ref_prefix = "refs/heads/";
+	int err = 0;
 
 	struct refspec refspec;
 
@@ -596,6 +598,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		if (write_cache(fd, active_cache, active_nr) ||
 		    commit_locked_index(lock_file))
 			die("unable to write new index file");
+
+		err |= run_hook(NULL, "post-checkout", sha1_to_hex(null_sha1),
+				sha1_to_hex(remote_head->old_sha1), "1", NULL);
 	}
 
 	strbuf_release(&reflog_msg);
@@ -603,5 +608,5 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	strbuf_release(&key);
 	strbuf_release(&value);
 	junk_pid = 0;
-	return 0;
+	return err;
 }
diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index 9b2e1a9..4fdb418 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -71,4 +71,16 @@ test_expect_success 'post-checkout receives the right args when not switching br
         test $old = $new -a $flag = 0
 '
 
+mkdir -p templates/hooks
+cat >templates/hooks/post-checkout <<'EOF'
+#!/bin/sh
+echo $@ > $GIT_DIR/post-checkout.args
+EOF
+chmod +x templates/hooks/post-checkout
+
+test_expect_success 'post-checkout hook is triggered by clone' '
+	git clone --template=templates . clone3 &&
+	test -f clone3/.git/post-checkout.args
+'
+
 test_done
-- 
1.6.2.rc2.313.gce9b3.dirty
