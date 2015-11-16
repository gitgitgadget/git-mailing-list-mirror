From: Clemens Buchacher <clemens.buchacher@intel.com>
Subject: Re: [PATCH] allow hooks to ignore their standard input stream
Date: Mon, 16 Nov 2015 09:05:58 +0100
Organization: Intel Deutschland GmbH - Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany - Tel: +49 89 99 8853-0, www.intel.de - Managing Directors: Prof. Dr. Hermann Eul, Christin Eisenschmid - Chairperson of the Supervisory Board: Tiffany Doon Silva - Registered Office: Munich - Commercial Register: Amtsgericht Mnchen HRB 186928
Message-ID: <20151116080558.GA23851@musxeris015.imu.intel.com>
References: <20151111143920.GA30409@musxeris015.imu.intel.com> <20151111144222.GA24717@musxeris015.imu.intel.com> <20151113061729.GC32157@sigill.intra.peff.net> <20151113093303.GA4111@musxeris015.imu.intel.com> <20151113232320.GB16173@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: junio@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 16 09:06:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyEnf-0000Bs-GO
	for gcvg-git-2@plane.gmane.org; Mon, 16 Nov 2015 09:06:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbbKPIGE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 03:06:04 -0500
Received: from mga02.intel.com ([134.134.136.20]:10834 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751462AbbKPIGC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 03:06:02 -0500
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP; 16 Nov 2015 00:06:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,301,1444719600"; 
   d="scan'208";a="839475978"
Received: from musxeris015.imu.intel.com (HELO localhost) ([10.216.40.13])
  by fmsmga001.fm.intel.com with ESMTP; 16 Nov 2015 00:05:59 -0800
Content-Disposition: inline
In-Reply-To: <20151113232320.GB16173@sigill.intra.peff.net>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281329>

Hi Junio,

I believe we have finalized the discussion on this patch. Please apply

On Fri, Nov 13, 2015 at 06:23:20PM -0500, Jeff King wrote:
> 
> > +test_expect_success 'filling pipe buffer does not cause failure' '
> > +	git push parent1 "refs/heads/b/*:refs/heads/b/*" &&
> > +	test_cmp expected actual
> > +'
> 
> It actually _does_ read all of the input, but I guess is making sure we
> call write() in a loop. I don't know if this is even worth keeping.
> 
> Can you think of a good reason that it is checking something
> interesting?

No, I also cannot think of a good reason to keep it. Here is the patch
with the test above removed.

Best regards,
Clemens

--o<--
Since ec7dbd145 (receive-pack: allow hooks to ignore its standard input stream)
the pre-receive and post-receive hooks ignore SIGPIPE. Do the same for the
remaining hooks pre-push and post-rewrite, which read from standard input. The
same arguments for ignoring SIGPIPE apply.

Include test by Jeff King which checks that SIGPIPE does not cause
pre-push hook failure. With the use of git update-ref --stdin it is fast
enough to be enabled by default.

Signed-off-by: Clemens Buchacher <clemens.buchacher@intel.com>
---
 builtin/commit.c         |  3 +++
 t/t5571-pre-push-hook.sh | 33 +++++++++++++++------------------
 transport.c              | 11 +++++++++--
 3 files changed, 27 insertions(+), 20 deletions(-)

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
 
diff --git a/t/t5571-pre-push-hook.sh b/t/t5571-pre-push-hook.sh
index 6f9916a..ba975bb 100755
--- a/t/t5571-pre-push-hook.sh
+++ b/t/t5571-pre-push-hook.sh
@@ -109,23 +109,20 @@ test_expect_success 'push to URL' '
 	diff expected actual
 '
 
-# Test that filling pipe buffers doesn't cause failure
-# Too slow to leave enabled for general use
-if false
-then
-	printf 'parent1\nrepo1\n' >expected
-	nr=1000
-	while test $nr -lt 2000
-	do
-		nr=$(( $nr + 1 ))
-		git branch b/$nr $COMMIT3
-		echo "refs/heads/b/$nr $COMMIT3 refs/heads/b/$nr $_z40" >>expected
-	done
-
-	test_expect_success 'push many refs' '
-		git push parent1 "refs/heads/b/*:refs/heads/b/*" &&
-		diff expected actual
-	'
-fi
+test_expect_success 'set up many-ref tests' '
+	{
+		nr=1000
+		while test $nr -lt 2000
+		do
+			nr=$(( $nr + 1 ))
+			echo "create refs/heads/b/$nr $COMMIT3"
+		done
+	} | git update-ref --stdin
+'
+
+test_expect_success 'sigpipe does not cause pre-push hook failure' '
+	echo "exit 0" | write_script "$HOOK" &&
+	git push parent1 "refs/heads/b/*:refs/heads/b/*"
+'
 
 test_done
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
