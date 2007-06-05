From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] Add git-filter-branch
Date: Tue, 5 Jun 2007 12:18:45 +0200
Message-ID: <20070605101845.GA16160@diku.dk>
References: <Pine.LNX.4.64.0706030129110.4046@racer.site> <f3t2mm$f0$1@sea.gmane.org> <Pine.LNX.4.64.0706030147520.4046@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 05 12:18:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvW7s-0003nS-Dv
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 12:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754699AbXFEKSu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 06:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759618AbXFEKSt
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 06:18:49 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:37498 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754699AbXFEKSt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2007 06:18:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 0063FF008E;
	Tue,  5 Jun 2007 12:18:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ar5Xsc2QbfsX; Tue,  5 Jun 2007 12:18:46 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 019F6F0052;
	Tue,  5 Jun 2007 12:18:46 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id A62B56DFB5B; Tue,  5 Jun 2007 12:16:35 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 9A6A262A5D; Tue,  5 Jun 2007 12:18:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0706030147520.4046@racer.site>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49181>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote Sun, Jun 03, 2007:
> Second, it does not even need bash.
> 
> At least that is what I tried to make sure. I replaced the only instance 
> of a bashim I was aware, namely the arrayism of $unchanged. It can be a 
> string just as well, as we are only storing object names in it.
> 
> Tell me if it does not work for you.
> 
> Or even better, provide me with a test case that fails for you.

I found a small problem when /bin/sh is linked to dash.

$ /bin/dash t*-filter-branch.sh
*   ok 1: setup
* FAIL 2: rewrite identically

                git-filter-branch H2

* FAIL 3: result is really identical

                test $H = $(git-rev-parse H2)

* FAIL 4: rewrite, renaming a specific file

                git-filter-branch --tree-filter "mv d doh || :" H3

* FAIL 5: test that the file was renamed

                test d = $(git show H3:doh)

* failed 4 among 5 test(s)
$ cd trash/
$ rm -rf .git-rewrite/
$ git filter-branch H2
/home/fonseca/bin/git-filter-branch: 386: arith: syntax error: "i+1"
$

A possible fix that makes the test pass for me.

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 0c8a7df..5cf9d3c 100644
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -339,7 +339,7 @@ test $commits -eq 0 && die "Found nothing to rewrite"
 
 i=0
 while read commit; do
-	i=$((i+1))
+	i=$(echo i+1 | bc)
 	printf "$commit ($i/$commits) "
 
 	git-read-tree -i -m $commit

-- 
Jonas Fonseca
