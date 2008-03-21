From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] remote.c: Fix overtight refspec validation
Date: Fri, 21 Mar 2008 19:12:15 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803211840480.19665@iabervon.org>
References: <alpine.LNX.1.00.0803202049090.19665@iabervon.org> <7v4pb0vhrg.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0803210014100.19665@iabervon.org> <7vmyosskyu.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0803210134070.19665@iabervon.org>
 <7v3aqksic6.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0803211148120.19665@iabervon.org> <7vlk4boh6v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Samuel Tardieu <sam@rfc1149.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 22 00:13:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcqQF-0002CA-6F
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 00:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbYCUXMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 19:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbYCUXM3
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 19:12:29 -0400
Received: from iabervon.org ([66.92.72.58]:35167 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932482AbYCUXM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 19:12:27 -0400
Received: (qmail 28316 invoked by uid 1000); 21 Mar 2008 23:12:15 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Mar 2008 23:12:15 -0000
In-Reply-To: <7vlk4boh6v.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77776>

On Fri, 21 Mar 2008, Junio C Hamano wrote:

> We tightened the refspec validation code in an earlier ef00d15 (Tighten
> refspec processing, 2008-03-17) per my suggestion, but the suggestion was
> misguided to begin with and it broke this usage:
> 
>     $ git push origin HEAD~12:master
> 
> The syntax of push refspecs and fetch refspecs are similar in that they
> are both colon separated LHS and RHS (possibly prefixed with a + to
> force), but the similarity ends there.  For example, LHS in a push refspec
> can be anything that evaluates to a valid object name at runtime (except
> when colon and RHS is missing, or it is a glob), while it must be a
> valid-looking refname in a fetch refspec.  To validate them correctly, the
> caller needs to be able to say which kind of refspecs they are.  It is
> unreasonable to keep a single interface that cannot tell which kind it is
> dealing with, and ask it to behave sensibly.
> 
> This commit separates the parsing of the two into different functions, and
> clarifies the code to implement the parsing proper (i.e. splitting into
> two parts, making sure both sides are wildcard or neither side is).
> 
> This happens to also allow pushing a commit named with the esoteric "look
> for that string" syntax:
> 
>     $ git push ../test.git ':/remote.c: Fix overtight refspec:master'


> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>   Daniel Barkalow <barkalow@iabervon.org> writes:
> 
>   > ... (although the 
>   > patch text made it hard to see; we really need some magic to make diff not 
>   > bother to save 4 identifier-free lines and just show it as a complete 
>   > replacement).
> 
>   Yeah, I tend to agree and some people seem to favor "diff -c" for this
>   reason.
> 
>   In any case, here is an updated patch with a better description and
>   necessary tests.  The "validly looking extended SHA-1 expression" check
>   is wholly outside the scope of 1.5.5 regression fix so I did not even
>   attempt to address it, but what this commit fixes needs to be addressed
>   before -rc1.
> 
>  builtin-fetch.c     |    3 +-
>  builtin-send-pack.c |    2 +-
>  remote.c            |  122 ++++++++++++++++++++++++++++++++++-----------------
>  remote.h            |    3 +-
>  t/t5511-refspec.sh  |   67 ++++++++++++++++++++++++++++
>  5 files changed, 153 insertions(+), 44 deletions(-)
>  create mode 100755 t/t5511-refspec.sh
> 
> diff --git a/builtin-fetch.c b/builtin-fetch.c
> index b2b9935..a11548c 100644
> --- a/builtin-fetch.c
> +++ b/builtin-fetch.c
> @@ -652,5 +652,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  
>  	signal(SIGINT, unlock_pack_on_signal);
>  	atexit(unlock_pack);
> -	return do_fetch(transport, parse_ref_spec(ref_nr, refs), ref_nr);
> +	return do_fetch(transport,
> +			parse_fetch_refspec(ref_nr, refs), ref_nr);
>  }
> diff --git a/builtin-send-pack.c b/builtin-send-pack.c
> index 930e0fb..bb9c33a 100644
> --- a/builtin-send-pack.c
> +++ b/builtin-send-pack.c
> @@ -537,7 +537,7 @@ static void verify_remote_names(int nr_heads, const char **heads)
>  	int i;
>  
>  	for (i = 0; i < nr_heads; i++) {
> -		const char *remote = strchr(heads[i], ':');
> +		const char *remote = strrchr(heads[i], ':');
>  
>  		remote = remote ? (remote + 1) : heads[i];
>  		switch (check_ref_format(remote)) {
> diff --git a/remote.c b/remote.c
> index 9700a33..4117bfc 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -393,58 +393,98 @@ static void read_config(void)
>  	alias_all_urls();
>  }
>  
> -struct refspec *parse_ref_spec(int nr_refspec, const char **refspec)
> +static struct refspec *parse_refspec_internal(int nr_refspec, const char **refspec, int fetch)
>  {
>  	int i;
>  	int st;
>  	struct refspec *rs = xcalloc(sizeof(*rs), nr_refspec);
> +
>  	for (i = 0; i < nr_refspec; i++) {
> -		const char *sp, *ep, *gp;
> -		sp = refspec[i];
> -		if (*sp == '+') {
> +		size_t llen, rlen;
> +		int is_glob;
> +		const char *lhs, *rhs;
> +
> +		llen = rlen = is_glob = 0;
> +
> +		lhs = refspec[i];
> +		if (*lhs == '+') {
>  			rs[i].force = 1;
> -			sp++;
> +			lhs++;
>  		}
> -		gp = strstr(sp, "/*");
> -		ep = strchr(sp, ':');
> -		if (gp && ep && gp > ep)
> -			gp = NULL;
> -		if (ep) {
> -			if (ep[1]) {
> -				const char *glob = strstr(ep + 1, "/*");
> -				if (glob && glob[2])
> -					glob = NULL;
> -				if (!glob)
> -					gp = NULL;
> -				if (gp)
> -					rs[i].dst = xstrndup(ep + 1,
> -							     glob - ep - 1);
> -				else
> -					rs[i].dst = xstrdup(ep + 1);
> -			}
> -		} else {
> -			ep = sp + strlen(sp);
> +
> +		rhs = strrchr(lhs, ':');
> +		if (rhs) {
> +			rhs++;
> +			rlen = strlen(rhs);
> +			is_glob = (2 <= rlen && !strcmp(rhs + rlen - 2, "/*"));
> +			rs[i].dst = xstrndup(rhs, rlen - is_glob * 2);
>  		}
> -		if (gp && gp + 2 != ep)
> -			gp = NULL;
> -		if (gp) {
> -			rs[i].pattern = 1;
> -			ep = gp;
> +
> +		llen = (rhs ? (rhs - lhs - 1) : strlen(lhs));
> +		if (is_glob != (2 <= llen && !memcmp(lhs + llen - 2, "/*", 2)))
> +			goto invalid;
> +
> +		if (is_glob) {
> +			llen -= 2;
> +			rlen -= 2;
>  		}
> -		rs[i].src = xstrndup(sp, ep - sp);
> +		rs[i].pattern = is_glob;
> +		rs[i].src = xstrndup(lhs, llen);
>  
> -		if (*rs[i].src) {
> +		/*
> +		 * Do we want to validate LHS?
> +		 *
> +		 * - Fetch refspec must have LHS that names a valid
> +		 *   looking ref (unless it is empty, which defaults to
> +		 *   HEAD).
> +		 *
> +		 * - Push refspec "LHS" without ":RHS" is a synonym for
> +		 *   "LHS:LHS", and LHS must be a valid looking ref
> +		 *   (cannot be empty).
> +		 *
> +		 * - Push refspec "LHS:RHS" that is a glob must be
> +		 *   a valid looking ref (unless it is empty to remove)
> +		 *
> +		 * Hence we check non-empty LHS for fetch, and
> +		 * colonless or glob LHS for push here.
> +		 *
> +		 * Note that push refspec "LHS:RHS" that is not a glob
> +		 * can have any valid extended SHA-1 expression (or
> +		 * "empty" for removal) in LHS, and we cannot check
> +		 * for error until it actually gets used.
> +		 */

Wouldn't this be clearer and not meaningfully harder in 
parse_fetch_refspec and parse_push_refspec? There are, between the two 
types of checking and the two sides to check, a total of 6 expressions 
used to determine whether something has to be valid as a head, and only 
one pair of them are the same (rs[i].dst), and that's trivial (you don't 
check the part after the colon if there's no colon).

> +		if (fetch ? (*rs[i].src) : (!rhs || is_glob)) {

This is an odd combination of locals and struct members.
                                         : (!rs[i].dst || rs[i].pattern) {

>  			st = check_ref_format(rs[i].src);
>  			if (st && st != CHECK_REF_FORMAT_ONELEVEL)
> -				die("Invalid refspec '%s'", refspec[i]);
> +				goto invalid;
>  		}
> -		if (rs[i].dst && *rs[i].dst) {
> +
> +		/*
> +		 * RHS: both push destination and fetch tracking ref
> +		 * must name a valid looking ref, but in fetch, colon
> +		 * followed by emptiness is the same as not having the
> +		 * colon nor RHS.
> +		 */
> +		if (rs[i].dst && (!fetch || *rs[i].dst)) {
>  			st = check_ref_format(rs[i].dst);
>  			if (st && st != CHECK_REF_FORMAT_ONELEVEL)
> -				die("Invalid refspec '%s'", refspec[i]);
> +				goto invalid;
>  		}
>  	}
>  	return rs;
> +
> + invalid:
> +	die("Invalid refspec '%s'", refspec[i]);
> +}
