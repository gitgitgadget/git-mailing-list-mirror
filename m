From: Jeff King <peff@peff.net>
Subject: Re: git clone NonExistentLocation
Date: Thu, 17 Feb 2011 23:01:52 -0500
Message-ID: <20110218040152.GA25466@sigill.intra.peff.net>
References: <4D5CE3E7.5030101@atlas-elektronik.com>
 <4D5D1715.5020707@drmicha.warpmail.net>
 <4D5D1A04.4090107@atlas-elektronik.com>
 <4D5D1BCB.3010003@drmicha.warpmail.net>
 <AANLkTin3Pf4XD_gbwxPzW4uff9SbDWJdGug6jM_SHDo+@mail.gmail.com>
 <4D5D5275.5070501@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 18 05:02:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqHXf-0003Ho-4W
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 05:02:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754765Ab1BREB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 23:01:58 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:33822 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752111Ab1BREB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 23:01:56 -0500
Received: (qmail 26718 invoked by uid 111); 18 Feb 2011 04:01:55 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 18 Feb 2011 04:01:55 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Feb 2011 23:01:52 -0500
Content-Disposition: inline
In-Reply-To: <4D5D5275.5070501@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167161>

On Thu, Feb 17, 2011 at 05:53:09PM +0100, Michael J Gruber wrote:

> Digging a little further: since a nonexisting directory is neither a dir
> nor a file, clone thinks it is not local (is_local=is_bundle=0). None of
> the transport_* commands error out since the relevant one is guarded by
> 86ac751...
> 
> Reverting that or forcing is_local=1 both help, but how to detect "local
> nonexisting" reliably?
> 
> In fact, I don't have a problem with the current state if we document it :)

Hmm, the current behavior is even weirder. This clones an empty
repository:

  git clone does-not-exist

but this causes an error:

  git clone does-not-exist new-dir

Regardless, I think we should catch this error, as it is likely not
what the user intended. Yes, there's a warning, but I just don't see in
what circumstance this behavior would be useful, and the downside is
that you may have failed to actually create a copy of your data, which
could lead to data loss.

I think the patch below is the right fix.

-- >8 --
Subject: [PATCH] clone: die when trying to clone missing local path

Since 86ac751 (Allow cloning an empty repository,
2009-01-23), doing:

  git clone does-not-exist

has created does-not-exist as an empty repository. This was
an unintentional side effect of 86ac751. Even weirder,
doing:

  git clone does-not-exist new-dir

_does_ fail, making this "feature" (if you want to consider
it such) broken. Let's detect this situation and explicitly
die. It's almost certainly not what the user intended.

This patch also adds two tests. One for the missing path
case, and one to confirm that a similar case, cloning a
non-repository directory, fails.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/clone.c        |    5 ++++-
 t/t5701-clone-local.sh |   13 +++++++++++++
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 60d9a64..55785d0 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -412,8 +412,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	path = get_repo_path(repo_name, &is_bundle);
 	if (path)
 		repo = xstrdup(make_nonrelative_path(repo_name));
-	else if (!strchr(repo_name, ':'))
+	else if (!strchr(repo_name, ':')) {
+		if (!file_exists(repo_name))
+			die("repository '%s' does not exist", repo_name);
 		repo = xstrdup(make_absolute_path(repo_name));
+	}
 	else
 		repo = repo_name;
 	is_local = path && !is_bundle;
diff --git a/t/t5701-clone-local.sh b/t/t5701-clone-local.sh
index 0f4d487..6972258 100755
--- a/t/t5701-clone-local.sh
+++ b/t/t5701-clone-local.sh
@@ -144,4 +144,17 @@ test_expect_success 'clone empty repository, and then push should not segfault.'
 	test_must_fail git push)
 '
 
+test_expect_success 'cloning non-existent directory fails' '
+	cd "$D" &&
+	rm -rf does-not-exist &&
+	test_must_fail git clone does-not-exist
+'
+
+test_expect_success 'cloning non-git directory fails' '
+	cd "$D" &&
+	rm -rf not-a-git-repo not-a-git-repo-clone &&
+	mkdir not-a-git-repo &&
+	test_must_fail git clone not-a-git-repo not-a-git-repo-clone
+'
+
 test_done
-- 
1.7.4.1.3.g720b9
