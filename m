From: Jeff King <peff@peff.net>
Subject: [PATCH] git_connect: clear GIT_* environment for ssh
Date: Fri, 4 Sep 2015 18:40:08 -0400
Message-ID: <20150904224008.GA11164@sigill.intra.peff.net>
References: <CAOxFTcx9E_FtYD_Jn3+S3j-rwGO+hJSVXUC2S5ZBB6der7dUuw@mail.gmail.com>
 <20150904125448.GA25501@sigill.intra.peff.net>
 <xmqqpp1yf3qe.fsf@gitster.mtv.corp.google.com>
 <20150904214454.GA18320@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 00:40:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXzeb-0005bE-Be
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 00:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933907AbbIDWkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 18:40:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:55254 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932848AbbIDWkL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 18:40:11 -0400
Received: (qmail 1245 invoked by uid 102); 4 Sep 2015 22:40:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Sep 2015 17:40:10 -0500
Received: (qmail 29925 invoked by uid 107); 4 Sep 2015 22:40:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Sep 2015 18:40:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Sep 2015 18:40:08 -0400
Content-Disposition: inline
In-Reply-To: <20150904214454.GA18320@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277345>

On Fri, Sep 04, 2015 at 05:44:54PM -0400, Jeff King wrote:

> > Just to make sure I got you correctly, you are saying that "we
> > propagate, but that is not correct. We should stop doing so", right?
> 
> Exactly. We do not propagate config over git:// or http:// (because we
> do not share our environment). Nor do we do so over same-machine
> connections (because we explicitly clean the environment). So ssh:// is
> the odd duck.

So here is the patch I would propose. I'm fairly certain it will solve
Giuseppe's problem, though I think there is something else odd going on
here that I don't understand. I'm worried that we're papering over
another regression. Giuseppe, if you can still find time to do that
bisect, it would be helpful.

-- >8 --
Subject: git_connect: clear GIT_* environment for ssh

When we "switch" to another local repository to run the server
side of a fetch or push, we must clear the variables in
local_repo_env so that our local $GIT_DIR, etc, do not
pollute the upload-pack or receive-pack that is executing in
the "remote" repository.

We have never done so for ssh connections. For the most
part, nobody has noticed because ssh will not pass unknown
environment variables by default. However, it is not out of
the question for a user to configure ssh to pass along GIT_*
variables using SendEnv/AcceptEnv.

We can demonstrate the problem by using "git -c" on a local
command and seeing its impact on a remote repository.  This
config ends up in $GIT_CONFIG_PARAMETERS. In the local case,
the config has no impact, but in the ssh transport, it does
(our test script has a fake ssh that passes through all
environment variables; this isn't normal, but does simulate
one possible setup).

Signed-off-by: Jeff King <peff@peff.net>
---
 connect.c                     |  4 ++--
 t/t5507-remote-environment.sh | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 2 deletions(-)
 create mode 100755 t/t5507-remote-environment.sh

diff --git a/connect.c b/connect.c
index c0144d8..962f990 100644
--- a/connect.c
+++ b/connect.c
@@ -721,6 +721,8 @@ struct child_process *git_connect(int fd[2], const char *url,
 		strbuf_addch(&cmd, ' ');
 		sq_quote_buf(&cmd, path);
 
+		/* remove repo-local variables from the environment */
+		conn->env = local_repo_env;
 		conn->in = conn->out = -1;
 		if (protocol == PROTO_SSH) {
 			const char *ssh;
@@ -778,8 +780,6 @@ struct child_process *git_connect(int fd[2], const char *url,
 			}
 			argv_array_push(&conn->args, ssh_host);
 		} else {
-			/* remove repo-local variables from the environment */
-			conn->env = local_repo_env;
 			conn->use_shell = 1;
 		}
 		argv_array_push(&conn->args, cmd.buf);
diff --git a/t/t5507-remote-environment.sh b/t/t5507-remote-environment.sh
new file mode 100755
index 0000000..e614929
--- /dev/null
+++ b/t/t5507-remote-environment.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+
+test_description='check environment showed to remote side of transports'
+. ./test-lib.sh
+
+test_expect_success 'set up "remote" push situation' '
+	test_commit one &&
+	git config push.default current &&
+	git init remote
+'
+
+test_expect_success 'set up fake ssh' '
+	GIT_SSH_COMMAND="f() {
+		cd \"\$TRASH_DIRECTORY\" &&
+		eval \"\$2\"
+	}; f" &&
+	export GIT_SSH_COMMAND &&
+	export TRASH_DIRECTORY
+'
+
+# due to receive.denyCurrentBranch=true
+test_expect_success 'confirm default push fails' '
+	test_must_fail git push remote
+'
+
+test_expect_success 'config does not travel over same-machine push' '
+	test_must_fail git -c receive.denyCurrentBranch=false push remote
+'
+
+test_expect_success 'config does not travel over ssh push' '
+	test_must_fail git -c receive.denyCurrentBranch=false push host:remote
+'
+
+test_done
-- 
2.5.1.812.ge796bff
