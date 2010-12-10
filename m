From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 00/10] vcs-svn: prepare for (implement?) incremental
 import
Date: Fri, 10 Dec 2010 04:20:07 -0600
Message-ID: <20101210102007.GA26298@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 10 11:20:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR05f-0001am-NG
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 11:20:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596Ab0LJKUc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 05:20:32 -0500
Received: from mail-gw0-f42.google.com ([74.125.83.42]:45689 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428Ab0LJKUb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 05:20:31 -0500
Received: by gwb20 with SMTP id 20so2882897gwb.1
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 02:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=7MohS5yyudbMw5ypOUuEQPrg+vLda/2pLuQOyrSruJI=;
        b=qTFnMm2CTgdflevlCArj4zltKsjp6MdXBWztvGuOO7bCczDO/5HvqtGHbvMQk+mMmS
         +NJ929yV/xYIomK7vxbxG8q84RifdzXu5f/K/TGuDPxBui5A5DUjSxgJOoM18ppdkcM8
         d+m5oml10rxObqONnNYNrkTNdU0lkN2Y7ktGA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=NU5ZLGB2xbSZ6rg+r783D+k1IwWvmMZl13ousU3+6d/nN5w6vNOaT4zmVos9jVdvL3
         ZoDH5m18X1DAx8FL+lr8/y7kgnCg8H6Vj8lEJCGRJvbII9iqUftbL2Us+fpCFozSmI5o
         hdMZuUpxZijQV2fkR+kYJX9j6DkTS5QT3MHho=
Received: by 10.151.47.3 with SMTP id z3mr1111557ybj.131.1291976428560;
        Fri, 10 Dec 2010 02:20:28 -0800 (PST)
Received: from burratino (adsl-69-209-58-175.dsl.chcgil.sbcglobal.net [69.209.58.175])
        by mx.google.com with ESMTPS id p1sm1364598ybn.5.2010.12.10.02.20.26
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 10 Dec 2010 02:20:27 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163395>

Hi,

Using David's "ls" command we can eliminate the in-memory repo_tree
and rely on the target repository for information about old revs.
This means all state that needs to persist between svn-fe runs is
either in the target repo or in the marks file, so in theory this
should allow incremental imports already (I haven't tried it).

Caveats:

Not split up as nicely as it ought to be.  In particular, the last
patch should be split up at least into one patch to modify git
fast-import, another for the vcs-svn lib.  Perhaps it could be split
finer than that.

There is a potential deadlock, marked with NEEDSWORK.

Error checking is not so great.  Error states tend to result in
deadlock rather than a nicer error.

In particular, we have no way to distinguish between a missing
(nonsense) path and an empty directory.

There's a little blind alley in the first few patches --- cat_mark and
the function to apply deltas to an old rev do not survive to the end
of the series.  I kept that because (1) I am lazy and (2) it serves as
a quick intro to use of the "ls" command.

Probably there are all sorts of bugs and unclear code.  I haven't
tested beyond running the test suite.

You can find the series alone at

	git://repo.or.cz/git/jrn.git refs/topics/db/vcs-svn-incremental

and merged with other topics at

	git://repo.or.cz/git/jrn.git vcs-svn-pu

Requires the db/text-delta and db/fast-import-blob-access topics,
available from the same place.

Any thoughts would be welcome.

Jonathan Nieder (10):
  vcs-svn: use higher mark numbers for blobs
  vcs-svn: save marks for imported commits
  vcs-svn: introduce cat_mark function to retrieve a marked blob
  vcs-svn: make apply_delta caller retrieve preimage
  vcs-svn: split off function to export result from delta application
  vcs-svn: do not rely on marks for old blobs
  vcs-svn: split off function to make 'ls' requests
  vcs-svn: prepare to eliminate repo_tree structure
  vcs-svn: simplifications for repo_modify_path et al
  vcs-svn: eliminate repo_tree structure

 cache.h               |    2 +
 fast-import.c         |   42 +++++--
 t/t9010-svn-fe.sh     |   55 +++++----
 vcs-svn/fast_export.c |  168 +++++++++++++++++++------
 vcs-svn/fast_export.h |   22 +++-
 vcs-svn/repo_tree.c   |  333 ++++---------------------------------------------
 vcs-svn/repo_tree.h   |    6 +-
 vcs-svn/string_pool.c |    2 +-
 vcs-svn/string_pool.h |    2 +-
 vcs-svn/svndump.c     |   89 +++++++++----
 10 files changed, 301 insertions(+), 420 deletions(-)

-- 
1.7.2.4
