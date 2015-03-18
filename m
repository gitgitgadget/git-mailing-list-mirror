From: Jeff King <peff@peff.net>
Subject: [PATCH] clone: initialize atexit cleanup handler earlier
Date: Wed, 18 Mar 2015 14:55:32 -0400
Message-ID: <20150318185531.GA650@peff.net>
References: <etPan.5509bdf2.7a1ae87d.1766@ttvadmins-MacBook-Pro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Spencer Nelson <s@spenczar.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 19:55:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYJ80-0000wM-Op
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 19:55:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755379AbbCRSzf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Mar 2015 14:55:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:34772 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754887AbbCRSze (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 14:55:34 -0400
Received: (qmail 24150 invoked by uid 102); 18 Mar 2015 18:55:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Mar 2015 13:55:34 -0500
Received: (qmail 5744 invoked by uid 107); 18 Mar 2015 18:55:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Mar 2015 14:55:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Mar 2015 14:55:32 -0400
Content-Disposition: inline
In-Reply-To: <etPan.5509bdf2.7a1ae87d.1766@ttvadmins-MacBook-Pro.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265747>

On Wed, Mar 18, 2015 at 11:03:30AM -0700, Spencer Nelson wrote:

> If you=E2=80=99re in a shell in a directory which no longer exists (b=
ecause,
> say, another terminal removed it), then getcwd() will fail, at least
> on OS X Yosemite 10.10.2. In this case, git clone will fail. That=E2=80=
=99s
> totally reasonable.

Yeah, we fail in set_git_work_tree, which calls real_path() on the new
directory, which fails because it cannot get the current working
directory. In the example you gave, we already have an absolute path to
the new directory, and it is outside the "disappeared" directory. So I
would think we could get by without having a cwd. It looks like we do s=
o
because we have to chdir() away from the cwd as part of real_path, and
then need to be able to chdir back. So I'm not sure there's an easy way
to fix it.

Anyway, that's tangential to your actual problem...

> If you invoke git clone with the git clone <repo> <dir> syntax, then
> <dir> will be created, but it will be empty.

I think the original code just didn't expect set_git_work_tree to fail,
and doesn't install the cleanup code until after it is called. This
patch fixes it.

-- >8 --
Subject: clone: initialize atexit cleanup handler earlier

If clone fails, we generally try to clean up any directories
we've created. We do this by installing an atexit handler,
so that we don't have to manually trigger cleanup. However,
since we install this after touching the filesystem, any
errors between our initial mkdir() and our atexit() call
will result in us leaving a crufty directory around.

We can fix this by moving our atexit() call earlier. It's OK
to do it before the junk_work_tree variable is set, because
remove_junk makes sure the variable is initialized. This
means we "activate" the handler by assigning to the
junk_work_tree variable, which we now bump down to just
after we call mkdir(). We probably do not want to do it
before, because a plausible reason for mkdir() to fail is
EEXIST (i.e., we are racing with another "git init"), and we
would not want to remove their work.

OTOH, this is probably not that big a deal; we will allow
cloning into an empty directory (and skip the mkdir), which
is already racy (i.e., one clone may see the other's empty
dir and start writing into it). Still, it does not hurt to
err on the side of caution here.

Note that writing into junk_work_tree and junk_git_dir after
installing the handler is also technically racy, as we call
our handler on an async signal.  Depending on the platform,
we could see a sheared write to the variables. Traditionally
we have not worried about this, and indeed we already do
this later in the function. If we want to address that, it
can come as a separate topic.

Signed-off-by: Jeff King <peff@peff.net>
---
Sheesh, for such a little change, there are a lot of racy things to
think about. Note that even if we did want to make two racing clone
processes atomic in creating the working tree, the whole git_dir
initialization is still not (and explicitly ignores EEXIST). I think if
somebody wants atomicity here, they should do the mkdir themselves, and
then have git fill in the rest.

No test. I seem to recall that Windows is tricky with making the cwd go
away (can you even do it there while a process is still in it?), and I
don't think such a minor thing is worth the portability headcaches in
the test suite.

 builtin/clone.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index aa01437..53a2e5a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -842,20 +842,21 @@ int cmd_clone(int argc, const char **argv, const =
char *prefix)
 		git_dir =3D mkpathdup("%s/.git", dir);
 	}
=20
+	atexit(remove_junk);
+	sigchain_push_common(remove_junk_on_signal);
+
 	if (!option_bare) {
-		junk_work_tree =3D work_tree;
 		if (safe_create_leading_directories_const(work_tree) < 0)
 			die_errno(_("could not create leading directories of '%s'"),
 				  work_tree);
 		if (!dest_exists && mkdir(work_tree, 0777))
 			die_errno(_("could not create work tree dir '%s'"),
 				  work_tree);
+		junk_work_tree =3D work_tree;
 		set_git_work_tree(work_tree);
 	}
-	junk_git_dir =3D git_dir;
-	atexit(remove_junk);
-	sigchain_push_common(remove_junk_on_signal);
=20
+	junk_git_dir =3D git_dir;
 	if (safe_create_leading_directories_const(git_dir) < 0)
 		die(_("could not create leading directories of '%s'"), git_dir);
=20
--=20
2.3.3.520.g3cfbb5d
