From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: extra headers in commit objects
Date: Wed, 3 Feb 2010 09:40:41 -0800
Message-ID: <20100203174041.GC14799@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 03 18:40:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcjDk-0002m5-Jn
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 18:40:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932742Ab0BCRku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 12:40:50 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:47367 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932692Ab0BCRkt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 12:40:49 -0500
Received: by iwn39 with SMTP id 39so1810507iwn.1
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 09:40:48 -0800 (PST)
Received: by 10.231.149.10 with SMTP id r10mr6084569ibv.63.1265218843833;
        Wed, 03 Feb 2010 09:40:43 -0800 (PST)
Received: from localhost ([209.20.77.23])
        by mx.google.com with ESMTPS id 23sm7745190iwn.3.2010.02.03.09.40.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Feb 2010 09:40:42 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138848>

Am I correct that core C developers are still under the opinion
that extra headers in a commit object aren't encouraged?

That is, we shouldn't see something like this made-up example:

  $ git cat-file commit HEAD
  tree e0fb24d872e2daa1507ea5879e1cdce5c0da9902
  parent ec0865178ad6d8dab9ccd82b07bc3f3dae20542a
  parent 89d61592bddda4dfcb90314be9e06479f712bb7f
  author Junio C Hamano <gitster@pobox.com> 1265176189 -0800
  committer Junio C Hamano <gitster@pobox.com> 1265176189 -0800
  bug 18389
  url http://example.com/some/mailing/list/post
  message-id <gitster-182819131@gitster.computer>

  Merge git://repo.or.cz/git-gui into next

(Sorry Junio for picking on your latest next merge...)


Today I came across this "bug fix" [1,2] in Dulwich, which is
claiming to be a pure-Python implementation of Git.

[1] http://git.samba.org/?p=jelmer/dulwich.git;a=commit;h=bc8d73f1146afba8828a7dadbb4320f592cddcab
[2] http://git.samba.org/?p=jelmer/dulwich.git;a=commitdiff;h=bc8d73f1146afba8828a7dadbb4320f592cddcab;hp=4e50426fb72e6c9259feecbba5bfcf053af62335

I haven't spoken with Jelmer Vernooij directly about it, but after
some indirect email through a 3rd party, it seems he might be under
the impression that this really is a bug in Dulwich, because "other
git implementations do it".

Uhm.


I thought the canonical reference implementation was C Git
(aka git-core), as maintained by Junio Hamano, and the object
formats, core data structures, and network protocols were
fairly well documented between the Git Community Book and the
Documentation/technical/ directory.

The only other widely used Git implementation that I know of is JGit.
It sure as hell doesn't do this, and it sure as hell isn't what I
would call the reference implementation for Git... and that project
is my own baby.

Yes, there are many other Git implementations.  But I thought nearly
all of them were toys, and none of them were even close to serving
the kind of production volume that JGit serves, and JGit isn't even
considered a production library by most.  Yet JGit always tries to
conform to whatever standard is set by the C implementation.


Basically, aside from having a pretty horrible morning thus far,
and being in a really bad mood, I'm starting to get a bit worried
about the proliferation of Git implementations, and what the notion
of the standard network protocol and file formats is.

We're starting to see a fork in the basic protocols happen.  Hell,
Dulwich 0.4.1 isn't even capable of speaking over the network to
C Git, but it does talk to itself, so its valid, right?  :-(

 $ PYTHONPATH=`pwd` ./bin/dul-daemon . &
 $ git clone git://localhost/.git
 Initialized empty Git repository in /usr/local/google/users/sop/tmp/localhost/.git/
 fetch-pack: protocol error: bad band #78
 fatal: early EOF
 fatal: index-pack failed

Fortunately a friend of mine is spending some time trying to patch
it up... trying to get it back in compliance with the C reference
implementation.


At the end of the day, is it a bug that C git doesn't support
working with extra commit headers?  IMHO, no, because, we've
rejected these in the past, and its not part of the Git standard.
And other implementations shouldn't be trying to sell it that way.

</rather-pissed-off-rant>

-- 
Shawn.
