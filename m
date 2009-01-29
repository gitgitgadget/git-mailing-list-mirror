From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jan 2009, #07; Wed, 28)
Date: Wed, 28 Jan 2009 22:51:38 -0500
Message-ID: <20090129035138.GC11836@coredump.intra.peff.net>
References: <7vwscej26i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 04:53:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSNxk-0004Kv-L7
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 04:53:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915AbZA2Dvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 22:51:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753823AbZA2Dvm
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 22:51:42 -0500
Received: from peff.net ([208.65.91.99]:52296 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753456AbZA2Dvl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 22:51:41 -0500
Received: (qmail 28461 invoked by uid 107); 29 Jan 2009 03:51:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 28 Jan 2009 22:51:50 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Jan 2009 22:51:38 -0500
Content-Disposition: inline
In-Reply-To: <7vwscej26i.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107626>

On Wed, Jan 28, 2009 at 06:06:45PM -0800, Junio C Hamano wrote:

> * sr/clone-empty (Fri Jan 23 01:07:32 2009 +0100) 1 commit
>  + Allow cloning an empty repository
> 
> Has anybody actually tried this and made sure the resulting empty clone
> works fine after the clone source gets updated with some contents?

Hmm. It sort of works:

  $ mkdir parent && (cd parent && git init)
  Initialized empty Git repository in /home/peff/parent/.git/

  $ git clone parent child
  Initialized empty Git repository in /home/peff/child/.git/
  warning: You appear to have cloned an empty repository.

So far so good...

  $ (cd parent && echo content >file && git add file && git commit -m one)
  [normal commit output]
  $ (cd child && git fetch)
  [normal fetch output]

But:

  $ (cd child && git pull)
  You asked me to pull without telling me which branch you
  want to merge with, and 'branch.master.merge' in
  ...

So it's not quite seamless. The problem is that we're not setting up the
branch.master.* config on the empty clone. Nor do we set up
refs/remotes/origin/HEAD.

On top of that, I get funniness between versions:

  $ ssh peff.net 'git version && mkdir foo && cd foo && git init'
  git version 1.5.6.5
  Initialized empty Git repository in /mnt/data/home/peff/foo/.git/

  $ git clone peff.net:foo
  Initialized empty Git repository in /home/peff/foo/.git/
  warning: You appear to have cloned an empty repository.
  $ fatal: The remote end hung up unexpectedly

-Peff
