From: greened@obbligato.org (David A. Greene)
Subject: Odd rebase behavior
Date: Tue, 15 Dec 2015 21:17:30 -0600
Message-ID: <877fkf9j5h.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: john@keeping.me.uk, sandals@crustytoothpaste.net, peff@peff.net,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 16 04:17:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a92bB-0000S0-Ot
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 04:17:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933954AbbLPDRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 22:17:44 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:56260 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933900AbbLPDRn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 22:17:43 -0500
Received: from 206-55-177-216.fttp.usinternet.com ([206.55.177.216] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1a92aw-0003GK-Am; Tue, 15 Dec 2015 21:17:38 -0600
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282531>

Hi,

The attached tests do not do what I expected them to do.  I commented
out the tests involving the new rebase empty commit behavior I just
sent.  The uncommented tests show the strange behavior.

According to the rebase man page, rebase gathers commits as in "git log
<upstream>..HEAD."  However, that is not what happens in the tests
below.  Some of the commits disappear.

The test basically does this:

- Setup a master project and a subproject, merged via a subtree-like
  merge (this is how git-subtree does it).

- Add some commits to the subproject directory after the subtree merge,
  to create some history not in the original subproject.

- filter-branch --subdirectory-filter to extract commits from the
  subproject directory.

- Rebase those commits back on to the original subproject repository.

The above loses all commits made after the subproject is merged into
the main project.

Note that the rebase is a little wonky.  filter-branch creates a
disconnected graph and the rebase is invoked with <upstream>=master.
I'm not sure how rebase is supposed to operate in this case (if it is
supported at all) but it definitely is not doing the master..HEAD thing.

Replacing "master" with "--root" causes rebase to do the right thing.

This seems like a bug to me, even with the strange <upstream> on a
disconnected graph.  At the very least git should not silently lose
commits.

I can think of two ways this could be resolved:

- Forbid this kind of operation and error our with a message (when
  <upstream> and HEAD do not share ancestry)

- Make it work as if --root were specified

Thoughts?

                         -David

--->8---

#!/bin/sh

test_description='git rebase tests for empty commits

This test runs git rebase and tests handling of empty commits.
'
. ./test-lib.sh

addfile() {
    name=$1
    echo $(basename ${name}) > ${name}
    ${git} add ${name}
    ${git} commit -m "Add $(basename ${name})"
}

check_equal()
{
	test_debug 'echo'
	test_debug "echo \"check a:\" \"{$1}\""
	test_debug "echo \"      b:\" \"{$2}\""
	if [ "$1" = "$2" ]; then
		return 0
	else
		return 1
	fi
}

last_commit_message()
{
	git log --pretty=format:%s -1
}

test_expect_success 'setup' '
	test_commit README &&
	mkdir files &&
	cd files &&
	git init &&
	test_commit master1 &&
	test_commit master2 &&
	test_commit master3 &&
	cd .. &&
	test_debug "echo Add project master to master" &&
	git fetch files master &&
	git branch files-master FETCH_HEAD &&
	test_debug "echo Add subtree master to master via subtree" &&
	git read-tree --prefix=files_subtree files-master &&
	git checkout -- files_subtree &&
	tree=$(git write-tree) &&
	head=$(git rev-parse HEAD) &&
	rev=$(git rev-parse --verify files-master^0) &&
	commit=$(git commit-tree -p ${head} -p ${rev} -m "Add subproject master" ${tree}) &&
	git reset ${commit} &&
	cd files_subtree &&
	test_commit master4 &&
	cd .. &&
	test_commit files_subtree/master5
'

# Does not preserve master4 and master5.
test_expect_success 'Rebase default' '
	git checkout -b rebase-default master &&
	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
	git commit -m "Empty commit" --allow-empty &&
	git rebase -Xsubtree=files_subtree  --preserve-merges --onto files-master master &&
	check_equal "$(last_commit_message)" "files_subtree/master5"
'

# Does not preserve master4, master5 and empty.
test_expect_success 'Rebase --keep-empty' '
	git checkout -b rebase-keep-empty master &&
	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
	git commit -m "Empty commit" --allow-empty &&
	git rebase -Xsubtree=files_subtree --keep-empty --preserve-merges --onto files-master master &&
	check_equal "$(last_commit_message)" "Empty commit"
'


# Does not preserve master4 and master5.
#test_expect_success 'Rebase --keep-redundant' '
#	git checkout -b rebase-keep-redundant master &&
#	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
#	git commit -m "Empty commit" --allow-empty &&
#	git rebase -Xsubtree=files_subtree --keep-redundant --preserve-merges --onto files-master master &&
#	check_equal "$(last_commit_message)" "files_subtree/master5"
#'


# Does not preserve master4, master5 and empty.
#test_expect_success 'Rebase --keep-empty --keep-redundant' '
#	git checkout -b rebase-keep-empty-keep-redundant master &&
#	git filter-branch --prune-empty -f --subdirectory-filter files_subtree &&
#	git commit -m "Empty commit" --allow-empty &&
#	git rebase -Xsubtree=files_subtree --keep-empty --keep-redundant --preserve-merges --onto files-master master &&
#	check_equal "$(last_commit_message)" "Empty commit"
#'


test_done
