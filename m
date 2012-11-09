From: Ulrich =?utf-8?B?U3DDtnJsZWlu?= <uqs@spoerlein.net>
Subject: git merge commits are non-deterministic? what changed?
Date: Fri, 9 Nov 2012 14:31:32 +0100
Message-ID: <20121109133132.GK69724@acme.spoerlein.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 09 15:02:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWp9j-0002l9-9G
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 15:01:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552Ab2KIOBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 09:01:46 -0500
Received: from acme.spoerlein.net ([88.198.49.12]:14195 "EHLO
	acme.spoerlein.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342Ab2KIOBp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 09:01:45 -0500
X-Greylist: delayed 1810 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Nov 2012 09:01:45 EST
Received: from localhost (acme.spoerlein.net [IPv6:2a01:4f8:131:23c2::1])
	by acme.spoerlein.net (8.14.5/8.14.5) with ESMTP id qA9DVWsk008922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Fri, 9 Nov 2012 14:31:33 +0100 (CET)
	(envelope-from uqs@spoerlein.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=spoerlein.net;
	s=dkim200908; t=1352467894;
	bh=Nd+QeBIm4hh7v/1HgtkC03dESwOSL3kyE+i8mXb49Tg=;
	h=Date:From:To:Subject;
	b=ffXbosR7LIoy/4Cqu+3XUTJ30APnSvm/R0AsrXVGWpCukAhmZ83UhB4HB3iuY+oza
	 1hBcymtoPnqR5oycDkC+OMC9Pt+PHDGizB125RHNIU/YuyBVszjpcuvTFyRYsuPZhf
	 4GLGB0mgugccRKc2qYU9TDbiUt88aTOKguTSimtU=
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209219>

Hi all,

I'm running a couple of conversions from SVN to git, using a slightly
hacked version of svn2git (because it can cope with multiple branches
and is several orders of magnitude faster than git-svn).

Anyway, when doing some verification runs, using the same version of
svn2git, but different versions of git, I get different commit hashes,
and I tracked it down to the ordering of the parents inside a merge
commit.

version 1.7.9.2
% git show --format=raw e209a83|head
commit e209a83c1e0a387c88a44f3a8f2be2670ed85eae
tree de2d7c6726a45428d4a310da2acd8839daf9f85f
parent 5fba0401c23a594e4ad5e807bf14a5439645a358
parent 25062ba061871945759b3baa833fe64969383e40
parent 89bebeef185ed08424fc548f8569081c6add2439
parent c7d5f60d3a7e2e3c4da23b157c62504667344438
parent e7bc108f0d6a394050818a4af64a59094d3c793e
parent 48231afadc40013e6bfda56b04a11ee3a602598f
author rgrimes <rgrimes@FreeBSD.org> 739897097 +0000
committer rgrimes <rgrimes@FreeBSD.org> 739897097 +0000

vs

git version 1.8.0
% git show --format=raw 42f0fad|head
commit 42f0fadccab6eefc7ffdc1012345b42ad45e36c2
tree de2d7c6726a45428d4a310da2acd8839daf9f85f
parent 5fba0401c23a594e4ad5e807bf14a5439645a358
parent 25062ba061871945759b3baa833fe64969383e40
parent 89bebeef185ed08424fc548f8569081c6add2439
parent 48231afadc40013e6bfda56b04a11ee3a602598f
parent c7d5f60d3a7e2e3c4da23b157c62504667344438
parent e7bc108f0d6a394050818a4af64a59094d3c793e
author rgrimes <rgrimes@FreeBSD.org> 739897097 +0000
committer rgrimes <rgrimes@FreeBSD.org> 739897097 +0000

I haven't verified to see if that ordering is stable within a git
version, but the fact that it changed across versions clearly means that
I cannot depend on this currently (I have never seen this problem in two
years, so I blame git 1.8.0 ...)

Two questions:
1. Can we impose a stable ordering of the commits being recorded in a
merge commit? Listing parents in chronological order or something like
that.

2. Why the hell is the commit hash dependent on the ordering of the
parent commits? IMHO it should sort the set of parents before
calculating the hash ...

Help?
Uli
