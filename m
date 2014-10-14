From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] receive-pack: plug minor memory leak in unpack()
Date: Tue, 14 Oct 2014 05:16:29 -0400
Message-ID: <20141014091628.GB16686@peff.net>
References: <54390DC0.8060302@web.de>
 <20141012015321.GA15272@peff.net>
 <xmqq1tqb4wkm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 16:43:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xe3Jo-0007Sn-9c
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 16:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbaJNOnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 10:43:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:58346 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932239AbaJNOnP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 10:43:15 -0400
Received: (qmail 14543 invoked by uid 102); 14 Oct 2014 14:43:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Oct 2014 09:43:15 -0500
Received: (qmail 9028 invoked by uid 107); 14 Oct 2014 09:16:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Oct 2014 05:16:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Oct 2014 05:16:29 -0400
Content-Disposition: inline
In-Reply-To: <xmqq1tqb4wkm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 13, 2014 at 12:08:09PM -0700, Junio C Hamano wrote:

> > I wonder if run-command should provide a managed env array similar
> > to the "args" array.
> 
> I took a look at a few of them:

I took a brief look, too.

I had hoped we could just all it "env" and everybody would be happy
using it instead of bare pointers. But quite a few callers assign
"local_repo_env" to to child_process.env. We could copy it into an
argv_array, of course, but that really feels like working around the
interface. So I think we would prefer to keep both forms available.

That raises the question: what should it be called? The "argv_array"
form of "argv" is called "args". The more I see it, the more I hate that
name, as the two are easily confused. We could have:

  const char **argv;
  struct argv_array argv_array;
  const char **env;
  struct argv_array env_array;

though "argv_array" is a lot to type when you have a string of
argv_array_pushf() calls (which are already by themselves kind of
verbose). Maybe that's not too big a deal, though.

We could flip it to give the managed version the short name (and calling
the unmanaged version "env_ptr" or something). That would require
munging the existing callers, but the tweak would be simple.

>  - daemon.c::handle() uses a static set of environment variables
>    that are not built with argv_array().  Same for argv.

Most of the callers you mentioned are good candidates. This one is
tricky.

The argv array gets malloc'd and set up by the parent git-daemon
process. Then each time we get a client, we create a new struct
child_process that references it. So using the managed argv-array would
actually be a bit more complicated (and not save any memory; we just
always point to the single copy for each child).

For the environment, we build it in a function-local buffer, point the
child_process's env field at it, start the child, and then copy the
child_process into our global list of children. When we notice a child
is dead (by linearly going through the list with waitpid), we free the
list entry. So there are a few potentially bad things here:

  1. We memcpy the child_process to put it on the list. Which does work,
     though it feels a little like we are violating the abstraction
     barrier.

  2. The child_process in the list points to the local "env" buffer that
     is no longer valid. There's no bug because we don't ever look at
     it. Moving to a managed env would fix that. But I have to wonder if
     we even want to be keeping the "struct child_process" around in the
     first place (all we really care about is the pid).

  3. If we do move to a managed env, then we expect it to get cleaned up
     in finish_command. But we never call that; we just free the list
     memory containing the child_process. We would want to call
     finish_command. Except that we will have reaped the process already
     with our call to waitpid() from check_dead_children. So we'd need a
     new call to do just the cleanup without the wait, I guess.

  4. For every loop on the listen socket, we call waitpid() for each
     living child, which is a bit wasteful. We'd probably do better to
     call waitpid(0, &status, WNOHANG), and then look up the resulting
     pid in a hashmap or sorted list when we actually see something that
     died. I don't know that this is a huge problem in practice. We use
     git-daemon pretty heavily on our backend servers at GitHub, and it
     seems to use about 5% of a CPU constantly on each machine. Which is
     kind of lame, given that it isn't doing anything at all, but is
     hardly earth-shattering.

So I'm not sure if it is worth converting to a managed env. There's a
bit of ugliness, but none of it is causing any problems, and doing so
opens a can of worms. The most interesting thing to fix (to me, anyway)
is number 4, but that has nothing to do with the env in the first place.
:)

-Peff
