From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 10/13] credentials: add "cache" helper
Date: Mon, 9 Jan 2012 23:44:30 -0500
Message-ID: <20120110044430.GA23619@sigill.intra.peff.net>
References: <20111210102827.GA16460@sigill.intra.peff.net>
 <20111210103407.GJ16529@sigill.intra.peff.net>
 <20120110015038.GA17754@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 05:44:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkTZw-0005Y0-9m
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 05:44:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756074Ab2AJEod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 23:44:33 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60885
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756036Ab2AJEoc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 23:44:32 -0500
Received: (qmail 5788 invoked by uid 107); 10 Jan 2012 04:51:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 Jan 2012 23:51:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jan 2012 23:44:30 -0500
Content-Disposition: inline
In-Reply-To: <20120110015038.GA17754@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188213>

On Mon, Jan 09, 2012 at 07:50:38PM -0600, Jonathan Nieder wrote:

> 	--- expect-stderr       2012-01-10 00:07:02.398365248 +0000
> 	+++ stderr      2012-01-10 00:07:02.418364996 +0000
> 	@@ -1,2 +1,3 @@
> 	+fatal: socket path is too long to fit in sockaddr
> 	 askpass: Username for 'https://example.com':
> 	 askpass: Password for 'https://askpass-username@example.com':
> 	not ok - 1 helper (cache) has no existing data
> 
> I didn't notice until recently because typically the cwd is short.
> The sun_path[] array on this machine is 108 bytes; POSIX informs me
> that some platforms make it as small as 96 bytes and there's no
> guaranteed lower limit.  The machines[*] triggering it were running
> tests in a chroot, hence the long path.

Ugh. Some days I really love working on Unix systems. And then some days
you run across junk like this.

Presumably Linux has kept to 108 to avoid breaking older programs.  So
it's not as if we can assume it will be changed soon, or just write this
off as a limitation for old crappy systems.

Googling around, I've seen some indication that you can simply
over-allocate the sockaddr_un and pass a longer length to connect.
However that just seems to yield EINVAL on Linux (and even if it did
work on Linux, I'd be surprised if it worked everywhere).

Which really leaves us with only one option: chdir and bind to a
relative path, as you did below.

> -	if (!socket_path)
> -		socket_path = expand_user_path("~/.git-credential-cache/socket");
> -	if (!socket_path)
> -		die("unable to find a suitable socket path; use --socket");
> +	if (!socket_path) {
> +		char *home = expand_user_path("~");
> +		if (!home)
> +			die("unable to find a suitable socket path; use --socket");
> +
> +		if (!chdir(home))
> +			socket_path = ".git-credential-cache/socket";
> +		else if (errno == ENOENT && !strcmp(op, "exit"))
> +			return 0;
> +		else
> +			die("cannot enter home directory");
> +	}

I think this is the right approach, but the wrong place to do it. Your
patch only helps people using the default path (so passing
--socket=$longpath would still be broken). And we'd need a similar fix
for the binding side in credential-cache--daemon.

Here's a patch which passes your $longpath test.

-- >8 --
Subject: [PATCH] unix-socket: handle long socket pathnames

On many systems, the sockaddr_un.sun_path field is quite
small. Even on Linux, it is only 108 characters. A user of
the credential-cache daemon can easily surpass this,
especially if their home directory is in a deep directory
tree (since the default location expands ~/.git-credentials).

We can hack around this in the unix-socket.[ch] code by
doing a chdir() to the enclosing directory, feeding the
relative basename to the socket functions, and then
restoring the working directory.

This introduces several new possible error cases for
creating a socket, including an irrecoverable one in the
case that we can't restore the working directory. In the
case of the credential-cache code, we could perhaps get away
with simply chdir()-ing to the socket directory and never
coming back. However, I'd rather do it at the lower level
for a few reasons:

  1. It keeps the hackery behind an opaque interface instead
     of polluting the main program logic.

  2. A hack in credential-cache won't help any unix-socket
     users who come along later.

  3. The chdir trickery isn't that likely to fail (basically
     it's only a problem if your cwd is missing or goes away
     while you're running).  And because we only enable the
     hack when we get a too-long name, it can only fail in
     cases that would have failed under the previous code
     anyway.

Signed-off-by: Jeff King <peff@peff.net>
---
 unix-socket.c |   74 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/unix-socket.c b/unix-socket.c
index 84b1509..664782a 100644
--- a/unix-socket.c
+++ b/unix-socket.c
@@ -9,27 +9,86 @@ static int unix_stream_socket(void)
 	return fd;
 }
 
-static void unix_sockaddr_init(struct sockaddr_un *sa, const char *path)
+static int chdir_len(const char *orig, int len)
+{
+	char *path = xmemdupz(orig, len);
+	int r = chdir(path);
+	free(path);
+	return r;
+}
+
+struct unix_sockaddr_context {
+	char orig_dir[PATH_MAX];
+};
+
+static void unix_sockaddr_cleanup(struct unix_sockaddr_context *ctx)
+{
+	if (!ctx->orig_dir[0])
+		return;
+	/*
+	 * If we fail, we can't just return an error, since we have
+	 * moved the cwd of the whole process, which could confuse calling
+	 * code.  We are better off to just die.
+	 */
+	if (chdir(ctx->orig_dir) < 0)
+		die("unable to restore original working directory");
+}
+
+static int unix_sockaddr_init(struct sockaddr_un *sa, const char *path,
+			      struct unix_sockaddr_context *ctx)
 {
 	int size = strlen(path) + 1;
-	if (size > sizeof(sa->sun_path))
-		die("socket path is too long to fit in sockaddr");
+
+	ctx->orig_dir[0] = '\0';
+	if (size > sizeof(sa->sun_path)) {
+		const char *slash = find_last_dir_sep(path);
+		const char *dir;
+		int dir_len;
+
+		if (!slash) {
+			errno = ENAMETOOLONG;
+			return -1;
+		}
+
+		dir = path;
+		dir_len = slash - path;
+
+		path = slash + 1;
+		size = strlen(path) + 1;
+		if (size > sizeof(sa->sun_path)) {
+			errno = ENAMETOOLONG;
+			return -1;
+		}
+
+		if (!getcwd(ctx->orig_dir, sizeof(ctx->orig_dir))) {
+			errno = ENAMETOOLONG;
+			return -1;
+		}
+		if (chdir_len(dir, dir_len) < 0)
+			return -1;
+	}
+
 	memset(sa, 0, sizeof(*sa));
 	sa->sun_family = AF_UNIX;
 	memcpy(sa->sun_path, path, size);
+	return 0;
 }
 
 int unix_stream_connect(const char *path)
 {
 	int fd;
 	struct sockaddr_un sa;
+	struct unix_sockaddr_context ctx;
 
-	unix_sockaddr_init(&sa, path);
+	if (unix_sockaddr_init(&sa, path, &ctx) < 0)
+		return -1;
 	fd = unix_stream_socket();
 	if (connect(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0) {
+		unix_sockaddr_cleanup(&ctx);
 		close(fd);
 		return -1;
 	}
+	unix_sockaddr_cleanup(&ctx);
 	return fd;
 }
 
@@ -37,20 +96,25 @@ int unix_stream_listen(const char *path)
 {
 	int fd;
 	struct sockaddr_un sa;
+	struct unix_sockaddr_context ctx;
 
-	unix_sockaddr_init(&sa, path);
+	if (unix_sockaddr_init(&sa, path, &ctx) < 0)
+		return -1;
 	fd = unix_stream_socket();
 
 	unlink(path);
 	if (bind(fd, (struct sockaddr *)&sa, sizeof(sa)) < 0) {
+		unix_sockaddr_cleanup(&ctx);
 		close(fd);
 		return -1;
 	}
 
 	if (listen(fd, 5) < 0) {
+		unix_sockaddr_cleanup(&ctx);
 		close(fd);
 		return -1;
 	}
 
+	unix_sockaddr_cleanup(&ctx);
 	return fd;
 }
-- 
1.7.9.rc0.33.g15ced5
