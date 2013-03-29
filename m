From: Jeff King <peff@peff.net>
Subject: [PATCH] t1300: document some aesthetic failures of the config editor
Date: Fri, 29 Mar 2013 13:50:58 -0400
Message-ID: <20130329175058.GA13506@sigill.intra.peff.net>
References: <CAD7mMPW=jr6PaAc50h-Wpf42-UPrn0A5KmisqXNXqqLv78AEgg@mail.gmail.com>
 <20130329170032.GA3552@sigill.intra.peff.net>
 <87ip4ayvfn.fsf@linux-k42r.v.cablecom.net>
 <20130329172307.GA11099@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Phil Haack <haacked@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 29 18:51:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULdSe-0005nu-UJ
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 18:51:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756702Ab3C2RvC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 13:51:02 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48474 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756635Ab3C2RvA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 13:51:00 -0400
Received: (qmail 7668 invoked by uid 107); 29 Mar 2013 17:52:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Mar 2013 13:52:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Mar 2013 13:50:58 -0400
Content-Disposition: inline
In-Reply-To: <20130329172307.GA11099@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219517>

The config-editing code used by "git config var value" is
built around the regular config callback parser, whose only
triggerable item is an actual key. As a result, it does not
know anything about section headers, which can result in
unnecessarily ugly output:

  1. When we delete the last key in a section, we should be
     able to delete the section header.

  2. When we add a key into a section, we should be able to
     reuse the same section header, even if that section did
     not have any keys in it already.

Unfortunately, fixing these is not trivial with the current
code. It would involve the config parser recording and
passing back information on each item it finds, including
headers, keys, and even comments (or even better, generating
an actual in-memory parse-tree).

Since these behaviors do not cause any functional problems
(i.e., the resulting config parses as expected, it is just
uglier than one would like), fixing them can wait until
somebody feels like substantially refactoring the parsing
code. In the meantime, let's document them as known issues
with some tests.

Signed-off-by: Jeff King <peff@peff.net>
---
I had hoped this would be a quick fix, but it really isn't. I'm happy
enough if somebody wants to try to work on it, but I think the only
clean fix is going to involve a rewrite of the parsing code, so I'm
willing to let it go for now.

Junio, note that this conflicts semantically (but not textually) with
the tip of jc/apply-ws-fix-tab-in-indent, which refactors q_to_tab into
qz_to_tab_space.

 t/t1300-repo-config.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 3c96fda..d62facb 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1087,4 +1087,36 @@ test_expect_success 'barf on incomplete string' '
 	grep " line 3 " error
 '
 
+# good section hygiene
+test_expect_failure 'unsetting the last key in a section removes header' '
+	cat >.git/config <<-\EOF &&
+	[section]
+	# some intervening lines
+	# that should be saved
+	key = value
+	EOF
+
+	cat >expect <<-\EOF &&
+	# some intervening lines
+	# that should be saved
+	EOF
+
+	git config --unset section.key &&
+	test_cmp expect .git/config
+'
+
+test_expect_failure 'adding a key into an empty section reuses header' '
+	cat >.git/config <<-\EOF &&
+	[section]
+	EOF
+
+	q_to_tab >expect <<-\EOF &&
+	[section]
+	Qkey = value
+	EOF
+
+	git config section.key value
+	test_cmp expect .git/config
+'
+
 test_done
-- 
1.8.2.13.g0f18d3c
