From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] refs.c: get_ref_cache: use a bucket hash
Date: Mon, 16 Nov 2015 11:31:30 -0500
Message-ID: <20151116163130.GA15046@sigill.intra.peff.net>
References: <20150316142026.GJ7847@inner.h.apk.li>
 <xmqq1tkosvpi.fsf@gitster.dls.corp.google.com>
 <20150316184040.GA8902@inner.h.apk.li>
 <20150317024005.GA26313@peff.net>
 <xmqqd248p4o9.fsf@gitster.dls.corp.google.com>
 <20150317054759.GA16860@peff.net>
 <20151113152915.GC16219@inner.h.apk.li>
 <20151114000118.GB18260@sigill.intra.peff.net>
 <20151114133501.GI16219@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 16 17:31:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyMgs-0003oD-7l
	for gcvg-git-2@plane.gmane.org; Mon, 16 Nov 2015 17:31:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691AbbKPQbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 11:31:34 -0500
Received: from cloud.peff.net ([50.56.180.127]:58145 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751942AbbKPQbd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 11:31:33 -0500
Received: (qmail 4997 invoked by uid 102); 16 Nov 2015 16:31:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Nov 2015 10:31:33 -0600
Received: (qmail 13945 invoked by uid 107); 16 Nov 2015 16:32:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Nov 2015 11:32:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Nov 2015 11:31:30 -0500
Content-Disposition: inline
In-Reply-To: <20151114133501.GI16219@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281347>

On Sat, Nov 14, 2015 at 02:35:01PM +0100, Andreas Krey wrote:

> On Fri, 13 Nov 2015 19:01:18 +0000, Jeff King wrote:
> ...
> >   2. But for a little more work, pushing the is_git_directory() check
> >      out to the call-sites gives us probably saner semantics overall.
> 
> Oops, now I get it[1]: You mean replacing resolve_gitlink_ref usages
> with is_git_directory, like:

Yes. I mistakenly said is_git_directory, when I really meant
is_git_repository, the new function added in 0179ca7a62. You seem to
have figured out what I meant, but the critical thing is that we check
"$dir/.git", not just "$dir" (and check it both as a git dir and as a
gitfile, as is_git_repository() does).

I'm not sure if we can simply make that function public or not. It's
mostly straightforward, but it does err on the side of "yes, this is a
git repo" if we see a ".git" file we can't read. I think that's probably
reasonable in most sites, but I didn't look closely.

> diff --git a/dir.c b/dir.c
> index d2a8f06..7765dc6 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1375,8 +1375,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
>  		if (dir->flags & DIR_SHOW_OTHER_DIRECTORIES)
>  			break;
>  		if (!(dir->flags & DIR_NO_GITLINKS)) {
> -			unsigned char sha1[20];
> -			if (resolve_gitlink_ref(dirname, "HEAD", sha1) == 0)
> +			if (is_git_directory(dirname))
>  				return path_untracked;
>  		}
>  		return path_recurse;
> 
> That, I like. If it is correct.

Yes, that's what I had in mind, modulo the directory/repository thing
above (the is_git_repository function also takes a strbuf, so we'd need
to handle that extra allocation somewhere).

-Peff
