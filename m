From: James Ketrenos <jketreno@linux.intel.com>
Subject: GIT overlay repositories
Date: Wed, 13 Jul 2005 13:03:57 -0500
Message-ID: <42D5578D.3000301@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090507050903050608030404"
X-From: git-owner@vger.kernel.org Wed Jul 13 19:05:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DskfB-000837-8O
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 19:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVGMRD7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 13:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbVGMRDt
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 13:03:49 -0400
Received: from fmr17.intel.com ([134.134.136.16]:41413 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261293AbVGMRD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2005 13:03:28 -0400
Received: from orsfmr100.jf.intel.com (orsfmr100.jf.intel.com [10.7.209.16])
	by orsfmr002.jf.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j6DH3RNM009116
	for <git@vger.kernel.org>; Wed, 13 Jul 2005 17:03:27 GMT
Received: from [127.0.0.1] (logicsbox.jf.intel.com [134.134.16.142])
	by orsfmr100.jf.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id j6DH3Oop018357
	for <git@vger.kernel.org>; Wed, 13 Jul 2005 17:03:26 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050626
X-Accept-Language: en-us, en
To: git@vger.kernel.org
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------090507050903050608030404
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Ok...

I started working on this a few weeks ago when it didn't appear 
anyone else had worked on support for this feature.  Since then, I
haven't kept pace with GIT development, so someone may have done 
something similar in the interim.  That said...

Start with two repositories, let's call them Repo-A and Repo-B.  Repo-A
is hosted on some server somewhere and contains lots of code 
(let's say its a kernel source repository).  Repo-B is only adding a 
small amount of changes to the repo (for argument sake, let's say the 
IPW2100 and IPW2200 projects) on top of what is already provided by Repo-A. 

For several reasons, we would like users to be able to get just the 
differences between Repo-A and Repo-B from me.

For example, the user gets the full Repo-A:

	rsync -avpr rsync://somewhere.com/repo-a/.git/objects/ \ 
		.git/objects/
	rsync -avpr rsync://somewhere.com/repo-a/.git/refs/heads/master \
		.git/refs/heads/parent

and then overlays just the delta, which they obtain from me:

	rsync -avpr rsync://myserver.com/repo-delta/.git/objects/ \
		.git/objects/
	rsync -avpr rsync://myserver.com/repo-delta/.git/refs/heads/master \
		.git/refs/heads/master

The user can then run:

	ln -s .git/HEAD refs/heads/master
	git-read-tree -m HEAD
	git-checkout-cache -a -q -f -u

And now their disk has the entire Repo-A + Repo-B object 
tree as if Repo-B had been entirely stored on myserver.com.

Adding this recursively is pretty straightforward if we introduce an 
'ancestors' file stored on the overlay repository that contains the URL 
and SHA of the tip of the parent when it was used to build the full 
repository.  For example:

% cat .git/refs/ancestors (edited to fit 80 columns)
rsync://rsync.kernel.org/...-2.6.git/#ieee80211	0c16...7f3
rsync://bughost.org/repos/ieee80211-delta/.git/ 5cb5...b84
rsync://bughost.org/repos/ipw-delta/.git/       f3ed...abe

A simple script (attached as 'git-grab-overlay') can then walk this 
ancestor file and pull down updates as needed from each of the parent 
repositories.

The process of creating the overlays is pretty straight forward (for 
simple cases anyway)

For example:

	A1   B  <-- HEAD SHA1
	|    |
	|    |
	| .->'  <-- parent SHA1
	|/     
	|
	A

In this state, the list of objects is easily obtained by walking the 
tree from HEAD back to the parent's SHA1 at the time the branch was 
made.  This can be done with something like: 

	git-rev-list --objects HEAD ^parent

To simplify things, I created the attached script 'git-make-overlay' 
which will create an overlay repository with for all objects needed 
between a given SHA1 and the HEAD of the repository:

	cd repository
	git-make-overlay ../target

This script will take the current HEAD and cached parent SHA (stored via 
the git-grab-overlay or manually when you create the intial tree) and 
create an overlay that you can then store on a remote server for others 
to pull.

Obviously you don't want the overlay repository to remain out of sync 
with the parent repository for too long.  The process of updating the 
full local repository is then a matter of:

  * Grabbing the latest parent objects
  * Caching the parent's latest master (store as new-parent)
  * Perform a merge of the child back into the master tree
  * Updating the cached heads (parent, master, etc.)

The merge is accomplished via:

	child=$(cat .git/HEAD)
	parent=$(cat .git/refs/heads/new-parent)
	base=$(git-merge-base $child $parent)
	# NOTE: base should be the same as .git/refs/heads/parent!

Is it best to merge the smaller subset back into the merge base, ie:

	git-read-tree -m $base $parent $child

In either case, the merge will fail if you have your local tree in a 
state consistent with child (vs. base).  So before you do the merge you 
need to either nuke the local tree or use paramters to the git- tools 
that I don't know about (definitely wouldn't suprise me).  When I run it, 
I create a temporary directory with a symlink of .git to the .git directory
where the merge will occur.  After the merge is done, I go back to the main
directory and resync the local file system with the GIT repository.

Anyway, I put together another simple script that attempts to do the 
above--minus the symlink hack (attached as git-merge-parent).  It invokes 
the git-merge-heads script which does some of what Cogito's cg-merge does, 
only with support for automatically launching an external merge conflict 
resolution program.  It relies on cogito's cg-Xmergefile so you need to 
have cogito to use git-merge-parent and git-merge-heads.
	
Frequently when remerging with a parent repository--especially one that 
may contain a version of the child within it, there will be merge 
conflicts.  The git-merge-parent accepts (well, requries) a MERGE 
environment variable to invoke as a merge conflict resolver.  If a 
conflict arrises, it will prompt if you want to resolve the merge, 
undo the update, or exit and allow you to finish the process manually.

If you chose to run the conflict editor, it will invoke it by providing 
three versions of the conflicting file:

1.  The base version (as captured in the tree identified 
    with git-merge-base on the parent and child) -- named FILE.base
2.  The parent version named FILE.parent
3.  The child version named FILE

After all merge conflicts have been manually updated, the 
git-merge-parent script will commit those changes, along with the rest 
of the merge, and move the child's HEAD to the new tree identity.  In 
addition it will cache the HEAD of the parent's merge.

I haven't really tested the whole merge extensiveloy; it has worked 
(more or less) with some simple parent updates I've done here.  However, 
it may be of use to some folks out there, and if others can take it 
forward beyond what I have, or merge the functionality into cogito (or 
wherever) great. 

I have a tree currently up that demonstrates the above in use.  
You can access it via:

  git-grab-overlay rsync://bughost.org/repos/ipw-delta/.git/ ipw-dev/

James




--------------090507050903050608030404
Content-Type: text/plain;
 name="git-grab-overlay"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-grab-overlay"

#!/usr/bin/env bash
# Copyright (c) 2005, Intel Corporation, James Ketrenos

function die()
{
	ret=$1
	shift
	echo $@ >&2
	exit $ret
}

function pull-delta-repo()
{
	parent=$1

	if echo "$parent" | egrep -q "#"; then
		branch=$(echo $parent | sed -ne "s,.*#\(.*\),\1,p")
		parent=$(echo $parent | sed -ne "s,\([^#]*\).*,\1,")
	else
		branch=master
	fi
	echo "$parent" | grep -q "/\$" || parent="$parent/"

	mkdir -p ${dst}{refs/{heads,branches},objects}

	echo "Grabbing repo:"
	echo -en "\tparent..."
	rsync ${RSYNC_FLAGS} -ap ${parent}refs/heads/${branch} \
		${2}refs/heads/parent || 
		die 5 "Could not pull $parent $branch"
	echo "done."

	echo -en "\tancestors..."
	rsync ${RSYNC_FLAGS} -ap ${parent}refs/ancestors \
		${2}refs/ancestors || 
		die 5 "Could not pull $parent $branch"
	echo "done."

	cat ${2}refs/ancestors |
	while read url sha; do
		echo $url | grep "^#.*" && continue
		url=$(echo $url | sed -e "s,\([^#]*\).*,\1,")
		echo $url | grep -q "/\$" || url="$url/"
		dir=$(echo $sha | sed -ne "s#^\(..\).*#\1#p")
		obj=$(echo $sha | sed -ne "s#^..\(.*\)#\1#p")
		echo -e "Checking for updates on:\n\t$url\nfor\n\t$sha..."
		if [ ! -e ${2}objects/$dir/$obj ]; then
			echo "Updating objects from $url..."
			rsync ${RSYNC_FLAGS} -avpr \
				${url}objects/ \
				${2}objects/ ||
				die 6 "Could not pull objects from $url."
			echo "Updated."
		else
			echo "$url up to date."
		fi
	done || exit 1

	url=$parent
	sha=$(cat ${2}/refs/heads/parent)
	dir=$(echo $sha | sed -ne "s#^\(..\).*#\1#p")
	obj=$(echo $sha | sed -ne "s#^..\(.*\)#\1#p")
	if [ ! -e ${2}objects/$dir/$obj ]; then
		echo "Updating objects from $url..."
		rsync ${RSYNC_FLAGS} -avpr \
			${url}objects/ \
			${2}objects/ ||
		die 6 "Coult not pull objects from $url."
	else
		echo "$url up to date."
	fi

	echo -e "$parent\t$sha" >> ${2}refs/ancestors
	cp ${2}refs/heads/parent ${2}refs/heads/master
	ln -sf refs/heads/master ${2}HEAD
#	rsync ${RSYNC_FLAGS} -ap ${1}refs/branches ${2}refs/branches/
}

([ ! "$1" ] || [ ! "$2" ]) && echo \
"usage: git-grab-overlay src_delta_repo target_full_repo" && exit 1

src="${1}"
echo ${src} | grep -q "/\$" || src="${src}/"
echo ${src} | grep -q "\.git/\$" || src="${src}.git/"

dst="${2}"
echo ${dst} | grep -q "/\$" || dst="${dst}/"
echo ${dst} | grep -q "\.git/\$" || dst="${dst}.git/"
[ ! -d ${dst} ] && (mkdir -p ${dst} || die 5 "Error creating '${dst}'")
dst=`readlink -f ${dst}`/

pull-delta-repo $src $dst || exit 1

echo ""
echo "${2} now contains the full tree from ${1}."
echo -e "\nTo sync the files to the cache state, run:"
echo -e "\t% cd ${2}"
echo -e "\t% git-read-tree -m HEAD && git-checkout-cache -q -f -u -a"
while true; do
	read -p "Do you want to do this now? [Y/n] :" reply
	case $reply in
	"n")	exit 0
		;;
	"Y"|"y"|"")
		dir=$PWD
		cd ${2}
		git-read-tree -m HEAD
		git-checkout-cache -q -f -u -a
		cd $PWD
		exit 0
	esac
done

--------------090507050903050608030404
Content-Type: text/plain;
 name="git-make-overlay"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-make-overlay"

#!/usr/bin/env bash
# Copyright (c) 2005, Intel Corporation, James Ketrenos

function die()
{
	ret=$1
	shift
	echo -e $@>&2
	exit $ret
}


function copy-object()
{
        dir=$(echo $1 | sed -e 's#\(..\).*#\1/#')
        obj=$(echo $1 | sed -e 's#..\(.*\)#\1#')

        [ ! -e ${2}objects/${dir}${obj} ] && \
                return 1

        if [ -e ${3}objects/${dir}${obj} ]; then
		[ "$warn" ] && echo "$1 already exists in $3."
                return 0
	fi

        [ ! -d ${3}objects/${dir} ] && \
                (mkdir -p ${3}objects/${dir} || return 1)

        cp -a ${2}objects/${dir}${obj} ${3}objects/${dir} || return 1
}


[ "$1" ] ||
	die 1 \
"usage: git-make-overlay dst-repo [SHA1]\n\n"\
"Where dst-repo is the target directory to store the overlay\n"\
"repository and SHA1 is the 'base' of the tree you want to create the\n"\
"delta against.\n"\
"\n"\
"If not provided, the script will compute the merge base between\n"\
"the parent (.git/refs/heads/parent) and the current HEAD (which would\n"\
"typically be the same).\n"\
"\n"\
"For example:\n"\
"  % child=\$(cat .git/HEAD)\n"\
"  % parent=\$(cat .git/refs/heads/parent)\n"\
"  % git-make-overlay ../overlay \$(git-merge-base \$child \$parent)\n"\
"\n"\
"The resulting overlay will be populated with the following files:\n"\
"\n"\
"  .git/objects\t\tContaining all objects not contained in parent.\n"\
"  .git/refs/ancestors\tParental lineage to root repository.\n"\
"  .git/refs/heads/master\tSHA for the tip of this overlay.\n"\
"\n"

[ -d ".git" ] ||
	die 2 ".git repository not found."

dst=$1
echo $dst | grep -ne "/\$" || dst="$1/"
echo $dst | grep -ne "\.git/\$" || dst="${dst}.git/"
[ ! -d $dst ] && (mkdir -p $dst || die 3 "mkdir: error creating '$dst'")
shift

if [ "$1" ]; then 
	base="$1"
else 
	base="$(git-merge-base $(cat .git/HEAD) $(cat .git/refs/heads/parent))"
fi

head=$(cat .git/HEAD)

echo -e \
"Creating overlay from:\n"\
"\t$base ->\n"\
"\t\t$head (HEAD)\nin\n"\
"\t$dst\n"

(git-rev-list --objects $head ^$base ||
                die 2 "git-rev-list failed!") |
while read sha rest; do
	copy-object $sha .git/ $dst || 
		die 5 "copy-object failed on $sha!"
	type=$(git-cat-file -t $sha)
	echo -e "$sha\t$type\t$rest"
done

mkdir -p ${dst}refs/heads || die 5 "Error creating refs/heads"
cat .git/HEAD > ${dst}refs/heads/master
ln -sf refs/heads/master ${dst}HEAD
cp .git/refs/ancestors ${dst}refs/ancestors

echo "done."

--------------090507050903050608030404
Content-Type: text/plain;
 name="git-merge-heads"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-merge-heads"

#!/usr/bin/env bash
#
# Portions based on cg-merge Copyright (c) Petr Baudis, 2005
# Copyright (c) 2005, Intel Corporation, James Ketrenos

. ${COGITO_LIB:-/usr/lib/cogito/}cg-Xlib

function die()
{
	ret=$1
	shift
	echo $@ >&2
	exit $ret
}

([ "$1" ] && [ "$2" ]) || 
	die 1 "usage: git-merge-heads parent-sha1 child-sha1"

git-read-tree HEAD ||
	die 8 "Failed to read tree"

parent=$1
child=$2
base=$(git-merge-base $1 $2) || 
	die 2 "Failed to obtain common base for trees"

git-read-tree -m $base $parent $child ||
	die 3 "Failed to merge trees"

if ! git-merge-cache -o ${COGITO_LIB:-/usr/lib/cogito/}cg-Xmergefile -a; then
	git-resolve-conflicts ||
		die 4 "Failed to resolve conflicts"
fi

tree=$(git-write-tree) || 
	die 5 "Failed to write merged tree."

echo "Merge succeeded as tree $tree."

while true; do
	read -p "Do you wish to commit this tree? [y]n :" reply <&1
	case $reply in
	n)	break
		;;
	y|*)
		echo "Type your COMMIT message followed by CTRL-D:"
		commit=$(git-commit-tree $tree -p $parent -p $child) ||
			die 6 "Commit failed."
		echo "Commit succeeded as commit $commit."
		echo "Moving HEAD to $commit"
		echo $commit > .git/HEAD
		break
		;;
	esac
done

git-read-tree -m HEAD

while true; do
	read -p "Do you wish to update the files on disk to reflect repository? [y]n :" reply <&1
	case $reply in
	n)	break
		;;
	y|*)
		git-read-tree -m HEAD ||
			die 9 "Failed to read tree."

		git-checkout-cache -q -u -f -a ||
			die 7 "Checkout failed."

		break
		;;
	esac
done


--------------090507050903050608030404
Content-Type: text/plain;
 name="git-merge-parent"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-merge-parent"

#!/usr/bin/env bash
# Copyright (c) 2005, Intel Corporation, James Ketrenos

function die()
{
	ret=$1
	shift
	echo $@ >&2
	exit $ret
}

[ ! "$MERGE" ] && 
	die 1 "MERGE must be set to merge program (ie, export MERGE=kdiff3)"

parent=
branch=
function get_parent_and_branch()
{
	[ ! -e .git/refs/parent ] && return 1
	parent=$(cat .git/refs/parent)
	[ ! "$parent" ] && return 1

	if echo ${parent} | egrep -q "#"; then
		branch="refs/heads/"$(echo $parent | sed -ne "s,.*#\(.*\),\1,p")
		parent=$(echo $parent | sed -e "s,\([^#]*\).*,\1,")
	else
		branch="HEAD"
	fi

	echo $parent | grep "/\$" || parent="${parent}/"

	return 0
}

function merge_parent()
{
	[ -e ".git/refs/heads/repository.merge" ] && 
		die 9 "Prior merge failed and not un-done."

	repo=$1
	branch=$2
	echo $repo | grep "/\$" || repo="${repo}/"
#	First verify there are no uncommitted changes, then proceed...
#	(TODO: Add script commands for checking for uncommitted changes)
#
#	Obtain the parent's HEAD and store as .git/refs/heads/parent.tip and
#		.git/refs/heads/parent.merge
	echo "Checking for updates from ${repo}${branch}..."

	rsync ${RSYNC_FLAGS} -vpL ${repo}${branch} .git/refs/heads/parent.tip || return 1

	parent=$(cat .git/refs/heads/parent)
	new_parent=$(cat .git/refs/heads/parent.tip)
	echo $new_parent > .git/refs/heads/parent.merge || return 2

#	Check for an update; if no update, we're done
	[ "$parent" == "$new_parent" ] && return 0

	child=$(cat .git/HEAD)

#	Grab the latest objects from the parent
	echo "Pulling object files"
	rsync ${RSYNC_FLAGS} -avpr ${repo}objects/ .git/objects/ || return 3

#	Copy the current HEAD to .git/refs/heads/repository.merge
	echo "Caching HEAD in repository.merge"
	cp .git/HEAD .git/refs/heads/repository.merge || return 4


#	Update the GIT index
	echo "Setting local repository to mirror parent"
	echo $new_parent > .git/HEAD || return 5
	rm .git/index
	git-read-tree -m HEAD || return 6
#	git-checkout-cache -f -u -a

# 	At this point, our local repository is now a mirror of the 
#	parent repository.  

#	Merge and commit the repository changes back into the current parent
	echo "Merging child back into parent"
	git-merge-heads $new_parent $child || return 7

#	Update parent / repo index links
	mv -f .git/refs/heads/parent.tip .git/refs/heads/parent || return 12

	mv .git/refs/heads/repository.merge .git/refs/heads/pre-merge
	
	echo "Updating ancestors file..."
	url=$(cat .git/refs/parent)
	sed -i -e "s#$url\t$parent#$url\t$new_parent#g" \
		.git/refs/ancestors
	return 0
}

function merge_cleanup()
{
#	If any of the above fails, the repository should be changed back 
#	to its original state:
	
	rm -f .git/refs/heads/{parent,repository}.merge \
		.git/refs/heads/parent.tip || \
		return 1
	ln -sf refs/heads/master .git/HEAD || return 2
	git-read-tree -m HEAD || return 3
	git-checkout-files -q -f -u -a || return 4

	return 0
}

if ! get_parent_and_branch; then
#	merge_cleanup
	exit 1
fi

echo -e "Attempting merging with:\n\t$parent\n..."
merge_parent $parent $branch || 
	die 12 "Error merging parent."

rm -rf .git/merge*

exit 0

--------------090507050903050608030404--
