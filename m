From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fast-export: quote paths with spaces
Date: Wed, 27 Jun 2012 17:58:01 -0400
Message-ID: <20120627215801.GD2292@sigill.intra.peff.net>
References: <1340655120-89736-1-git-send-email-jaysoffian@gmail.com>
 <7vk3yueru8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 23:58:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sk0FY-0007PI-Go
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 23:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283Ab2F0V6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jun 2012 17:58:07 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:47312
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932172Ab2F0V6F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2012 17:58:05 -0400
Received: (qmail 4578 invoked by uid 107); 27 Jun 2012 21:58:08 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Jun 2012 17:58:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jun 2012 17:58:01 -0400
Content-Disposition: inline
In-Reply-To: <7vk3yueru8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200762>

On Mon, Jun 25, 2012 at 07:21:03PM -0700, Junio C Hamano wrote:

> Jay Soffian <jaysoffian@gmail.com> writes:
> 
> > A path containing a space must be quoted when used as an argument to
> > either the copy or rename commands. 6280dfdc3b (fast-export: quote paths
> > in output, 2011-08-05) previously attempted to fix fast-export's quoting
> > by passing all paths through quote_c_style(). However, that function does
> > not consider the space to be a character which requires quoting, so let's
> > special-case the space inside print_path(). This will cause
> > space-containing paths to also be quoted in other commands where such
> > quoting is not strictly necessary, but it does not hurt to do so.
> >
> > Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> > ---
> > Sorry, not test added. I barely had time to get out this patch. :-(
> 
> Thanks.
> 
> I have to say it might be less error prone to always c-quote the
> string, as the recipient is expected to be able to grok it anyway,
> but I'll let fast-import/export experts to comment on it and perhaps
> add a test or two ;-)

I am not (and do not want to be) a fast-import/export expert, but since
the bug was in my incomplete fix, here is a slightly cleaned up version
of the patch.

I expanded the commit message a bit to explain why 6280dfdc3b did not
notice this and adjusted the tests to cover this. I also tweaked the
code to fit our usual no-curlies-for-single line style.

I don't think there's anything wrong with just quoting all of the time;
the output is not typically read by humans. But not quoting does make it
easier for lazy scripts to work when there are no magic characters
present.

-- >8 --
From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] fast-export: quote paths with spaces

A path containing a space must be quoted when used as an
argument to either the copy or rename commands (because
unlike other commands, the path is not the final thing on
the line for those commands).

Commit 6280dfdc3b (fast-export: quote paths in output,
2011-08-05) previously attempted to fix fast-export's
quoting by passing all paths through quote_c_style().
However, that function does not consider the space to be a
character which requires quoting, so let's special-case the
space inside print_path(). This will cause space-containing
paths to also be quoted in other commands where such quoting
is not strictly necessary, but it does not hurt to do so.

The test from 6280dfdc3b did not detect this because, while
it does introduce renames in the export stream, it does not
actually turn on rename detection, so they were presented as
pairs of deletions/adds. Using "-M" reveals the bug.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fast-export.c  | 2 ++
 t/t9350-fast-export.sh | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index ef7c012..9ab6db3 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -185,6 +185,8 @@ static void print_path(const char *path)
 	int need_quote = quote_c_style(path, NULL, NULL, 0);
 	if (need_quote)
 		quote_c_style(path, NULL, stdout, 0);
+	else if (strchr(path, ' '))
+		printf("\"%s\"", path);
 	else
 		printf("%s", path);
 }
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index b00196b..dc99556 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -430,7 +430,7 @@ test_expect_success 'fast-export quotes pathnames' '
 	 git commit -m rename &&
 	 git read-tree --empty &&
 	 git commit -m deletion &&
-	 git fast-export HEAD >export.out &&
+	 git fast-export -M HEAD >export.out &&
 	 git rev-list HEAD >expect &&
 	 git init result &&
 	 cd result &&
-- 
1.7.11.29.g70f3df7
