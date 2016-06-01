From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git-submodule has bash-ism?
Date: Wed, 1 Jun 2016 12:37:47 -0400
Message-ID: <20160601163747.GA10721@sigill.intra.peff.net>
References: <xmqq1t4h3jxo.fsf@gitster.mtv.corp.google.com>
 <xmqqoa7kzy3u.fsf@gitster.mtv.corp.google.com>
 <xmqqk2i8zxtx.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 18:38:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b899l-0000UX-P7
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 18:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbcFAQhv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 12:37:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:47277 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750822AbcFAQhu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 12:37:50 -0400
Received: (qmail 17258 invoked by uid 102); 1 Jun 2016 16:37:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 12:37:50 -0400
Received: (qmail 2114 invoked by uid 107); 1 Jun 2016 16:37:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 12:37:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jun 2016 12:37:47 -0400
Content-Disposition: inline
In-Reply-To: <xmqqk2i8zxtx.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296099>

On Wed, Jun 01, 2016 at 09:19:06AM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > These are two other offenders.
> >
> > $ git grep '^[	 ]local[ 	]' \*.sh
> > t/t5500-fetch-pack.sh:	local diagport
> > t/t7403-submodule-sync.sh:	local root
> >
> > The grep gives many other hits, but those in completion are OK; it
> > is designed to be specific to bash, and whose tests in t9902 is in
> > the same boat.  A few more near the end of t/test-lib-functions are
> > only for mingw where bash is the only supported shell at least for
> > running tests.
> 
> I think this should be sufficient (extra sets of eyeballs are
> appreciated).  For 5500, diagport is not a variable used elsewhere
> and can simply lose the "local".  7403 overrides the "root" variable
> used in the test framework for no good reason (its use is not about
> temporarily relocating where the test repositories are created), but
> they can be made not to clobber the varible by moving them into the
> subshells it already uses.

I peeked at these cases last night when looking at other shell stuff,
and I agree these are the only two spots which need attention (though I
find it interesting that they've been around for a while with nobody
complaining. "local" isn't in POSIX, but it _is_ supported in a lot of
shells. I wonder if we are being overly conservative in disallowing it,
as the impetus here seems to be ancient versions of ksh, which is having
other problems).

Anyway, I am OK with dropping these ones for now. They are not helping
anything, and they are the last two spots.

> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index 9b9bec4..dc305d6 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -556,7 +556,6 @@ check_prot_path () {
>  }
>  
>  check_prot_host_port_path () {
> -	local diagport
>  	case "$2" in
>  		*ssh*)
>  		pp=ssh

This one is particularly egregious because the function sets a bunch of
other variables and does not bother to "local" them.

> diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
> index 79bc135..5503ec0 100755
> --- a/t/t7403-submodule-sync.sh
> +++ b/t/t7403-submodule-sync.sh
> @@ -62,13 +62,13 @@ test_expect_success 'change submodule' '
>  '
>  
>  reset_submodule_urls () {
> -	local root
> -	root=$(pwd) &&
>  	(
> +		root=$(pwd) &&
>  		cd super-clone/submodule &&
>  		git config remote.origin.url "$root/submodule"
>  	) &&
>  	(
> +		root=$(pwd) &&
>  		cd super-clone/submodule/sub-submodule &&
>  		git config remote.origin.url "$root/submodule"

Hmm. Isn't $root always just going to be $TRASH_DIRECTORY here? There's
only one caller, which appears to pass an argument which is ignored (?).

It's probably worth doing the minimal thing now and leaving further
cleanup for a separate patch, though. Cc-ing John Keeping, the author of
091a6eb0feed, which added this code.

-Peff
