From: Rainer Blome <rainer.blome@gmx.de>
Subject: Re: How to update? (git Changed but not updated)
Date: Sun, 22 Feb 2009 02:32:22 +0100
Message-ID: <49A0AB26.40701@gmx.de>
References: <49A070B5.90909@dplanet.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070002080202050507070205"
Cc: git@vger.kernel.org
To: "Reto S. News" <retoh@dplanet.ch>
X-From: git-owner@vger.kernel.org Sun Feb 22 02:34:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lb3F6-0002SL-OZ
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 02:34:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755019AbZBVBbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2009 20:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754970AbZBVBbH
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Feb 2009 20:31:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:47501 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754714AbZBVBbG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2009 20:31:06 -0500
Received: (qmail invoked by alias); 22 Feb 2009 01:31:04 -0000
Received: from e180141191.adsl.alicedsl.de (EHLO [192.168.1.52]) [85.180.141.191]
  by mail.gmx.net (mp015) with SMTP; 22 Feb 2009 02:31:04 +0100
X-Authenticated: #3213004
X-Provags-ID: V01U2FsdGVkX1+L4mgIl5KLHrp+FeZjACLY/v6LaX4CuOBgp3fj5m
	2L8P6L8i44rNhB
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de-DE; rv:1.8.1.19) Gecko/20081204 SeaMonkey/1.1.14
In-Reply-To: <49A070B5.90909@dplanet.ch>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110989>

This is a multi-part message in MIME format.
--------------070002080202050507070205
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Reto S. News wrote:
> Beginner question: "How to update the pushed changes on the master?"

> # git status # Shows me correctly foo.txt has been changed by the"Slave"

No, it shows that the work tree has been left behind with respect to the 
head of master.

Fix this using git checkout master and git reset --hard.

> # git show   # Shows me even the made changes in a diff style!

But probably the wrong way around, showing added lines as removed?


Freshman answer:
Here's what I am doing.

The attached script mygit-test.sh is a simple test of the below work 
flow, with three repositories a (origin), and clones b and c.

Let's calls the "Master" server "Shared", to avoid confusion with any 
"master" branch.

On Shared, do not work in the master branch.
Instead, work in a dedicated local branch, for example 
"central-development".

# Only needed if your working directory and index are not clean:
git stash

git checkout master
git checkout -b central-development

# Only needed if you had to stash above:
git stash apply
# You can now commit any changes
# Once you've safely commited the changes, use: git stash clear


On Slave, do not work in the master branch as well.
Instead, work in a dedicated local branch, for example "slave".

git checkout -b master origin/master  # Ensure a local copy of master exists
git pull origin master # Ensure the new branch is up to date
git checkout -b slave  # Create the local development branch

# Now edit, commit, edit, commit, ...
# Once you want to publish your changes:

# Update local copy of master:
git pull --rebase origin master

# LOOP:
# Merge your changes on top of new master, staying on slave:
git rebase master slave
# Test and review the merged code on slave.

# Update local copy of master, again,
# to make sure it has not changed in the meantime:
git pull --rebase origin master
# If it changed, go to LOOP, otherwise continue below.

# Update local copy of master (this is now fast-forward)
git rebase slave master
# Send changes to master on Shared
git push origin master
# Leave master
git checkout slave

On Shared:
# Update development with respect to changes on master
git rebase master development


Complex?  Yes.
Can it be simplified?  I hope so.

I have written a script that helps to use the work flow described here.
If anyone is interested, please comment.

Good luck, Rainer


--------------070002080202050507070205
Content-Type: application/x-sh;
 name="mygit-test.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mygit-test.sh"

#!/bin/sh
# @file mygit-test.sh - Test shared repository work flow

set -u;
set -e;

#set_x="set -x";
set_x="${set_x-:}";
$set_x;

init()
{
    testdir="mygit-tests";
    file="foo";
    tab=$(printf "\t");

    # Allow global control of calls
    git=$(which git);
    git() { $git "$@"; }

    cleanup;
    mkdir "$testdir";
    # Make testdir absolute:
    testdir=`cd "$testdir"; pwd`;
    cd "$testdir";

    a="$testdir/repo_a";
    b="$testdir/repo_b";
    c="$testdir/repo_c";

    int="integr";
    dev="devel";
}

cleanup() {
    rm -rf "$testdir" || true;
}

status() {
    if git status; then :;
    else echo "git status returned $?"; fi;
}

head() { git log "--pretty=format:%H" -1 "$1" --; }

origin_init() {
    name="$1"; shift;
    dir="$1"; shift;
    mkdir "$dir";
    (
	cd "$dir";
	git init; status;

	# Can't checkout because the branch is not yet born
	#git checkout -b "$dev"; status;
	git symbolic-ref HEAD "refs/heads/$name-$dev"; status;
	echo "bar" > "$file"; status;
	git add .; status;
	git commit -m "Initial"; status;

	git branch -a "$int"; status;
	#gitk --all;
	git branch -v;
	[ $(head "$name-$dev") = $(head "$int") ];
	);
}

clone() {
    name="$1"; shift;
    src="$1"; shift;
    dst="$1"; shift;
    #pwd;
    #mkdir "$dst";
    git clone --no-checkout "$src" "$dst";
    (
	cd "$dst";
	git remote -v show;
	git remote -v show origin;
	git remote -v show | grep "origin$tab$src";
	git checkout -b "$int" "origin/$int";
	git checkout -b "$name-$dev";

	echo "changed source from $dst" >> "$file";
	git commit -m "Change by $dst" -a;

	git pull --rebase origin "$int";
	[ `head "$int"` = `head "origin/$int"` ];
	[ `git merge-base "$int" "$name-$dev"` = `head "$int"` ];
	git rebase "$int" "$name-$dev";

	git pull --rebase origin "$int";
	git rebase "$name-$dev" "$int";

	git push origin "$int";
	git checkout "$name-$dev";
	);
}

work()
{
    origin_init "a" "$a";
    # "file://" syntax avoids implied "--local"
    clone "b" "file://$a" "$b";
    clone "c" "file://$a" "$c";

    (
	cd "$a";
	git rebase "$int" "a-$dev";
	cat "$file";
	grep "changed source from $b" "$file";
	grep "changed source from $c" "$file";
	);
}

main() {
    init "$@";
    work;
    #cleanup;
}

main "$@";

# EOF

--------------070002080202050507070205--
