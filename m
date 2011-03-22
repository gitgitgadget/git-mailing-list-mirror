From: Jeff King <peff@peff.net>
Subject: Re: Weird behavior of shell variables in git aliases
Date: Tue, 22 Mar 2011 07:18:44 -0400
Message-ID: <20110322111844.GA32446@sigill.intra.peff.net>
References: <d9c38309-c433-476c-bba3-f2c5b7e94a89@k15g2000prk.googlegroups.com>
 <20110321215310.GA2122@sigill.intra.peff.net>
 <7v8vw8nmh2.fsf@alter.siamese.dyndns.org>
 <7v4o6wnlxm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Dun Peal <dunpealer@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 12:19:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1zc3-0002cS-3s
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 12:18:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473Ab1CVLSy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 07:18:54 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50942
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750820Ab1CVLSw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 07:18:52 -0400
Received: (qmail 23553 invoked by uid 107); 22 Mar 2011 11:19:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 22 Mar 2011 07:19:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Mar 2011 07:18:44 -0400
Content-Disposition: inline
In-Reply-To: <7v4o6wnlxm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169722>

On Mon, Mar 21, 2011 at 03:33:25PM -0700, Junio C Hamano wrote:

> >> But interestingly, that's _not_ the behavior as of Erik's 7f51f8b
> >> (alias: use run_command api to execute aliases, 2011-01-07), which is in
> >> master but not yet released. With that, we end up executing:
> >>
> >>   sh -c 'echo $1 && echo $1 "$@"' 'echo $1 && echo $1' 'foo'
> [...]
> >
> > Oh, I should have been paying a bit more attention.  I've been assuming
> > that we were turning "!anything" into { "sh", "-c", "anything", "-" }
> > followed by the user supplied arguments.

Yeah, I think that would be more useful in general, but...

> The attached quick hack gives
> 
>   $ git config alias.silly
>   !echo hello $1; echo $# args, bye!
>   $ GIT_TRACE=1 ./git silly world funny
>   trace: exec: 'git-silly' 'world' 'funny'
>   trace: run_command: 'git-silly' 'world' 'funny'
>   trace: run_command: 'sh' '-c' 'echo hello $1; echo $# args, bye'\!'' '-' 'world' 'funny'
>   trace: exec: 'sh' '-c' 'echo hello $1; echo $# args, bye'\!''
>   '-' 'world' 'funny'
>   hello world
>   2 args, bye!
> 
> but it would penalize a properly written alias that uses "sh -c <it> -"
> trick itself by double forking, which is not very nice and I am unhappy
> about.

Doesn't it also break a lot of other more garden-variety aliases that
rely on the automagic "$@", like:

  $ git config alias.log-nopager
  !git --no-pager log

  $ GIT_TRACE=1 git.v1.7.4 log-nopager --oneline
  trace: exec: 'git-log-nopager' '--oneline'
  trace: run_command: 'git-log-nopager' '--oneline'
  trace: alias to shell cmd: log-nopager => git --no-pager log '--oneline'
  trace: built-in: git 'log' '--oneline'
  93c7d44 foo

  $ GIT_TRACE=1 git.master log-nopager --oneline
  trace: exec: 'git-log-nopager' '--oneline'
  trace: run_command: 'git-log-nopager' '--oneline'
  trace: run_command: 'git --no-pager log' '--oneline'
  trace: exec: 'sh' '-c' 'git --no-pager log "$@"' 'git --no-pager log' '--oneline'
  trace: built-in: git 'log' '--oneline'
  93c7d44 foo

  $ GIT_TRACE=1 git.jch.shell-alias log-nopager --oneline
  trace: exec: 'git-log-nopager' '--oneline'
  trace: run_command: 'git-log-nopager' '--oneline'
  trace: run_command: 'sh' '-c' 'git --no-pager log' '-' '--oneline'
  trace: exec: 'sh' '-c' 'git --no-pager log' '-' '--oneline'
  trace: built-in: git 'log'
  commit 93c7d44635e8bb56a4fd864d024ce75a2ad4ffcf
  Author: Jeff King <peff@peff.net>
  Date:   Tue Mar 22 06:57:02 2011 -0400

      foo

I think the evolution of the alias code was something like:

 1. Let's have alias.foo, so that "git foo XXX" can be aliased to "git
    log --whatever XXX", just like shell aliases.

 2. Oops, git doesn't allow some things in (1) that we might want to do,
    like turning off the pager or choosing a new repo. For that we need
    to respawn git, so now we have "!git --whatever1 log --whatever2".
    It appends the arguments, just like the form in (1), so it is
    consistent.

 3. Oops, (2) doesn't allow complex mini-scripts that access the
    parameters in a non-sequential way. You have to do "!sh -c 'git
    --whatever $1 log --whatever2 $2'".

Knowing that step (3) exists, I think your solution is a better one. The
question is whether it is better enough to be worth breaking the people
who were helped by step (2).

Another way of looking at it is that types (1) and (2) are like shell
aliases. And they suck for complex things, just the way that shell
aliases do. The solution in the shell is to put your complex alias into
a shell function, or to push it into its own script. In git, you can
push things into their own script, but we have no equivalent to a shell
function. So one solution is:

  git config function.silly '!echo hello $1; echo $# args, bye!'

The name is of course terrible. But I think the idea is sound that there
are two different types of interface people may want. On the other hand,
this is getting kind of grossly complex. The separate script option is
always available.

-Peff
