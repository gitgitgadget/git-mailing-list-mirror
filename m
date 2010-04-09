From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [WIP PATCH 0/4] Recursively checkout submodules
Date: Fri, 09 Apr 2010 23:34:39 +0200
Message-ID: <4BBF9D6F.2000006@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 09 23:34:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0Lqg-0006nM-81
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 23:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757144Ab0DIVel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 17:34:41 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:47207 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603Ab0DIVek (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 17:34:40 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 7E81614D11D25;
	Fri,  9 Apr 2010 23:34:39 +0200 (CEST)
Received: from [80.128.86.62] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #4)
	id 1O0LqZ-0005eF-00; Fri, 09 Apr 2010 23:34:39 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+HPHPVDpwLZMFcS0Wzk5snshECbfUe644sdE0W
	FXW9uBf4jwBSQAH1FtW2MQIcPQ7xWxVF6KC1VXrQBdZkeTERSY
	wFqj2USxwqvjPfxRhcDg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144474>

Having found some Git time recently i started to tackle the next
major issue on my agenda to improve submodule experience: Check
out the matching versions of populated submodules when doing a
checkout in the superproject (without having to do an explicit
"git submodule update").

So here is what i came up with so far: The first two patches lay
the groundwork by introducing a new function checkout_submodule()
in submodule.c and calling it from checkout_entry(). The new
"ignore_submodules" flags added to "struct checkout" and "struct
unpack_trees_options" can be used to prevent that (and default
to true, which is the old behavior then changed by the following
patches). The next two patches teach "git checkout" and "git
checkout-index" to default to checking out submodules too unless
the new option "--ignore-subodules" is used.

What's working:
* Changing branches and specific revisions update the submodules
  accordingly
* "Revert changes" in "git gui" resets submodules now

What's missing:
* Test cases
* I think "git fetch" should recurse into populated submodules
  too, otherwise the commits to check out there might be missing


Opinions?


Jens Lehmann (4):
  Prepare checkout_entry() for recursive checkout of submodules
  Add "ignore_submodules" member to "struct unpack_trees_options"
  Teach checkout to recursively checkout submodules
  Teach checkout-index to recursively checkout submodules

 Documentation/git-checkout-index.txt |    9 ++++++++-
 Documentation/git-checkout.txt       |    7 +++++++
 archive.c                            |    1 +
 builtin/apply.c                      |    1 +
 builtin/checkout-index.c             |    5 ++++-
 builtin/checkout.c                   |    6 ++++++
 builtin/clone.c                      |    1 +
 builtin/commit.c                     |    1 +
 builtin/merge.c                      |    2 ++
 builtin/read-tree.c                  |    1 +
 builtin/reset.c                      |    1 +
 cache.h                              |    3 ++-
 diff-lib.c                           |    2 ++
 entry.c                              |    9 ++++++---
 merge-recursive.c                    |    1 +
 submodule.c                          |   32 ++++++++++++++++++++++++++++++++
 submodule.h                          |    1 +
 t/t2013-checkout-submodule.sh        |   14 ++++++++++++--
 unpack-trees.c                       |    1 +
 unpack-trees.h                       |    3 ++-
 20 files changed, 92 insertions(+), 9 deletions(-)
