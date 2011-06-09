From: Jeff King <peff@peff.net>
Subject: [PATCH 03/10] config: die on error in command-line config
Date: Thu, 9 Jun 2011 11:52:32 -0400
Message-ID: <20110609155232.GC25507@sigill.intra.peff.net>
References: <20110609155001.GA14969@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Claire Fousse <claire.fousse@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 09 17:52:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUhXP-0007Pu-2Q
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 17:52:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174Ab1FIPwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 11:52:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52501
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754013Ab1FIPwf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 11:52:35 -0400
Received: (qmail 13937 invoked by uid 107); 9 Jun 2011 15:52:43 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 Jun 2011 11:52:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jun 2011 11:52:32 -0400
Content-Disposition: inline
In-Reply-To: <20110609155001.GA14969@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175536>

The error handling for git_config is somewhat confusing. We
collect errors from running git_config_from_file on the
various config files and carefully pass them back up. But
the two odd things are:

  1. We actually die on most errors in git_config_from_file.
     In fact, the only error we actually pass back up is if
     fopen() fails on the file.

  2. Most callers of git_config do not check the error
     return at all, but will continue if git_config reports
     an error.

When the code for "git -c core.foo=bar" was added, it
dutifully passed errors up the call stack, only for them to
be eventually ignored. This makes it inconsistent with the
file-parsing code, which will die when it sees malformed
config. And it's somewhat unsafe, because it means an error
in parsing a typo like:

  git -c clean.requireforce=ture clean

will continue the command, ignoring the config the user
tried to give.

Signed-off-by: Jeff King <peff@peff.net>
---
Another option would be to just make git_config call die() on error
instead of returning the error code that is ignored everywhere. But I
wasn't sure if anybody was relying on the "fopen failure is silently
ignored" behavior.

 config.c               |    2 +-
 t/t1300-repo-config.sh |    8 ++++++++
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/config.c b/config.c
index aa5eb78..ebd404a 100644
--- a/config.c
+++ b/config.c
@@ -856,7 +856,7 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 
 	switch (git_config_from_parameters(fn, data)) {
 	case -1: /* error */
-		ret--;
+		die("unable to parse command-line config");
 		break;
 	case 0: /* found nothing */
 		break;
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index ca5058e..584e956 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -910,4 +910,12 @@ test_expect_success 'git -c does not split values on equals' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git -c dies on bogus config' '
+	test_must_fail git -c core.bare=foo rev-parse
+'
+
+test_expect_success 'git -c complains about empty key' '
+	test_must_fail git -c "=foo" rev-parse
+'
+
 test_done
-- 
1.7.6.rc1.36.g91167
