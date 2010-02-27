From: Jeff King <peff@peff.net>
Subject: Re: Retrospectively add alternates to a repository?
Date: Sat, 27 Feb 2010 03:34:18 -0500
Message-ID: <20100227083418.GC27191@coredump.intra.peff.net>
References: <loom.20100227T004822-959@post.gmane.org>
 <be6fef0d1002261837g794e8df2yc92261d46f3235bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steve Folly <steve@spfweb.co.uk>, git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 09:34:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlI83-00033R-Qs
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 09:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967988Ab0B0IeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2010 03:34:22 -0500
Received: from peff.net ([208.65.91.99]:42660 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967981Ab0B0IeV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2010 03:34:21 -0500
Received: (qmail 12004 invoked by uid 107); 27 Feb 2010 08:34:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 27 Feb 2010 03:34:38 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Feb 2010 03:34:18 -0500
Content-Disposition: inline
In-Reply-To: <be6fef0d1002261837g794e8df2yc92261d46f3235bd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141191>

On Sat, Feb 27, 2010 at 10:37:25AM +0800, Tay Ray Chuan wrote:

> yes, just make sure the objects/info/alternates file points to the
> location of that cloned repo's object directory; for example:
> 
>   $ echo /path/to/cloned/repo/.git/objects > .git/objects/info/alternates

You will probably want to then get rid of anything in the child that is
now available in the alternates repository.

I would have thought "git repack -adl" works, but I think there is
something a little funny in the logic. It reports "nothing new to pack",
but does not delete the loose objects. But packing first then worked:

  $ git clone large-parent child
  $ echo $PWD/large-parent/.git/objects >child/.git/objects/info/alternates
  $ cd child

  $ du -sh .git/objects
  51M     .git/objects

  $ git repack -adl && du -sh .git/objects
  Nothing new to pack.
  51M     .git/objects

  $ git repack -ad && du -sh .git/objects
  Counting objects: 3, done.
  Delta compression using up to 2 threads.
  Compressing objects: 100% (2/2), done.
  Writing objects: 100% (3/3), done.
  Total 3 (delta 0), reused 0 (delta 0)
  51M     .git/objects

  $ git repack -adl && du -sh .git/objects
  Nothing new to pack.
  20K     .git/objects

-Peff
