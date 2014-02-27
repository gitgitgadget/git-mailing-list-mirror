From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] upload-pack: allow shallow fetching from a read-only
 repository
Date: Thu, 27 Feb 2014 04:04:26 -0500
Message-ID: <20140227090426.GA21892@sigill.intra.peff.net>
References: <1393485183-20100-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 10:05:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIwtl-0000zT-MS
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 10:04:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbaB0JEt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Feb 2014 04:04:49 -0500
Received: from cloud.peff.net ([50.56.180.127]:57881 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750979AbaB0JE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 04:04:29 -0500
Received: (qmail 11412 invoked by uid 102); 27 Feb 2014 09:04:28 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Feb 2014 03:04:28 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Feb 2014 04:04:26 -0500
Content-Disposition: inline
In-Reply-To: <1393485183-20100-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242792>

On Thu, Feb 27, 2014 at 02:13:03PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:

> Before cdab485 (upload-pack: delegate rev walking in shallow fetch to
> pack-objects - 2013-08-16) upload-pack does not write to the source
> repository. cdab485 starts to write $GIT_DIR/shallow_XXXXXX if it's a
> shallow fetch, so the source repo must be writable.
>=20
> Fall back to $TMPDIR if $GIT_DIR/shallow_XXXXXX cannot be created in
> this case. Note that in other cases that write $GIT_DIR/shallow_XXXXX=
X
> and eventually rename it to $GIT_DIR/shallow, there is no fallback to
> $TMPDIR.

That makes sense.

> @@ -224,7 +224,16 @@ char *setup_temporary_shallow(const struct sha1_=
array *extra)
>  	if (write_shallow_commits(&sb, 0, extra)) {
>  		struct strbuf path =3D STRBUF_INIT;
>  		strbuf_addstr(&path, git_path("shallow_XXXXXX"));
> -		fd =3D xmkstemp(path.buf);
> +		if (read_only) {
> +			fd =3D mkstemp(path.buf);
> +			if (fd < 0) {
> +				char buf[PATH_MAX];
> +				fd =3D git_mkstemp(buf, sizeof(buf), "shallow_XXXXXX");
> +			}
> +			if (fd < 0)
> +				die_errno("Unable to create temporary shallow file");
> +		} else
> +			fd =3D xmkstemp(path.buf);

This is not introduced by your patch, but I notice that we do not seem
to do anything with the tempfiles when the program dies prematurely.
We've started collecting stale shallow_XXXXXX files in our server repos=
=2E

=46or the writable cases, should we be using the lockfile API to take
shallow.lock? It looks like we do take a lock on it, but only after the
fetch, and then we have to do a manual check for it having moved (by th=
e
way, shouldn't we do that check under the lock? I think
setup_alternate_shallow has a race condition).

I guess the reason to take the lock at the last minute is that the whol=
e
fetch is heavyweight. But if the fetches are going to conflict, perhaps
it is better to have lock contention at the beginning, rather than
failing only at the end. I don't know very much about the shallow
system; does each operation rewrite the shallow file, or is it often
left untouched (in which case two simultaneous fetches could coexist
most of the time).

At any rate, if we used the lockfile API, it handles tempfile cleanup
automatically. Otherwise, I think we need something like the patch
below (in the interest of simplicity, I just drop all of the explicit
unlinks and let them use the atexit handler to clean up; you could also
add a function to explicitly unlink the tempfile and clear the handler)=
=2E

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 85bba35..ac1d9b5 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -833,8 +833,6 @@ static void execute_commands(struct command *comman=
ds,
 			error("BUG: run 'git fsck' for safety.\n"
 			      "If there are errors, try to remove "
 			      "the reported refs above");
-		if (alt_shallow_file && *alt_shallow_file)
-			unlink(alt_shallow_file);
 	}
 }
=20
@@ -1087,10 +1085,6 @@ static void update_shallow_info(struct command *=
commands,
 			cmd->skip_update =3D 1;
 		}
 	}
-	if (alt_shallow_file && *alt_shallow_file) {
-		unlink(alt_shallow_file);
-		alt_shallow_file =3D NULL;
-	}
 	free(ref_status);
 }
=20
diff --git a/fetch-pack.c b/fetch-pack.c
index 90fdd49..ae8550e 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -947,17 +947,6 @@ static void update_shallow(struct fetch_pack_args =
*args,
 	if (!si->shallow || !si->shallow->nr)
 		return;
=20
-	if (alternate_shallow_file) {
-		/*
-		 * The temporary shallow file is only useful for
-		 * index-pack and unpack-objects because it may
-		 * contain more roots than we want. Delete it.
-		 */
-		if (*alternate_shallow_file)
-			unlink(alternate_shallow_file);
-		free((char *)alternate_shallow_file);
-	}
-
 	if (args->cloning) {
 		/*
 		 * remote is shallow, but this is a clone, there are
diff --git a/shallow.c b/shallow.c
index bbc98b5..0f2bb48 100644
--- a/shallow.c
+++ b/shallow.c
@@ -8,6 +8,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "commit-slab.h"
+#include "sigchain.h"
=20
 static int is_shallow =3D -1;
 static struct stat shallow_stat;
@@ -216,27 +217,49 @@ int write_shallow_commits(struct strbuf *out, int=
 use_pack_protocol,
 	return write_shallow_commits_1(out, use_pack_protocol, extra, 0);
 }
=20
+static struct strbuf shallow_tmpfile =3D STRBUF_INIT;
+
+static void remove_shallow_tmpfile(void)
+{
+	if (shallow_tmpfile.len) {
+		unlink_or_warn(shallow_tmpfile.buf);
+		strbuf_reset(&shallow_tmpfile);
+	}
+}
+
+static void remove_shallow_tmpfile_on_signal(int signo)
+{
+	remove_shallow_tmpfile();
+	sigchain_pop(signo);
+	raise(signo);
+}
+
 char *setup_temporary_shallow(const struct sha1_array *extra)
 {
 	struct strbuf sb =3D STRBUF_INIT;
 	int fd;
=20
 	if (write_shallow_commits(&sb, 0, extra)) {
-		struct strbuf path =3D STRBUF_INIT;
-		strbuf_addstr(&path, git_path("shallow_XXXXXX"));
-		fd =3D xmkstemp(path.buf);
+		strbuf_addstr(&shallow_tmpfile, git_path("shallow_XXXXXX"));
+		fd =3D xmkstemp(shallow_tmpfile.buf);
+
+		/* XXX can there be multiple shallow tempfiles in one program?
+		 * In that case, we would need to maintain a list */
+		atexit(remove_shallow_tmpfile);
+		sigchain_push_common(remove_shallow_tmpfile_on_signal);
+
 		if (write_in_full(fd, sb.buf, sb.len) !=3D sb.len)
 			die_errno("failed to write to %s",
-				  path.buf);
+				  shallow_tmpfile.buf);
 		close(fd);
 		strbuf_release(&sb);
-		return strbuf_detach(&path, NULL);
+		return shallow_tmpfile.buf;
 	}
 	/*
 	 * is_repository_shallow() sees empty string as "no shallow
 	 * file".
 	 */
-	return xstrdup("");
+	return shallow_tmpfile.buf;
 }
=20
 void setup_alternate_shallow(struct lock_file *shallow_lock,
diff --git a/upload-pack.c b/upload-pack.c
index 0c44f6b..55c1f71 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -242,11 +242,6 @@ static void create_pack_file(void)
 		error("git upload-pack: git-pack-objects died with error.");
 		goto fail;
 	}
-	if (shallow_file) {
-		if (*shallow_file)
-			unlink(shallow_file);
-		free(shallow_file);
-	}
=20
 	/* flush the data */
 	if (0 <=3D buffered) {
