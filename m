From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Move refspec pattern matching to match_refs().
Date: Thu, 17 May 2007 01:55:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705170106270.18541@iabervon.org>
References: <Pine.LNX.4.64.0705162217250.18541@iabervon.org>
 <7vhcqcavn5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 17 07:56:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoYy8-0004m7-FY
	for gcvg-git@gmane.org; Thu, 17 May 2007 07:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754745AbXEQF4D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 01:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754854AbXEQF4D
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 01:56:03 -0400
Received: from iabervon.org ([66.92.72.58]:1295 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754745AbXEQF4B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 01:56:01 -0400
Received: (qmail 15709 invoked by uid 1000); 17 May 2007 05:55:59 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 May 2007 05:55:59 -0000
In-Reply-To: <7vhcqcavn5.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47504>

On Wed, 16 May 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > This means that send-pack and http-push will support pattern refspecs,
> > so builtin-push.c doesn't have to expand them, and also git push can
> > just turn --tags into "refs/tags/*", further simplifying builtin-push.c
> 
> Nice.
> 
> > @@ -266,5 +174,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
> >  		usage(push_usage);
> >  	}
> >  	set_refspecs(argv + i, argc - i);
> > +	if (all && refspec)
> > +		usage(push_usage);
> > +
> >  	return do_push(repo);
> >  }
> 
> Is this hunk an independent bugfix?  I think send-pack has its
> own check but I guess http-push lacked its own check?

This replaces the die() in expand_refspecs(), which was at the end of 
set_refspecs(). I think the idea is that "git push --all foo bar" isn't a 
consistancy problem, but it suggests that the user is confused, and so the 
error should be up front if there is one.

> > diff --git a/refs.c b/refs.c
> > index 2ae3235..cd63f37 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -603,15 +603,18 @@ int get_ref_sha1(const char *ref, unsigned char *sha1)
> >  
> >  static inline int bad_ref_char(int ch)
> >  {
> > -	return (((unsigned) ch) <= ' ' ||
> > -		ch == '~' || ch == '^' || ch == ':' ||
> > -		/* 2.13 Pattern Matching Notation */
> > -		ch == '?' || ch == '*' || ch == '[');
> > +	if (((unsigned) ch) <= ' ' ||
> > +	    ch == '~' || ch == '^' || ch == ':')
> > +		return 1;
> > +	/* 2.13 Pattern Matching Notation */
> > +	if (ch == '?' || ch == '*' || ch == '[')
> > +		return 2;
> > +	return 0;
> >  }
> >  
> >  int check_ref_format(const char *ref)
> >  {
> > -	int ch, level;
> > +	int ch, level, bad_type;
> >  	const char *cp = ref;
> >  
> >  	level = 0;
> > @@ -622,13 +625,19 @@ int check_ref_format(const char *ref)
> >  			return -1; /* should not end with slashes */
> >  
> >  		/* we are at the beginning of the path component */
> > -		if (ch == '.' || bad_ref_char(ch))
> > +		if (ch == '.')
> >  			return -1;
> > +		bad_type = bad_ref_char(ch);
> > +		if (bad_type) {
> > +			return (bad_type == 2 && !*cp) ? -3 : -1;
> > +		}
> >  
> >  		/* scan the rest of the path component */
> >  		while ((ch = *cp++) != 0) {
> > -			if (bad_ref_char(ch))
> > -				return -1;
> > +			bad_type = bad_ref_char(ch);
> > +			if (bad_type) {
> > +				return (bad_type == 2 && !*cp) ? -3 : -1;
> > +			}
> >  			if (ch == '/')
> >  				break;
> >  			if (ch == '.' && *cp == '.')
> > diff --git a/remote.c b/remote.c
> > index 46fe8d9..05b16ad 100644
> > --- a/remote.c
> > +++ b/remote.c
> >...
> > @@ -497,23 +501,48 @@ static struct ref *find_ref_by_name(struct ref *list, const char *name)
> >...
> >  int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
> >  	       int nr_refspec, char **refspec, int all)
> >  {
> >  	struct refspec *rs =
> >  		parse_ref_spec(nr_refspec, (const char **) refspec);
> >  
> > -	if (nr_refspec)
> > -		return match_explicit_refs(src, dst, dst_tail, rs, nr_refspec);
> > +	if (nr_refspec) {
> > +		if (match_explicit_refs(src, dst, dst_tail, rs, nr_refspec))
> > +			return -1;
> > +	}
> 
> Style?  "if (nr_refspec && match_explicit...)" and then you can
> lose the excess braces.

Actually, just "if (match_explicit(...))" is fine. It'll do nothing and 
return 0 if !nr_refspec.

> >  	/* pick the remainder */
> >  	for ( ; src; src = src->next) {
> >  		struct ref *dst_peer;
> >  		if (src->peer_ref)
> >  			continue;
> > +		if (!check_pattern_match(rs, nr_refspec, src))
> > +			continue;
> > +
> >  		dst_peer = find_ref_by_name(dst, src->name);
> > -		if ((dst_peer && dst_peer->peer_ref) || (!dst_peer && !all))
> > +		if (dst_peer && dst_peer->peer_ref) {
> > +			/* We're already sending something to this ref. */
> > +			continue;
> > +		}
> > +		if (!dst_peer && !nr_refspec && !all) {
> > +			/* Remote doesn't have it, and we have no
> > +			 * explicit pattern, and we don't have
> > +			 * --all. */
> >  			continue;
> > +		}
> >  		if (!dst_peer) {
> >  			/* Create a new one and link it */
> >  			int len = strlen(src->name) + 1;
> 
> Style?  Excess braces...

A comment doesn't count as a second "thing" to be in a conditional for the 
purposes of style? Multiple equally-indented lines without braces 
distracts me with thinking that the actual statement might be misindented.

> I am not sure what is going on here.  Your new code returns -3
> when the pattern has any metacharacter at the end, and
> metacharacter in the middle gives -1.  Does that mean the code
> would say "alright, that is a pattern" when it sees "refs/heads/foo["?
>
> I think we can go two ways.
> 
>  (1) Although the current code does not support it, the intent
>      for the globbing refspec "refs/*:refs/remotes/origin/*" was
>      to allow "refs/heads/[a-z]*:refs/remotes/origin/[a-z]*" (I
>      am not sure about the RHS, but it should be clear that what
>      is intended is "grab only the ones that begin with [a-z]
>      and track" in that example).  If we were to eventually do
>      this, I think check_ref_format() should probably be a bit
>      more careful when parsing glob() patterns (e.g. matching
>      bra-ket).
>      
>  (2) As my uncertainty about the RHS above shows, we may not
>      support more general glob patterns and stay with only the
>      trailing "/*".  At least that is what we have now.  Maybe
>      check_ref_format should return "good but ends with meta"
>      only when the refspec consists of all good ref_char
>      followed by "/*" at the end.
> 
> My current preference is the latter.

The latter is probably the way to go for now. But as far as I can tell, 
refs/heads/db-*:refs/heads/* is currently supported, too.

So, for (2), I'd make bad_ref_char only return 2 for '*', and return 1 for 
'?' and '['.

We can let more stuff get through if we make the parser able to parse it.

	-Daniel
*This .sig left intentionally blank*
