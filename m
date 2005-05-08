From: Junio C Hamano <junkio@cox.net>
Subject: Re: Broken adding of cache entries
Date: Sun, 08 May 2005 15:18:06 -0700
Message-ID: <7v7ji94b1d.fsf@assigned-by-dhcp.cox.net>
References: <20050507001409.GP32629@pasky.ji.cz>
	<1115431767.32065.182.camel@localhost.localdomain>
	<20050507152849.GD9495@pasky.ji.cz>
	<7vhdhealjm.fsf@assigned-by-dhcp.cox.net>
	<20050507224116.GF9495@pasky.ji.cz>
	<7vll6q8s4o.fsf@assigned-by-dhcp.cox.net>
	<7vbr7m8p05.fsf@assigned-by-dhcp.cox.net>
	<7vll6q70mg.fsf@assigned-by-dhcp.cox.net>
	<20050508165915.GW9495@pasky.ji.cz>
	<7v3bsx5sxx.fsf@assigned-by-dhcp.cox.net>
	<20050508212202.GM9495@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 00:12:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUtzg-0003fH-H0
	for gcvg-git@gmane.org; Mon, 09 May 2005 00:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262982AbVEHWSW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 18:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262992AbVEHWSW
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 18:18:22 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:28104 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S262982AbVEHWSK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2005 18:18:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050508221806.MRRS16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 8 May 2005 18:18:06 -0400
To: Petr Baudis <pasky@ucw.cz>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> Still, I'd like to know why the checking in write-tree is necessary.

The following is just a rephrase of what I wrote in my previous
message <7vll6q70mg.fsf@assigned-by-dhcp.cox.net>.

------------ test.sh ------------
#!/bin/sh

test="++testdir"
rm -fr $test
mkdir $test
cd $test || exit

show () {
	echo "# ls ($1)"
	ls -F
	echo "# git-ls-files --stage ($1)"
	git-ls-files --stage
	case "$2" in
	'')	;;
	?*)
		echo "# git-ls-tree -r ($1)"
		git-ls-tree -r $2
		;;
	esac
}

echo "# Original"
git-init-db
date >not-so-interesting
git-update-cache --add not-so-interesting
original=$(echo Original | git-commit-tree $(git-write-tree))
show Original $original
rm -rf path not-so-interesting

echo "# Branch A"
git-read-tree $original
git-checkout-cache -f -a
date >path
git-update-cache --add path
branchA=$(echo Branch A Changes |
          git-commit-tree $(git-write-tree) -p $original)
show 'Branch A' $branchA
rm -rf path not-so-interesting

echo "# Branch B"
git-read-tree $original
git-checkout-cache -f -a
mkdir path
date >path/file
git-update-cache --add path/file
branchB=$(echo Branch B Changes |
          git-commit-tree $(git-write-tree) -p $original)
show 'Branch B' $branchB
rm -rf path not-so-interesting

echo "# Attempt merge O A B"
mb=$(git-merge-base $branchA $branchB)
echo "Original  $original"
echo "Branch-A  $branchA"
echo "Branch-B  $branchB"
echo "MergeBase $mb"

git-read-tree -m $mb $branchA $branchB
show "Merge"
------------ test.out ------------
# Original
defaulting to local storage area
Committing initial tree 682c2247823f37e4cf64f240009c9ba932b04fe0
# ls (Original)
not-so-interesting
# git-ls-files --stage (Original)
100644 9bcc8fabbbb587ba312a45b144dce8f4d9191da5 0 not-so-interesting
# git-ls-tree -r (Original)
100644	blob	9bcc8fabbbb587ba312a45b144dce8f4d9191da5	not-so-interesting
# Branch A
# ls (Branch A)
not-so-interesting
path
# git-ls-files --stage (Branch A)
100644 9bcc8fabbbb587ba312a45b144dce8f4d9191da5 0 not-so-interesting
100644 9bcc8fabbbb587ba312a45b144dce8f4d9191da5 0 path
# git-ls-tree -r (Branch A)
100644	blob	9bcc8fabbbb587ba312a45b144dce8f4d9191da5	not-so-interesting
100644	blob	9bcc8fabbbb587ba312a45b144dce8f4d9191da5	path
# Branch B
# ls (Branch B)
not-so-interesting
path/
# git-ls-files --stage (Branch B)
100644 9bcc8fabbbb587ba312a45b144dce8f4d9191da5 0 not-so-interesting
100644 9bcc8fabbbb587ba312a45b144dce8f4d9191da5 0 path/file
# git-ls-tree -r (Branch B)
100644	blob	9bcc8fabbbb587ba312a45b144dce8f4d9191da5	not-so-interesting
040000	tree	f4e939c9b65aff9a59118f3f3f299ef30744adfa	path
100644	blob	9bcc8fabbbb587ba312a45b144dce8f4d9191da5	path/file
# Attempt merge O A B
Original  40c1d8a0e79df9e681667e0074664266b6bd9935
Branch-A  88b3e7e4ce0ba55c60fe4de6523968ecabb1cc78
Branch-B  0faa7f6b7f68ce2951fe3f26f937766ee53dc11c
MergeBase 40c1d8a0e79df9e681667e0074664266b6bd9935
# ls (Merge)
# git-ls-files --stage (Merge)
100644 9bcc8fabbbb587ba312a45b144dce8f4d9191da5 0 not-so-interesting
100644 9bcc8fabbbb587ba312a45b144dce8f4d9191da5 2 path
100644 9bcc8fabbbb587ba312a45b144dce8f4d9191da5 3 path/file

