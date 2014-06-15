From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 00/14] Add submodule test harness
Date: Sun, 15 Jun 2014 18:56:09 +0200
Message-ID: <539DD029.4030506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 15 18:56:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwDjE-0007Rl-SS
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jun 2014 18:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbaFOQ4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2014 12:56:21 -0400
Received: from mout.web.de ([212.227.17.11]:55306 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751468AbaFOQ4U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2014 12:56:20 -0400
Received: from [192.168.178.41] ([84.132.144.103]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MfHfy-1X7h8M28YE-00OnMp; Sun, 15 Jun 2014 18:56:16
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:U0doQ/ot6tF0BpuFuubJOipISdQ60Ry3HVY18Bod1E6r4NcPF5e
 Wak6GexXGh/VvZmZ6ZU5wZ0CjQpP2axRHO83vmeAR1ex12y0mUFnh2xf3q2ahE9K8vYrk9r
 YChTgSV4KuGx9fetxBC0ElAy+SwL4K/B/B1vn7+Zy/NqswaCqFFnCB0RH9xI8ewJK+svJ+m
 eWWeT01ees08I0mFyrC7g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251682>

This is the series I sought feedback for some time ago in gmane/$245048. It
took longer than I expected to finish this series because I had to diagnose
the test failures I saw with some of the ten commands I added since then.
They boiled down to four different inconsistencies in Git's handling of new
or removed submodules. Sometimes no empty directory is created for a new
submodule. stash and cherry-pick seem to use wrong submodule ignore settings
("all" instead of "dirty"), so they overlook submodule changes. And merge
behaves strange when a submodule is removed, as it tries to merge new tracked
files with those remaining from the submodule. This series only documents
these issues (which most probably didn't cause any real world problems until
now because adding and removing submodules wasn't well supported anyway).

The first patch adds a simple helper function to the test lib which makes
it easier to test for an empty submodule directory.

The second patch contains the heavy lifting, it adds the test framework for
switching submodules. Currently only transitions without merge conflicts are
tested for, I intend to add others producing merge conflicts in a follow-up
series.

The other twelve patches use the framework to test all relevant work tree
manipulating commands. In addition to the two general problems documented
in the second patch some patches add known failures for problems of some
commands/actions to be fixed in later patches.

The only work tree changing command I didn't cover here is checkout-index, as
that updates the work tree to the content of the index but doesn't remove any
formerly tracked files, which means it doesn't do a full transition from one
commit to another. If I overlooked another command, please speak up so I can
include it too.

Jens Lehmann (14):
  test-lib: add test_dir_is_empty()
  submodules: Add the lib-submodule-update.sh test library
  checkout: call the new submodule update test framework
  apply: add t4137 for submodule updates
  read-tree: add t1013 for submodule updates
  reset: add t7112 for submodule updates
  bisect: add t6041 for submodule updates
  merge: add t7613 for submodule updates
  rebase: add t3426 for submodule updates
  pull: add t5572 for submodule updates
  cherry-pick: add t3512 for submodule updates
  am: add t4255 for submodule updates
  stash: add t3906 for submodule updates
  revert: add t3513 for submodule updates

 t/lib-submodule-update.sh        | 670 +++++++++++++++++++++++++++++++++++++++
 t/t1013-read-tree-submodule.sh   |  12 +
 t/t2013-checkout-submodule.sh    |   5 +
 t/t3426-rebase-submodule.sh      |  46 +++
 t/t3512-cherry-pick-submodule.sh |  13 +
 t/t3513-revert-submodule.sh      |  32 ++
 t/t3906-stash-submodule.sh       |  24 ++
 t/t4137-apply-submodule.sh       |  20 ++
 t/t4255-am-submodule.sh          |  21 ++
 t/t5572-pull-submodule.sh        |  74 +++++
 t/t6041-bisect-submodule.sh      |  32 ++
 t/t7112-reset-submodule.sh       |  14 +
 t/t7613-merge-submodule.sh       |  19 ++
 t/test-lib-functions.sh          |  11 +
 14 files changed, 993 insertions(+)
 create mode 100755 t/lib-submodule-update.sh
 create mode 100755 t/t1013-read-tree-submodule.sh
 create mode 100755 t/t3426-rebase-submodule.sh
 create mode 100755 t/t3512-cherry-pick-submodule.sh
 create mode 100755 t/t3513-revert-submodule.sh
 create mode 100755 t/t3906-stash-submodule.sh
 create mode 100755 t/t4137-apply-submodule.sh
 create mode 100755 t/t4255-am-submodule.sh
 create mode 100755 t/t5572-pull-submodule.sh
 create mode 100755 t/t6041-bisect-submodule.sh
 create mode 100755 t/t7112-reset-submodule.sh
 create mode 100755 t/t7613-merge-submodule.sh

-- 
2.0.0.275.gc479268
