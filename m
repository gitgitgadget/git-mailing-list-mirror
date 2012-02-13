From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC/PATCH] tag: make list exclude !<pattern>
Date: Mon, 13 Feb 2012 10:37:24 +0100
Message-ID: <4F38D9D4.5000203@alum.mit.edu>
References: <20120210185516.GA4903@tgrennan-laptop> <1328926618-17167-1-git-send-email-tmgrennan@gmail.com> <7vaa4qnk4u.fsf@alter.siamese.dyndns.org> <4F361DD4.9020108@alum.mit.edu> <7vlio9n5ym.fsf@alter.siamese.dyndns.org> <4F389FB1.2070706@alum.mit.edu> <7vsjifgrwl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Tom Grennan <tmgrennan@gmail.com>, pclouds@gmail.com,
	git@vger.kernel.org, krh@redhat.com, jasampler@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 10:37:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwsLn-0003e2-L5
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 10:37:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730Ab2BMJhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 04:37:31 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:41339 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141Ab2BMJha (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 04:37:30 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q1D9bOIu009570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 13 Feb 2012 10:37:25 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.26) Gecko/20120131 Lightning/1.0b2 Thunderbird/3.1.18
In-Reply-To: <7vsjifgrwl.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190622>

On 02/13/2012 07:37 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Of *course* they operate on different namespaces.  But part of the way
>> that revisions are selected using rev-list is by *selecting or excluding
>> refnames* from which it should crawl.
> 
> I am appalled if that is truly the understanding of yours, after having
> taken more than a few patches from you to fairly core parts of Git.
> 
> "rev-list A ^B" does not say "include A and exclude B from which rev-list
> should crawl" AT ALL.  We _actively_ crawl from both A and B.  It is that
> what are reachable from B is painted in a color different from the color
> in which we paint what are reachable from A.

Please read my emails more carefully before insulting me.

It is perfectly clear to me that there are two types of exclusion that
we are talking about.  And *both* of them are (or should be) relevant to
rev-parse.

Take the following repository with three branches:

o---o---o---o  A
     \   \
      \   o---o  C
       \
        o---o  B

If I do "git rev-list A B ^C" then I get the commits marked "*" in the
following diagram

o---o---o---*  A
     \   \
      \   o---o  C
       \
        *---*  B

By excluding C I have necessarily excluded a part of the history of A and B.

If we assume that the proposed feature is implemented and I do "git
rev-list $(git for-each-ref --format='%(refname)' A B ^C)", then I get
something different:

*---*---*---*  A
     \   \
      \   o---o  C
       \
        *---*  B

I argue that this is a useful selection.  For example, maybe I want to
remove the clutter of branch C from my view, but I still want to see the
*whole* history of branches A and B.  The middle selection doesn't do it.

Obviously this is not really necessary if there are only three branches,
but if there are dozens, and if A, B, and C are patterns rather than
literal branch names, then it can be very convenient.

For example, suppose I want to see the status of all of my submissions
in your repository in the context of your main branches plus my local
branches.  It would be great to be able to type

    gitk --with-branch='refs/heads/*' \
         --with-branch='remotes/gitster/*' \
         --without-branch='remotes/gitster/*/**' \
         --with-branch='remotes/gitster/mh/*'

I don't know of a way to do that now.

> A better pair you could have mentioned would be for-each-ref vs rev-parse
> (not rev-list).  What Tom wanted with "do not show the refs that match the
> pattern" he originally wanted to give to "tag --list" would be
> 
> 	for-each-ref A ^B
> 
> that is "show ref that matches A but do not show if it also matches B",
> while what you want to say is "I want to paint A in positive color and
> paint B in negative color, and I want to get a canonical notation to do
> so", it is spelled with rev-parse, not for-each-ref, like this:
> 
> 	rev-parse A ^B

That's not what I want; see above.

> In other words,
> 
> 	git rev-list $(git rev-parse A ^B)
> 
> would be the equivalent to "git rev-list A ^B".
> 
> Maybe you are troubled that there are multiple concepts of negation, which
> ultimately comes from the undeniable fact that for-each-ref and rev-parse
> operate on entities in different concept domain (refnames and objects)?
> And if we decide to use "^", then these two different concepts of negation
> are both expressed with the same operator "prefix ^", leading to
> confusion?

Not only that, but also that both concepts of negation are interesting
and useful within "git rev-list", and therefore we should make them
*combinable*.

To be very explicit, I advocate:

1. Implement an explicit syntax for "do not include references matching
this pattern in a list of references".  Implement this syntax in
for-each-ref; something like

    --with-ref=PATTERN / --without-ref=PATTERN
    --with-branch=PATTERN / --without-branch=PATTERN
    --with-tag=PATTERN / --without-tag=PATTERN
    --with-remote=PATTERN / --without-remote=PATTERN

The point of having multiple with/without pairs would be that the first
would match full refnames explicitly (i.e., the pattern would usually
start with "refs/"), whereas the other pairs would implicitly prepend
"refs/heads/", "refs/tags/", or "refs/remotes/", respectively, to the
pattern for convenience.  There should also be an "--all" option that is
equivalent to "--with-ref=**".

The output from for-each-ref would essentially be a *list of positive
references* matching the criteria.  In other words,
"--without-branch=foo" would cause "refs/heads/foo" to be *excluded*
from the output altogether, *not* included as "^refs/heads/foo".

The order of the options should be significant, with the last matching
pattern winning.

2. The pattern matching of refnames should be like fnmatch, with the
addition of "**" as a wildcard meaning "any characters, including '/'".

3. Other reference-listing commands should take the same options as
appropriate; for example, "git branch --list" would take
--with(out)?-branch and --with(out)?-remote (and maybe
--with(out)?-ref); "git tag --list" would take --with(out)?-tag (and
maybe --with(out)?-ref), etc.

4. The *exact same options* should be added to rev-list, and would
effectively be expanded into a list of positive references; e.g.,

    git rev-list --with-branch=A --with-branch=B --without-branch=C

would be equivalent to

    git rev-list $(git for-each-ref --format='%(refname)'
--with-branch=A --with-branch=B --without-branch=C)

If A, B, and C happen to be branch names rather than patterns, the above
would be equivalent to

    git rev-list refs/heads/A refs/heads/B

Note that this *differs* (in a useful way!) from

    git rev-list refs/heads/A refs/heads/B --not refs/heads/C

or

    git rev-list refs/heads/A refs/heads/B ^refs/heads/C

which are useful in other scenarios and whose meanings we would of
course retain.

If "--not" is used in git-rev-list, it would demarcate groups of options
that are passed separately to for-each-ref; for example,

    git rev-list --all --with-branch=A --without-branch=B \
           --not --with-branch=C --without-branch=D

would be equivalent to

    git rev-list $(git for-each-ref --format='%(refname)' --all
--with-branch=A --without-branch=B)\
           --not $(git for-each-ref --format='%(refname)'
--with-branch=C --without-branch=D)

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
