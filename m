From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] revision: allow selection of commits that do not match
 a pattern
Date: Sat, 7 Jul 2007 20:35:35 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707071957370.4093@racer.site>
References: <20070707153001.GA10408MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707071724410.4093@racer.site> <20070707165208.GC1528MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0707071831300.4093@racer.site> <20070707184224.GE1528MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sat Jul 07 21:42:55 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7GB7-0001AH-MH
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 21:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753354AbXGGTmr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 15:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753353AbXGGTmr
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 15:42:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:48787 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753326AbXGGTmq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 15:42:46 -0400
Received: (qmail invoked by alias); 07 Jul 2007 19:42:44 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp001) with SMTP; 07 Jul 2007 21:42:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19+wOxJI7N+0JsYRE9C7IN6zpohsZ0OL0LvqlGnOc
	sQJS1svnzL9g6K
X-X-Sender: gene099@racer.site
In-Reply-To: <20070707184224.GE1528MdfPADPa@greensroom.kotnet.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51837>

Hi,

On Sat, 7 Jul 2007, Sven Verdoolaege wrote:

> We do this by maintaining two lists of patterns, one for
> those that should match and one for those that should not match.

I would at least give one example in the commit message

> diff --git a/revision.c b/revision.c
> index 5184716..4b00ada 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -821,40 +821,65 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
>  	return 0;
>  }
>  
> -static void add_grep(struct rev_info *revs, const char *ptn, enum grep_pat_token what)
> +static void add_grep_to_filter(struct grep_opt **filter, const char *ptn,
> +				enum grep_pat_token what)
>  {
> -	if (!revs->grep_filter) {
> +	if (!*filter) {

Why not keep it "add_grep", and do a

	struct grep_opt **filter = negated ? 
		&revs->grep_neg_filter : &revs->grep_filter;

Hm? You avoid an extra function that way.

> +static void add_header_grep(struct rev_info *revs, const char *field,
> +			    const char *pattern)
>  {
>  	char *pat;
>  	const char *prefix;
>  	int patlen, fldlen;
> +	int negated = 0;
>  
>  	fldlen = strlen(field);
>  	patlen = strlen(pattern);
>  	pat = xmalloc(patlen + fldlen + 10);
>  	prefix = ".*";
> +	if (*pattern == '!') {
> +		negated = 1;
> +		pattern++;
> +	}
> +	if (pattern[0] == '\\' && pattern[1] == '!')
> +		pattern++;
>  	if (*pattern == '^') {
>  		prefix = "";
>  		pattern++;
>  	}
>  	sprintf(pat, "^%s %s%s", field, prefix, pattern);
> -	add_grep(revs, pat, GREP_PATTERN_HEAD);
> +	add_grep(revs, pat, GREP_PATTERN_HEAD, negated);
>  }

The parsing for "!" is again duplicated in add_message_grep(). Why not put 
it into add_grep(), and do

	negated = *pattern == '!';
	sprintf(pat, "%s^%s %s%s", negated ? "!" : "", field, prefix, 
		pattern + negated);

instead? No need to change the signature of add_grep(), and all callers 
get the '!' feature for free.

> @@ -1249,6 +1277,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
>  		compile_grep_patterns(revs->grep_filter);
>  	}
>  
> +	if (revs->grep_neg_filter) {
> +		compile_grep_patterns(revs->grep_neg_filter);
> +	}
> +

Please lose the "{" and "}".

> @@ -1329,11 +1361,14 @@ static int rewrite_parents(struct rev_info *revs, struct commit *commit)
>  
>  static int commit_match(struct commit *commit, struct rev_info *opt)
>  {
> -	if (!opt->grep_filter)
> -		return 1;
> -	return grep_buffer(opt->grep_filter,
> +	return (!opt->grep_filter ||
> +		grep_buffer(opt->grep_filter,
> +			   NULL, /* we say nothing, not even filename */
> +			   commit->buffer, strlen(commit->buffer))) &&
> +	       (!opt->grep_neg_filter ||
> +		!grep_buffer(opt->grep_neg_filter,
>  			   NULL, /* we say nothing, not even filename */
> -			   commit->buffer, strlen(commit->buffer));
> +			   commit->buffer, strlen(commit->buffer)));
>  }

Urgh! That's not nice on my eyes.

Also, I suspect that the semantics are not yet clear, what should happen 
if all_match is unset.

BTW I suspect that a better way than having two filter lists is 
demonstrated in builtin-grep.c.

Ciao,
Dscho
