From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] am -3: allow nonstandard -p<num> option
Date: Tue, 28 Feb 2012 21:58:42 -0500
Message-ID: <20120229025842.GA3585@sigill.intra.peff.net>
References: <1330471495-12013-1-git-send-email-gitster@pobox.com>
 <1330471495-12013-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 29 03:58:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2Zkh-0004Br-Ns
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 03:58:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030639Ab2B2C6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 21:58:45 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60774
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753952Ab2B2C6p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 21:58:45 -0500
Received: (qmail 18242 invoked by uid 107); 29 Feb 2012 02:58:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 28 Feb 2012 21:58:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2012 21:58:42 -0500
Content-Disposition: inline
In-Reply-To: <1330471495-12013-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191803>

On Tue, Feb 28, 2012 at 03:24:54PM -0800, Junio C Hamano wrote:

> When falling back to 3-way merge, we run "git apply" to synthesize the
> fake ancestor tree by parsing the incoming patch, and another "git apply"
> to apply the patch to the fake ancestor tree.  Both invocation need to
> be aware of the custom -p<num> setting to parse patches that were prepared
> with non-standard src/dst prefix.

Makes sense. One question:

> diff --git a/git-am.sh b/git-am.sh
> index 1c13b13..d5d168f 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -127,15 +127,18 @@ fall_back_3way () {
>      mkdir "$dotest/patch-merge-tmp-dir"
>  
>      # First see if the patch records the index info that we can use.
> -    git apply --build-fake-ancestor "$dotest/patch-merge-tmp-index" \
> -	"$dotest/patch" &&
> +    cmd="git apply $git_apply_opt --build-fake-ancestor" &&
> +    cmd="$cmd "'"$dotest/patch-merge-tmp-index" "$dotest/patch"' &&
> +    eval "$cmd" &&

$git_apply_opt can have other stuff in it, too (from my cursory reading,
it looks like --whitespace, --directory, --exclude, -C, --reject,
--ignore-whitespace, and --ignore-space-change).  Those options are now
passed, too.

Naively, I don't think it should be a problem. Many of them will do
nothing (because the patch _should_ apply cleanly to the blobs it
mentions). Some seem like an obvious improvement (e.g., "--directory"
should be just as necessary as "-p", I would think). For something like
"--whitespace=error", I would think we would have errored out already
when we first tried to apply the patch. Or maybe not. I didn't test.

-Peff
