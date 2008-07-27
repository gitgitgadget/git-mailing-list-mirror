From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] make sure parsed wildcard refspec ends with slash
Date: Sun, 27 Jul 2008 13:20:34 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0807271257400.19665@iabervon.org>
References: <1216854795-51155-1-git-send-email-lee.marlow@gmail.com> <1216858043-53646-1-git-send-email-lee.marlow@gmail.com> <20080725204051.GB23202@spearce.org> <7v1w1hsmnc.fsf@gitster.siamese.dyndns.org> <20080726082405.GA10104@sigill.intra.peff.net>
 <7vvdysb2na.fsf@gitster.siamese.dyndns.org> <7vsktv3l9k.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 27 19:21:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KN9w9-00038y-86
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 19:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756755AbYG0RUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 13:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752993AbYG0RUg
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 13:20:36 -0400
Received: from iabervon.org ([66.92.72.58]:51338 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752479AbYG0RUf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 13:20:35 -0400
Received: (qmail 19293 invoked by uid 1000); 27 Jul 2008 17:20:34 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Jul 2008 17:20:34 -0000
In-Reply-To: <7vsktv3l9k.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90347>

On Sat, 26 Jul 2008, Junio C Hamano wrote:

> A wildcard refspec is internally parsed into a refspec structure with src
> and dst strings.  Many parts of the code assumed that these do not include
> the trailing "/*" when matching the wildcard pattern with an actual ref we
> see at the remote.  What this meant was that we needed to make sure not
> just that the prefix matched, and also that a slash followed the part that
> matched.
> 
> But a codepath that scans the result from ls-remote and finds matching
> refs forgot to check the "matching part must be followed by a slash" rule.
> This resulted in "refs/heads/b1" from the remote side to mistakenly match
> the source side of "refs/heads/b/*:refs/remotes/b/*" refspec.
> 
> Worse, the refspec crafted internally by "git-clone", and a hardcoded
> preparsed refspec that is used to implement "git-fetch --tags", violated
> this "parsed widcard refspec does not end with slash" rule; simply adding
> the "matching part must be followed by a slash" rule then would have
> broken codepaths that use these refspecs.
> 
> This commit changes the rule to require a trailing slash to parsed
> wildcard refspecs.  IOW, "refs/heads/b/*:refs/remotes/b/*" is parsed as
> src = "refs/heads/b/" and dst = "refs/remotes/b/".  This allows us to
> simplify the matching logic because we only need to do a prefixcmp() to
> notice "refs/heads/b/one" matches and "refs/heads/b1" does not.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I have a nagging suspicion that it might be a simpler and cleaner change
> > to change parse_refspec_internal() to keep the trailing slash, instead of
> > dropping it.  Then the check you added is not needed (the trailing slash
> > guarantees that the pattern matches at the hierarchy boundary), neither
> > any of the change in this patch.
> 
> This is the other variant, and it turns out that I was right.  Among the
> 64-18 = 46 new lines, 30 are from the new test file.  Two existing
> "matching part is followed by '/'" tests are removed.

Yeah, the first version of this code included the '/', by virtue of having 
the '/' not be required in the refspec (i.e., you could have 
"refs/heads/b*"); when you told me that refspecs needed to have a '/' 
before the '*', I thought that it would be easiest to not include the '/', 
since it was redundant, but, in retrospect, I'm not too surprised that it 
simplifies things to include it.

Acked-by: Daniel Barkalow <barkalow@iabervon.org>

>  remote.c               |   52 +++++++++++++++++++++++++++++++----------------
>  t/t5513-fetch-track.sh |   30 +++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+), 18 deletions(-)
> 
> diff --git a/remote.c b/remote.c
> index 0d6020b..f61a3ab 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -427,6 +427,28 @@ static void read_config(void)
>  	alias_all_urls();
>  }
>  
> +/*
> + * We need to make sure the tracking branches are well formed, but a
> + * wildcard refspec in "struct refspec" must have a trailing slash. We
> + * temporarily drop the trailing '/' while calling check_ref_format(),
> + * and put it back.  The caller knows that a CHECK_REF_FORMAT_ONELEVEL
> + * error return is Ok for a wildcard refspec.
> + */
> +static int verify_refname(char *name, int is_glob)
> +{
> +	int result, len = -1;
> +
> +	if (is_glob) {
> +		len = strlen(name);
> +		assert(name[len - 1] == '/');
> +		name[len - 1] = '\0';
> +	}
> +	result = check_ref_format(name);
> +	if (is_glob)
> +		name[len - 1] = '/';
> +	return result;
> +}
> +

Maybe check_ref_format() ought to have a return for "this is valid as a 
directory rather than a single ref", and that would be allowed with globs? 
I'm not too fond of temporarily changing strings for testing. Also, this 
design (while it matches the current code), means that check_ref_format() 
sees one fewer level than the refs that match will actually have, which is 
a little confusing.

	-Daniel
*This .sig left intentionally blank*
