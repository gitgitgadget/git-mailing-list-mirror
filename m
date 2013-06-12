From: Jeff King <peff@peff.net>
Subject: Re: Is Git multithreaded ?
Date: Wed, 12 Jun 2013 15:38:37 -0400
Message-ID: <20130612193836.GB4898@sigill.intra.peff.net>
References: <51B8BBC0.6020908@free.fr>
 <51B8BDE4.7030008@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Laurent Alebarde <l.alebarde@free.fr>
X-From: git-owner@vger.kernel.org Wed Jun 12 21:38:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmqsX-0007oG-2q
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 21:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754342Ab3FLTil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jun 2013 15:38:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:39363 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753747Ab3FLTik (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 15:38:40 -0400
Received: (qmail 8466 invoked by uid 102); 12 Jun 2013 19:39:33 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Jun 2013 14:39:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Jun 2013 15:38:37 -0400
Content-Disposition: inline
In-Reply-To: <51B8BDE4.7030008@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227667>

On Wed, Jun 12, 2013 at 08:28:52PM +0200, Laurent Alebarde wrote:

> I wonder if Git is multithreaded ?

A few selected operations are multi-threaded if you compile with
thread support (i.e., do not set NO_PTHREADS when you build).

> For example, during a commit, does it process the files one after one,
> or does it use a set of threads, say 10, to process 10 files in
> parrallel ?

Commit is not multi-threaded, for example.

> In the Git_Guide (http://wiki.sourcemage.org/Git_Guide.html), I can
> read this :
> 
> "T/o enable aut-detection for number of threads to use (good for
> multi-CPU or multi-core computers) for packing repositories, use:

But object packing (used during fetch/push, and during git-gc) is
multi-threaded (at least the delta compression portion of it is).

> But it is not a lot explanatory (to me). In particular, if Git is
> multithreded and can be configured regarding the number of workers, I
> wonder in which operations it uses it ?

There is no master list, and the set of threaded operations changes from
version to version. If you have a clone of the git source code, you can
find the places where threads are used with

  git grep NO_PTHREADS

as every threaded spot also has a single-threaded variant.

The current list is something like:

  - finding delta candidates during pack-objects (gc, server side of
    fetch, client side of push); controlled by pack.threads, which
    defaults to "number of CPUs you have"

  - resolving received objects in index-pack via fetch; controlled by
    pack.threads

  - git grep on a working tree (I do not recall the details, but I think
    grepping a commit actually ends up slower when parallel); I do not
    think there is config to control this

  - when stat()-ing files to refresh the index. This is not about
    parallel CPU performance, but about reducing latency on slow
    filesystems (e.g., NFS) by pipelining requests; controlled by
    core.preloadindex, which defaults to "false"

  - git may fork to perform certain asynchronous operations (e.g.,
    during a fetch, one process runs pack-objects to create the output,
    and the other speaks the git protocol, mostly just passing through
    the output to the client. On systems with threads, some of these
    operations are performed using a thread rather than fork. This is
    not about CPU performance, but about keeping the code simple (and
    cannot be controlled with config).

I hope that helps.

-Peff
