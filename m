From: Jeff King <peff@peff.net>
Subject: [PATCH 3/5] submodule: export sanitized GIT_CONFIG_PARAMETERS
Date: Thu, 28 Apr 2016 09:37:44 -0400
Message-ID: <20160428133744.GC25319@sigill.intra.peff.net>
References: <20160428133534.GA19056@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacob Keller <jacob.keller@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git Users <git@vger.kernel.org>, Jens.Lehmann@web.de
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 15:37:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avm8d-0004sp-RW
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 15:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752368AbcD1Nhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 09:37:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:58300 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752322AbcD1Nhr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 09:37:47 -0400
Received: (qmail 25613 invoked by uid 102); 28 Apr 2016 13:37:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 09:37:46 -0400
Received: (qmail 9604 invoked by uid 107); 28 Apr 2016 13:37:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 Apr 2016 09:37:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Apr 2016 09:37:44 -0400
Content-Disposition: inline
In-Reply-To: <20160428133534.GA19056@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292878>

Commit 14111fc (git: submodule honor -c credential.* from
command line, 2016-02-29) taught git-submodule.sh to save
the sanitized value of $GIT_CONFIG_PARAMETERS when clearing
the environment for a submodule. However, it failed to
export the result, meaning that it had no effect for any
sub-programs.

We didn't catch this in our initial tests because we checked
only the "clone" case, which does not go through the shell
script at all. Provoking "git submodule update" to do a
fetch demonstrates the bug.

Noticed-by: Lars Schneider <larsxschneider@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 git-submodule.sh           |  1 +
 t/t5550-http-fetch-dumb.sh | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2a84d7e..3a40d4b 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -200,6 +200,7 @@ sanitize_submodule_env()
 	sanitized_config=$(git submodule--helper sanitize-config)
 	clear_local_git_env
 	GIT_CONFIG_PARAMETERS=$sanitized_config
+	export GIT_CONFIG_PARAMETERS
 }
 
 #
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index e8e91bb..13ac788 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -112,6 +112,23 @@ test_expect_success 'cmdline credential config passes to submodule via clone' '
 	expect_askpass pass user@host
 '
 
+test_expect_success 'cmdline credential config passes submodule update' '
+	# advance the submodule HEAD so that a fetch is required
+	git commit --allow-empty -m foo &&
+	git push "$HTTPD_DOCUMENT_ROOT_PATH/auth/dumb/repo.git" HEAD &&
+	sha1=$(git rev-parse HEAD) &&
+	git -C super-clone update-index --cacheinfo 160000,$sha1,sub &&
+
+	set_askpass wrong pass@host &&
+	test_must_fail git -C super-clone submodule update &&
+
+	set_askpass wrong pass@host &&
+	git -C super-clone \
+	    -c "credential.$HTTPD_URL.username=user@host" \
+	    submodule update &&
+	expect_askpass pass user@host
+'
+
 test_expect_success 'fetch changes via http' '
 	echo content >>file &&
 	git commit -a -m two &&
-- 
2.8.1.617.gbdccc2d
