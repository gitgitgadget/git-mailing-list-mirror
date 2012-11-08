From: Jeff King <peff@peff.net>
Subject: Re: git commit/push can fail silently when clone omits ".git"
Date: Thu, 8 Nov 2012 13:56:43 -0500
Message-ID: <20121108185643.GN15560@sigill.intra.peff.net>
References: <CAABvdFyn=_2JKHYA_jAduoNAti3U0YFHbdU94esm=m8R0s2LcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Git Issues <git@vger.kernel.org>
To: "Jeffrey S. Haemer" <jeffrey.haemer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 19:57:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWXHh-0000Zg-Ub
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 19:57:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756Ab2KHS4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 13:56:48 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36586 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751920Ab2KHS4r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 13:56:47 -0500
Received: (qmail 31750 invoked by uid 107); 8 Nov 2012 18:57:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Nov 2012 13:57:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Nov 2012 13:56:43 -0500
Content-Disposition: inline
In-Reply-To: <CAABvdFyn=_2JKHYA_jAduoNAti3U0YFHbdU94esm=m8R0s2LcA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209184>

On Sun, Nov 04, 2012 at 12:50:58PM -0700, Jeffrey S. Haemer wrote:

> I got bitten by what follows. Yes, it's an edge case. Yes I now understand
> why it does what it does. Yes the right answer is "Don't do that, Jeff." :-)
> 
> Still, it took me a little time to figure out what I'd done wrong because
> the failure is silent, so I thought I'd document it. Perhaps there's even
> some way to issue an error message for cases like this.
> 
> The attached test script shows the issue in detail, but here's the basic
> failure:
> 
> $ ls
> hello.git
> $ git clone hello # *Mistake!* Succeeds, but should have cloned "hello.git"
> or into something else.

It does clone hello.git into "hello", but it sets remote.origin.url in
the cloned repository to "/path/to/hello". I.e., to itself, rather than
the correct hello.git.

The reason is that "clone" sets the config from the repo name you gave
it, not the path it finds on disk. The name you gave was not ambiguous
at the time of clone, but it became so during the clone. I am tempted to
say that we should set the config to the path we found on disk, not what
the user gave us. That includes the ugly "/.git" for non-bare repos, but
we should be able to safely strip that off without adding any ambiguity
(i.e, it is only "foo" versus "foo.git" that is ambiguous).

Unfortunately, the patch below which does that seems to make t7407 very
unhappy. It looks like the submodule test uses "git clone ." and
"git-submodule add" expects the "/." to still be at the end of the
configured URL when processing relative submodule paths. I'm not sure if
that is important, or an unnecessary brittleness in the submodule code.

Jens, Heiko?

---
diff --git a/builtin/clone.c b/builtin/clone.c
index 0d663e3..687d5c0 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -713,8 +713,12 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	repo_name = argv[0];
 
 	path = get_repo_path(repo_name, &is_bundle);
-	if (path)
-		repo = xstrdup(absolute_path(repo_name));
+	if (path) {
+		if (!suffixcmp(path, "/.git"))
+			repo = xstrndup(path, strlen(path) - 5);
+		else
+			repo = xstrdup(path);
+	}
 	else if (!strchr(repo_name, ':'))
 		die(_("repository '%s' does not exist"), repo_name);
 	else
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 67869b4..0eeeb2d 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -280,4 +280,20 @@ test_expect_success 'clone checking out a tag' '
 	test_cmp fetch.expected fetch.actual
 '
 
+test_expect_success 'clone does not create ambiguous config' '
+	git init --bare ambiguous.git &&
+	git clone ambiguous &&
+	(
+		cd ambiguous &&
+		test_commit one &&
+		git push --all
+	) &&
+	echo one >expect &&
+	(
+		cd ambiguous.git &&
+		git log -1 --format=%s
+	) >actual &&
+	test_cmp expect actual
+'
+
 test_done
