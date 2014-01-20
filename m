From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] t/perf: time rev-list with UNINTERESTING commits
Date: Mon, 20 Jan 2014 17:11:42 -0500
Message-ID: <20140120221142.GA24320@sigill.intra.peff.net>
References: <20140120212845.GA11451@sigill.intra.peff.net>
 <20140120213101.GA16095@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 20 23:11:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5N4O-0002pl-IB
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jan 2014 23:11:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753062AbaATWLp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jan 2014 17:11:45 -0500
Received: from cloud.peff.net ([50.56.180.127]:35869 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751825AbaATWLo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jan 2014 17:11:44 -0500
Received: (qmail 16412 invoked by uid 102); 20 Jan 2014 22:11:43 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Jan 2014 16:11:43 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Jan 2014 17:11:42 -0500
Content-Disposition: inline
In-Reply-To: <20140120213101.GA16095@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240731>

On Mon, Jan 20, 2014 at 04:31:01PM -0500, Jeff King wrote:

> diff --git a/t/perf/p0001-rev-list.sh b/t/perf/p0001-rev-list.sh
> index 4f71a63..b7258a7 100755
> --- a/t/perf/p0001-rev-list.sh
> +++ b/t/perf/p0001-rev-list.sh
> @@ -14,4 +14,21 @@ test_perf 'rev-list --all --objects' '
>  	git rev-list --all --objects >/dev/null
>  '
>  
> +test_expect_success 'create new unreferenced commit' '
> +	git checkout --detach HEAD &&
> +	echo content >>file &&
> +	git add file &&
> +	git commit -m detached &&
> +	commit=$(git rev-parse --verify HEAD) &&
> +	git checkout -
> +'

This is bad to be touching the repo and assuming it is non-bare. For
some reason I assumed that the perf suite made a copy of the repo, but
it doesn't. If you point to a bare repo via GIT_PERF_REPO, this part of
the test fails.

It's actually enough to demonstrate the problem without changing the
tree at all. So this produces the same numbers, and works everywhere:

diff --git a/t/perf/p0001-rev-list.sh b/t/perf/p0001-rev-list.sh
index b7258a7..16359d5 100755
--- a/t/perf/p0001-rev-list.sh
+++ b/t/perf/p0001-rev-list.sh
@@ -15,12 +15,7 @@ test_perf 'rev-list --all --objects' '
 '
 
 test_expect_success 'create new unreferenced commit' '
-	git checkout --detach HEAD &&
-	echo content >>file &&
-	git add file &&
-	git commit -m detached &&
-	commit=$(git rev-parse --verify HEAD) &&
-	git checkout -
+	commit=$(git commit-tree HEAD^{tree} -p HEAD)
 '
 
 test_perf 'rev-list $commit --not --all' '

It still modifies the test repo, but at least in a fairly innocuous way.

-Peff
