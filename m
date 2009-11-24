From: Marc Fournier <marc.fournier@camptocamp.com>
Subject: git-subtree: directory mismatch
Date: Tue, 24 Nov 2009 20:53:53 +0100
Message-ID: <20091124195353.GA16627@lonquimay.wrk.lsn.camptocamp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 24 21:22:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ND1uR-0004hE-In
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 21:22:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932779AbZKXUWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 15:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932718AbZKXUWg
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 15:22:36 -0500
Received: from c2cpc15.camptocamp.com ([128.179.66.15]:47875 "EHLO
	mail.camptocamp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932570AbZKXUWf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 15:22:35 -0500
X-Greylist: delayed 1725 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Nov 2009 15:22:35 EST
Received: from lonquimay.localdomain (c2cpc3.camptocamp.com [128.179.66.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.camptocamp.com (Postfix) with ESMTP id 37CF18063E;
	Tue, 24 Nov 2009 21:53:54 +0100 (CET)
Received: by lonquimay.localdomain (Postfix, from userid 1000)
	id D45AEAE139; Tue, 24 Nov 2009 20:53:53 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133591>

Hi,

I've come across this weird behaviour using git-subtree: when updating a
directory created by git-subtree, the content of some (almost) random
neighbour directory gets replaced, instead of the directory specified by
"git-subtree --prefix".


mkdir /tmp/testrepo
cd /tmp/testrepo
git init .
mkdir -p modules/cognac/{manifests,files}
mkdir -p modules/cognac/manifests/{classes,definitions}
touch modules/cognac/README modules/cognac/manifests/classes/foo.pp
modules/cognac/manifests/definitions/bar.pp modules/cognac/files/blabla
git add modules/
git commit -m "test"

git remote add mapserver git://github.com/camptocamp/puppet-mapserver.git
git remote update
git-subtree add --prefix modules/mapserver 97f5985b # an older commit

# So far so good, I have 2 subdirectories in modules/ with completely
# different content.

# Then, the content of modules/cognac/ gets completely replaced by the
# content of HEAD from git://github.com/camptocamp/puppet-mapserver.git.
# modules/mapserver still contains the content of commit 97f5985b.

git-subtree pull --prefix modules/mapserver mapserver master

>From git://github.com/camptocamp/puppet-mapserver
 * branch            master     -> FETCH_HEAD
Removing modules/cognac/files/blabla
Removing modules/cognac/manifests/classes/foo.pp
Removing modules/cognac/manifests/definitions/bar.pp
Merge made by subtree.
 modules/cognac/files/apt-preferences               |    3 +
 modules/cognac/files/epsg.C2C                      | 5445 ++++++++++++++++++++
 modules/cognac/files/epsg.legacy                   | 5445 ++++++++++++++++++++
 modules/cognac/files/epsg.minimal                  |   14 +
 modules/cognac/files/etc/apt/preferences-20070910  |    3 +
 modules/cognac/files/etc/apt/preferences-20080225  |   35 +
 modules/cognac/files/etc/apt/preferences-v5-2      |   35 +
 modules/cognac/manifests/classes/epsg.pp           |   21 +
 .../cognac/manifests/classes/mapserver-debian.pp   |   82 +
 modules/cognac/manifests/classes/v5.pp             |   46 +
 modules/cognac/manifests/init.pp                   |    8 +
 11 files changed, 11137 insertions(+), 0 deletions(-)
 create mode 100644 modules/cognac/files/apt-preferences
 delete mode 100644 modules/cognac/files/blabla
 create mode 100755 modules/cognac/files/epsg.C2C
 create mode 100755 modules/cognac/files/epsg.legacy
 create mode 100644 modules/cognac/files/epsg.minimal
 create mode 100644 modules/cognac/files/etc/apt/preferences-20070910
 create mode 100644 modules/cognac/files/etc/apt/preferences-20080225
 create mode 100644 modules/cognac/files/etc/apt/preferences-v5-2
 create mode 100644 modules/cognac/manifests/classes/epsg.pp
 delete mode 100644 modules/cognac/manifests/classes/foo.pp
 create mode 100644 modules/cognac/manifests/classes/mapserver-debian.pp
 create mode 100644 modules/cognac/manifests/classes/v5.pp
 delete mode 100644 modules/cognac/manifests/definitions/bar.pp
 create mode 100644 modules/cognac/manifests/init.pp

I was not able to reproduce this bug in any of the following cases:
 - if the README file wasn't empty
 - if modules/cognac is renamed to something else
 - if modules/cognac doesn't have the same sub-directories than
   modules/mapserver

This bug happens using git 1.5.5.6 as well as 1.6.5. It seems to happen
when git-subtree calls "git merge -s subtree".

Maybe something is broken in this puppet-mapserver.git repository I use ?
I've encountered the same problem with other directories too.

Any idea ?

Thanks !
Marc
