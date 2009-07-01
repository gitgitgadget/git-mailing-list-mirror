From: Robert Stonehouse <rstonehouse@solarflare.com>
Subject: git bisect; is there a way to pick only from the children of a given commit
Date: Wed, 1 Jul 2009 17:12:16 +0000 (UTC)
Message-ID: <loom.20090701T170535-707@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 01 19:15:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MM3Ox-0007eb-FY
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 19:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753434AbZGARPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 13:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753071AbZGARPA
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 13:15:00 -0400
Received: from main.gmane.org ([80.91.229.2]:39506 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752794AbZGARO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 13:14:59 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1MM3Og-00006P-Lc
	for git@vger.kernel.org; Wed, 01 Jul 2009 17:15:02 +0000
Received: from 82-69-69-95.dsl.in-addr.zen.co.uk ([82.69.69.95])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Jul 2009 17:15:02 +0000
Received: from rstonehouse by 82-69-69-95.dsl.in-addr.zen.co.uk with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Jul 2009 17:15:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 82.69.69.95 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.11) Gecko/2009061118 Fedora/3.0.11-1.fc10 Firefox/3.0.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122585>

Hi,

I had a problem where I thought git bisect would be a good way forwards.
It didn't work as expected so I made myself a simpler test-case.

featureA (which was a new build target) was broken at HEAD. It had been
developed on the featureA branch. After featureA was merged into master,
featureB (which had branched from master at the same point as featureA) was
merged with master.

  $ git log --graph --abbrev-commit --pretty=oneline
  * b394c57... master4
  *   7e8d675... Merge branch 'featureB'
  |\  
  | * 8d87aee... featureB2
  | * c1a8450... featureB1
  * | 44c5601... master3
  * |   269602a... Merge branch 'featureA'
  |\ \  
  | * | 91b1bbb... featureA2
  | * | 0c15834... featureA1
  | |/  
  * | 1ea4a0c... master2
  |/  
  * 204f839... master1

Tag featureA1 was my good commit, and HEAD was the bad.
I was surprised that git bisect was asking me to test commits on the featureB
branch. I couldn't test the build target that was broken on branch featureB
because it wasn't present in the code at that point.

I understand that bisect can choose anywhere from the list of commits that are
included in the ancestry of HEAD but excludes commits in the ancestry of 
featureA1
  $ git rev-list --pretty=oneline featureA1..HEAD
  b394c57d13c11ce5bec63b4e3556ea9a308bc196 master4
  7e8d675bb277849d7aaa5c8333f5916455bc3a8a Merge branch 'featureB'
  44c5601dbc4c3988553999098cd29fe2bddc2f77 master3
  8d87aee0793a96f9d606fd33cb32b337a2e0a518 featureB2
  269602a2c5326e475866355986b5dc47f8945b30 Merge branch 'featureA'
  c1a8450e552370cc4efc2ea3bf20bf8456051999 featureB1
  1ea4a0c51d59ff6471f43e1cb19e207b95baef8a master2
  91b1bbbbac551cf315bf6e5e8f7cea988fe8d9e8 featureA2

What I really want to bisect is the list of commits that are children of
featureA1 (or alternatively any commit that have an ancestor of featureA1)
i.e. featureA2, master{3,4}, merge{A,B}

 $ git rev-list --pretty=oneline --first-parent featureA1..HEAD 
is nearly what I want but I haven't found an option in git-bisect to pass
extra arguments to rev-list. But also --first-parent wouldn't consider
featureA2 in this case.

Is there a way to do what I want (bisect all children of a commit)?

I hope that this description isn't too unreadable!
Many thanks

-- 
Rob Stonehouse
