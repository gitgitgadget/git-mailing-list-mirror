From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 14/14] shortlog: match commit trailers with --ident
Date: Tue, 29 Dec 2015 02:50:13 -0500
Message-ID: <20151229075013.GA9191@sigill.intra.peff.net>
References: <20151229071847.GA8726@sigill.intra.peff.net>
 <20151229073832.GN8842@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 29 08:50:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDp34-0001sU-NO
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 08:50:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508AbbL2HuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 02:50:18 -0500
Received: from cloud.peff.net ([50.56.180.127]:46652 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751198AbbL2HuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 02:50:16 -0500
Received: (qmail 19027 invoked by uid 102); 29 Dec 2015 07:50:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 01:50:16 -0600
Received: (qmail 20113 invoked by uid 107); 29 Dec 2015 07:50:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Dec 2015 02:50:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Dec 2015 02:50:13 -0500
Content-Disposition: inline
In-Reply-To: <20151229073832.GN8842@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283106>

A few comments on my own patch...

On Tue, Dec 29, 2015 at 02:38:32AM -0500, Jeff King wrote:

> If a project uses commit trailers, this patch lets you use
> shortlog to see who is performing each action. For example,
> running:
> 
>   git shortlog -ns --ident=reviewed-by

So obviously you can do something similar by piping git-log into grep.
What I think this buys us is the ability to use the trailer-parsing code
rather than hacking together a regex. And it lets you do stuff like
this:

> in git.git shows who has reviewed. You can even use a custom
> format to see things like who has helped whom:
> 
>   git shortlog --format="...helped %an (%ad)" --ident=helped-by

Which relies on correlating trailers and their matching commits.

Since there may be multiple entries per commit, this always ends up as:

  Helper Ident (1):
          ...helped Author Ident
	  ...helped Other Author
	  etc

It would be neat to be able to format it so that each line was a full
record (which would make further stats easier). We'd need a new
formatting option for that.

> diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
> index a89a01e..16080c4 100644
> --- a/Documentation/git-shortlog.txt
> +++ b/Documentation/git-shortlog.txt
> @@ -54,6 +54,15 @@ OPTIONS
>  +
>   - `author`, commits are grouped by author (this is the default)
>   - `committer`, commits are grouped by committer
> + - any other value, the `<type>` is interpreted as a case-insensitive
> +   commit message trailer (see linkgit:git-interpret-trailers[1]). For
> +   example, if your project uses `Reviewed-by` trailers, you might want
> +   to see who has been reviewing with
> +   `git shortlog -ns --ident=reviewed-by`.

This doesn't leave us many syntactic "outs" for adding new ident types
in the future (nor can you match a trailer called "Author"). I guess we
could call this "--ident=trailer:reviewed-by" to be more precise, but
it's more annoying to type. Perhaps we could consider that the
"official" syntax, and DWIM "--ident=foo" to "--ident=trailer:foo", with
the caveat that it may change in the future. I dunno.

> ++
> +Note that commits that do not include the trailer will not be counted.
> +Likewise, commits with multiple trailers (e.g., multiple signoffs) may
> +count more than once.

I think counting multiples is the only sensible thing here. If you have
two helped-by fields, for example it would make sense to credit each
helper. For S-o-b, where the same person may sign-off twice, it does
mean you get credited twice for a single commit. I'm not sure if that's
a feature or not. :)

-Peff
