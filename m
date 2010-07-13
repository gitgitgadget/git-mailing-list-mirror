From: Marat Radchenko <marat@slonopotamus.org>
Subject: VERY slow git format-patch (tens on minutes) during rebase and rev-list during rebase -i
Date: Tue, 13 Jul 2010 06:56:45 +0000 (UTC)
Message-ID: <loom.20100713T082913-327@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 13 08:57:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYZQS-0003Ms-Mw
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 08:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875Ab0GMG5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 02:57:01 -0400
Received: from lo.gmane.org ([80.91.229.12]:33340 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751404Ab0GMG5A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 02:57:00 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OYZQG-0003JQ-Pc
	for git@vger.kernel.org; Tue, 13 Jul 2010 08:56:57 +0200
Received: from 195.218.191.171 ([195.218.191.171])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 08:56:56 +0200
Received: from marat by 195.218.191.171 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 08:56:56 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 195.218.191.171 (Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHTML, like Gecko) Chrome/5.0.375.86 Safari/533.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150883>

Hi.

My setup:
0. Quad-code machine with 8GB of ram, 10K RPM hdd.
1. SVN repo that i periodically fetch into origin/trunk branch. Has ~200 
commits/day.
2. My local branch with 1-5 commits which i often rebase against trunk.
3. I haven't rebased for 2 days, so i'm rebasing 3 (three) commits in my branch 
over 453 commits in trunk using "git rebase trunk".
4. trunk does contain "bad" from diff POV files (big & binary).
5. Sadly, data in repo is confidential.

Expected: rebase takes some reasonable amount of time (< 1 min?).

Actual: rebase takes 20 mins.

Almost all of that time was spent doing `git format-patch -k --stdout --full-
index --ignore-if-in-upstream 
80bb0dfe3d86f3cc9095ea616d9d1b1530fbe7b8..d3fde4ae7497981a6fe61b0366b105477896cf
52` (that's three commits from my branch) at 100% of one CPU core.

Additional info:

Another similar rebase but over 4.5k of commits took 2 hours.

Running without --ignore-if-in-upstream:
$ time git format-patch -k --stdout --full-index 
80bb0dfe3d86f3cc9095ea616d9d1b1530fbe7b8..d3fde4ae7497981a6fe61b0366b105477896cf
5 | wc -l
25823
Is it 
real	0m0.163s
user	0m0.140s
sys	0m0.020s

Proof there are only three commits:

$ git rev-list 
80bb0dfe3d86f3cc9095ea616d9d1b1530fbe7b8..d3fde4ae7497981a6fe61b0366b105477896cf
52d3fde4ae7497981a6fe61b0366b105477896cf52
e18069258806bda6a6165822003f5e9fd958f906
c8c2f2e157e615b73d0baab1d793a22991c9ba71

Questions:
1. Is it expected behavior (branch you rebase onto has binary files -> no 
performance for you)?
2. If [1] is yes, is it possible to prevent rebase from running --ignore-if-in-
upstream?
3. If [1] is no, should i run some kind of profiler (how?) to determine what 
exactly causes such performance drop?
