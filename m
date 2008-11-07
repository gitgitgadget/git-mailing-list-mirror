From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH] checkout: Don't crash when switching away from an invalid branch.
Date: Fri, 07 Nov 2008 18:02:10 +0100
Message-ID: <871vxnbhbh.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 18:29:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyV8w-000586-V4
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 18:29:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbYKGR15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 12:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbYKGR15
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 12:27:57 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:34686 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbYKGR14 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 12:27:56 -0500
X-Greylist: delayed 1508 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Nov 2008 12:27:29 EST
Received: from adsl-84-226-29-112.adslplus.ch ([84.226.29.112] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1KyUir-00039h-Lf
	for git@vger.kernel.org; Fri, 07 Nov 2008 11:02:20 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 2BDF21E73B6; Fri,  7 Nov 2008 18:02:10 +0100 (CET)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
X-Spam-Score: -3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100318>

I have a tree where for some reason HEAD was pointing to an invalid
commit. I'm not sure how this happened, but git checkout should be
able to recover from that situation without crashing.

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 builtin-checkout.c               |   14 +++++++++-----
 t/t2011-checkout-invalid-head.sh |   18 ++++++++++++++++++
 2 files changed, 27 insertions(+), 5 deletions(-)
 create mode 100755 t/t2011-checkout-invalid-head.sh

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 57b94d2..7c1b8cd 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -47,7 +47,8 @@ static int post_checkout_hook(struct commit *old, struct commit *new,
 
 	memset(&proc, 0, sizeof(proc));
 	argv[0] = name;
-	argv[1] = xstrdup(sha1_to_hex(old->object.sha1));
+	argv[1] = old ? xstrdup(sha1_to_hex(old->object.sha1))
+		      : "0000000000000000000000000000000000000000";
 	argv[2] = xstrdup(sha1_to_hex(new->object.sha1));
 	argv[3] = changed ? "1" : "0";
 	argv[4] = NULL;
@@ -492,10 +493,13 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 	}
 
 	old_desc = old->name;
-	if (!old_desc)
+	if (!old_desc && old->commit)
 		old_desc = sha1_to_hex(old->commit->object.sha1);
-	strbuf_addf(&msg, "checkout: moving from %s to %s",
-		    old_desc, new->name);
+	if (old_desc)
+		strbuf_addf(&msg, "checkout: moving from %s to %s",
+			    old_desc, new->name);
+	else
+		strbuf_addf(&msg, "checkout: moving to %s", new->name);
 
 	if (new->path) {
 		create_symref("HEAD", new->path, msg.buf);
@@ -551,7 +555,7 @@ static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
 	 * a new commit, we want to mention the old commit once more
 	 * to remind the user that it might be lost.
 	 */
-	if (!opts->quiet && !old.path && new->commit != old.commit)
+	if (!opts->quiet && !old.path && old.commit && new->commit != old.commit)
 		describe_detached_head("Previous HEAD position was", old.commit);
 
 	if (!old.commit) {
diff --git a/t/t2011-checkout-invalid-head.sh b/t/t2011-checkout-invalid-head.sh
new file mode 100755
index 0000000..764bb0a
--- /dev/null
+++ b/t/t2011-checkout-invalid-head.sh
@@ -0,0 +1,18 @@
+#!/bin/sh
+
+test_description='checkout switching away from an invalid branch'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	echo hello >world &&
+	git add world &&
+	git commit -m initial
+'
+
+test_expect_success 'checkout master from invalid HEAD' '
+	echo 0000000000000000000000000000000000000000 >.git/HEAD &&
+	git checkout master --
+'
+
+test_done
-- 
1.6.0.3.669.g76740

-- 
Alexandre Julliard
julliard@winehq.org
