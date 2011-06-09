From: Jeff King <peff@peff.net>
Subject: [PATCH 02/10] fix "git -c" parsing of values with equals signs
Date: Thu, 9 Jun 2011 11:51:36 -0400
Message-ID: <20110609155136.GB25507@sigill.intra.peff.net>
References: <20110609155001.GA14969@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Claire Fousse <claire.fousse@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 09 17:51:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUhWL-0006l3-1h
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 17:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754002Ab1FIPvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 11:51:40 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52493
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752781Ab1FIPvj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 11:51:39 -0400
Received: (qmail 13904 invoked by uid 107); 9 Jun 2011 15:51:47 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 Jun 2011 11:51:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jun 2011 11:51:36 -0400
Content-Disposition: inline
In-Reply-To: <20110609155001.GA14969@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175534>

If you do something like:

  git -c core.foo="value with = in it" ...

we would split your option on "=" into three fields and
throw away the third one. With this patch we correctly take
everything after the first "=" as the value (keys cannot
have an equals sign in them, so the parsing is unambiguous).

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c               |    2 +-
 t/t1300-repo-config.sh |    6 ++++++
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/config.c b/config.c
index e0b3b80..aa5eb78 100644
--- a/config.c
+++ b/config.c
@@ -45,7 +45,7 @@ static int git_config_parse_parameter(const char *text,
 	struct strbuf tmp = STRBUF_INIT;
 	struct strbuf **pair;
 	strbuf_addstr(&tmp, text);
-	pair = strbuf_split(&tmp, '=');
+	pair = strbuf_split_max(&tmp, '=', 2);
 	if (pair[0]->len && pair[0]->buf[pair[0]->len - 1] == '=')
 		strbuf_setlen(pair[0], pair[0]->len - 1);
 	strbuf_trim(pair[0]);
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 3db5626..ca5058e 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -904,4 +904,10 @@ test_expect_success 'git -c works with aliases of builtins' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git -c does not split values on equals' '
+	echo "value with = in it" >expect &&
+	git -c core.foo="value with = in it" config core.foo >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.6.rc1.36.g91167
