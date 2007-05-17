From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Move refspec pattern matching to match_refs().
Date: Wed, 16 May 2007 22:04:14 -0700
Message-ID: <7vhcqcavn5.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0705162217250.18541@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu May 17 07:05:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoYAi-00074J-Qo
	for gcvg-git@gmane.org; Thu, 17 May 2007 07:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760033AbXEQFEW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 01:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760034AbXEQFEW
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 01:04:22 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:33706 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760033AbXEQFEV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 01:04:21 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070517050421.DWNB14313.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Thu, 17 May 2007 01:04:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 054E1X0041kojtg0000000; Thu, 17 May 2007 01:04:20 -0400
In-Reply-To: <Pine.LNX.4.64.0705162217250.18541@iabervon.org> (Daniel
	Barkalow's message of "Wed, 16 May 2007 22:19:12 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47499>

Daniel Barkalow <barkalow@iabervon.org> writes:

> This means that send-pack and http-push will support pattern refspecs,
> so builtin-push.c doesn't have to expand them, and also git push can
> just turn --tags into "refs/tags/*", further simplifying builtin-push.c

Nice.

> @@ -266,5 +174,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>  		usage(push_usage);
>  	}
>  	set_refspecs(argv + i, argc - i);
> +	if (all && refspec)
> +		usage(push_usage);
> +
>  	return do_push(repo);
>  }

Is this hunk an independent bugfix?  I think send-pack has its
own check but I guess http-push lacked its own check?

> diff --git a/refs.c b/refs.c
> index 2ae3235..cd63f37 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -603,15 +603,18 @@ int get_ref_sha1(const char *ref, unsigned char *sha1)
>  
>  static inline int bad_ref_char(int ch)
>  {
> -	return (((unsigned) ch) <= ' ' ||
> -		ch == '~' || ch == '^' || ch == ':' ||
> -		/* 2.13 Pattern Matching Notation */
> -		ch == '?' || ch == '*' || ch == '[');
> +	if (((unsigned) ch) <= ' ' ||
> +	    ch == '~' || ch == '^' || ch == ':')
> +		return 1;
> +	/* 2.13 Pattern Matching Notation */
> +	if (ch == '?' || ch == '*' || ch == '[')
> +		return 2;
> +	return 0;
>  }
>  
>  int check_ref_format(const char *ref)
>  {
> -	int ch, level;
> +	int ch, level, bad_type;
>  	const char *cp = ref;
>  
>  	level = 0;
> @@ -622,13 +625,19 @@ int check_ref_format(const char *ref)
>  			return -1; /* should not end with slashes */
>  
>  		/* we are at the beginning of the path component */
> -		if (ch == '.' || bad_ref_char(ch))
> +		if (ch == '.')
>  			return -1;
> +		bad_type = bad_ref_char(ch);
> +		if (bad_type) {
> +			return (bad_type == 2 && !*cp) ? -3 : -1;
> +		}
>  
>  		/* scan the rest of the path component */
>  		while ((ch = *cp++) != 0) {
> -			if (bad_ref_char(ch))
> -				return -1;
> +			bad_type = bad_ref_char(ch);
> +			if (bad_type) {
> +				return (bad_type == 2 && !*cp) ? -3 : -1;
> +			}
>  			if (ch == '/')
>  				break;
>  			if (ch == '.' && *cp == '.')
> diff --git a/remote.c b/remote.c
> index 46fe8d9..05b16ad 100644
> --- a/remote.c
> +++ b/remote.c
>...
> @@ -497,23 +501,48 @@ static struct ref *find_ref_by_name(struct ref *list, const char *name)
>...
>  int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
>  	       int nr_refspec, char **refspec, int all)
>  {
>  	struct refspec *rs =
>  		parse_ref_spec(nr_refspec, (const char **) refspec);
>  
> -	if (nr_refspec)
> -		return match_explicit_refs(src, dst, dst_tail, rs, nr_refspec);
> +	if (nr_refspec) {
> +		if (match_explicit_refs(src, dst, dst_tail, rs, nr_refspec))
> +			return -1;
> +	}

Style?  "if (nr_refspec && match_explicit...)" and then you can
lose the excess braces.

>  
>  	/* pick the remainder */
>  	for ( ; src; src = src->next) {
>  		struct ref *dst_peer;
>  		if (src->peer_ref)
>  			continue;
> +		if (!check_pattern_match(rs, nr_refspec, src))
> +			continue;
> +
>  		dst_peer = find_ref_by_name(dst, src->name);
> -		if ((dst_peer && dst_peer->peer_ref) || (!dst_peer && !all))
> +		if (dst_peer && dst_peer->peer_ref) {
> +			/* We're already sending something to this ref. */
> +			continue;
> +		}
> +		if (!dst_peer && !nr_refspec && !all) {
> +			/* Remote doesn't have it, and we have no
> +			 * explicit pattern, and we don't have
> +			 * --all. */
>  			continue;
> +		}
>  		if (!dst_peer) {
>  			/* Create a new one and link it */
>  			int len = strlen(src->name) + 1;

Style?  Excess braces...

> diff --git a/send-pack.c b/send-pack.c
> index 59352c8..697dbbc 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -354,6 +354,7 @@ static void verify_remote_names(int nr_heads, char **heads)
>  		case -2: /* ok but a single level -- that is fine for
>  			  * a match pattern.
>  			  */
> +		case -3: /* ok but ends with a pattern-match character */
>  			continue;
>  		}
>  		die("remote part of refspec is not a valid name in %s",

I am not sure what is going on here.  Your new code returns -3
when the pattern has any metacharacter at the end, and
metacharacter in the middle gives -1.  Does that mean the code
would say "alright, that is a pattern" when it sees "refs/heads/foo["?

I think we can go two ways.

 (1) Although the current code does not support it, the intent
     for the globbing refspec "refs/*:refs/remotes/origin/*" was
     to allow "refs/heads/[a-z]*:refs/remotes/origin/[a-z]*" (I
     am not sure about the RHS, but it should be clear that what
     is intended is "grab only the ones that begin with [a-z]
     and track" in that example).  If we were to eventually do
     this, I think check_ref_format() should probably be a bit
     more careful when parsing glob() patterns (e.g. matching
     bra-ket).
     
 (2) As my uncertainty about the RHS above shows, we may not
     support more general glob patterns and stay with only the
     trailing "/*".  At least that is what we have now.  Maybe
     check_ref_format should return "good but ends with meta"
     only when the refspec consists of all good ref_char
     followed by "/*" at the end.

My current preference is the latter.
