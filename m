From: Christian Jaeger <chrjae@gmail.com>
Subject: [ANNOUNCE] cj-git-splitrepo & removing 'empty' merge commits with filter-branch
Date: Sun, 4 Sep 2011 22:34:24 -0400
Message-ID: <CAEjYwfXDV=3M0O1oNX31kxdi-R4ZhG=6-qLYnkBmL2gm9UWi_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 04:34:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0P1P-0007B6-NP
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 04:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208Ab1IECeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Sep 2011 22:34:46 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:65321 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875Ab1IECeo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2011 22:34:44 -0400
Received: by yie30 with SMTP id 30so3129997yie.19
        for <git@vger.kernel.org>; Sun, 04 Sep 2011 19:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=EXZ5nz4Vk9XRgTO3bkmDsdgXHYuNrs+8mfbhX61L0FY=;
        b=vAPA+9f0GRX++34kj21DGKXwOrMgguwcUP6lgFu79ieHjghz0deHqSP3GUIYg8Re8F
         lVDsOwwTFfX0PcCS8vPecVMcdh1pyJWqilcgoYY8WU06fRd/3jc1a17xs9f2fjV4FYYT
         mJgFgquIZ2FlSTCyPFjEyn6cao+yJZbvr8++E=
Received: by 10.150.170.20 with SMTP id s20mr213646ybe.389.1315190084146; Sun,
 04 Sep 2011 19:34:44 -0700 (PDT)
Received: by 10.150.97.17 with HTTP; Sun, 4 Sep 2011 19:34:24 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180713>

Hello

I've needed a program to split a repository into multiple
repositories, each with part of the history according to file path
rules. I already wrote a wrapper around git filter-branch that took
care of the path filtering, but this time I finally wanted to take
care of merge commits that "do nothing", i.e. that have one parent
commit with the same tree as the merge commit and another parent
that's part of the history of the other parent. (Similar rule for
octopus merges if I happen to ever run across one of these.)
git-filter-branch doesn't have functionality to remove these by
itself, thus a custom commit filter is needed.

This turned out to be a bit of an adventure because arrays are really
well suited for this, but I've rarely used them in shell scripts, so I
tracked down the necessary syntactical vodoo for writing my code in
bash, only to find out that git filter-branch is actually calling my
code in sh, not bash (hence no arrays). After realizing this, and
coping with it by moving my code inside a bash invocation (and making
a copy of the library code from git-filter-branch--why isn't this in a
separate file, btw, then I could just include it from there?), I
thought I should perhaps send you all a notice about it, in case
anyone else wanted to split repositories cleanly, too. Or in case
someone wanted to point out that I'm doing this in a stupid way or a
nice solution exists elsewhere already: please tell me about it!

So, here's my wrapper around git-filter-branch that is able to remove
paths (including whole directories) and removes 'empty' merges:
https://github.com/pflanze/chj-bin/blob/master/cj-git-filter-branch

And a wrapper around cj-git-filter-branch that makes creating a
partial copy of a repository easy:
https://github.com/pflanze/chj-bin/blob/master/cj-git-splitrepo

If you want to actually run these, you need some of my libraries:

   # cd /opt; mkdir chj; cd chj
   # git clone https://github.com/pflanze/chj-perllib.git perllib
   # git clone https://github.com/pflanze/chj-bin.git bin
   # git clone https://github.com/pflanze/Class-Array.git
   # mkdir /usr/local/lib/site_perl/ # if it doesn't exist already
   # ln -s /opt/chj/perllib/Chj /usr/local/lib/site_perl/
   # ln -s /opt/chj/Class-Array /usr/local/lib/site_perl/Class

  and add /opt/chj/bin to your PATH (through your .bash_profile or
  similar)

(or you could supposedly use the PERL5LIB env var instead of symlinks).

Christian.
