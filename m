From: Jeff King <peff@peff.net>
Subject: [PATCH 12/10] support pager.* for external commands
Date: Thu, 18 Aug 2011 15:01:32 -0700
Message-ID: <20110818220132.GB7799@sigill.intra.peff.net>
References: <20110818215820.GA7767@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 00:01:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuAej-0002qK-N3
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 00:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754835Ab1HRWBh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 18:01:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46375
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754812Ab1HRWBg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 18:01:36 -0400
Received: (qmail 25563 invoked by uid 107); 18 Aug 2011 22:02:16 -0000
Received: from 173-164-171-125-SFBA.hfc.comcastbusiness.net (HELO sigill.intra.peff.net) (173.164.171.125)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Aug 2011 18:02:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Aug 2011 15:01:32 -0700
Content-Disposition: inline
In-Reply-To: <20110818215820.GA7767@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179635>

Without this patch, any commands that are not builtin would
not respect pager.* config. For example:

  git config pager.stash false
  git stash list

would still use a pager. With this patch, pager.stash now
has an effect. If it is not specified, we will still fall
back to pager.log when we invoke "log" from "stash list".

Signed-off-by: Jeff King <peff@peff.net>
---
I think we didn't do this in the original pager.* patches because of
initialization order problems. It was dangerous to look at config too
early in the process, or something similar; I don't recall the exact
problems. But since work from Jonathan and Duy last summer, I think some
of those issues have gone away. At least I couldn't find any problems.
And I have been running with this patch since last November and haven't
noticed anything odd.

 git.c            |    2 ++
 t/t7006-pager.sh |   36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/git.c b/git.c
index 375e9b2..e8cff60 100644
--- a/git.c
+++ b/git.c
@@ -462,6 +462,8 @@ static void execv_dashed_external(const char **argv)
 	const char *tmp;
 	int status;
 
+	if (use_pager == -1)
+		use_pager = check_pager_config(argv[0]);
 	commit_pager_choice();
 
 	strbuf_addf(&cmd, "git-%s", argv[0]);
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index a8c6e85..742238c 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -481,4 +481,40 @@ test_expect_success TTY 'alias-specific pager can override aliased command' '
 	test_cmp expect actual
 '
 
+test_expect_success 'setup external command' '
+	cat >git-external <<-\EOF &&
+	#!/bin/sh
+	git "$@"
+	EOF
+	chmod +x git-external
+'
+
+test_expect_success TTY 'command-specific pager works for external commands' '
+	sane_unset PAGER GIT_PAGER &&
+	echo "foo:initial" >expect &&
+	>actual &&
+	test_config pager.external "sed s/^/foo:/ >actual" &&
+	test_terminal git --exec-path="`pwd`" external log --format=%s -1 &&
+	test_cmp expect actual
+'
+
+test_expect_success TTY 'sub-commands of externals use their own pager' '
+	sane_unset PAGER GIT_PAGER &&
+	echo "foo:initial" >expect &&
+	>actual &&
+	test_config pager.log "sed s/^/foo:/ >actual" &&
+	test_terminal git --exec-path=. external log --format=%s -1 &&
+	test_cmp expect actual
+'
+
+test_expect_success TTY 'external command pagers override sub-commands' '
+	sane_unset PAGER GIT_PAGER &&
+	>expect &&
+	>actual &&
+	test_config pager.external false &&
+	test_config pager.log "sed s/^/log:/ >actual" &&
+	test_terminal git --exec-path=. external log --format=%s -1 &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.6.10.g62f04
