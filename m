From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] connect: let callers know if connection is a socket
Date: Mon, 16 May 2011 02:52:11 -0400
Message-ID: <20110516065211.GB19078@sigill.intra.peff.net>
References: <20110516063944.GB25731@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon May 16 08:52:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLrf9-0003LZ-O8
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 08:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849Ab1EPGwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 02:52:15 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43855
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739Ab1EPGwO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 02:52:14 -0400
Received: (qmail 11329 invoked by uid 107); 16 May 2011 06:54:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 May 2011 02:54:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 May 2011 02:52:11 -0400
Content-Disposition: inline
In-Reply-To: <20110516063944.GB25731@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173711>

They might care because they want to do a half-duplex close.
With pipes, that means simply closing the output descriptor;
with a socket, you must actually call shutdown.

Instead of exposing the magic no_fork child_process struct,
let's encapsulate the test in a function.

Signed-off-by: Jeff King <peff@peff.net>
---
An more object-oriented refactoring would be something like:

  struct git_connection {
    struct child_process child;
    int in;
    int out;
  };

  void git_connection_read_fd(struct git_connection *c)
  {
          return c->in;
  }

  void git_connect_write_fd(struct git_connect *c)
  {
          return c->child.pid ? c->out : c->in;
  }

  void git_connection_half_duplex_close(struct git_connection *c)
  {
          if (!c->child.pid)
                  shutdown(c->in, SHUT_WR);
          else
                  close(c->out);
  }

but the idea that a git connection is defined by two file descriptors
runs throughout the code (in fact, we don't even explicitly do the
half-duplex close in the pipe case; we hand the descriptor off to the
pack-objects run-command, which takes ownership). So trying to be fancy
and abstracted is not worth it in this case.

 cache.h   |    1 +
 connect.c |    7 ++++++-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index bf468e5..724aad4 100644
--- a/cache.h
+++ b/cache.h
@@ -865,6 +865,7 @@ extern struct ref *find_ref_by_name(const struct ref *list, const char *name);
 #define CONNECT_VERBOSE       (1u << 0)
 extern struct child_process *git_connect(int fd[2], const char *url, const char *prog, int flags);
 extern int finish_connect(struct child_process *conn);
+extern int git_connection_is_socket(struct child_process *conn);
 extern int path_match(const char *path, int nr, char **match);
 struct extra_have_objects {
 	int nr, alloc;
diff --git a/connect.c b/connect.c
index 86ad150..20a008d 100644
--- a/connect.c
+++ b/connect.c
@@ -634,10 +634,15 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 	return conn;
 }
 
+int git_connection_is_socket(struct child_process *conn)
+{
+	return conn == &no_fork;
+}
+
 int finish_connect(struct child_process *conn)
 {
 	int code;
-	if (!conn || conn == &no_fork)
+	if (!conn || git_connection_is_socket(conn))
 		return 0;
 
 	code = finish_command(conn);
-- 
1.7.5.1.13.g0ca09.dirty
