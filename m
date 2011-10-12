From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] t1300: test mixed-case variable retrieval
Date: Wed, 12 Oct 2011 14:30:02 -0400
Message-ID: <20111012183002.GB18948@sigill.intra.peff.net>
References: <20111012182742.GA14543@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Oct 12 20:30:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE3ZE-0002Nk-N3
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 20:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753871Ab1JLSaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 14:30:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58670
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752046Ab1JLSaF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 14:30:05 -0400
Received: (qmail 13721 invoked by uid 107); 12 Oct 2011 18:30:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Oct 2011 14:30:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Oct 2011 14:30:02 -0400
Content-Disposition: inline
In-Reply-To: <20111012182742.GA14543@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183387>

We should be able to ask for a config value both by its
canonical all-lowercase name (as git does internally), as
well as by random mixed-case (which will be canonicalized by
git-config for us).

Subsections are a tricky point, though. Since we have both

  [section "Foo"]

and

  [section.Foo]

you might want git-config to canonicalize the subsection or
not, depending on which you are expecting. But there's no
way to communicate this; git-config sees only the key, and
doesn't know which type of section name will be in the
config file.

So it must leave the subsection intact, and it is up to the
caller to provide a canonical version of the subsection if
they want to match the latter form.

Signed-off-by: Jeff King <peff@peff.net>
---
I was surprised this wasn't tested anywhere, but I couldn't find any
such place. I think it makes sense to document the desired behavior in
the form of a few tests.

 t/t1300-repo-config.sh |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index cf508af..8a37f96 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -73,6 +73,33 @@ EOF
 
 test_expect_success 'non-match result' 'test_cmp expect .git/config'
 
+test_expect_success 'find mixed-case key by canonical name' '
+	echo Second >expect &&
+	git config cores.whatever >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'find mixed-case key by non-canonical name' '
+	echo Second >expect &&
+	git config CoReS.WhAtEvEr >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'subsections are not canonicalized by git-config' '
+	cat >>.git/config <<-\EOF &&
+	[section.SubSection]
+	key = one
+	[section "SubSection"]
+	key = two
+	EOF
+	echo one >expect &&
+	git config section.subsection.key >actual &&
+	test_cmp expect actual &&
+	echo two >expect &&
+	git config section.SubSection.key >actual &&
+	test_cmp expect actual
+'
+
 cat > .git/config <<\EOF
 [alpha]
 bar = foo
-- 
1.7.7.rc2.21.gb9948
