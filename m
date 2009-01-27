From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 0/3] fix "Funny: git -p submodule summary"
Date: Tue, 27 Jan 2009 01:25:12 -0500
Message-ID: <20090127062512.GA10487@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0901081601240.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 27 07:26:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRhPF-0000TD-Nv
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 07:26:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbZA0GZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 01:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbZA0GZS
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 01:25:18 -0500
Received: from peff.net ([208.65.91.99]:40355 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751213AbZA0GZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 01:25:16 -0500
Received: (qmail 9227 invoked by uid 107); 27 Jan 2009 06:25:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 27 Jan 2009 01:25:23 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Jan 2009 01:25:12 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901081601240.30769@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107315>

On Thu, Jan 08, 2009 at 04:07:08PM +0100, Johannes Schindelin wrote:

> Just try this with a submodule that has more changes than fit on a screen:
> 
> 	$ git -p submodule summary
> 
> In my tests, it consistently fscks up my console.  I wonder if this is 
> related to ea27a18(spawn pager via run_command interface).

OK, here is a patch series that fixes the problem:

  1/3: git: s/run_command/run_builtin/
  2/3: run_command: handle missing command errors more gracefully
  3/3: git: use run_command to execute dashed externals

1 is a cleanup, 2 is infrastructure support, and 3 is the actual fix.

There are two potential downsides to the fix:

 1. There is an extra fork and a parent process sitting in memory for
    dashed externals. This is pretty necessary to any fix, since
    something has to wait to do pager cleanup, and we can't rely on the
    child to do so.

 2. A failed attempt to execute a dashed external results in an extra
    fork. For builtins, this has no impact, since they take precedence.
    For aliases, though, it means we will do an extra fork before
    realizing that there is no dashed external and trying the alias.

We can fix '2' by actually doing the PATH lookup ourselves, and only
calling run_command if we know we have a match.  We can also reduce the
impact of both by only doing this multi-process magic if we have spawned
a pager; then only a small subset of invocations needs to pay for it.

I chose not to do the second optimization because it makes the code more
complex and inconsistent (we now have two different ways of doing the
same thing, depending on a seemingly unrelated setting) and fragile
(the pager might not be the only atexit handler installed).

The first (doing PATH lookup ourselves) might make sense, though.

JSixt, there are some tweaks to the Windows code to report back the exec
error. They look obviously correct to me, but I have no box to test
(even compile test) them on.

-Peff
