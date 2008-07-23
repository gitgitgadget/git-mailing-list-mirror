From: Ingo Molnar <mingo@elte.hu>
Subject: q: faster way to integrate/merge lots of topic branches?
Date: Wed, 23 Jul 2008 15:05:18 +0200
Message-ID: <20080723130518.GA17462@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 23 15:06:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLe34-0006Ur-5o
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 15:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbYGWNFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 09:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbYGWNFb
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 09:05:31 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:32991 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750762AbYGWNFa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 09:05:30 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1KLe1v-0006gF-Os
	from <mingo@elte.hu>
	for <git@vger.kernel.org>; Wed, 23 Jul 2008 15:05:28 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id D2EF33E21AB; Wed, 23 Jul 2008 15:05:16 +0200 (CEST)
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
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89644>


I've got the following, possibly stupid question: is there a way to 
merge a healthy number of topic branches into the master branch in a 
quicker way, when most of the branches are already merged up?

Right now i've got something like this scripted up:

  for B in $(git-branch | cut -c3- ); do git-merge $B; done 

It takes a lot of time to run on even a 3.45GHz box:

  real    0m53.228s
  user    0m41.134s
  sys     0m11.405s

I just had a workflow incident where i forgot that this script was 
running in one window (53 seconds are a _long_ time to start doing some 
other stuff :-), i switched branches and the script merrily chugged away 
merging branches into a topic branch i did not intend.

It iterates over 140 branches - but all of them are already merged up.

Anyone can simulate it by switching to the linus/master branch of the 
current Linux kernel tree, and doing:

   time for ((i=0; i<140; i++)); do git-merge v2.6.26; done

   real    1m26.397s
   user    1m10.048s
   sys     0m13.944s

One could argue that determining whether it's all merged up already is a 
complex task, but but even this seemingly trivial merge of HEAD into 
HEAD is quite slow:

   time for ((i=0; i<140; i++)); do git-merge HEAD; done

   real    0m17.871s
   user    0m8.977s
   sys     0m8.396s

I'm wondering whether there are tricks to speed this up. The real script 
i'm using is much longer and obscured with boring details like errors, 
conflicts, etc. - but the above is the gist of it. (and that is what 
makes it slow primarily)

Using a speculative Octopus might be one approach, but that runs into 
the octopus merge limitation at 24 branches, and it also is quite slow 
as well. (and is not equivalent to the serial merge of 140 branches)

I have thought of using the last CommitDate of the topic branch and 
compare it with the last CommitDate of the master branch [and i can 
trust those values] - that would be a lot faster - but maybe i'm missing 
something trivial that makes that approach unworkable. It would also be 
nice to have a builtin shortcut for that instead of having to go via 
"git-log --pretty=fuller" to dump the CommitDate field.

builtin-integrate.c perhaps? ;-)

	Ingo
