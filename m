From: Brian Campbell <lambda@continuation.org>
Subject: Re: Remove diff machinery dependency from read-cache
Date: Sat, 23 Jan 2010 01:31:35 -0500
Message-ID: <18EEE333-C31B-4648-A9A5-F828C1582C10@continuation.org>
References: <alpine.LFD.2.00.1001211119130.13231@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jan 23 07:32:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYZXq-0006w6-2W
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 07:32:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754375Ab0AWGcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 01:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753444Ab0AWGcZ
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 01:32:25 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:36601 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068Ab0AWGcY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Jan 2010 01:32:24 -0500
Received: from homiemail-a2.g.dreamhost.com (caiajhbdcbef.dreamhost.com [208.97.132.145])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 0389317992E
	for <git@vger.kernel.org>; Fri, 22 Jan 2010 22:32:25 -0800 (PST)
Received: from [192.168.1.3] (c-75-69-96-104.hsd1.nh.comcast.net [75.69.96.104])
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id 091FED26E3;
	Fri, 22 Jan 2010 22:31:39 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1001211119130.13231@localhost.localdomain>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137812>

On Jan 21, 2010, at 2:37 PM, Linus Torvalds wrote:

> ---
> builtin-add.c |   76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
> read-cache.c  |   78 ---------------------------------------------------------
> 2 files changed, 76 insertions(+), 78 deletions(-)
> 
> diff --git a/builtin-add.c b/builtin-add.c
> index cb6e590..2705f8d 100644

I've recently tried building "master" from git://git.kernel.org/pub/scm/git/git.git, and got the following error:

    $ make
...snip...	
        LINK git-fast-import
    Undefined symbols:
      "_git_mailmap_file", referenced from:
          _git_default_config in libgit.a(config.o)
    ld: symbol(s) not found
    collect2: ld returned 1 exit status
    make: *** [git-fast-import] Error 1

When I bisect, I find this commit to blame:

    $ git bisect start master v1.6.6.1
    Bisecting: 197 revisions left to test after this (roughly 8 steps)
    [f8eb50f60b5c8efda3529fcf89517080c686ce0b] Merge branch 'jh/commit-status'
    $ git bisect run make -j2
    running make -j2
    GIT_VERSION = 1.6.6.240.gf8eb5
...snip...
    fb7d3f32b283a3847e6f151a06794abd14ffd81b is the first bad commit
    commit fb7d3f32b283a3847e6f151a06794abd14ffd81b
    Author: Linus Torvalds <torvalds@linux-foundation.org>
    Date:   Thu Jan 21 11:37:38 2010 -0800

I also verified that it fails from with "make clean; make", so a dirty tree or -j2 aren't to blame. I'm not terribly familiar with the code base, so I'm a bit puzzled about why this commit would have cause the error that it does; I don't see any obvious connection between add_files_to_cache() and git_mailmap_file. 

Can anyone explain why I'd be seeing such an error? Is this a problem on my end?

    $ uname -a
    Darwin erlang.local 10.2.0 Darwin Kernel Version 10.2.0: Tue Nov  3 10:37:10 PST 2009; root:xnu-1486.2.11~1/RELEASE_I386 i386
    $ gcc --version
    i686-apple-darwin10-gcc-4.2.1 (GCC) 4.2.1 (Apple Inc. build 5646) (dot 1)
    Copyright (C) 2007 Free Software Foundation, Inc.
    This is free software; see the source for copying conditions.  There is NO
    warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
