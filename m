From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] prompt: respect GIT_TERMINAL_PROMPT to disable terminal
 prompts
Date: Wed, 3 Dec 2014 22:52:29 -0500
Message-ID: <20141204035228.GB21492@peff.net>
References: <20141204034206.GA1493@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu Dec 04 04:52:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwNT5-0008Ut-Mn
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 04:52:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038AbaLDDwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 22:52:32 -0500
Received: from cloud.peff.net ([50.56.180.127]:48139 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751302AbaLDDwb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 22:52:31 -0500
Received: (qmail 9694 invoked by uid 102); 4 Dec 2014 03:52:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Dec 2014 21:52:31 -0600
Received: (qmail 2983 invoked by uid 107); 4 Dec 2014 03:52:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Dec 2014 22:52:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Dec 2014 22:52:29 -0500
Content-Disposition: inline
In-Reply-To: <20141204034206.GA1493@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260726>

If you run git as part of an automated system, you might
prefer git to die rather than try to issue a prompt on the
terminal (because there would be nobody to see it and
respond, and the process would hang forever).

This usually works out of the box because getpass() (and our
more featureful replacements) will fail when there is no
tty, but this does not cover all cases. For example, a batch
system run via ssh might have a tty, even when the user does
not expect it.

Let's provide an environment variable the user can set to
avoid even trying to touch the tty at all.

Signed-off-by: Jeff King <peff@peff.net>
---
I also considered adding a "git --[no-]terminal-prompt"
option, but it seemed like overkill to me. I imagine the
common use would be to just set this at the top of a script.
But it would be trivial to add if we want to.

No tests, because our lib-terminal.sh infrastructure is not
up to the challenge of fooling getpass(). Besides not
handling input at all, git will actually open /dev/tty
itself. So we would have to open a pty and then set it as
the controlling terminal for the sub-process.  It's probably
possible, but I'm not sure the portability headaches are
worth testing such a trivial feature.

 Documentation/git.txt |  4 ++++
 prompt.c              | 16 ++++++++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index afb48d3..54f7a1c 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -906,6 +906,10 @@ for further details.
 	and read the password from its STDOUT. See also the 'core.askpass'
 	option in linkgit:git-config[1].
 
+'GIT_TERMINAL_PROMPT'::
+	If this environment variable is set to `0`, git will not prompt
+	on the terminal (e.g., when asking for HTTP authentication).
+
 'GIT_CONFIG_NOSYSTEM'::
 	Whether to skip reading settings from the system-wide
 	`$(prefix)/etc/gitconfig` file.  This environment variable can
diff --git a/prompt.c b/prompt.c
index e5b4938..8181eeb 100644
--- a/prompt.c
+++ b/prompt.c
@@ -57,11 +57,19 @@ char *git_prompt(const char *prompt, int flags)
 			r = do_askpass(askpass, prompt);
 	}
 
-	if (!r)
-		r = git_terminal_prompt(prompt, flags & PROMPT_ECHO);
 	if (!r) {
-		/* prompts already contain ": " at the end */
-		die("could not read %s%s", prompt, strerror(errno));
+		const char *err;
+
+		if (git_env_bool("GIT_TERMINAL_PROMPT", 1)) {
+			r = git_terminal_prompt(prompt, flags & PROMPT_ECHO);
+			err = strerror(errno);
+		} else {
+			err = "terminal prompts disabled";
+		}
+		if (!r) {
+			/* prompts already contain ": " at the end */
+			die("could not read %s%s", prompt, err);
+		}
 	}
 	return r;
 }
-- 
2.2.0.390.gf60752d
