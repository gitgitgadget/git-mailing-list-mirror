From: Jeff King <peff@peff.net>
Subject: Re: How do I resolve conflict after popping stash without adding the
 file to index?
Date: Wed, 22 Apr 2015 15:29:49 -0400
Message-ID: <20150422192948.GA27656@peff.net>
References: <5535697E.2030204@yandex.ru>
 <xmqqsibujyit.fsf@gitster.dls.corp.google.com>
 <553583C0.6090404@yandex.ru>
 <20150421212922.GC13230@peff.net>
 <5536D099.1000103@yandex.ru>
 <20150421225228.GB26322@peff.net>
 <xmqqa8y0f4cv.fsf@gitster.dls.corp.google.com>
 <20150422183540.GC3535@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dmitry Gutov <dgutov@yandex.ru>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 21:30:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl0LY-0003hO-Ti
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 21:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754968AbbDVT35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 15:29:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:48752 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754857AbbDVT3w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 15:29:52 -0400
Received: (qmail 10945 invoked by uid 102); 22 Apr 2015 19:29:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 14:29:51 -0500
Received: (qmail 13092 invoked by uid 107); 22 Apr 2015 19:30:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Apr 2015 15:30:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Apr 2015 15:29:49 -0400
Content-Disposition: inline
In-Reply-To: <20150422183540.GC3535@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267617>

On Wed, Apr 22, 2015 at 02:35:40PM -0400, Jeff King wrote:

> Ironically, the message before e0e2a9c actually recommends staging
> changes before applying the stash, which would lead to this exact
> situation! So I think the most trivial patch is:
> 
> diff --git a/git-stash.sh b/git-stash.sh
> index d4cf818..f1865c9 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -442,6 +442,7 @@ apply_stash () {
>  	assert_stash_like "$@"
>  
>  	git update-index -q --refresh || die "$(gettext "unable to refresh index")"
> +	git diff-index --cached HEAD || die "dirty index; cannot apply stash"
>  
>  	# current index state
>  	c_tree=$(git write-tree) ||
> 
> but it makes me wonder if somebody would find it annoying that they
> cannot apply a stash into their work-in-progress (i.e., it _might_ cause
> annoyance, but most of the time it will be convenient to do so).

It does actually fail a test in t3903, but I think that test just
incidentally had a dirty index, and didn't care about that particular
feature.

> We also have require_clean_work_tree() in git-sh-setup.sh. We definitely
> don't want the first half of that, but we do want the diff-index check.
> So probably we'd want to refactor that into two separate functions, and
> only call the require_clean_index part.

This turned out to be more work than it was worth. Most of the effort
in that function is about adjusting the messages to handle the cases
when either or both of the working tree and index are dirty. I did pick
up the useful bits from there, though:

  - use --quiet to suppress output and so that the exit code actually
    matters

  - use "--" to disambiguate the ref

  - I didn't pick up the `rev-parse HEAD` call. I don't think it's
    necessary (i.e., diff-index should barf for us if it can't read
    HEAD).

Here are the patches.

  [1/3]: t3903: stop hard-coding commit sha1s
  [2/3]: t3903: avoid applying onto dirty index
  [3/3]: stash: require a clean index to apply

-Peff
