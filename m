From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] mailinfo: always clean up rfc822 header folding
Date: Thu, 26 May 2011 16:53:38 -0400
Message-ID: <20110526205338.GB31340@sigill.intra.peff.net>
References: <20110526203625.GA31018@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
X-From: git-owner@vger.kernel.org Thu May 26 22:53:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPhYz-0003xA-Kd
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 22:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758281Ab1EZUxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 16:53:42 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51496
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755061Ab1EZUxl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 16:53:41 -0400
Received: (qmail 17185 invoked by uid 107); 26 May 2011 20:53:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 May 2011 16:53:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2011 16:53:38 -0400
Content-Disposition: inline
In-Reply-To: <20110526203625.GA31018@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174564>

Without the "-k" option, mailinfo will convert a folded
subject header like:

  Subject: this is a
    subject that doesn't
    fit on one line

into a single line. With "-k", however, we assumed that
these newlines were significant and represented something
that the sending side would want us to preserve.

For messages created by format-patch, this assumption was
broken by a1f6baa (format-patch: wrap long header lines,
2011-02-23).  For messages sent by arbitrary MUAs, this was
probably never a good assumption to make, as they may have
been folding subjects in accordance with rfc822's line
length recommendations all along.

This patch now joins folded lines with a single whitespace
character. This treats header folding purely as a syntactic
feature of the transport mechanism, not as something that
format-patch is trying to tell us about the original
subject.

Signed-off-by: Jeff King <peff@peff.net>
---
The astute reader will notice that even with this patch, there is still
a regression when using new versions of format-patch (with a1f6baa) with
an older version of "git am". But you only see it when using "am -k", so
interoperability is probably not a huge deal:

  1. Before this patch, "am -k" was arguably broken anyway for applying
     random patches via email, since MUAs may have been doing arbitrary
     header folding. So we can probably discount people running "am -k"
     on random input as insane.

  2. People doing "git format-patch -k | git am -k" will presumably use
     the same version for both, and are OK.

  3. People doing "git format-patch -k >file", followed by upgrading
     git, and t hen "git am file" are still OK, since the newer version
     of "am" handles the output of both old and new format-patch.

  4. The problematic case is "git format-patch -k >file" with v1.7.5 or
     newer, then _downgrading_ git, then using "git am -k" to apply. Or
     more likely, using a newer version to create an mbox, shipping the
     mbox to another machine, and then using an older "git am" to apply.

So I don't see it as all that likely a problem in practice. If we do
care, we can't fix it with a simple patch. We would have to revert the
header-folding from format-patch, fix am, wait N time units until all of
the old "am" no longer exists, and then re-apply.

 builtin/mailinfo.c     |    2 +-
 t/t4152-am-subjects.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 71e6262..bfb32b7 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -400,7 +400,7 @@ static int read_one_header_line(struct strbuf *line, FILE *in)
 			break;
 		if (strbuf_getline(&continuation, in, '\n'))
 			break;
-		continuation.buf[0] = '\n';
+		continuation.buf[0] = ' ';
 		strbuf_rtrim(&continuation);
 		strbuf_addbuf(line, &continuation);
 	}
diff --git a/t/t4152-am-subjects.sh b/t/t4152-am-subjects.sh
index 7222c06..37e5c03 100755
--- a/t/t4152-am-subjects.sh
+++ b/t/t4152-am-subjects.sh
@@ -58,7 +58,7 @@ test_expect_success 'long subject preserved (format-patch | am)' '
 test_expect_success 'long subject preserved (format-patch -k | am)' '
 	check_subject long-k
 '
-test_expect_failure 'long subject preserved (format-patch -k | am -k)' '
+test_expect_success 'long subject preserved (format-patch -k | am -k)' '
 	check_subject long-k -k
 '
 
-- 
1.7.4.5.26.g0c6a2
