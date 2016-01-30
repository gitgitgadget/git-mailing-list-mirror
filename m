From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] transport: drop support for git-over-rsync
Date: Sat, 30 Jan 2016 02:28:13 -0500
Message-ID: <20160130072813.GB14696@sigill.intra.peff.net>
References: <20160130051133.GA21973@dcvr.yhbt.net>
 <20160130054141.GB1677@sigill.intra.peff.net>
 <20160130063036.GC1677@sigill.intra.peff.net>
 <20160130072126.GA14696@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Jan 30 08:28:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPPxE-00070s-IL
	for gcvg-git-2@plane.gmane.org; Sat, 30 Jan 2016 08:28:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417AbcA3H2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2016 02:28:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:34775 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751302AbcA3H2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2016 02:28:16 -0500
Received: (qmail 20595 invoked by uid 102); 30 Jan 2016 07:28:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 30 Jan 2016 02:28:16 -0500
Received: (qmail 7146 invoked by uid 107); 30 Jan 2016 07:28:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 30 Jan 2016 02:28:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 30 Jan 2016 02:28:13 -0500
Content-Disposition: inline
In-Reply-To: <20160130072126.GA14696@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285104>

On Sat, Jan 30, 2016 at 02:21:26AM -0500, Jeff King wrote:

> Even the commit porting rsync over to C from shell (cd547b4)
> lists it as deprecated! So between the 10 years of informal
> warnings, and the fact that it has been severely broken
> since 2007, it's probably safe to simply remove it without
> further deprecation warnings.

Obviously it would not be the end of the world to start with a
warning("git-over-rsync is going away!") patch, or to mention it in the
release notes and hold this patch back for a version or two. But after
seeing the extent of the breakage, I can't believe anybody has used it
for years. But I'm also open to erring on the conservative side.

> ---
>  Documentation/config.txt           |   2 +-
>  Documentation/git-bundle.txt       |   2 +-
>  Documentation/git-clone.txt        |   3 +-
>  Documentation/git-repack.txt       |   2 +-
>  Documentation/git.txt              |   2 -
>  Documentation/gitcore-tutorial.txt |  18 +-
>  Documentation/gittutorial.txt      |   2 +-
>  Documentation/urls.txt             |   6 +-
>  t/t5510-fetch.sh                   |  36 ----
>  transport.c                        | 332 +------------------------------------
>  10 files changed, 10 insertions(+), 395 deletions(-)

I cleaned up all of the documentation references I could find, except
one: the git-svn manual notes that because SVN metadata is kept outside
of refs, you should use rsync for cloning. I'm not sure what to
recommend there. I don't eve nthink that "git clone rsync://" would copy
that metadata. So perhaps it just meant "rsync the whole thing yourself"
(in which case it is OK to leave it).

> @@ -984,11 +658,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
>  	if (helper) {
>  		transport_helper_init(ret, helper);
>  	} else if (starts_with(url, "rsync:")) {
> -		transport_check_allowed("rsync");
> -		ret->get_refs_list = get_refs_via_rsync;
> -		ret->fetch = fetch_objs_via_rsync;
> -		ret->push = rsync_transport_push;
> -		ret->smart_options = NULL;
> +		die("git-over-rsync is no longer supported");

I added this as a convenience to anybody who does try to use it
(otherwise they get a more confusing "eh, what is rsync" message).

But if we drop this "if" entirely, then somebody can ship
git-remote-rsync, if they really wanted to (you can use it either way as
"rsync::whatever" but this blocks the fallback of "rsync:whatever").

-Peff
