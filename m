From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] daemon: Skip unknown "extra arg" information
Date: Thu, 4 Jun 2009 18:33:32 -0700
Message-ID: <20090605013332.GV3355@spearce.org>
References: <20090604220824.GT3355@spearce.org> <7vbpp3tsg0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 03:33:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCOJR-0000zp-0S
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 03:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373AbZFEBdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 21:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752205AbZFEBda
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 21:33:30 -0400
Received: from george.spearce.org ([209.20.77.23]:51937 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752138AbZFEBda (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 21:33:30 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 37530381D1; Fri,  5 Jun 2009 01:33:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vbpp3tsg0.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120733>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > If we don't recognize an extra arg supplied hidden behind the
> > command, we should skip it and look at the next extra arg, in
> > case we recognize the next one.
> >
> > For example, we currently don't recognize the "user=" extra arg,
> > but we should still be able to start this connection anyway:
> 
> I do not necessarily agree 100% with that argument.

Actually, we're already f'kd.  We can't change the protocol like
we had hoped.  I still think this should go in maint.

--8<--
daemon: Strictly parse the "extra arg" part of the command

Since 1.4.4.5 (49ba83fb67 "Add virtualization support to git-daemon")
git daemon enters an infinite loop and never terminates if a client
hides any extra arguments in the initial request line which is not
exactly "\0host=blah\0".

Since that change, a client must never insert additional extra
arguments, or attempt to use any argument other than "host=", as
any daemon will get stuck parsing the request line and will never
complete the request.

Since the client can't tell if the daemon is patched or not, it
is not possible to know if additional extra args might actually be
able to be safely requested.

If we ever need to extend the git daemon protocol to support a new
feature, we may have to do something like this to the exchange:

  # If both support git:// v2
  #
  C: 000cgit://v2
  S: 0010ok host user
  C: 0018host git.kernel.org
  C: 0027git-upload-pack /pub/linux-2.6.git
  S: ...git-upload-pack header...

  # If client supports git:// v2, server does not:
  #
  C: 000cgit://v2
  S: <EOF>

  C: 003bgit-upload-pack /pub/linux-2.6.git\0host=git.kernel.org\0
  S: ...git-upload-pack header...

This requires the client to create two TCP connections to talk to
an older git daemon, however all daemons since the introduction of
daemon.c will safely reject the unknown "git://v2" command request,
so the client can quite easily determine the server supports an
older protocol.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 connect.c |    5 ++++-
 daemon.c  |   10 ++++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/connect.c b/connect.c
index f6b8ba6..958c831 100644
--- a/connect.c
+++ b/connect.c
@@ -579,7 +579,10 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 			git_tcp_connect(fd, host, flags);
 		/*
 		 * Separate original protocol components prog and path
-		 * from extended components with a NUL byte.
+		 * from extended host header with a NUL byte.
+		 *
+		 * Note: Do not add any other headers here!  Doing so
+		 * will cause older git-daemon servers to crash.
 		 */
 		packet_write(fd[1],
 			     "%s %s%chost=%s%c",
diff --git a/daemon.c b/daemon.c
index daa4c8e..b2babcc 100644
--- a/daemon.c
+++ b/daemon.c
@@ -406,15 +406,15 @@ static char *xstrdup_tolower(const char *str)
 }
 
 /*
- * Separate the "extra args" information as supplied by the client connection.
+ * Read the host as supplied by the client connection.
  */
-static void parse_extra_args(char *extra_args, int buflen)
+static void parse_host_arg(char *extra_args, int buflen)
 {
 	char *val;
 	int vallen;
 	char *end = extra_args + buflen;
 
-	while (extra_args < end && *extra_args) {
+	if (extra_args < end && *extra_args) {
 		saw_extended_args = 1;
 		if (strncasecmp("host=", extra_args, 5) == 0) {
 			val = extra_args + 5;
@@ -436,6 +436,8 @@ static void parse_extra_args(char *extra_args, int buflen)
 			/* On to the next one */
 			extra_args = val + vallen;
 		}
+		if (extra_args < end && *extra_args)
+			die("Invalid request");
 	}
 
 	/*
@@ -545,7 +547,7 @@ static int execute(struct sockaddr *addr)
 	hostname = canon_hostname = ip_address = tcp_port = NULL;
 
 	if (len != pktlen)
-		parse_extra_args(line + len + 1, pktlen - len - 1);
+		parse_host_arg(line + len + 1, pktlen - len - 1);
 
 	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
 		struct daemon_service *s = &(daemon_service[i]);
-- 
1.6.3.2.277.gd10543

-- 
Shawn.
