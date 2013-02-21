From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] archive: let remote clients get reachable commits
Date: Thu, 21 Feb 2013 10:52:08 -0500
Message-ID: <20130221155208.GA19943@sigill.intra.peff.net>
References: <1361456643-51851-1-git-send-email-gurugray@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Sergey Segeev <gurugray@yandex.ru>
X-From: git-owner@vger.kernel.org Thu Feb 21 16:52:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8YRo-00061J-51
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 16:52:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754294Ab3BUPwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 10:52:11 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55503 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754163Ab3BUPwK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 10:52:10 -0500
Received: (qmail 27406 invoked by uid 107); 21 Feb 2013 15:53:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Feb 2013 10:53:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Feb 2013 10:52:08 -0500
Content-Disposition: inline
In-Reply-To: <1361456643-51851-1-git-send-email-gurugray@yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216778>

On Thu, Feb 21, 2013 at 06:24:03PM +0400, Sergey Segeev wrote:

> Some time we need to get valid commit without a ref but with proper
> tree-ish, now we can't do that.
> 
> This patch allow upload-archive's to use reachability checking
> rather than checking that is a ref. This means a remote client can
> fetch a tip of any valid sha1 or tree-ish.

That sounds like a good goal, but...

> @@ -252,22 +260,16 @@ static void parse_treeish_arg(const char **argv,
>  	const struct commit *commit;
>  	unsigned char sha1[20];
>  
> -	/* Remotes are only allowed to fetch actual refs */
> -	if (remote) {
> -		char *ref = NULL;
> -		const char *colon = strchr(name, ':');
> -		int refnamelen = colon ? colon - name : strlen(name);
> -
> -		if (!dwim_ref(name, refnamelen, sha1, &ref))
> -			die("no such ref: %.*s", refnamelen, name);
> -		free(ref);
> -	}

The point of this was to allow "commit:path" syntax, and check that
commit pointed to a ref. The natural extension would be to also check
that the commit part is reachable.

I think it is also not sufficient to just check whether the left-hand
side of the colon is a reachable commit. You would also want to handle
non-commits which are directly pointed-to by a ref or its tag (e.g.,
think of a tag pointing directly to a tree, like the v2.6.11 tag in the
linux repo).

Your check...

>  	commit = lookup_commit_reference_gently(sha1, 1);
>  	if (commit) {
> +
> +		/* Remotes are only allowed to fetch actual objects */
> +		if (remote && !for_each_ref(check_reachable, (void *)commit))
> +			die("Not a valid object name");
> +
>  		commit_sha1 = commit->object.sha1;
>  		archive_time = commit->date;
>  	} else {

...will do nothing if we do not have a commit reference (e.g., an arbitrary
sha1, or commit:path syntax). We follow the "else" of this branch, and
allow arbitrary sha1's to be fetched (like "unreachable_sha1:subdir").

-Peff
