From: Jeff King <peff@peff.net>
Subject: [PATCHv2 2/2] attr: drop C/C++ default extension mapping
Date: Mon, 19 Dec 2011 10:57:37 -0500
Message-ID: <20111219155737.GB19829@sigill.intra.peff.net>
References: <20111217033808.GA8683@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 19 16:57:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rcfb4-0006SP-Et
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 16:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277Ab1LSP5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 10:57:42 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45885
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752209Ab1LSP5k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 10:57:40 -0500
Received: (qmail 32109 invoked by uid 107); 19 Dec 2011 16:04:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 19 Dec 2011 11:04:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Dec 2011 10:57:37 -0500
Content-Disposition: inline
In-Reply-To: <20111217033808.GA8683@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187452>

The point of this mapping is largely to get funcname
support. However, there's been some indication that our C
funcname pattern produces worse results than the default
pattern, so let's leave it unmapped for now.

If and when it improves, this commit can be reverted.

Signed-off-by: Jeff King <peff@peff.net>
---
Obviously this could just be squashed into the first patch. But I think
I'd rather leave a more explicit note in the history.

When writing the justification for this commit message, though, I did
notice that my reasoning is slightly flawed. The complaint is that the C
funcname pattern sucks, and therefore a user who hasn't configured
anything has a worse experience with patch 1. But enabling that sucky
experience is a two-step process:

  1. map *.c, etc to the diff driver "cpp"

  2. diff driver "cpp" has a funcname (which is reportedly bad)

Since this series is about tweaking extension mapping, the natural thing
to do is not enable (1).

But when you think about it, if our funcname pattern is bad, shouldn't
preventing (2) be the right thing? That is, if our funcname pattern is
really worse than the default language-agnostic match, wouldn't we be
doing everybody a service to simply remove the builtin
diff.cpp.xfuncname pattern?

Then you're not only not causing a regression for users who haven't
configured anything; you're actively helping people who have set
"diff=cpp" themselves.

Of course you're causing a regression to people who _like_ the current
diff.cpp.xfuncname. But if they are so widespread, then why is there so
much opposition to turning it on by default? My theory is that people
aren't actually using the builtin diff.cpp.xfuncname.

 attr.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/attr.c b/attr.c
index 10713f3..2f33128 100644
--- a/attr.c
+++ b/attr.c
@@ -316,12 +316,6 @@ static void free_attr_elem(struct attr_stack *e)
 	"*.rb diff=ruby",
 	"*.bib diff=bibtex",
 	"*.tex diff=tex",
-	"*.c diff=cpp",
-	"*.cc diff=cpp",
-	"*.cxx diff=cpp",
-	"*.cpp diff=cpp",
-	"*.h diff=cpp",
-	"*.hpp diff=cpp",
 	"*.cs diff=csharp",
 	"*.[Ff] diff=fortran",
 	"*.[Ff][0-9][0-9] diff=fortran",
-- 
1.7.8.rc2.38.gd9625
