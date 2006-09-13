From: Junio C Hamano <junkio@cox.net>
Subject: Re: Marking abandoned branches
Date: Wed, 13 Sep 2006 13:45:02 -0700
Message-ID: <7vhczb7ay9.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910609130817r39bbf8a8x2e05461816d9d2a1@mail.gmail.com>
	<20060913152451.GH23891@pasky.or.cz>
	<Pine.LNX.4.63.0609131729500.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmz93a9v9.fsf@assigned-by-dhcp.cox.net> <ee9jv6$ga0$1@sea.gmane.org>
	<7vbqpja8wz.fsf@assigned-by-dhcp.cox.net> <ee9mff$qd1$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 13 22:45:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNbba-0002yG-Cd
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 22:45:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWIMUpG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 16:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWIMUpG
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 16:45:06 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:30639 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751186AbWIMUpE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 16:45:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060913204503.LWVB21457.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Wed, 13 Sep 2006 16:45:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Mwks1V00c1kojtg0000000
	Wed, 13 Sep 2006 16:44:53 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ee9mff$qd1$1@sea.gmane.org> (Jakub Narebski's message of "Wed,
	13 Sep 2006 21:34:24 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26941>

Jakub Narebski <jnareb@gmail.com> writes:

> Moreover, git currently reads appropriate ref directly in
> git_get_hash_by_ref, not supporting even symrefs, not to mention packed
> refs. One solution would be to add support for symrefs and packed refs
> directly in gitweb (Git.pm can help here), another to use git core command
> (git-rev-parse?) but that can make gitweb slower (additional fork).

The only use of that function is in git_get_refs_list to read
refs by hand, one-by-one.  This calling function needs to be
updated to use the core more effectively to adjust to Linus's
refs/ anyway, so I think git_get_hash_by_ref is too low level
implementation detail to worry about.  What we want is a core
support that git_get_refs_list can use to get the list of refs
and information associated with them efficiently.

Now git_get_refs_list is called from four places, three
functions.  git_summary does two separate calls to refs/tags and
refs/heads.  git_tags and git_heads do one call each for their
own hierarchy.  What this suggests is that the core support we
will give needs a way to specify what subset of refs/* to
include.  peek-remote allows you to do this and it is fairly
efficient for local case (although it could be made more
efficient by not using the general git_connect() framework if we
want a faster local-only command), but it gives back only the
object names.  git_get_refs_list wants more than that.  So what
does it want to know? [*1*]

Looking at parse_ref [*2*]:

 - object name
 - type
   - for a 'tag':
     - what is tagged (type and object name)
     - the tag name
     - the tagger information (name, time, and zone)
     - comment but except PGP signature
     - if it directly [*3*] tags a 'commit':
       - its age based on the commit timestamp
  - for a 'commit':
     - the refname itself
     - the first line of the log message
     - commit timestamp
     - the age based on the commit timestamp
  - for others:
     - the refname itself

The parse_ref implementation itself uses two helpers: parse_tag
and parse_commit, and are used to show a single tag or commit
from git_tag and git_commit request.

So it appears to me that show-ref needs to have at least:

 (1) A way to specify what refs to show, via --tags, --heads,
     --all, and explicit refname parameters.

 (2) Output format specifier to give information of interest for
     each object, which includes the header fields and body of a
     tag and a commit object.  For a tag object, the same for
     the object the tag refers to needs to be availble.

The strawman man-page I sent out about a month ago satisfies the
above except the unpeeling of tag needed in the latter part of
(2).

I'll try to code the one specified by the original strawman up
sometime today; we can discuss enhancements after that.

> I hope that Linus work will be left to mature first in 'pu', then in 'next'
> branch...

That's the general idea.  A new topic always starts out in their
own topic branch, and when I have enough time to look at it in
isolation and I feel confident enough that it is in testable
shape together with what are already in 'next', it is merged
into 'next'.  I did not have enough concentration last night so
Linus's refs/ spent the night in 'pu'.  Hopefully I'll have
energy to look at it enough today to decide if it can be merged
to 'next', or other fix-ups are needed.

It may break 'gitweb' and possibly others.  I offhand do not
know what other things (including git Porcelainish) look at
refs/ directly; they obviously need fixing before the refs/ work
hits 'master', or maybe even 'next'.

> ... wouldn't refs cache (similar to current index for files) be
> better idea?

The ideal is to make a fast and easy way for Porcelains to
access what they want to know about the refs without knowing
their implementation.  We already provide ways to do so except
that they may not be fast nor easy.  And the "may not be fast"
part is what triggers 'cache would be better' reaction, but the
right thing to do is not to work it around with a clutch, but to
design what an appropriate core side support is and implement
it.


[*1*] Here, I am essentially designing what show-ref command
should look like.  I was hoping that Porcelain people who are
users of the core to do this sort of "requirement design" and
present a proposal based on their actual needs.  Unfortunately
it never happened.  Let me set an example by showing how it
should be done here.

[*2*] This is called only once from git_get_refs, so we can get
rid of this function when we rewrite git_get_refs.

[*3*] If we rewrite this part using "foo^{}", gitweb would lose
the ability to distinguish a tag that points directly at a
commit and a tag that points at a tag that points at a commit.
I do not think anybody currently appreciates it right now but
later we might miss it if we did so.

There unfortunately is no way to use rev^{whatever} syntax to
say "peel the onion only one level".
