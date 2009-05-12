From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Cherry woes
Date: Tue, 12 May 2009 15:15:05 +0200
Message-ID: <4A097659.4060507@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 12 15:15:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3rph-0005Ee-NA
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 15:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbZELNPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 09:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752535AbZELNPQ
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 09:15:16 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:53177 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752229AbZELNPP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 May 2009 09:15:15 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id DCE96343056
	for <git@vger.kernel.org>; Tue, 12 May 2009 09:15:14 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 12 May 2009 09:15:14 -0400
X-Sasl-enc: ig9mhpWgPSKyLrD7hL+7UQgxxuIPaINjyJYnOPz4AkLA 1242134114
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3201C1F466
	for <git@vger.kernel.org>; Tue, 12 May 2009 09:15:14 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090511 Lightning/1.0pre Shredder/3.0b3pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118893>

Hi there

I encountered a misfeature of cherry or misuse of it by myself... Also,
the behaviour is not quite what the doc suggests. The script below
generates the following DAG:

*   05f4f8c (refs/heads/master) Merge branch 'upstream'
|\
| * 2c8fad1 (refs/heads/upstream) add a
* | df7b5e4 Add a
|/
* 6bdebf5 init

Naively, one would say that master and upstream contain one commit each
which differ but their patch-ids coincide (see below). That's the same
situation before as well as after the merge.

But calling "git cherry -v upstream" when on the master branch gives
different results:

Before merge:
- df7b5e472d9a23d02943b331a7dc9ec638f44b33 Add a
Merge made by recursive.
After merge:
+ df7b5e472d9a23d02943b331a7dc9ec638f44b33 Add a

Of course master contains both 2c8fad1 and df7b5e4, and upstream only
the latter (Did I say "naively"?). But still upstream contains a commit
which is patch-equivalent to 2c8fad1, and which git cherry does not find.

The point is that "git cherry upstream head" looks at each commit in
upstream..head and checks whether there is an equivalent patch in
head..upstream. (This differs from the doc which says fork-point..head
resp. fork-point..upstream.)

In the DAG above, all is well when head is master^ (df7b5e4), i.e.
before the merge, but head..upstream is empty after the merge.

Now, adjusting the doc is easy, but I still feel that cherry does not
give the most useful info in the situation at hand. But how would I find
a better lower boundary for the range ..upstream? merge-base of master
and upstream is upstream so that doesn't cut it. So I'm wondering what
the right approach is and whether anyone cares.

Michael

--->%---
#!/bin/bash

rm -Rf cherrybug
mkdir cherrybug && cd cherrybug && git init
echo a > a && git add a && git commit -m init
git checkout -b upstream
echo b >> a && git add a && git commit -m "add a"
git checkout master
echo b >> a && git add a && git commit -m "Add a"
echo "Before merge:"
git cherry -v upstream
git merge upstream
echo "After merge:"
git cherry -v upstream
