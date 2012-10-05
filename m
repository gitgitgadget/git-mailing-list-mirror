From: Jeff King <peff@peff.net>
Subject: Re: git 1.8.0.rc0.18.gf84667d trouble with "git commit -p file"
Date: Fri, 5 Oct 2012 18:57:58 -0400
Message-ID: <20121005225758.GA1202@sigill.intra.peff.net>
References: <201210051420.q95EKjj3008300@netbook1.inf.utfsm.cl>
 <op.wlp1lws70aolir@keputer>
 <7vsj9ssgcp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Frans Klaver <fransklaver@gmail.com>, git@vger.kernel.org,
	"Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
	Conrad Irwin <conrad.irwin@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 06 00:58:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKGqT-00038x-OX
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 00:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136Ab2JEW6E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2012 18:58:04 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42320 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752254Ab2JEW6C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 18:58:02 -0400
Received: (qmail 2386 invoked by uid 107); 5 Oct 2012 22:58:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 05 Oct 2012 18:58:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Oct 2012 18:57:58 -0400
Content-Disposition: inline
In-Reply-To: <7vsj9ssgcp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207125>

On Fri, Oct 05, 2012 at 03:29:10PM -0700, Junio C Hamano wrote:

> Assuming that the last step of what Horst did was "git commit -pm",
> I think Git is wrong in this case.  When you tell "git commit" what
> to commit, unless you give "-i" (aka "also") option, the command
> makes a commit to record changes only from what you tell "git
> commit" to commit, regardless of what you earlier did to the index.

Yeah. Defaulting to "-o" would match the rest of git-commit's behavior
much better.

> This is one of the times I wish I said "No, you cannot have a pony".
> The change was done without thinking things through, and reviewers
> including me did not realize this particular downside.
> [...]
> Cf. 
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/173033/focus=173246

Actually, I am not sure that thread or feature is to blame. Certainly it
would have been an opportune time to notice the problem. But this issue
goes back much further for "git commit --interactive", which has always
assumed "-i" rather than "-o". This even predates the switch from shell
to C; you can see the same behavior from 6cbf07e (git-commit: add a
--interactive option, 2007-03-05).

I guess you could argue that "--interactive" and "--patch" should have
different defaults, but I'm not sure I agree. They should both match
what "git commit foo" does by default.

> I think the right thing to do is to fix "git commit -p" so that it
> starts from the HEAD (on a temporary index), just like how partial
> commits are made with "git commit file1 file2".   Or just forbid it
> when the index does not match HEAD.

Agreed. I am inclined to call this a bugfix, though it does worry me
slightly that we would be changing a behavior that has existed for so
many years.

We should probably also support explicit "-i -p" and "-o -p" options, as
well (the former would give people who really want the existing behavior
a way to get it). And the same for "--interactive". I can't say I'm
excited about making all that work, though. Like you, I think it is more
sane to use existing tools to inspect and tweak the index to your
liking, and then commit.

-Peff
