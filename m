From: Ray Lehtiniemi <rayl@mail.com>
Subject: Re: Can you do this with GIT?
Date: Fri, 27 Jul 2007 13:52:11 -0600
Message-ID: <200707271352.11147.rayl@mail.com>
References: <11834063.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: CPD <cdavidson@altsoftware.com>
X-From: git-owner@vger.kernel.org Fri Jul 27 21:53:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEVs0-0008BX-Bz
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 21:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762969AbXG0TxA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 15:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763010AbXG0TxA
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 15:53:00 -0400
Received: from static-68-179-52-57.ptr.terago.ca ([68.179.52.57]:38511 "EHLO
	mail.headplay.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762514AbXG0Tw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 15:52:59 -0400
Received: from linux.local ([192.168.1.201])
	by mail.headplay.com with ESMTP; Fri, 27 Jul 2007 13:52:41 -0600
User-Agent: KMail/1.9.5
In-Reply-To: <11834063.post@talk.nabble.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53961>

On Friday 27 July 2007 12:02, CPD wrote:

> We produce variations based on a (mostly) common codebase. In CVS I set up 
> "environment" modules for each platform, then when you are working on that
> platform, you simply check out the correct environment and build. Only the
> needed code and tools are exposed in that environment (this is important as
> clients must NOT see each other's code and most customers have some
> customization). I do this by defining and renaming modules in the CVSROOT
> modules file.

this sounds very close to what i'm trying to achieve at the moment.


> Does GIT support anything like this? Or another way to acheive the same
> end?

i couldn;t find any ready way to do it.... but i've hacked up a few 
preliminary thoughts on how this might work in git.  comments and feedback 
are welcome :-)

the basic idea is to import each snapshot of each vendor release as a tagged 
root commit, then push all these tagged root commits into a central "library" 
repository. each tagged root commit stands alone and functions as a cvs 
module.

library repos are set up as remotes under git, and a simple script will import 
a set of snapshots into a brand new project as a baseline for customization.

the three shell scripts, and the two control files used by them, are included 
here:

==> vendor-tracking.sh <==
###########################################################
#
# Import a vendor snapshot into a "library" repository.
#
# To import a vendor snapshot, unzip the snapshot into
# a new folder.  Then go into the folder and type
#
#  xxx-import <library> <tag>
#
# This will create an empty git repo in the current
# snapshot folder and create a root commit in 
# it which holds the snapshot.  This root commit will be
# tagged as "tag" and then pushed into the "library" repo.
#
# No error checking is done.
#
###########################################################
xxx-import ()
{(
	repo=$1
	tag=$2

	export GIT_DIR=/tmp/$$.$tag

	rm -rf $GIT_DIR
	mkdir -p $GIT_DIR

	git init
	git add .
	git commit -s -m "Import $tag"
	git tag $tag master
	git push $repo refs/tags/$tag:refs/tags/$tag

	rm -rf $GIT_DIR
)}

###########################################################
#
# Use a vendor release in the current project.
#
# To use a copy of some vendor snapshot in the current
# project, go to the top level of your current project,
# then type
#
#  xxx-use <library> <tag> <path>
#
# The tagged snapshot will be fetched from the library
# and deposited into the <path> subdirectory, then committed
# to the project.
# 
# No error checking is done.
#
###########################################################
xxx-use ()
{(
	repo=$1
	tag=$2
	path=$3

	git fetch $repo refs/tags/$tag:refs/tags/$tag
	git read-tree --prefix=$path/ $tag
	git commit -s -m "Use $tag as $path"
)}

###########################################################
#
# Create a new project from a set of vendor components.
#
# To start a new project with a known array of vendor
# components, create a remotes file describing the libraries
# and an manifest file describing the components and how they
# will be used. Then, in a new folder, type
#
#  xxx-start <remotes> <manifest>
#
# This will create a new Git project in the current folder,
# add a remote for each library repository, then proceed to
# fetch and commit each vendor component into the new project.
# The new project is now ready to be customized.
# 
# No error checking is done.
#
###########################################################
xxx-start ()
{(
	remotes=$1
	manifest=$2

	git init

	cat $remotes |
	while read name url
	do
		git remote add $name $url
	done

	cat $manifest |
	while read path remote tag
	do
		xxx-use $remote $tag $path
	done

	git checkout -f master
)}


==> remotes <==
lib1	ssh://me@home.com/home/me/work/library
lib2	//filesrv/git/library

==> manifest <==
path/to/A		lib1	vendorA/componentA/version1
path/to/B		lib2	vendorB/componentB/version2






i would prefer to import and tag raw tree objects, since i get some of my 
snapshots as pre-assembled collections of (modified copies of) several 
components.  it would therefore be convenient to have several tags per 
snapshot pointing at the subtrees corresponding to each component.  however,  
fetch and push seem to prefer commits over trees.... 

as it stands, the vendor snapshots have no "history" to them.  each snapshot 
stands in isolation.  there was an interesting thread a few days ago about 
importing ancient kernel history as a series of trees, then "stitching 
together" a "synthetic history" from a collection of trees.  i would see 
something like that as the basis for "vendor tracking branches", which could 
be restitched if an older snapshot is received "out of order".


hope it helps
ray
