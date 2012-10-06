From: Jeff King <peff@peff.net>
Subject: Re: git 1.8.0.rc0.18.gf84667d trouble with "git commit -p file"
Date: Sat, 6 Oct 2012 09:12:00 -0400
Message-ID: <20121006131200.GB11712@sigill.intra.peff.net>
References: <201210051420.q95EKjj3008300@netbook1.inf.utfsm.cl>
 <op.wlp1lws70aolir@keputer>
 <7vsj9ssgcp.fsf@alter.siamese.dyndns.org>
 <20121005225758.GA1202@sigill.intra.peff.net>
 <7v8vbkru8o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Frans Klaver <fransklaver@gmail.com>, git@vger.kernel.org,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
	Conrad Irwin <conrad.irwin@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 06 15:12:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKUAz-0006pr-0s
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 15:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755264Ab2JFNMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 09:12:07 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42891 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755054Ab2JFNMF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2012 09:12:05 -0400
Received: (qmail 6442 invoked by uid 107); 6 Oct 2012 13:12:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 06 Oct 2012 09:12:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 06 Oct 2012 09:12:00 -0400
Content-Disposition: inline
In-Reply-To: <7v8vbkru8o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207144>

On Fri, Oct 05, 2012 at 11:26:47PM -0700, Junio C Hamano wrote:

> In the case of "add/commit --interactive", it is much more clear
> what state the index is in when the command gave interactive control
> to the user.  The short-cut "add/commit -p" interface, however, does
> not give you an access to its s)tatus subcommand, making the user
> experience somewhat different.
> 
> That makes the problem much more severe for "-p" compared to
> "--interactive", but the fundamental UI consistency it introduces is
> the same as the issue under discussion in this thread.

Agreed.

> Suppose you have two paths E and F, both of which have differences
> between HEAD and the index, and the index and the working tree file
> (i.e. you earlier edited E and F, did "git add E F" and further
> edited them).
> 
> You say "git commit -p F".
> 
> What should happen?  It is clear that the resulting commit should
> record no change since its parent commit at path E (that is what
> "only" semantics mean).
> 
> What state should the "add -p" interaction start from for path F?
> Should you be picking from a patch between the state you previously
> "git add"ed to the index and the working tree, or should the entire
> difference between HEAD and the working tree eligible to be picked
> or deferred during the "add -p" session?  Starting from a temporary
> index that matches HEAD essentially means that you lose the earlier
> "git add F" [*1*].
> 
> Another case to consider is to start from the same condition, and
> instead to say "git commit -p" without any pathspec.  What should
> happen?

Hmm. Good questions. In the former case, I would have said you should
definitely omit E and then start from the staged point of F, as that is
almost certainly what the user meant. But that is utterly inconsistent
with what we are discussing for the no-pathspec case.

I have a gut feeling that what I would expect for "-p" is roughly:

  1. Feed add--interactive the current index state.

  2. Feed add--interactive the set of pathspecs on the command line to
     limit its work.

  3. For any path that is updated by the interactive session, keep the
     result.

  4. For other paths, revert to HEAD.

I think that would "do what I mean" most of the time. But it is a
horrible set of rules to try to explain to someone (and it is off the
top of my head; I wouldn't be surprised if you can come up with a
situation where those rules do not behave well).

> Just doing "use a temporary index that is initialized to HEAD" may
> be an expedient thing to do, but I suspect that I will be saying the
> same "I should have said 'You cannot have a pony' back then" again
> in a not so distant future if we did so without thinking these
> things through.
> 
> As I do not see any practical value in "commit -p", I do not think
> it is worth my time thinking these things through thoroughly myself.
> 
> Unless somebody who cares about "commit -p" does so to come up with
> reasonable semantics, and updates the code to match that desired
> behaviour, the responsible thing to do is to error out "-p" when
> your index is different from HEAD, I think.

Yeah. I did not agree with your conclusion here when we started the
conversation, but I am starting to now. I am not opposed at all to
somebody working out the semantics, but I do not really care to work on
it myself. In the meantime, I would rather not do any halfway fixes
that will just make things worse.

Another option is to leave it with "-i" semantics in the meantime, which
are at least easy to explain: it is simply a shorthand for running "git
add -p && git commit". That may be inconsistent with other aspects of
commit, but people have (apparently) been happy with it, and there has
not been a rash of complaints.

As a non-user of "commit -p" myself, I don't have a strong opinion
either way.

-Peff
