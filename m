From: Lukas Fleischer <lfleischer@lfos.de>
Subject: [PATCH/RFC] receive-pack: allow for hiding refs outside the namespace
Date: Mon, 26 Oct 2015 09:09:59 +0100
Message-ID: <1445846999-8627-1-git-send-email-lfleischer@lfos.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 26 09:16:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqcxW-0007K1-4K
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 09:16:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240AbbJZIQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 04:16:45 -0400
Received: from elnino.cryptocrack.de ([46.165.227.75]:39549 "EHLO
	elnino.cryptocrack.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000AbbJZIQn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 04:16:43 -0400
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Oct 2015 04:16:42 EDT
Received: by elnino.cryptocrack.de (OpenSMTPD) with ESMTPSA id 1aba93df;
	TLS version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO;
	for <git@vger.kernel.org>;
	Mon, 26 Oct 2015 09:10:01 +0100 (CET)
X-Mailer: git-send-email 2.6.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280185>

Right now, we always advertise all refs as ".have", even those outside
the current namespace. This leads to problems when trying to push to a
repository with a huge number of namespaces from a slow connection.

Add a configuration option receive.advertiseAllRefs that can be used to
determine whether refs outside the current namespace should be
advertised or not.

Signed-off-by: Lukas Fleischer <lfleischer@lfos.de>
---
We are using Git namespaces to store a huge number of (virtual)
repositories inside a shared repository. While the blobs in the virtual
repositories are fairly similar, they do not share any refs, so
advertising any refs outside the current namespace is undesirable. See
the discussion on [1] for details.

Note that this patch is just a draft: I didn't do any testing, apart
from checking that it compiles. I would like to hear some opinions
before sending a polished version.

Is our use case considered common enough to justify the inclusion of
such a configuration option in mainline?

Are there suggestions for a better name for the option? Ideally, it
should contain the word "namespace" but I could not come up with
something sensible that is short enough.

[1] https://lists.archlinux.org/pipermail/aur-general/2015-October/031596.html

 Documentation/config.txt |  6 ++++++
 builtin/receive-pack.c   | 31 +++++++++++++++++++++----------
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 315f271..aa101a7 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2201,6 +2201,12 @@ receive.advertiseAtomic::
 	capability to its clients. If you don't want to this capability
 	to be advertised, set this variable to false.
 
+receive.advertiseAllRefs::
+	By default, git-receive-pack will advertise all refs, even those
+	outside the current namespace, so that the client can use them to
+	minimize data transfer. If you only want to advertise refs from the
+	active namespace to be advertised, set this variable to false.
+
 receive.autogc::
 	By default, git-receive-pack will run "git-gc --auto" after
 	receiving data from git-push and updating refs.  You can stop
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e6b93d0..ea9a820 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -41,6 +41,7 @@ static struct strbuf fsck_msg_types = STRBUF_INIT;
 static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
 static int advertise_atomic_push = 1;
+static int advertise_all_refs = 1;
 static int unpack_limit = 100;
 static int report_status;
 static int use_sideband;
@@ -190,6 +191,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.advertiseallrefs") == 0) {
+		advertise_all_refs = git_config_bool(var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
@@ -222,16 +228,21 @@ static void show_ref(const char *path, const unsigned char *sha1)
 static int show_ref_cb(const char *path, const struct object_id *oid, int flag, void *unused)
 {
 	path = strip_namespace(path);
-	/*
-	 * Advertise refs outside our current namespace as ".have"
-	 * refs, so that the client can use them to minimize data
-	 * transfer but will otherwise ignore them. This happens to
-	 * cover ".have" that are thrown in by add_one_alternate_ref()
-	 * to mark histories that are complete in our alternates as
-	 * well.
-	 */
-	if (!path)
-		path = ".have";
+	if (!path) {
+		if (advertise_all_refs) {
+			/*
+			 * Advertise refs outside our current namespace as
+			 * ".have" refs, so that the client can use them to
+			 * minimize data transfer but will otherwise ignore
+			 * them. This happens to cover ".have" that are thrown
+			 * in by add_one_alternate_ref() to mark histories that
+			 * are complete in our alternates as well.
+			 */
+			path = ".have";
+		} else {
+			return 0;
+		}
+	}
 	show_ref(path, oid->hash);
 	return 0;
 }
-- 
2.6.2
