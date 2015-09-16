From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 36/67] remote-ext: simplify git pkt-line generation
Date: Wed, 16 Sep 2015 17:23:39 -0400
Message-ID: <20150916212339.GF3915@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915155210.GJ29753@sigill.intra.peff.net>
 <xmqqfv2ep18k.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 23:23:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcKBE-0000mw-VM
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 23:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904AbbIPVXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 17:23:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:60390 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752498AbbIPVXs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 17:23:48 -0400
Received: (qmail 27904 invoked by uid 102); 16 Sep 2015 21:23:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 16:23:48 -0500
Received: (qmail 23851 invoked by uid 107); 16 Sep 2015 21:23:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 17:23:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Sep 2015 17:23:39 -0400
Content-Disposition: inline
In-Reply-To: <xmqqfv2ep18k.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278069>

On Wed, Sep 16, 2015 at 01:18:03PM -0700, Junio C Hamano wrote:

> > +	/* Now go back and fill in the size */
> > +	if (buffer.len > 0xFFFF)
> >  		die("Request too large to send");
> > +	xsnprintf(buffer.buf, buffer.alloc, "%04x", (unsigned)buffer.len);
> 
> So we now write "0000something something\0host=something" into the buffer
> and then try to overwrite the first four bytes?  Does this xsnprintf()
> stop after writing the four hexadecimal, or does it clobber the first
> byte of the payload (i.e. copy of serv[0]) by a NUL termination?

Argh, you're right, this is totally broken. We obviously have zero test
coverage of this feature. :(

This strategy cannot work at all without a way to format without adding
the NUL (or hackily saving and restoring the overwritten character).
The pkt-line code does its own hex formatting to get around this.

In fact...I think this whole patch can basically be replaced with a call
to packet_write().

Like this:

-- >8 --
Subject: [PATCH] remote-ext: simplify git pkt-line generation

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
2.6.0.rc2.408.ga2926b9
