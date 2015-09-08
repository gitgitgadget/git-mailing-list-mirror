From: Jeff King <peff@peff.net>
Subject: [PATCH] git_connect: clarify conn->use_shell flag
Date: Tue, 8 Sep 2015 04:33:14 -0400
Message-ID: <20150908083314.GB2991@sigill.intra.peff.net>
References: <CAOxFTcx9E_FtYD_Jn3+S3j-rwGO+hJSVXUC2S5ZBB6der7dUuw@mail.gmail.com>
 <20150904125448.GA25501@sigill.intra.peff.net>
 <xmqqpp1yf3qe.fsf@gitster.mtv.corp.google.com>
 <20150904214454.GA18320@sigill.intra.peff.net>
 <20150904224008.GA11164@sigill.intra.peff.net>
 <CAOxFTcz9dZRQVnVnt+GtzAiu+GBi7CPE17d7rGo3H0v56MMAZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 10:33:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZELH-0001Sr-Mi
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 10:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676AbbIHIdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2015 04:33:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:56173 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751658AbbIHIdR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 04:33:17 -0400
Received: (qmail 32315 invoked by uid 102); 8 Sep 2015 08:33:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Sep 2015 03:33:17 -0500
Received: (qmail 20585 invoked by uid 107); 8 Sep 2015 08:33:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Sep 2015 04:33:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Sep 2015 04:33:14 -0400
Content-Disposition: inline
In-Reply-To: <CAOxFTcz9dZRQVnVnt+GtzAiu+GBi7CPE17d7rGo3H0v56MMAZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277497>

On Sat, Sep 05, 2015 at 03:50:08PM +0200, Giuseppe Bilotta wrote:

> which matches my previous findings in that the problem was
> GIT_WORK_TREE being leaked. Since setting GIT_WORK_TREE when setting
> GIT_DIR is correct, the solution is indeed to clear GIT_* environment
> variables for ssh, as you propose. I tested your patch and indeed it
> fixes my problem.

Yeah, that makes sense.

> I still don't understand why you cannot replicate the issue on your
> side. One thing that is _extremely_ important in reproducing the
> problem is that the leaked GIT_WORK_TREE point to a non-existent (or
> otherwise inaccessible) directory in the server machine. For example,
> on my first attempt to reproduce I was trying to use my clone of the
> git repo, and it wouldn't work because I _did_ have a ~/src/git on
> both machines, even though I was pushing to a
> remote.machine:/tmp/test.git

I checked that the path in question is not accessible in my test setup.
I'm also confused why it doesn't replicate for me.

I noticed that your original report shows receive-pack behaving well,
but the child unpack-objects complaining. That process should not care
about GIT_WORK_TREE either, though.

> Would it be worth looking at the issue server-side too, as this looks
> like something that might have exploit potential? (At the very least,
> it could be used to test if/which directories the remote user has
> access to.)

I think if anything, the server side should be clearing GIT_DIR,
GIT_WORK_TREE, etc, when it does enter_repo(). The point of that
function is to enter a repository which is given externally (generally
on the command-line, though in the case of git-daemon, across the
socket). Clearing any existing local-repo environment variables seems
like it should be part of that.

That's as easy as:

diff --git a/path.c b/path.c
index 95acbaf..395a75d 100644
--- a/path.c
+++ b/path.c
@@ -383,6 +383,10 @@ const char *enter_repo(const char *path, int strict)
 {
 	static char used_path[PATH_MAX];
 	static char validated_path[PATH_MAX];
+	const char * const *env;
+
+	for (env = local_repo_env; *env; env++)
+		unsetenv(*env);
 
 	if (!path)
 		return NULL;

but I suspect it would break some esoteric cases. E.g.:

  git clone -u 'git -c some.option=true upload-pack' foo.git

does what you'd expect now. With that patch, upload-pack would clear its
env before entering "foo.git", and would ignore it.

It would probably be OK to clean GIT_DIR (since we overwrite it in
enter_repo anyway) and GIT_WORK_TREE (since upload-pack, etc, should not
care about it). But the others are much more confusing (should we clear
GIT_ALTERNATE_OBJECT_DIRECTORIES? You would not want that to bleed over
between repositories, but setting it manually seems like a legitimate,
if uncommon, thing to do).

So I'm hesitant to do a patch like that because it seems like the wrong
layer. It's at the interface between the old and new repos that we need
clean these up. And we are (with my other patch) doing that on the
client side. If the server side wants to enforce some protection, that's
a good idea, too. But it should be happening at the ssh layer; i.e.,
disabling "AcceptEnv GIT_*".

> > -- >8 --
> > Subject: git_connect: clear GIT_* environment for ssh
> >
> > When we "switch" to another local repository to run the server
> > side of a fetch or push, we must clear the variables in
> > local_repo_env so that our local $GIT_DIR, etc, do not
> > pollute the upload-pack or receive-pack that is executing in
> > the "remote" repository.
> 
> I think we might want to mention GIT_WORK_TREE explicitly here, since
> this seems to be the one causing issues.

Heh. I avoided doing so because I could not convince it to cause an
issue (and even with that aside, the config thing is wrong by itself,
and I _could_ test that).

> The patch works for me, so aside from the suggested commit message
> change, I'm all for it.

Thanks for testing/reviewing.

> > @@ -778,8 +780,6 @@ struct child_process *git_connect(int fd[2], const char *url,
> >                         }
> >                         argv_array_push(&conn->args, ssh_host);
> >                 } else {
> > -                       /* remove repo-local variables from the environment */
> > -                       conn->env = local_repo_env;
> >                         conn->use_shell = 1;
> 
> Of course we're now left with just conn->use_shell = 1 in the non-ssh
> case. This could be moved in front of the if, and replaced with
> something like conn>use_shell = !(procol == PROTO_SSH), but maybe this
> would kill legibility. It's just  that a single line i the else clause
> of a large if looks odd.

Yeah, I noticed that, too, but I wanted to keep the diff minimal. Maybe
it is worth doing this cleanup on top.

-- >8 --
Subject: [PATCH] git_connect: clarify conn->use_shell flag

When executing user-specified programs, we generally always
want to use a shell, for flexibility and consistency. One
big exception is executing $GIT_SSH, which for historical
reasons must not use a shell.

Once upon a time the logic in git_connect looked like:

  if (protocol == PROTO_SSH) {
	  ... setup ssh ...
  } else {
	  ... setup local connection ...
	  conn->use_shell = 1;
  }

But over time the PROTO_SSH block has grown, and the "local"
block has shrunk so that it contains only conn->use_shell;
it's easy to miss at the end of the large block.  Moreover,
PROTO_SSH now also sometimes sets use_shell, when the new
GIT_SSH_COMMAND is used.

To make the flow easier to follow, let's just set
conn->use_shell when we're setting up the "conn" struct, and
unset it (with a comment) in the historical GIT_SSH case.

Note that for clarity we leave "use_shell" on in the case
that we fall back to our default "ssh" This looks like a
behavior change, but in practice run-command.c optimizes
shell invocations without metacharacters into a straight
execve anyway.

Signed-off-by: Jeff King <peff@peff.net>
---
 connect.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/connect.c b/connect.c
index 962f990..6f3f85e 100644
--- a/connect.c
+++ b/connect.c
@@ -723,6 +723,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 
 		/* remove repo-local variables from the environment */
 		conn->env = local_repo_env;
+		conn->use_shell = 1;
 		conn->in = conn->out = -1;
 		if (protocol == PROTO_SSH) {
 			const char *ssh;
@@ -748,15 +749,21 @@ struct child_process *git_connect(int fd[2], const char *url,
 			}
 
 			ssh = getenv("GIT_SSH_COMMAND");
-			if (ssh) {
-				conn->use_shell = 1;
+			if (ssh)
 				putty = 0;
-			} else {
+			else {
 				const char *base;
 				char *ssh_dup;
 
+				/*
+				 * GIT_SSH is the no-shell version of
+				 * GIT_SSH_COMMAND (and must remain so for
+				 * historical compatibility).
+				 */
 				ssh = getenv("GIT_SSH");
-				if (!ssh)
+				if (ssh)
+					conn->use_shell = 0;
+				else
 					ssh = "ssh";
 
 				ssh_dup = xstrdup(ssh);
@@ -779,8 +786,6 @@ struct child_process *git_connect(int fd[2], const char *url,
 				argv_array_push(&conn->args, port);
 			}
 			argv_array_push(&conn->args, ssh_host);
-		} else {
-			conn->use_shell = 1;
 		}
 		argv_array_push(&conn->args, cmd.buf);
 
-- 
2.6.0.rc0.358.gaf70435
