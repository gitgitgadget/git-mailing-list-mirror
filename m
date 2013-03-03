From: Peter Rabbitson <rabbit@rabbit.us>
Subject: [BUG] Incorrect/misleading error when `git rev-list --objects
 --all` hits the max open files limit
Date: Mon, 4 Mar 2013 10:29:27 +1100
Message-ID: <20130303232927.GA16606@rabbit.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 04 00:40:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCIVh-0001i1-BR
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 00:40:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754709Ab3CCXjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 18:39:40 -0500
Received: from mujunyku.leporine.io ([113.212.96.195]:44077 "EHLO
	mujunyku.leporine.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754560Ab3CCXjj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Mar 2013 18:39:39 -0500
X-Greylist: delayed 611 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 Mar 2013 18:39:39 EST
Received: by mujunyku.leporine.io (Postfix, from userid 1000)
	id C03A9228160; Mon,  4 Mar 2013 10:29:27 +1100 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217372>

Hi!

I was tinkering with a massive git repository (actually a bup 
repository, but it is a standard valid git repo underneath). While 
validating that a repack ran succesfully I executed the command:

 git rev-list --objects --all > rev.list

And got back this:

error: packfile ./objects/pack/pack-d9808b7515419737806d0c621a0a1910f71c5cba.pack cannot be accessed
fatal: missing blob object '27a8cf44da85b958aef2b5074931e7913e08ae95'

Several hours later after successful fsck, and after chasing down trees 
blobs etc, I realized that the problem is too many open files. The hint 
came from ls-tree which lists the correct error (among a lot of spurious 
junk):

 git ls-tree -r c636a5f51d4e > /dev/null

 error: packfile ./objects/pack/pack-d9808b7515419737806d0c621a0a1910f71c5cba.pack cannot be accessed
 error: packfile ./objects/pack/pack-841e375f5e6c793a52fd1a3a2aea0b76219c4cdd.pack cannot be accessed
 error: packfile ./objects/pack/pack-e67d9bf75e0840fc6113170b314d2d5a32cbb45a.pack cannot be accessed
 error: packfile ./objects/pack/pack-b8fd8f083461c391fe6ec396840c328620d912e2.pack cannot be accessed
 error: packfile ./objects/pack/pack-d9808b7515419737806d0c621a0a1910f71c5cba.pack cannot be accessed
 error: packfile ./objects/pack/pack-804e0fadf56e2a165c157ef257620369adeea595.pack cannot be accessed
 error: unable to open object pack directory: ./objects/pack: Too many open files
 error: packfile ./objects/pack/pack-804e0fadf56e2a165c157ef257620369adeea595.pack cannot be accessed
 error: Could not read 32a050cb7e54a1e817d135d25ab251480e8d9e3c

Failure to report the correct message verified with git 1.7.2.5 and 
1.8.2 (debian testing and experimental).

I hope this is sufficient description to address the underlying issue. I 
will keep the un-repacked "many files" repo around just in case you need 
more info/testing (though lowering the ulimit works equally well on 
normal-size repos).

Cheers
