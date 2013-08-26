From: Kacper Kornet <kornet@camk.edu.pl>
Subject: [BUG] Shallow fetch can result in broken git repo
Date: Mon, 26 Aug 2013 02:22:02 +0200
Message-ID: <20130826002202.GA26940@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 26 02:53:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDl3O-0000Pp-LM
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 02:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754857Ab3HZAxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 20:53:04 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:36961 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754624Ab3HZAxD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 20:53:03 -0400
X-Greylist: delayed 1849 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Aug 2013 20:53:03 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 34B0B5F0007;
	Mon, 26 Aug 2013 02:22:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id zaFhEH0IB34t; Mon, 26 Aug 2013 02:22:33 +0200 (CEST)
Received: from gatekeeper.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 526385F0004;
	Mon, 26 Aug 2013 02:22:33 +0200 (CEST)
Received: by gatekeeper.camk.edu.pl (Postfix, from userid 1293)
	id 81AE74812B; Mon, 26 Aug 2013 02:22:02 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232970>

Starting from "6035d6a fetch-pack: prepare updated shallow file before
fetching the pack" the shallow fetches of commits with tags can result
in broken git repo.  The following script illustrates the problem:

#!/bin/sh

mkdir repo1 repo2
cd repo1
git init
for i in `seq 1 3`; do
        echo $i > foo
        git add foo
        git commit -m "Commit $i"
done
git tag tag HEAD~1

cd ../repo2
git init
git fetch --depth=2 ../repo1 master:branch
git fsck

The function fetch_pack in this case is called twice. During the
second called alternate_shallow_file contains "\0" (it is set to this
value by commit_lock_file(&shallow_lock) during first call of
fetch_pack). In the result the file .git/shallow, created during first
call to fetch_pack, is removed and the git repo ends with broken link.

The two possible fixes which I see are:

1) Replace back if (alternate_shallow_file) condition in fetch pack with 
   if (args->depth > 0) 

2) alternate_shallow_file should be copy of shallow_lock.filename not a
   reference to it

But I'm not able to determine by myself which one (if any) is a correct fix
to the problem.

-- 
  Kacper
