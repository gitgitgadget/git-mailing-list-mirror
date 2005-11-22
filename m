From: linux@horizon.com
Subject: Re: Get rid of .git/branches/ and .git/remotes/?
Date: 22 Nov 2005 08:21:44 -0500
Message-ID: <20051122132144.24691.qmail@science.horizon.com>
References: <4382D31E.40400@op5.se>
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Tue Nov 22 14:24:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeY5r-0007lq-4z
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 14:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbVKVNVw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 08:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbVKVNVw
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 08:21:52 -0500
Received: from science.horizon.com ([192.35.100.1]:53826 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751306AbVKVNVv
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 08:21:51 -0500
Received: (qmail 24692 invoked by uid 1000); 22 Nov 2005 08:21:44 -0500
To: ae@op5.se, linux@horizon.com
In-Reply-To: <4382D31E.40400@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12546>

> So, would this be considered legal or would it barf on baz?
> 
> foo		# No prefix
> 	bar	# tab prefix
>         baz     # 8 spaces prefix

It would barf on baz.  "\t" is not a prefix of "        ".

> Most people have tabsize at 8. Some don't. Some editors insert spaces
> instead of tabs while others don't. If we just match strings we'll
> end up with users sending bug-reports by cut'n pasting their perfectly
> valid-looking config which mixes tabs and spaces just because it's
> been edited by people using different editors.

> Real fun would be if the mta sends tabs as spaces. Then there'd
> be no way at all of telling if the config *is* valid or not.

We have this problem already with whitespace damage in the "before"
parts of patches.  Are you suggesting that the user will be confused
because some third party edited their config using an editor that
messed up the leading whitespace and then just left it broken?

There's a certain level of "evil gremlins came in during the night and
added bugs to my code" that I bloody well expect to be confusing!

You might have problems inserting a line that suffers mailer damage,
mailer sends you, but if you had sent it as a context diff, the patch
process would have choked on the whitespace anyway.

I'm not particularly agitating for an indent-based syntax, but it
is moderately popular and successful, and anyone criticising it should
at least know how it works.

The standard interpretation of leading whitespace accepts basically
that subset of "looks right" that is insensitive to tab setting.

> Excellent error messages aren't good enough. It's ok for Python, since 
> that's a programming language. We can expect infinitely more from 
> programmers than we can from users.

We're talking about git users here, right?
More specifically, we're talking about git users who are pulling from
multiple remote trees, no?

Perhaps you could clarify how this set of people is not a strict
subset of the set of programmers...

>> It irritates you the first few times until you learn to do it right in 
>> first place, just like it irritates most beginning C programmers that the
>> compiler keeps complaining about missing semicolons.

> If I'm trying out some new stuff that annoys me three times without me 
> seeing an obvious error on my part (in the editor of my choice) I 
> usually write it down as broken and move on.

What part of something like:
	Can't figure out nesting level on line 232.  Its leading
	whitespace ("        ", all spaces), is not a prefix or
	extension of the whitespace on the preceding line 230
	("\t", all tabs).
makes the error non-obvious?

If you refuse to read the error message at all, you can get confused,
but you'll also be confused by perfectly valid code producing diagnostics
like "error: dereferencing pointer to incomplete type" if you forget to
#include the right header 200 lines before the location of your error.

>> Computers will be annoying about syntax until they learn to do what
>> I want them to do rather than what I tell them to do, at which point
>> they'll be smart enough to start being annoying by doing what they want
>> to to instead of what I want them to do.

> That's not the point. If everything looks good it should work good, 
> regardless of which editor or tab-setting one's using.

Unfortunately, that's provably impossible, because it will look
different to different people.

Proof by example:

header1
    header2	# 4 spaces
        body3	# 8 spaces
	body4	# one tab

That looks good to me, with 8-space tabs:

header1 {
    header2 {
        body3
        body4
    }
}

But it also looks great to someone with 4-space tabs:

header1 {
    header2 {
        body3
    }
    body4
}

Too bad it doesn't work the same.

The standard whitespace-parsing algorithm rejects "body4" on the grounds
that it's ambiguous.  Simple, robust, and no making guesses that lead
to an error message 20 lines beyond the actual problem.  It just says
"Hey!  Fix line 4!"

>> Seriously, you could always have it print warning messages but try to
>> keep going by assuming 8 space tabs so that at least you can postpone
>> fixing the problem until your current train of thought has pulled into
>> the station.

> There used to be $TABSIZE (or some such). Check it if you implement 
> this. Or just skip it entirely. I would prefer the latter.

Fine with me.  It's a fallback heuristic anyway.
