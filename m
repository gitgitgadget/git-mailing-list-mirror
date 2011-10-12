From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Restrict ref-like names immediately below $GIT_DIR
Date: Wed, 12 Oct 2011 17:51:05 -0400
Message-ID: <20111012215105.GA4498@sigill.intra.peff.net>
References: <20111011161652.GA15629@sigill.intra.peff.net>
 <7vr52jfm8i.fsf@alter.siamese.dyndns.org>
 <7vmxd7flkw.fsf@alter.siamese.dyndns.org>
 <7v39ezffq5.fsf_-_@alter.siamese.dyndns.org>
 <20111011230749.GA29785@sigill.intra.peff.net>
 <7vehyjcckp.fsf@alter.siamese.dyndns.org>
 <20111012021128.GA32149@sigill.intra.peff.net>
 <7v39eyddoc.fsf@alter.siamese.dyndns.org>
 <20111012045004.GA22413@sigill.intra.peff.net>
 <7vvcru9k22.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	cmn@elego.de, A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 23:51:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE6hm-0006dt-87
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 23:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754363Ab1JLVvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 17:51:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58929
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751914Ab1JLVvH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 17:51:07 -0400
Received: (qmail 18610 invoked by uid 107); 12 Oct 2011 21:51:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Oct 2011 17:51:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Oct 2011 17:51:05 -0400
Content-Disposition: inline
In-Reply-To: <7vvcru9k22.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183421>

On Wed, Oct 12, 2011 at 10:49:41AM -0700, Junio C Hamano wrote:

> +static int refname_ok_at_root_level(const char *str, int len)
> +{
> +	int seen_non_root_char = 0;
> +
> +	while (len--) {
> +		char ch = *str++;
> +
> +		if (ch == '/')
> +			return 1;
> +		/*
> +		 * Only accept likes of .git/HEAD, .git/MERGE_HEAD at
> +		 * the root level as a ref.
> +		 */
> +		if (ch != '_' && (ch < 'A' || 'Z' < ch))
> +			seen_non_root_char = 1;
> +	}
> +	return !seen_non_root_char;
> +}

I thought from your earlier comment:

> I wanted to start as loose as possible to avoid negatively impacting
> existing users, later to tighten.  As fsck and friends never look
> outside of refs/, I think the prefix refs/ is a reasonable restriction
> that is safe.

that you did agree with tightening this up to allow just refs/ as a
subdirectory.

Squashable patch is below.

diff --git a/refs.c b/refs.c
index 0f26d9d..b159c4a 100644
--- a/refs.c
+++ b/refs.c
@@ -994,21 +994,20 @@ int check_refname_format(const char *ref, int flags)
 
 static int refname_ok_at_root_level(const char *str, int len)
 {
-	int seen_non_root_char = 0;
+	if (len >= 5 && !memcmp(str, "refs/", 5))
+		return 1;
 
 	while (len--) {
 		char ch = *str++;
 
-		if (ch == '/')
-			return 1;
 		/*
 		 * Only accept likes of .git/HEAD, .git/MERGE_HEAD at
 		 * the root level as a ref.
 		 */
 		if (ch != '_' && (ch < 'A' || 'Z' < ch))
-			seen_non_root_char = 1;
+			return 0;
 	}
-	return !seen_non_root_char;
+	return 1;
 }
 
 int refname_match(const char *abbrev_name, const char *full_name, const char **rules)
