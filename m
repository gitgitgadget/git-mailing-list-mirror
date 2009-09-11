From: Jeff King <peff@peff.net>
Subject: Re: bash_completion outside repo
Date: Fri, 11 Sep 2009 12:47:30 -0400
Message-ID: <20090911164730.GA21536@coredump.intra.peff.net>
References: <a3b675320909100813i3e70ab3at66408aebb9952c7d@mail.gmail.com>
 <20090911133313.GF2582@inocybe.localdomain>
 <a3b675320909110700k7eb7286qc8cb5691aae214c7@mail.gmail.com>
 <20090911141730.GA384@coredump.intra.peff.net>
 <20090911143651.GE1033@spearce.org>
 <20090911150934.GB977@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: james bardin <jbardin@bu.edu>, Todd Zullinger <tmz@pobox.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Sep 11 18:47:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mm9Hj-0002El-4k
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 18:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752687AbZIKQrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 12:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752488AbZIKQrc
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 12:47:32 -0400
Received: from peff.net ([208.65.91.99]:54763 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751283AbZIKQrb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 12:47:31 -0400
Received: (qmail 8143 invoked by uid 107); 11 Sep 2009 16:47:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 11 Sep 2009 12:47:51 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Sep 2009 12:47:30 -0400
Content-Disposition: inline
In-Reply-To: <20090911150934.GB977@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128206>

On Fri, Sep 11, 2009 at 11:09:34AM -0400, Jeff King wrote:

> Assuming you make such a patch, that will clear up the original issue. I
> wonder if we should fix "git config --list". The current semantics seem
> a little crazy to me, but it is a scriptable interface. I'm inclined to
> call this a bug, though.

And here is a patch to fix it.

-- >8 --
Subject: [PATCH] config: treat non-existent config files as empty

The git_config() function signals error by returning -1 in
two instances:

  1. An actual error occurs in opening a config file (parse
     errors cause an immediate die).

  2. Of the three possible config files, none was found.

However, this second case is often not an error at all; it
simply means that the user has no configuration (they are
outside a repo, and they have no ~/.gitconfig file). This
can lead to confusing errors, such as when the bash
completion calls "git config --list" outside of a repo. If
the user has a ~/.gitconfig, the command completes
succesfully; if they do not, it complains to stderr.

This patch allows callers of git_config to distinguish
between the two cases. Error is signaled by -1, and
otherwise the return value is the number of files parsed.
This means that the traditional "git_config(...) < 0" check
for error should work, but callers who want to know whether
we parsed any files or not can still do so.

We need to tweak one use of git_config in builtin-remote
that previously assumed the return value was either '0' or
'-1'.

Signed-off-by: Jeff King <peff@peff.net>
---

This is actually a bit overengineered. Of the hundreds of calls to
git_config, there are exactly _two_ which check the return value. And
neither of them cares whether we parsed files or not; they really only
care if there was an error. So we could simply return 0 as long as there
is no error.

This also makes me wonder, though. Git can do wildly different things
(including hard-to-reverse things) based on config (e.g., just consider
gc.pruneExpire). Yet we call git_config() without ever checking for
errors. In the actual parsing routines, we die() if there is an error.
But if we fail to open the file due to some transient error, we will
silently ignore the situation.

Granted, such transient errors are unlikely. The biggest reasons for
failing to open a file are that it doesn't exist, or that we have no
permission to read it, both of which are treated explicitly in
git_config as "silently ok". But I wonder if we should simply be dying
on such an error, and git_config() should just have a void return.

 builtin-remote.c       |    3 ++-
 config.c               |    4 +---
 t/t1300-repo-config.sh |    8 ++++++++
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 0777dd7..3bf1fe8 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -1245,7 +1245,8 @@ static int update(int argc, const char **argv)
 	for (i = 1; i < argc; i++) {
 		int groups_found = 0;
 		remote_group.name = argv[i];
-		result = git_config(get_remote_group, &groups_found);
+		if (git_config(get_remote_group, &groups_found) < 0)
+			result = -1;
 		if (!groups_found && (i != 1 || strcmp(argv[1], "default"))) {
 			struct remote *remote;
 			if (!remote_is_configured(argv[i]))
diff --git a/config.c b/config.c
index e87edea..e429674 100644
--- a/config.c
+++ b/config.c
@@ -709,9 +709,7 @@ int git_config(config_fn_t fn, void *data)
 		found += 1;
 	}
 	free(repo_config);
-	if (found == 0)
-		return -1;
-	return ret;
+	return ret == 0 ? found : ret;
 }
 
 /*
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 83b7294..db987b7 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -289,6 +289,14 @@ test_expect_success 'working --list' \
 	'git config --list > output && cmp output expect'
 
 cat > expect << EOF
+EOF
+
+test_expect_success '--list without repo produces empty output' '
+	git --git-dir=nonexistent config --list >output &&
+	test_cmp expect output
+'
+
+cat > expect << EOF
 beta.noindent sillyValue
 nextsection.nonewline wow2 for me
 EOF
-- 
1.6.5.rc0.174.g29a6d.dirty
