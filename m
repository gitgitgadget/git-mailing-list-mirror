From: Ingo Molnar <mingo@elte.hu>
Subject: q: git-fetch a tad slow?
Date: Mon, 28 Jul 2008 18:01:38 +0200
Message-ID: <20080728160138.GA12777@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 18:03:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNVBX-0002Wd-4M
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 18:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755442AbYG1QBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 12:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755446AbYG1QBy
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 12:01:54 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:53805 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752722AbYG1QBx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 12:01:53 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1KNVAJ-0000Yt-T0
	from <mingo@elte.hu>
	for <git@vger.kernel.org>; Mon, 28 Jul 2008 18:01:50 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id A2CD23E21B0; Mon, 28 Jul 2008 18:01:39 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0001]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90467>


here's another possibly stupid question.

Setup/background: distributed kernel testing cluster, there's a central 
box with a git repo of the kernel, and lots of of testboxes that track 
that repo over ssh transport. In each "iteration" a random kernel config 
is generated, built and booted, and the booted up kernel is checked. 
Performance of each iteration matters to total testing throughput, so i 
try to optimize the critical path.

Problem: i noticed that git-fetch is a tad slow:

  titan:~/tip> time git-fetch
 
  real    0m2.372s
  user    0m0.814s
  sys     0m0.951s

There are hundreds of branches, so i thought fetching a single branch 
alone would improve things:

  titan:~/tip> time git-fetch origin master

  real    0m0.942s
  user    0m0.285s
  sys     0m0.109s

But that's still slow - so i use a (lame) ad-hoc script instead:

  titan:~/tip> time tip-fetch

  real    0m0.246s
  user    0m0.024s
  sys     0m0.019s

... which ssh's to the repo to check tip/master by hand:

  HEAD=$(git-log -1 --pretty=format:"%H" HEAD)
  RHEAD=$(ssh server "cd tip; git-log master -1 --pretty=format:'%H'")
  [ "$RHEAD" != "$HEAD" ] && {
    [...]
  }

... which script is lame/expensive on multiple levels but still is much 
faster.

I'm wondering, am i missing something obvious? It seems most of the 
overhead is local CPU overhead, so it's something in Git's domain and 
not the expense of the ssh protocol. (which expense should be about 200 
msecs)

	Ingo
