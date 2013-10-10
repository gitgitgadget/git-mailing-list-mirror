From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: A workflow for local patch maintenance
Date: Thu, 10 Oct 2013 12:18:27 -0700
Message-ID: <20131010191827.GO9464@google.com>
References: <alpine.LSU.2.00.1310081906250.5715@hermes-2.csi.cam.ac.uk>
 <20131010013343.GB14429@sigill.intra.peff.net>
 <alpine.LSU.2.00.1310100927270.3100@hermes-2.csi.cam.ac.uk>
 <20131010173628.GB24782@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Thu Oct 10 21:18:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VULkq-0006BN-5s
	for gcvg-git-2@plane.gmane.org; Thu, 10 Oct 2013 21:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757455Ab3JJTSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Oct 2013 15:18:32 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35403 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896Ab3JJTSb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Oct 2013 15:18:31 -0400
Received: by mail-pa0-f48.google.com with SMTP id bj1so3213686pad.35
        for <git@vger.kernel.org>; Thu, 10 Oct 2013 12:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=TJtAt0e1/KFc6xkcDW0W0cnsXNr26O3rROX2xv0kfpU=;
        b=l6kx/VzXW1AwwKdjuHKOrvVEQ4GU/v8wgQuO6HQO/4aGC5sj2PHYVJnMdy+4nIQ3kf
         rx5NW+R5nVmip4I+74XV4s0/6JQZfMj9r+wBMqzq7FZ3OYnZ0v4AnEcpeq72K3aP35C2
         nj1y1kY2PTy0Dr+QTixs7k+2nnlA1uINNvpy8206rZHpu+aaLDUShuvxwBATu8toMltQ
         UZ98ddNwo0HWqcx6o9mf8/jIj1HQG+2nemwlmZKXOQvuKCXHUdKSk33Udg/QlDURFTKY
         9KA75JshU3dyoodrt5No8WYFGAMSh7N1GehcfcM5b7U1T3pRNdGO1iK5/gp4NapIIcjl
         fUnQ==
X-Received: by 10.68.225.9 with SMTP id rg9mr2760934pbc.122.1381432710738;
        Thu, 10 Oct 2013 12:18:30 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id zq10sm64509562pab.6.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 10 Oct 2013 12:18:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20131010173628.GB24782@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235875>

Jeff King wrote:

>   3. The pain in doing the big rebase-test-deploy cycle meant that we
>      often delayed it, keeping us several versions behind upstream.
>      This is bad not only for the end product (you aren't getting other
>      bugfixes from upstream as quickly), but also because the longer you
>      wait to rebase or merge, the more painful it generally is.
>
> That being said, there are some new downsides, as you noted:
>
>   1. Resolving conflicts between your version and the reworked upstream
>      version can be a pain.
>
>   2. If your local development does not happen in a clean series, it can
>      be hard to create a clean series for upstream, and/or revert in
>      favor of upstream when necessary.

That suggests a possible hybrid approach: use a normal merge-heavy
workflow day to day, but occasionally clean up, for example by
rebasing against upstream.

That doesn't address the question of "how do I preserve old versions
of my patchset after a rebase", though.

The msysgit project uses a script called merging-rebase.sh[1] to
keep their patches current on top of the shifting target of git's
"next".  It's similar to your "merge -s theirs" approach.  It has some
problems (once you get past the current version of the patch stack,
history mining is complicated by all the old versions of the patch
stack) but for their day-to-day development it works ok.

There is an interesting approach that involves only merging and never
rebasing, while still being able to create a presentable patch series
when you're done.  The idea is to keep each patch meant for upstream
consumption in a separate (specially named) branch, with tracked files
like ".topmsg" containing its commit message, dependencies, and other
metadata.  There is a tool called 'tg' (TopGit) for working with this
kind of repo[2].  The Hurd uses it for their binutils and glibc
patches.

Another tool for maintaining a public patch stack, this time using a
"quilt"-style workflow instead of aggressively using native git
commands, is guilt[3], used for example to maintain the ext4 patch
queue.

In practice I tend to find all these too formal, and just keep one
branch that moves forward and is never rebased and a separate branch
that is constantly rebased with commits explaining all my changes to
the upstream code.  E.g., see [4].  This probably only works when the
patch stack is not very large.

Jonathan

[1] https://github.com/msysgit/msysgit/blob/master/share/msysGit/merging-rebase.sh
[2] https://github.com/greenrd/topgit#readme
[3] http://repo.or.cz/w/guilt.git
[4] git://repo.or.cz/xz/debian.git

    Here the constantly-rebased branch is not even published, since
    it is easy to re-create by applying the patches.

    The constantly-advancing branch is "master", which consists of
    patched upstream source + extra metadata in the debian/
    subdirectory.

    The constantly-rebased branch can be revived by applying the
    patches from debian/diff/ to the "upstream" branch.
