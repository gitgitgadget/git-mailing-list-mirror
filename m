From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: refs/original breaks git-clone for tags
Date: Tue, 7 Sep 2010 18:14:00 -0500
Message-ID: <20100907231400.GA2024@capella.cs.uchicago.edu>
References: <5054888.117464.1282315250235.JavaMail.root@mail.hq.genarts.com> <32751199.117741.1282331329553.JavaMail.root@mail.hq.genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 01:14:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot7Mi-0004At-2Q
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 01:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175Ab0IGXOE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 19:14:04 -0400
Received: from camembert.cs.uchicago.edu ([128.135.164.153]:51628 "EHLO
	smtp.cs.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006Ab0IGXOD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 19:14:03 -0400
Received: from capella.cs.uchicago.edu (capella.cs.uchicago.edu [128.135.24.228])
	by smtp.cs.uchicago.edu (Postfix) with ESMTP id C7A41B8F4;
	Tue,  7 Sep 2010 18:14:01 -0500 (CDT)
Received: by capella.cs.uchicago.edu (Postfix, from userid 10442)
	id 85100B3F2; Tue,  7 Sep 2010 18:14:01 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <32751199.117741.1282331329553.JavaMail.root@mail.hq.genarts.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155748>

Hi Stephen,

Stephen Bash wrote:

> After a lot of guess and check, it appears the issue is somehow
> related to the refs/original directory created by filter-branch.  If
> that directory is moved out of refs/ or deleted the clone succeeds.
> Digging further, a simple rename of refs/original/refs/tags/tagFoo
> to anything else also fixes the problem.

Thanks for a clear report.  I backported your test case:

-- 8< --
#!/bin/sh
mkdir foo &&
(
	cd foo &&
	git init &&
	echo A >foo.txt &&
	git add foo.txt &&
	git commit -m "Created foo" &&
	git tag -am "Tagging foo" tagFoo &&
	git filter-branch --env-filter 'export GIT_AUTHOR_NAME=xyz123' \
				--tag-name-filter cat -- --all &&
	git show-ref
) &&
git clone file:///`pwd`/foo newFoo &&
(
	cd newFoo &&
	git show-ref
)
-- >8 --

which produces the result:

 ...
 07fa3d4c3aba83b293e24a12a87faca363ad34e6 refs/heads/master
 90a32c29df06b4f6e4218c1b82b35a3e49aed9f2 refs/original/refs/heads/master
 90a32c29df06b4f6e4218c1b82b35a3e49aed9f2 refs/original/refs/tags/tagfoo
 ef92777a31663135426a9648d0abb0c06b448fbe refs/tags/tagfoo
 ...
 Resolving deltas: 100% (1/1), done.
 error: refs/tags/tagfoo does not point to a valid object!
 07fa3d4c3aba83b293e24a12a87faca363ad34e6 refs/heads/master
 07fa3d4c3aba83b293e24a12a87faca363ad34e6 refs/remotes/origin/HEAD
 07fa3d4c3aba83b293e24a12a87faca363ad34e6 refs/remotes/origin/master
 $

The error message bisects to:

commit 5bdc32d3e50d8335c65e136e6b5234c5dd92a7a9 (tags/v1.6.5-rc3~20)
Author: Nicolas Pitre <nico@fluxnic.net>
Date:   Fri Sep 25 23:54:42 2009 -0400

    make 'git clone' ask the remote only for objects it cares about
    
    Current behavior of 'git clone' when not using --mirror is to fetch
    everything from the peer, and then filter out unwanted refs just before
    writing them out to the cloned repository.  This may become highly
    inefficient if the peer has an unusual ref namespace, or if it simply
    has "remotes" refs of its own, and those locally unwanted refs are
    connecting to a large set of objects which becomes unreferenced as soon
    as they are fetched.
    
    Let's filter out those unwanted refs from the peer _before_ asking it
    what refs we want to fetch instead, which is the most logical thing to
    do anyway.
    
    Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
    Signed-off-by: Shawn O. Pearce <spearce@spearce.org>

That is not too surprising.  Before then, "git clone" fetched
all objects.

The error message is from refs.c::do_one_ref(), which notices the
missing object ef92777a31663135426a9648d0abb0c06b448fbe (i.e., ye
old tag object).

Call chain:

 cmd_clone() ->
  write_remote_refs() ->
   pack_refs() ->
    do_for_each_ref() ->
     do_one_ref()

The transport is done afaict by then.

Nico, Shawn: ideas?
