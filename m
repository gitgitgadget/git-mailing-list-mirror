From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] transport: unambiguously determine local HEAD
Date: Sun, 15 Feb 2009 15:01:31 -0500
Message-ID: <20090215200131.GB26779@coredump.intra.peff.net>
References: <20090215195826.GA26740@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 21:03:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYnCh-0005wD-Mi
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 21:03:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbZBOUBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 15:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbZBOUBd
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 15:01:33 -0500
Received: from peff.net ([208.65.91.99]:59299 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751272AbZBOUBd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 15:01:33 -0500
Received: (qmail 9808 invoked by uid 107); 15 Feb 2009 20:01:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 15 Feb 2009 15:01:52 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Feb 2009 15:01:31 -0500
Content-Disposition: inline
In-Reply-To: <20090215195826.GA26740@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110051>

When we fetch refs using the git protocol, we have to guess
at which ref is pointed to by the HEAD. In the case of a
local filesystem repo, however, we can cheat by going to
that repo and peeking directly at the contents of HEAD.

Signed-off-by: Jeff King <peff@peff.net>
---
Again, this fails tests in t5505, and is not meant for inclusion.

 transport.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/transport.c b/transport.c
index c9f31f6..e575203 100644
--- a/transport.c
+++ b/transport.c
@@ -12,6 +12,8 @@
 #include "dir.h"
 #include "refs.h"
 
+static int is_local(const char *url);
+
 /* rsync support */
 
 /*
@@ -609,6 +611,40 @@ static int connect_setup(struct transport *transport)
 	return 0;
 }
 
+static void mark_head_via_local(const char *url, struct ref *refs)
+{
+	static const char *argv[] = { "symbolic-ref", "HEAD", NULL };
+	static const char *env[] = { GIT_DIR_ENVIRONMENT, NULL };
+	struct child_process cmd;
+	struct ref *head;
+	struct strbuf buf = STRBUF_INIT;
+
+	head = find_ref_by_name(refs, "HEAD");
+	if (!head)
+		return;
+
+	memset(&cmd, 0, sizeof cmd);
+	cmd.argv = argv;
+	cmd.env = env;
+	cmd.dir = url;
+	cmd.git_cmd = 1;
+	cmd.no_stdin = 1;
+	cmd.no_stderr = 1;
+	cmd.out = -1;
+
+	if (start_command(&cmd) < 0)
+		return;
+	if (strbuf_read(&buf, cmd.out, 64) < 0)
+		return;
+	if (finish_command(&cmd) != 0) {
+		strbuf_release(&buf);
+		return;
+	}
+
+	strbuf_trim(&buf);
+	head->symref = strbuf_detach(&buf, NULL);
+}
+
 static struct ref *get_refs_via_connect(struct transport *transport)
 {
 	struct git_transport_data *data = transport->data;
@@ -617,6 +653,9 @@ static struct ref *get_refs_via_connect(struct transport *transport)
 	connect_setup(transport);
 	get_remote_heads(data->fd[0], &refs, 0, NULL, 0, NULL);
 
+	if (is_local(transport->url))
+		mark_head_via_local(transport->url, refs);
+
 	return refs;
 }
 
-- 
1.6.2.rc0.258.gcef3.dirty
