From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] log.decorate: accept 0/1 bool values
Date: Thu, 18 Nov 2010 12:14:43 -0500
Message-ID: <20101118171443.GA21474@sigill.intra.peff.net>
References: <20101117170045.GA4108@sigill.intra.peff.net>
 <7v4obfg2td.fsf@alter.siamese.dyndns.org>
 <20101117195259.GA13008@sigill.intra.peff.net>
 <7vmxp6d0te.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 18 18:14:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ84T-0004yH-Qx
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 18:14:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759834Ab0KRROs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 12:14:48 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:46575 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755198Ab0KRROr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 12:14:47 -0500
Received: (qmail 17017 invoked by uid 111); 18 Nov 2010 17:14:46 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 18 Nov 2010 17:14:46 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Nov 2010 12:14:43 -0500
Content-Disposition: inline
In-Reply-To: <7vmxp6d0te.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161686>

On Thu, Nov 18, 2010 at 09:00:13AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I don't think it is worth closing the hole for no reason on other config
> > options, but I am certainly fine with breaking it in the case of
> > pager.*.
> 
> Hmm, I guess that is fine, but will we hear "Why does it behave
> differently only for pager.*" down the line, just like the issue your
> patch 1/2 addressed, which was "Why does it behave differently only for
> log.decorate?"

Perhaps, but the difference is that for log.decorate I had no answer
(because it was not behaving as indicated by the documentation), whereas
with this I can with a good conscious say "go away, you are relying
ridiculous undocumented behavior".

That being said, it is much easier than I expected to make it Just Work
the same way, so perhaps we should do this on top:

-- >8 --
Subject: [PATCH] handle arbitrary ints in git_config_maybe_bool

This function recently gained the ability to recognize the
documented "0" and "1" values as false/true. However, unlike
regular git_config_bool, it did not treat arbitrary numbers
as true. While this is undocumented and probably ridiculous
for somebody to rely on, it is safer to behave exactly as
git_config_bool would. Because git_config_maybe_bool can be
used to retrofit new non-bool values onto existings bool
options, not behaving in exactly the same way is technically
a regression.

Signed-off-by: Jeff King <peff@peff.net>
---
It even saves 2 lines, so it _must_ be better. :)

 config.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/config.c b/config.c
index d3fa953..299ae80 100644
--- a/config.c
+++ b/config.c
@@ -429,13 +429,11 @@ static int git_config_maybe_bool_text(const char *name, const char *value)
 
 int git_config_maybe_bool(const char *name, const char *value)
 {
-	int v = git_config_maybe_bool_text(name, value);
+	long v = git_config_maybe_bool_text(name, value);
 	if (0 <= v)
 		return v;
-	if (!strcmp(value, "0"))
-		return 0;
-	if (!strcmp(value, "1"))
-		return 1;
+	if (git_parse_long(value, &v))
+		return !!v;
 	return -1;
 }
 
-- 
1.7.3.2.510.g24900
