From: Jeff King <peff@peff.net>
Subject: Re: Gated Merge?
Date: Fri, 12 Feb 2016 14:00:17 -0500
Message-ID: <20160212190017.GA20801@sigill.intra.peff.net>
References: <xmqqvb5uvr40.fsf@gitster.mtv.corp.google.com>
 <CAH5451=rVmdTra0rVNEkfdfOeSyeETSMo7YGWdYozZr_=YyAtw@mail.gmail.com>
 <xmqqr3ghvn6a.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 20:00:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUIx6-0001Gr-OX
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 20:00:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679AbcBLTAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 14:00:20 -0500
Received: from cloud.peff.net ([50.56.180.127]:41152 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751831AbcBLTAU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 14:00:20 -0500
Received: (qmail 14198 invoked by uid 102); 12 Feb 2016 19:00:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Feb 2016 14:00:19 -0500
Received: (qmail 18388 invoked by uid 107); 12 Feb 2016 19:00:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Feb 2016 14:00:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Feb 2016 14:00:17 -0500
Content-Disposition: inline
In-Reply-To: <xmqqr3ghvn6a.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286070>

On Fri, Feb 12, 2016 at 09:44:13AM -0800, Junio C Hamano wrote:

> Andrew Ardill <andrew.ardill@gmail.com> writes:
> 
> > What is the benefit in doing this in notes vs having the tests in the
> > working tree?
> 
> Interesting.  I have never thought of adding this information to the
> project history proper---I've viewed this as primarily an aid for
> keeping track of topics in-flight by an individual, i.e. something
> that the rest of the project do not want to even see.

After reading Andrew's message, I wondered if these are really any
different than regular tests at all.

Let's say I implement feature X on a topic branch, and I add a
regression test for it. Once that is merged, now we have that regression
test forever[1], and any future topic branches that get merged from
master must pass that test or be rejected.

If I update the interface for foo(), it is the same thing. We do not
write a specific test for it, but we expect that the compiler will catch
any callers of the old foo, because the new tree carries the updated
definition that will not work with them (and we often structure our
interface refactoring exactly to catch such things).

So let's go back to your FORMAT_PRINT example. The topic changes all of
the format-attributes into FORMAT_PRINTF, but we never add a "test" that
says "now there are no more bare format-attributes, and if there are, it
is a regression".

But I don't think this needs to have anything to do with merges in
particular, or rules like "when merging a branch that does not have me
in it". It is about saying "from here on out, the tree state should
match this property, and we can test it by running this script". And
then running "make code-lint-tests" becomes part of the acceptance
testing for a proposed topic merge, just like "make test" is already
(and likewise, people forking _new_ branches from master after the topic
is merged would make sure they do not fail the code-lint tests before
even submitting the topic).

-Peff

[1] Of course it doesn't _have_ to be forever. We sometimes modify or
    back out tests as new situations come up, and we could do the same for
    these sorts of code-lint tests.
