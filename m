From: Carsten Fuchs <carsten.fuchs@cafu.de>
Subject: How to use subtrees when importing SVN repository with "vendor" branches?
Date: Thu, 01 Mar 2012 01:35:36 +0100
Message-ID: <4F4EC458.8090808@cafu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 01:35:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2tzk-0004Ix-CP
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 01:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757767Ab2CAAfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 19:35:39 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:64413 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756901Ab2CAAfj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 19:35:39 -0500
Received: from [192.168.1.73] (p5B0C701A.dip.t-dialin.net [91.12.112.26])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0M4Vjc-1SLPsL1LMy-00ykaD; Thu, 01 Mar 2012 01:35:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
X-Provags-ID: V02:K0:2aegmqyvj7rfZ+eAf71yo/RLMqC/071NHXBnL3uQTJg
 VgJkkzN4y6pEhCpmf7pJF/UOsKesybnWQyvSZdqyqqvVFLK539
 o6oFQkiGPtwjWs65Q8hAeAFHEZlRKqnIHA55Vz5+fIeHT1rfOm
 7actijfUHfoFIGw3sSamv5k9QBZSMus0UlGjZiTNHTx1yIU9Qw
 CJ4JJjoksTrlg0MaDByJL6cyiGgm8mXUBcx2coJO3A4NxGyGio
 0DErHuZA0M9HCpjFCSsksHAGDOecSzoL29EU8NZ9Mg3WtLJhhQ
 rJb/qpFvz0SK2uiOJ7HLz4u5oqF2pYYBgVCMZzZzE8ouEQznMu
 /NHus148wKAfE41znSTw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191866>

Hi all,

using git-svn, I've been converting our old SVN repositories to git with great success, 
but I don't know how to deal with our biggest and most important one.
The SVN repository structure is like this:

	branches/
	tags/
	trunk/
		ExtLibs/
			libpng/
			zlib/
			...
		some_dir_a/
		some_dir_b/
	vendor/
		libpng/
		zlib/
		...

The key problem is that we used to use the SVN "vendor branches" strategy: When a new 
version of libpng or zlib or ... is released, we update the vendor/ directory 
appropriately (essentially: delete the old files of the library, extract the tarball of 
the new release, commit).
Then we "SVN merged" the vendor/ directory into trunk/ExtLibs/.
This way, we were able to preserve our occasional customizations to the libraries in 
ExtLibs/ while updating to new vendor releases.

Using something like
	git svn init "svn://.../project_root" --trunk "trunk" git_test_project
it would be easy to fetch the projects trunk (never mind the branches and tags, we never 
used them much and are happy to ignore them). This properly converts the whole trunk to 
git, including subdirectory trunk/ExtLibs/, but with no notion of vendor/.

In contrast, using something like
	git svn init "svn://.../project_root" --trunk "trunk/ExtLibs" git_test_ExtLibs
	git config --add svn-remote.svn.fetch "vendor:refs/remotes/vendor"
	git svn fetch
yields a new clean "ExtLibs-only" git repository with the two branches trunk and vendor, 
and proper merge history (helped with grafting, where necessary), but is so far entirely 
unrelated to the main project repository.

Well... it seems like subtrees and subtree merging is a good way to proceed, but even 
though I've read everything I could find about the subject, I don't quite see how I can 
employ it in the case above, where ExtLibs/ isn't newly created, but history already exists.

Could you please give me an idea how I properly merge ExtLibs as a subdirectory into the 
main repository, including the history? I can add the ExtLibs repository (created as 
shown above) as a remote reference to the main repository, yielding a multi-root 
repository, but what then? Or should I rather convert only vendor/ and use that as a 
remote for merging? (Can grafting put to work in the subtrees context?)

I'd be very grateful for your help!

Best regards,
Carsten



-- 
    Cafu - the open-source Game and Graphics Engine
for multiplayer, cross-platform, real-time 3D Action
           Learn more at http://www.cafu.de
