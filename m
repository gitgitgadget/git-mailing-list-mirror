From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] ref namespaces: tests
Date: Thu, 14 Jul 2011 20:45:39 -0700
Message-ID: <20110715034538.GD28343@leaf>
References: <20110714205055.GA26956@leaf>
 <7v1uxs3177.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jamey Sharp <jamey@minilop.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 15 05:46:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhZLn-00053D-Ml
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 05:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932708Ab1GODp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 23:45:58 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:32925 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755047Ab1GODp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 23:45:57 -0400
X-Originating-IP: 217.70.178.134
Received: from mfilter4-d.gandi.net (mfilter4-d.gandi.net [217.70.178.134])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id 7D9C217206D;
	Fri, 15 Jul 2011 05:45:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter4-d.gandi.net
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter4-d.gandi.net (mfilter4-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id yxJnQo5elxbr; Fri, 15 Jul 2011 05:45:53 +0200 (CEST)
X-Originating-IP: 50.43.15.19
Received: from leaf (static-50-43-15-19.bvtn.or.frontiernet.net [50.43.15.19])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 7E94E172074;
	Fri, 15 Jul 2011 05:45:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v1uxs3177.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177188>

On Thu, Jul 14, 2011 at 04:13:48PM -0700, Junio C Hamano wrote:
> Josh Triplett <josh@joshtriplett.org> writes:
> >  create mode 100755 t/t5502-fetch-push-namespaces.sh
> 
> Isn't 5502 used already?

Argh.  Yes; I put it right after t5501-fetch-push-alternates.sh without
noticing that 5502 already existed.  I'll fix it to use t5507.  Thanks
for catching that.

> > +test_expect_success setup '
> > +	test_tick &&
> > +	git init original &&
> > +	(
> > +		cd original &&
> > +		i=0 &&
> > +		while [ "$i" -lt 2 ]
> > +		do
> > +			echo "$i" > count &&
> 
> This is just style, but the test scripts prefer to spell these like this:
> 
> 	while test "$i" -lt 2
> 	do
>         	echo "$i" >count &&
>                 ...
> 
> to favor "test" over "[ ... ]", and omit SP between ">" redirection (or
> "<" for that matter) and the filename.

Will do.  I had done a quick grep-survey of the tests to check usage of
test versus [, and saw enough of both to assume it didn't matter, but it
hadn't occurred to me to check CodingGuidelines for shell scripts; I now
see that it has a section specifically on shell scripting.  I'll fix
this in the next version.

Actually, I plan to unroll this two-iteration loop in the next version,
so that I can capture the two object hashes I need for use later in the
script.

Out of curiosity, what's the rationale for the use of test rather than
'['?  Just uniformity, or does test have some particular advantage over
'['?

> > +		git remote add pushee-namespaced "ext::git --namespace=namespace %s ../pushee" &&
> 
> Nice ;-).

Thanks. :)

> > +test_expect_success 'pushing into a repository using a ref namespace' '
> > +	(
> > +		cd original &&
> > +		git push pushee-namespaced master &&
> > +		git ls-remote pushee-namespaced > actual &&
> > +		printf "dc65a2e0f299dcc7efddbbe01641a28ee84329ba\trefs/heads/master\n" > expected &&
> 
> Could you avoid hardcoding the exact object names here?  Your script knows
> what object should appear at refs/heads/master at "pushee-namespaced" (as
> you have pushed from the repository "original" you are in), so it may be
> something like:
> 
> 	printf "%s\trefs/heads/mater\n" $(git rev-parse master) >expect
> 
> Same comment applies for all the other hardcoded object names.

I can do that; since the same two object hashes recur throughout the
script, I'll record them in shell variables up at the top.

> > +test_expect_success 'mirroring a repository using a ref namespace' '
> > +	git clone --mirror pushee mirror &&
> > +	(
> > +		cd mirror &&
> > +		git for-each-ref refs/ > actual &&
> > +		printf "dc65a2e0f299dcc7efddbbe01641a28ee84329ba commit\trefs/namespaces/namespace/refs/heads/master\n" > expected &&
> > +		printf "fbdf4310c71b916568f04753f603fb24a0544227 commit\trefs/namespaces/namespace/refs/tags/0\n" >> expected &&
> > +		printf "dc65a2e0f299dcc7efddbbe01641a28ee84329ba commit\trefs/namespaces/namespace/refs/tags/1\n" >> expected &&
> > +		test_cmp expected actual
> > +	)
> > +'
> 
> I am not sure what you are trying to test. "pushee" is pretending to be a
> hosting site that uses the namespace feature to house refs pushed from
> original in refs/namespaces/namespace/ so it is expected to have these
> refs under there.  You didn't make any "git remote" configuration in
> either mirror nor pushee, so it is natural with or without the namespace
> feature that "git clone --mirror" would find them at the same place.
> 
> What hasn't been tested in the above is to see what actual refs pushee has
> with (cd pushee && git for-each-ref), and you could argue that this test
> is a proxy for that, but then you are assuming that "clone --mirror" is
> not broken, which means it would make debugging harder when this test does
> start failing---is it the basic namespace feature, or is it mirror cloning
> that acquired a bug to break this test?

I wrote this test specifically to check for possible regressions in
clone or the machinery underneath it.  I wanted to ensure that no future
change caused clone to ignore refs in refs/namespaces/*.  In particular,
I want to protect against a regression caused by any future change to
the refs machinery that might cause it to ignore refs outside of
refs/heads/* or refs/tags/*, which might otherwise go un-noticed (as
they almost did during the development of this patchset, if not for an
incidental side effect of t5501).

If this test failed, I would expect that it would fail because clone
--mirror produced a mirrored repository which didn't actually contain
any refs, even though pushee contained the correctly namespaced refs;
thus, for-each-ref doesn't seem like the right test.

More generally, I also added this test because it tests a specific
high-level feature I care about: the ability to mirror a repository
containing namespaces using clone --mirror, and preserve those
namespaces.  I plan to use that as a backup mechanism, and I want it to
continue working. :)

- Josh Triplett
