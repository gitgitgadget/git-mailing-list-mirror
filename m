From: Jeff King <peff@peff.net>
Subject: [PATCH 04/10] config: avoid segfault when parsing command-line config
Date: Thu, 9 Jun 2011 11:52:43 -0400
Message-ID: <20110609155243.GD25507@sigill.intra.peff.net>
References: <20110609155001.GA14969@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Claire Fousse <claire.fousse@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 09 17:52:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUhXP-0007Pu-MB
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 17:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754238Ab1FIPwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 11:52:47 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52510
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754013Ab1FIPwq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 11:52:46 -0400
Received: (qmail 13993 invoked by uid 107); 9 Jun 2011 15:52:54 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 09 Jun 2011 11:52:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Jun 2011 11:52:43 -0400
Content-Disposition: inline
In-Reply-To: <20110609155001.GA14969@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175537>

We already check for an empty key on the left side of an
equals, but we would segfault if there was no content at
all.

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c               |    2 ++
 t/t1300-repo-config.sh |    4 ++++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/config.c b/config.c
index ebd404a..2517b62 100644
--- a/config.c
+++ b/config.c
@@ -46,6 +46,8 @@ static int git_config_parse_parameter(const char *text,
 	struct strbuf **pair;
 	strbuf_addstr(&tmp, text);
 	pair = strbuf_split_max(&tmp, '=', 2);
+	if (!pair[0])
+		return error("bogus config parameter: %s", text);
 	if (pair[0]->len && pair[0]->buf[pair[0]->len - 1] == '=')
 		strbuf_setlen(pair[0], pair[0]->len - 1);
 	strbuf_trim(pair[0]);
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 584e956..3e140c1 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -918,4 +918,8 @@ test_expect_success 'git -c complains about empty key' '
 	test_must_fail git -c "=foo" rev-parse
 '
 
+test_expect_success 'git -c complains about empty key and value' '
+	test_must_fail git -c "" rev-parse
+'
+
 test_done
-- 
1.7.6.rc1.36.g91167
