From: Jeff King <peff@peff.net>
Subject: [PATCH 37/68] remote-ext: simplify git pkt-line generation
Date: Thu, 24 Sep 2015 17:07:27 -0400
Message-ID: <20150924210727.GH30946@sigill.intra.peff.net>
References: <20150924210225.GA23624@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 24 23:10:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfDmB-0004AY-SY
	for gcvg-git-2@plane.gmane.org; Thu, 24 Sep 2015 23:10:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754591AbbIXVJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 17:09:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:35985 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753399AbbIXVHa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 17:07:30 -0400
Received: (qmail 12047 invoked by uid 102); 24 Sep 2015 21:07:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 16:07:29 -0500
Received: (qmail 29298 invoked by uid 107); 24 Sep 2015 21:07:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 24 Sep 2015 17:07:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2015 17:07:27 -0400
Content-Disposition: inline
In-Reply-To: <20150924210225.GA23624@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278625>

We format a pkt-line into a heap buffer, which requires
manual computation of the required size, and uses some bare
sprintf calls. We could use a strbuf instead, which would
take care of the computation for us. But it's even easier
still to use packet_write(). Besides handling the formatting
and writing for us, it fixes two things:

  1. Our manual max-size check used 0xFFFF, while technically
     LARGE_PACKET_MAX is slightly smaller than this.

  2. Our packet will now be output as part of
     GIT_TRACE_PACKET debugging.

Unfortunately packet_write() does not let us build up the
buffer progressively, so we do have to repeat ourselves a
little depending on the "vhost" setting, but the end result
is still far more readable than the original.

Since there were no tests covering this feature at all,
we'll add a few into t5802.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/remote-ext.c      | 34 +++++-----------------------------
 t/t5802-connect-helper.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 29 deletions(-)

diff --git a/builtin/remote-ext.c b/builtin/remote-ext.c
index 3b8c22c..e3cd25d 100644
--- a/builtin/remote-ext.c
+++ b/builtin/remote-ext.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "transport.h"
 #include "run-command.h"
+#include "pkt-line.h"
 
 /*
  * URL syntax:
@@ -142,36 +143,11 @@ static const char **parse_argv(const char *arg, const char *service)
 static void send_git_request(int stdin_fd, const char *serv, const char *repo,
 	const char *vhost)
 {
-	size_t bufferspace;
-	size_t wpos = 0;
-	char *buffer;
-
-	/*
-	 * Request needs 12 bytes extra if there is vhost (xxxx \0host=\0) and
-	 * 6 bytes extra (xxxx \0) if there is no vhost.
-	 */
-	if (vhost)
-		bufferspace = strlen(serv) + strlen(repo) + strlen(vhost) + 12;
+	if (!vhost)
+		packet_write(stdin_fd, "%s %s%c", serv, repo, 0);
 	else
-		bufferspace = strlen(serv) + strlen(repo) + 6;
-
-	if (bufferspace > 0xFFFF)
-		die("Request too large to send");
-	buffer = xmalloc(bufferspace);
-
-	/* Make the packet. */
-	wpos = sprintf(buffer, "%04x%s %s%c", (unsigned)bufferspace,
-		serv, repo, 0);
-
-	/* Add vhost if any. */
-	if (vhost)
-		sprintf(buffer + wpos, "host=%s%c", vhost, 0);
-
-	/* Send the request */
-	if (write_in_full(stdin_fd, buffer, bufferspace) < 0)
-		die_errno("Failed to send request");
-
-	free(buffer);
+		packet_write(stdin_fd, "%s %s%chost=%s%c", serv, repo, 0,
+			     vhost, 0);
 }
 
 static int run_child(const char *arg, const char *service)
diff --git a/t/t5802-connect-helper.sh b/t/t5802-connect-helper.sh
index 878faf2..b7a7f9d 100755
--- a/t/t5802-connect-helper.sh
+++ b/t/t5802-connect-helper.sh
@@ -69,4 +69,32 @@ test_expect_success 'update backfilled tag without primary transfer' '
 	test_cmp expect actual
 '
 
+
+test_expect_success 'set up fake git-daemon' '
+	mkdir remote &&
+	git init --bare remote/one.git &&
+	mkdir remote/host &&
+	git init --bare remote/host/two.git &&
+	write_script fake-daemon <<-\EOF &&
+	git daemon --inetd \
+		--informative-errors \
+		--export-all \
+		--base-path="$TRASH_DIRECTORY/remote" \
+		--interpolated-path="$TRASH_DIRECTORY/remote/%H%D" \
+		"$TRASH_DIRECTORY/remote"
+	EOF
+	export TRASH_DIRECTORY &&
+	PATH=$TRASH_DIRECTORY:$PATH
+'
+
+test_expect_success 'ext command can connect to git daemon (no vhost)' '
+	rm -rf dst &&
+	git clone "ext::fake-daemon %G/one.git" dst
+'
+
+test_expect_success 'ext command can connect to git daemon (vhost)' '
+	rm -rf dst &&
+	git clone "ext::fake-daemon %G/two.git %Vhost" dst
+'
+
 test_done
-- 
2.6.0.rc3.454.g204ad51
