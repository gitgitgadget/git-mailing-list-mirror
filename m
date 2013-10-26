From: Keshav Kini <keshav.kini@gmail.com>
Subject: Re: [PATCH] graph.c: visual difference on subsequent series
Date: Fri, 25 Oct 2013 21:37:59 -0500
Message-ID: <87mwlwn4e0.fsf@gmail.com>
References: <1382717268-21884-1-git-send-email-milton.soares.filho@gmail.com>
	<xmqqeh79jmtr.fsf@gitster.dls.corp.google.com>
	<CAPNngRMP29s9gZg9R987yRd2qJ=UuaMWnFphtQdGDRgG_SCxsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 26 04:38:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZtlY-0007yV-ME
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 04:38:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325Ab3JZCiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 22:38:13 -0400
Received: from plane.gmane.org ([80.91.229.3]:46665 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753270Ab3JZCiM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 22:38:12 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VZtlT-0007tS-6S
	for git@vger.kernel.org; Sat, 26 Oct 2013 04:38:11 +0200
Received: from cpe-72-179-6-119.austin.res.rr.com ([72.179.6.119])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 26 Oct 2013 04:38:11 +0200
Received: from keshav.kini by cpe-72-179-6-119.austin.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 26 Oct 2013 04:38:11 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: cpe-72-179-6-119.austin.res.rr.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Cancel-Lock: sha1:P69wL3hDL/Sh9SM3Mv46E3ikbUk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236731>

Milton Soares Filho <milton.soares.filho@gmail.com> writes:
> On 25 October 2013 15:13, Junio C Hamano <gitster@pobox.com> wrote:
>> Milton Soares Filho <milton.soares.filho@gmail.com> writes:
>>
>>>     git log --graph --oneline
>>>     * a1
>>>     * a2
>>>     x a3
>>>     * b1
>>>     * b2
>>>     x b3
>>
>> I agree that the problem you are trying to solve is a good thing to
>> tackle, and I also agree that marking a root commit differently from
>> other commits is one way to solve it, but I am not sure if that is
>> the best way.  If the stretches of a's and b's in your history are
>> very long, wouldn't it be easier to spot if they are painted in
>> different colours, in addition to or instead of marking the roots
>> differently [*1*], for example?
>
> Thanks for taking your time reviewing this patch, Junio. I didn't really thought
> it would get any attention since multiple root-commits is not a very common
> use-case[1]. However, if most people got excited with git-subtree new
> features as I did, there is a good chance that multiple root-commits are
> going to become a common-place in the near future ;-)

I don't think this is that obscure. I've often thought there should be
some way to distinguish root commits as well.  In fact when dealing with
multiple root commits I usually just don't use --oneline and instead use
the full --graph view so I can find root commits by grepping for '^  ' :)

I should also mention that there are lots of situations where you might
see multiple "root commits" not because there are truly multiple commits
with no parent in the repository, but because you're looking at some
subgraph of the history graph -- that is, you have multiple commits in
your display whose parents are purposely excluded. For example, you
might be looking at a revision list like 'C ^A ^B':

    master
    |  .---------------B
    | /       `-------------.
    O<                   .---`--C
    | \                 /
    |  `---------------A

The commits you were looking at would be these ones:

              `-------------.
                         .---`--C
                        /

So multiple "roots" can appear easily in such cases.

> That said, I completely agree that painting with different colors would be
> a much better fix, however I believe that it can be done in a separate
> changeset by someone that understands better the impact on the rest
> of the system. Personally, changing only the mark is sufficient because:
>
> a) it'll work on terminal types without coloring support and configurations
>     whose explicitly disable it
> b) it'll spare myself of running a separate GUI program just
>     to spot where each series begin
> c) it won't require any visual design skills from a developer (me)
>     without a minimal sense for it :-)

I'm a bit worried that if someone is parsing `git log --graph` output
looking for `*` lines they might suddenly start missing the root commits
that they were previously able to find.  I mean, not that anyone should
be doing that, but if we can avoid breaking that, why not do so?

What about just putting an extra blank line after every root commit line
(possibly except the last one)?  That should make it plenty easy to see
where the root commits are in --oneline mode.  I think it would actually
be easier to spot at a glance than replacing `*` with `x` because it
creates a gap in all columns of the output, rather than only in column
1.  Also, this is very subjective but I think it looks kind of ugly to
use "x" :P

By the by, you might want to use the `-v` argument to `git send-email`
so that people reading the list can tell at a glance which patch
versions are newer than which other patch versions.

-Keshav
