From: Michal Hocko <mhocko@suse.cz>
Subject: git describe --contains doesn't work properly for a commit
Date: Thu, 26 Feb 2015 14:35:34 +0100
Message-ID: <20150226133534.GB14878@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 14:35:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQybZ-0004IT-7p
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 14:35:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753881AbbBZNfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 08:35:36 -0500
Received: from cantor2.suse.de ([195.135.220.15]:42082 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753740AbbBZNff (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 08:35:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 5C4F8AC89
	for <git@vger.kernel.org>; Thu, 26 Feb 2015 13:35:34 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264441>

Hi,
I have just encountered an old kernel git commit:
commit c854363e80b49dd04a4de18ebc379eb8c8806674
Author: Dave Chinner <david@fromorbit.com>
Date:   Sat Feb 6 12:39:36 2010 +1100

    xfs: Use delayed write for inodes rather than async V2
[...]

which cannot be described properly:
$ git describe --contains c854363e80b49dd04a4de18ebc379eb8c8806674
fatal: cannot describe 'c854363e80b49dd04a4de18ebc379eb8c8806674'

but it seems to find a tag on which the commit is based:
$ git describe c854363e80b49dd04a4de18ebc379eb8c8806674
v2.6.33-rc4-49-gc854363e80b4

if I follow parents
sha=c854363e80b49dd04a4de18ebc379eb8c8806674; 
while true
do 
	parent=$(git show --format=%P $sha | head -1)
	echo $sha $parent
	git describe --contains $parent && break
	sha=$parent
done
c854363e80b49dd04a4de18ebc379eb8c8806674 777df5afdb26c71634edd60582be620ff94e87a0
fatal: cannot describe '777df5afdb26c71634edd60582be620ff94e87a0'
777df5afdb26c71634edd60582be620ff94e87a0 d5db0f97fbbeff11c88dec1aaf1536a975afbaeb
fatal: cannot describe 'd5db0f97fbbeff11c88dec1aaf1536a975afbaeb'
d5db0f97fbbeff11c88dec1aaf1536a975afbaeb 388f1f0c346b533b06d8bc792f7204ebc3e4b7da
v2.6.34-rc1~278^2~14

I am using:
$ git --version
git version 2.1.4

but the same seems to be the case with older git version (1.8.5.6).
$ git rev-list c854363e80b49dd04a4de18ebc379eb8c8806674..v2.6.34 | wc -l
11648

So there seems to be a line between the two commits AFAIU.

Is the history somehow broken or is it a bug in git?
-- 
Michal Hocko
SUSE Labs
