From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] tag: support configuring --sort via .gitconfig
Date: Thu, 10 Jul 2014 00:07:32 -0400
Message-ID: <20140710040731.GD28401@sigill.intra.peff.net>
References: <1404945412-10197-1-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 06:07:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X55e3-0000rP-E3
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 06:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbaGJEHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2014 00:07:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:59168 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750701AbaGJEHd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2014 00:07:33 -0400
Received: (qmail 29200 invoked by uid 102); 10 Jul 2014 04:07:34 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Jul 2014 23:07:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Jul 2014 00:07:32 -0400
Content-Disposition: inline
In-Reply-To: <1404945412-10197-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253173>

On Wed, Jul 09, 2014 at 03:36:51PM -0700, Jacob Keller wrote:

> +static int parse_sort_string(const char *arg)
> +{
> +	int sort = 0;
> +	int flags = 0;
> +
> +	if (*arg == '-') {
> +		flags |= REVERSE_SORT;
> +		arg++;
> +	}
> +	if (starts_with(arg, "version:")) {
> +		sort = VERCMP_SORT;
> +		arg += 8;
> +	} else if (starts_with(arg, "v:")) {
> +		sort = VERCMP_SORT;
> +		arg += 2;
> +	} else
> +		sort = STRCMP_SORT;
> +	if (strcmp(arg, "refname"))
> +		die(_("unsupported sort specification %s"), arg);
> +	sort |= flags;
> +
> +	return sort;
> +}

I know this is existing code you are moving, but I noticed it looks ripe
for using skip_prefix. Perhaps while we are in the area we should do the
following on top of your patch (I'd also be happy for it be squashed
in, but that may be too much in one patch).

-- >8 --
Subject: [PATCH] tag: use skip_prefix instead of magic numbers

We can make the parsing of the --sort parameter a bit more
readable by having skip_prefix keep our pointer up to date.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/tag.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index a679e32..016df98 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -353,18 +353,14 @@ static int parse_sort_string(const char *arg)
 	int sort = 0;
 	int flags = 0;
 
-	if (*arg == '-') {
+	if (skip_prefix(arg, "-", &arg))
 		flags |= REVERSE_SORT;
-		arg++;
-	}
-	if (starts_with(arg, "version:")) {
-		sort = VERCMP_SORT;
-		arg += 8;
-	} else if (starts_with(arg, "v:")) {
+
+	if (skip_prefix(arg, "version:", &arg) || skip_prefix(arg, "v:", &arg))
 		sort = VERCMP_SORT;
-		arg += 2;
-	} else
+	else
 		sort = STRCMP_SORT;
+
 	if (strcmp(arg, "refname"))
 		die(_("unsupported sort specification %s"), arg);
 	sort |= flags;
-- 
2.0.0.566.gfe3e6b2
