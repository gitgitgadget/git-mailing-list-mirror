From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 8/8] perf: add tests for tag --contains
Date: Wed, 25 Jun 2014 20:01:29 -0400
Message-ID: <20140626000129.GA25028@sigill.intra.peff.net>
References: <20140625233429.GA20457@sigill.intra.peff.net>
 <20140625235335.GH23146@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 26 02:01:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wzx8B-00044f-Ji
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 02:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755235AbaFZABb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 20:01:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:51237 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752688AbaFZABb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 20:01:31 -0400
Received: (qmail 6262 invoked by uid 102); 26 Jun 2014 00:01:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 Jun 2014 19:01:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jun 2014 20:01:29 -0400
Content-Disposition: inline
In-Reply-To: <20140625235335.GH23146@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252481>

On Wed, Jun 25, 2014 at 07:53:35PM -0400, Jeff King wrote:

> There are still two things about the timings that puzzle me a bit.

<forehead-palm>

This certainly isn't helping:

> +test_expect_success 'find reference points' '
> +	recent=$(git rev-parse HEAD~100) &&
> +	old=$(git rev-parse HEAD~5000) &&
> +	ancient=$(git rev-list | tail -n 1)
> +'

$ancient will always be empty, as rev-list needs a "HEAD" argument.

I also think HEAD~100 is probably _too_ recent, as it is not enough to
match any tags at all right now.

So with this patch:

diff --git a/t/perf/p7000-tag-contains.sh b/t/perf/p7000-tag-contains.sh
index 846f106..8294d41 100755
--- a/t/perf/p7000-tag-contains.sh
+++ b/t/perf/p7000-tag-contains.sh
@@ -6,9 +6,9 @@ test_description='speed of tag --contains lookups'
 test_perf_default_repo
 
 test_expect_success 'find reference points' '
-	recent=$(git rev-parse HEAD~100) &&
+	recent=$(git rev-parse HEAD~200) &&
 	old=$(git rev-parse HEAD~5000) &&
-	ancient=$(git rev-list | tail -n 1)
+	ancient=$(git rev-list HEAD | tail -n 1)
 '
 
 test_expect_success 'find most recent tag' '

I get:

  Test                              ffc4b80^          origin/master             HEAD                  
  ----------------------------------------------------------------------------------------------------
  7000.3: contains recent/all       1.99(1.97+0.01)   0.25(0.24+0.00) -87.4%    0.27(0.26+0.00) -86.4%
  7000.4: contains recent/v2.0.1    0.03(0.03+0.00)   0.00(0.00+0.00) -100.0%   0.03(0.02+0.00) +0.0% 
  7000.5: contains old/all          0.90(0.89+0.00)   0.18(0.17+0.00) -80.0%    0.27(0.26+0.00) -70.0%
  7000.6: contains old/v2.0.1       0.25(0.24+0.00)   0.03(0.03+0.00) -88.0%    0.25(0.24+0.00) +0.0% 
  7000.7: contains ancient/all      0.82(0.80+0.01)   0.13(0.12+0.00) -84.1%    0.27(0.26+0.01) -67.1%
  7000.8: contains ancient/v2.0.1   0.26(0.26+0.00)   0.09(0.08+0.00) -65.4%    0.25(0.24+0.00) -3.8% 

which looks about right.

-Peff
