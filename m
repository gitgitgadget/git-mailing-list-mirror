From: Clemens Buchacher <clemens.buchacher@intel.com>
Subject: [PATCH] allow hooks to ignore their standard input stream
Date: Wed, 11 Nov 2015 15:39:20 +0100
Organization: Intel Deutschland GmbH - Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany - Tel: +49 89 99 8853-0, www.intel.de - Managing Directors: Prof. Dr. Hermann Eul, Christin Eisenschmid - Chairperson of the Supervisory Board: Tiffany Doon Silva - Registered Office: Munich - Commercial Register: Amtsgericht Mnchen HRB 186928
Message-ID: <20151111143920.GA30409@musxeris015.imu.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junio@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 11 15:39:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwWYb-000296-7J
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 15:39:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbbKKOjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 09:39:25 -0500
Received: from mga03.intel.com ([134.134.136.65]:52062 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751324AbbKKOjY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 09:39:24 -0500
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP; 11 Nov 2015 06:39:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,276,1444719600"; 
   d="scan'208";a="598303240"
Received: from musxeris015.imu.intel.com (HELO localhost) ([10.216.40.13])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Nov 2015 06:39:22 -0800
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281165>

Since ec7dbd145 (receive-pack: allow hooks to ignore its standard input
stream) the pre-receive and post-receive hooks ignore SIGPIPE. Do the
same for the remaining hooks pre-push and post-rewrite, which read from
standard input. The same arguments for ignoring SIGPIPE apply.

Signed-off-by: Clemens Buchacher <clemens.buchacher@intel.com>
---
 builtin/commit.c |  3 +++
 transport.c      | 11 +++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index dca09e2..f2a8b78 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -32,6 +32,7 @@
 #include "sequencer.h"
 #include "notes-utils.h"
 #include "mailmap.h"
+#include "sigchain.h"
 
 static const char * const builtin_commit_usage[] = {
 	N_("git commit [<options>] [--] <pathspec>..."),
@@ -1537,8 +1538,10 @@ static int run_rewrite_hook(const unsigned char *oldsha1,
 		return code;
 	n = snprintf(buf, sizeof(buf), "%s %s\n",
 		     sha1_to_hex(oldsha1), sha1_to_hex(newsha1));
+	sigchain_push(SIGPIPE, SIG_IGN);
 	write_in_full(proc.in, buf, n);
 	close(proc.in);
+	sigchain_pop(SIGPIPE);
 	return finish_command(&proc);
 }
 
diff --git a/transport.c b/transport.c
index 23b2ed6..e34ab92 100644
--- a/transport.c
+++ b/transport.c
@@ -15,6 +15,7 @@
 #include "submodule.h"
 #include "string-list.h"
 #include "sha1-array.h"
+#include "sigchain.h"
 
 /* rsync support */
 
@@ -1127,6 +1128,8 @@ static int run_pre_push_hook(struct transport *transport,
 		return -1;
 	}
 
+	sigchain_push(SIGPIPE, SIG_IGN);
+
 	strbuf_init(&buf, 256);
 
 	for (r = remote_refs; r; r = r->next) {
@@ -1140,8 +1143,10 @@ static int run_pre_push_hook(struct transport *transport,
 			 r->peer_ref->name, sha1_to_hex(r->new_sha1),
 			 r->name, sha1_to_hex(r->old_sha1));
 
-		if (write_in_full(proc.in, buf.buf, buf.len) != buf.len) {
-			ret = -1;
+		if (write_in_full(proc.in, buf.buf, buf.len) < 0) {
+			/* We do not mind if a hook does not read all refs. */
+			if (errno != EPIPE)
+				ret = -1;
 			break;
 		}
 	}
@@ -1152,6 +1157,8 @@ static int run_pre_push_hook(struct transport *transport,
 	if (!ret)
 		ret = x;
 
+	sigchain_pop(SIGPIPE);
+
 	x = finish_command(&proc);
 	if (!ret)
 		ret = x;
-- 
1.9.4
