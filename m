From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Add a 'source' decorator for commits
Date: Tue, 28 Oct 2008 08:17:02 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0810280755570.3386@nehalem.linux-foundation.org>
References: <alpine.LFD.2.00.0810271256470.3386@nehalem.linux-foundation.org> <alpine.LFD.2.00.0810271305500.3386@nehalem.linux-foundation.org> <alpine.LFD.2.00.0810271306230.3386@nehalem.linux-foundation.org> <20081028054539.GA23195@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 28 16:19:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuqLl-0008M8-Ha
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 16:19:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754403AbYJ1PR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 11:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754396AbYJ1PR5
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 11:17:57 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53963 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754334AbYJ1PR4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Oct 2008 11:17:56 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9SFH31M014878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 28 Oct 2008 08:17:04 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9SFH2Px008256;
	Tue, 28 Oct 2008 08:17:02 -0700
In-Reply-To: <20081028054539.GA23195@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.942 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99297>



On Tue, 28 Oct 2008, Jeff King wrote:
> 
>   - Does it make sense to have this _in addition_ to --decorate (since
>     for any commit with a --decorate field, it would likely be the same
>     as --source)? Should it be a different type of decorate instead,
>     like --decorate=source or --decorate=branch?

I think they are different. People who want --source generally have other 
issues than people who want --decorate, and the two do actually work 
together.

In particular, think about things like "gitk", which currently can't do 
_either_, but that could easily support both. Even to the point where gitk 
might want to add both flags on its own, just to always get the branch and 
the decorate output.

And no, they are _not_ the same. They are vehemently not the same when you 
use abything but '--all', and even with --all they are different because 
decorate has no problems with multiple decorations on one commit, while 
source is very much a single thing per commit.

And --source really has to be just a single data field, because anything 
else will almost inevitably be too expensive to be worth it.


>   - Should this be triggered by the "%d" --pretty=format specifier? This
>     two-liner:
> 
> diff --git a/pretty.c b/pretty.c
> index f6ff312..bdaad19 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -487,6 +487,8 @@ static void format_decoration(struct strbuf *sb, const struct commit *commit)
>  	const char *prefix = " (";
>  
>  	load_ref_decorations();
> +	if (commit->util)
> +		printf("%s", (char *)commit->util);
>  	d = lookup_decoration(&name_decoration, &commit->object);
>  	while (d) {
>  		strbuf_addstr(sb, prefix);
> 
>     works, but:
> 
>       - it doesn't check revs->show_source, so is it possible that
>         commit->util is being used for something else?

Indeed. You should always do the show_source check. There are different 
things that use 'util', and while I don't think any of them will ever use 
the format string, it's still a good idea to just make it consistent.

However:

>       - using '%d' automatically turns on --decorate, so you end up with
>         both the --source and --decorate values. More sensible semantics
>         would be "%d turns on --decorate, unless you have done
>         --decorate=<explicit format>".

As mentioned above, I think this is a non-starter. I don't think 
"decorate" and "source" really have anything to do with each other, except 
that they get printed out in similar ways and in the same function for the 
default printout.

And quite frankly, even that was partly just a "minimal diff" thing, 
although I do think that they both are "decorations", it's just that they 
are very _different_ decorations.

>         Alternatively, this should just be "%b" or "%S".

So yeah, I'd expect a new format specifier.

>   - If you don't specify --all, you just get "HEAD" for everything.
>     Which makes sense when you consider the implementation, but I think
>     is probably a bit confusing for users.

I don't think it's at all confusing, for two reasons:

 - you'd never ever use it manually unless you give multiple branches. Why 
   would you spend time to type out '--source' unless it was because you 
   needed to?

 - for scripting, you want things consistent, even if the 'consistency' is 
   purely about always showing HEAD when that's the only source.

For the second case, imagine having gitk always add "--source" and 
"--decorate" to the command line (the same way it always adds --parents 
and --pretty=raw etc). gitk doesn't want to care how many branches you 
give it as arguments, or whether you use --tags or --all. But it would 
want to always parse things the same way.

No?

> Hmm. It would be nice to keep even a simple counter to get a "distance"
> from the ref and choose the one with the smallest distance

We don't have the space. The other fields on "struct commit" are already 
used (indegree is used for topo sorting etc), and while we could make the 
pointer itself point to a more complex structure rather than the name (one 
that contains counts and possibly multiple names), that would now mean 
that we'd have to make another allocation for each commit. 

And that's very much against the whole point of the 'source' decoration. 
It was designed to be basically zero-cost. 

I could imagine doing it as not a single string: you could make it be a 
pointer to a list of (alphabetically sorted) strings, and then you don't 
have to make an allocation for each commit, you'd only need to do 
something like

	void add_source(struct commit *commit, struct strin_list *list)
	{
		struct string_list *old = commit->util;

		if (!old) {
			commit->util = list;
			return;
		}
		if (old == list)
			return;
		.. do a union sort of 'old'/'list' ..
	}

and I think it would be a stable algorithm (ie we'd share all normal 
cases, and only have to allocate new lists in the relatively rare cases of 
graphs joining), and that would be acceptable.

But the "counter" thing would not work. Not because it's expensive to 
count (it's not - you just increment the counter every time you go to a 
parent, and then if the parent already has a ->util entry, you replace it 
if the new one has a smaller count), but because it's just expensive to do 
another allocation for each commit.

(Of course, "expense" is relative. Maybe another allocation is ok, since 
it would only trigger with --source.)

		Linus
