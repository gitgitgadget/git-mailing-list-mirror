From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 00/16] worktree: use "git reset --hard" to populate worktree
Date: Fri, 10 Jul 2015 20:05:30 -0400
Message-ID: <1436573146-3893-1-git-send-email-sunshine@sunshineco.com>
Cc: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 11 09:10:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDovr-00007d-Tn
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 09:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752687AbbGKHKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 03:10:39 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:32891 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957AbbGKHKj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 03:10:39 -0400
Received: by ietj16 with SMTP id j16so35700895iet.0
        for <git@vger.kernel.org>; Sat, 11 Jul 2015 00:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=s29//Nx5JSXhy0UqymcDhIY1jSogH12uKfBP3oQX89I=;
        b=N0PCiyDCIGEPF++kYy+nj1UoM3PhyeYMuFYqGDQArUHUjm2wUyYtKe1hrby5QBL9xA
         5RB88s2zs6BjlrrFhObebGROlgeyRb/6rCFxT9Yz0jejG0hji5Iz3lcmKdZT/m5vf9Bh
         vNyAkH4G/aFm3P19E3fy989owcSc/YBBLZQUMbcAWYtBfZyQx3m0fWH6/zH4yUuKbhGX
         NBFeL52S+noo4wLMb2ZZrTT5ZugwT7An0Abte4mPXRVIEgQZzuRdSV3NZbQgcCCkKDEU
         kgZ51HgXW/zGPJt5xGl7YbwwAoHHU1iP8Xhf6wNBCLcuzlXx12i6E9QbngSRK4mJ0nuU
         lo/A==
X-Received: by 10.107.8.17 with SMTP id 17mr6094111ioi.15.1436573187956;
        Fri, 10 Jul 2015 17:06:27 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id g81sm7533321ioi.20.2015.07.10.17.06.26
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Jul 2015 17:06:27 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc1.201.ga12d9f8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273856>

This is a follow-on series to [1], which migrated "git checkout --to"
functionality to "git worktree add". That series continued using "git
checkout" for the initial population of the new worktree, which required
git-checkout to have too intimate knowledge that it was operating in a
newly created worktree.

This series eliminates git-checkout from the picture by instead
employing "git reset --hard"[2] to populate the new worktree initially.

It is built atop 1eb07d8 (worktree: add: auto-vivify new branch when
<branch> is omitted, 2015-07-06), currently in 'next', which is
es/worktree-add except for the final patch (which retires
--ignore-other-worktrees) since the intention[3] was to drop that patch.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/273415
[2]: http://thread.gmane.org/gmane.comp.version-control.git/273415/focus=273454
[3]: http://thread.gmane.org/gmane.comp.version-control.git/273415/focus=273585

Eric Sunshine (16):
  checkout: avoid resolving HEAD unnecessarily
  checkout: name check_linked_checkouts() more meaningfully
  checkout: improve die_if_checked_out() robustness
  checkout: die_if_checked_out: simplify strbuf management
  checkout: generalize die_if_checked_out() branch name argument
  branch: publish die_if_checked_out()
  worktree: simplify new branch (-b/-B) option checking
  worktree: introduce options container
  worktree: make --detach mutually exclusive with -b/-B
  worktree: make branch creation distinct from worktree population
  worktree: add_worktree: construct worktree-population command locally
  worktree: detect branch symref/detach and error conditions locally
  worktree: make setup of new HEAD distinct from worktree population
  worktree: avoid resolving HEAD unnecessarily
  worktree: populate via "git reset --hard" rather than "git checkout"
  checkout: drop intimate knowledge of new worktree initial population

 branch.c           |  65 +++++++++++++++++++++++++++++++
 branch.h           |   7 ++++
 builtin/checkout.c |  82 +++------------------------------------
 builtin/worktree.c | 110 +++++++++++++++++++++++++++++++++++------------------
 4 files changed, 151 insertions(+), 113 deletions(-)

-- 
2.5.0.rc1.201.ga12d9f8
