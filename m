From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] CodingGuidelines: describe naming rules for
 configuration variables
Date: Sun, 1 Feb 2015 16:57:30 -0500
Message-ID: <20150201215729.GA19692@peff.net>
References: <xmqqiofskmfd.fsf@gitster.dls.corp.google.com>
 <1422484393-4414-1-git-send-email-gitster@pobox.com>
 <1422484393-4414-4-git-send-email-gitster@pobox.com>
 <54CDB5C6.3020702@alum.mit.edu>
 <xmqq1tm99yhx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 01 22:57:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YI2WQ-0001pR-70
	for gcvg-git-2@plane.gmane.org; Sun, 01 Feb 2015 22:57:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754271AbbBAV5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2015 16:57:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:43895 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752476AbbBAV5d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2015 16:57:33 -0500
Received: (qmail 25153 invoked by uid 102); 1 Feb 2015 21:57:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 01 Feb 2015 15:57:32 -0600
Received: (qmail 3373 invoked by uid 107); 1 Feb 2015 21:58:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 01 Feb 2015 16:58:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 01 Feb 2015 16:57:30 -0500
Content-Disposition: inline
In-Reply-To: <xmqq1tm99yhx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263241>

On Sun, Feb 01, 2015 at 12:18:34PM -0800, Junio C Hamano wrote:

> I can see it argued that for things that are completely independent
> (e.g. the consequence of setting fsck.badDate can never be affected
> by how fsck.missingTagger is configured), separate configuration
> variables may not be wrong per-se, but I can see that a set of knobs
> that would have been originally independent, as the operation grow
> richer, gain more semantics to make them related, and at that point,
> I doubt "they are internally independent; expose them as independent
> to the end users" argument would hold water that well.

I'm not sure I buy this argument. There are two syntaxes being discussed
here. Let's look at each.

Let's call this "type 1":

  [core]
  foo = bar -moof xyzzy=whatever

We have a single variable, but the value of that variable is essentially
a list of sub-variables. The sub-variables are either booleans (like
"bar" or "-moof") or possibly have values of their own (with an "=").
The sub-variables are tied together logically by being part of a single
"core.foo". Presumably the user can infer some relationship between them
through this.

Type 2 is more like:

  [foo]
  bar = true
  moof = false
  xyzzy = whatever

So we still have our same set of sub-variables, except now each is a
first-class config variable. They are tied together logically by being
part of a single section (I called it "foo" here, which drops the
"core"; but clearly we could give it whatever descriptive name we
wanted).

>From the user's perspective, I don't see how the implied relationships
are significantly different. In type 1, they are placed inside a single
value and in type 2, they are not. Both are a form of grouping.

Moreover, I am not even sure that the syntax is an important element in
communicating semantic relationships. In these examples, are "bar" and
"moof" dependent? Clearly they are _related_ by our grouping. But does
one depend on the other? Similarly, with the existing core.whitespace,
what tells you which of the sub-variables are related. The
"blank-at-eol" and "space-before-tab" variables are both
whitespace-related, but do not depend on each other at all. But
"indent-with-non-tab" and "tab-in-indent" are. Yet those two pairs are
represented the same way syntactically.

I don't think you can infer semantic independence from syntax. It's
simply too blunt an instrument (and as you noted, it may even change
over time).

> We structured the syntax for ease of the end user (not scripter) to
> shorter
> 
> 	core.whitespace = tab-in-indent,indent-with-non-tab
> 
> as we need the consistency thing either way (and it is easier to see
> the consistency mistakes when they appear next to each other).

I agree that this provides a slight advantage to "type 1", because it
requires syntactically that the definitions are near each other (whereas
with split variables, they can literally be in different files). And if
everything else were equal, that would be enough. But I think "type 1"
has a lot of other disadvantages. For example:

  1. I'm a user who has set my preferred core.whitespace in my
     ~/.gitconfig. A particular project I am working on uses an
     alternate tabwidth. How do I set that in the repo config without
     repeating my defaults?

  2. I'm writing a hook whose behavior depends on the whitespace
     settings. How do I ask git whether blank-at-eol is enabled?

  3. I'm a user who wants to set whitespace config. I prefer using "git
     config" to editing the file manually. How do I turn off
     blank-at-eol without disrupting my existing settings?

An astute reader will notice that case (1) is a double-edged sword. If
your defaults have "blank-at-eol" and you want to set
"indent-with-non-tab" in the repo, that's fine. If the default is
"tab-in-indent" and you want to set "indent-with-non-tab", then those
are in conflict (i.e., this is the exact thing you were complaining
about above).

But is it such a bad thing to have them in conflict? Can't we define a
set of rules that does what people expects? For example, by the "last
one wins" principle, any time we see "whitespace.tab-in-indent", it
clears the setting of "whitespace.indent-with-non-tab", and vice versa.
This isn't represented syntactically in the config file, but it is an
easy rule, does what people would want, and can be documented in
config.txt (which is where we have to talk about such semantic conflicts
anyway).

By the way, this is the exact case I am concerned about for fsck.*. Our
use case at GitHub would be something like:

  a. We set up sane defaults for fsck.* in /etc/gitconfig

  b. User complains that we will not accept their push, which contains
     objects with malformed committers.

  c. Support investigates, determines that the malformed objects are
     part of a well-established history, and that they are OK to enter.

  d. We relax fsck.committerIdent in that repo's $GIT_DIR/config file.

Copy-and-pasting the rest of the rules from (a) into the repo config
file in step (d) is not ideal.

> I see Peff cites "pager.<cmd>", but I think it was something that we
> would rather shouldn't have done, similar to "alias.<cmd>".  They
> are bad precedents we shouldn't encourage new things to mimic.
> 
> But that is not from "one-variable-with-list-is-better" (it is not
> better for these "independent" ones) but is purely from the syntax
> point of view.

Yeah, I'd agree that the problem there is orthogonal to the type 1/2
thing above. I don't think it has been a big deal in practice, just
because people with good taste do not name their commands with uppercase
anyway.

I'd be happy to transition to pager.*.enabled, etc, if we care. That is
a much more flexible system anyway, and I do not think there is any
backwards compatibility problem (we'd continue with alias.X as a synonym
for alias.X.command indefinitely). It would not even be that much work;
it is mostly that I have never seen anybody complain about it in the
real world.

-Peff
