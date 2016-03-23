From: Xiaolong Ye <xiaolong.ye@intel.com>
Subject: [PATCH v2 0/4] Add an option to git-format-patch to record base tree info
Date: Wed, 23 Mar 2016 16:52:23 +0800
Message-ID: <1458723147-7335-1-git-send-email-xiaolong.ye@intel.com>
Cc: fengguang.wu@intel.com, ying.huang@intel.com, philip.li@intel.com,
	julie.du@intel.com, Xiaolong Ye <xiaolong.ye@intel.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 09:53:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aieXX-0006m8-Qk
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 09:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754205AbcCWIxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 04:53:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:13327 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754032AbcCWIxN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 04:53:13 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP; 23 Mar 2016 01:53:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,381,1455004800"; 
   d="scan'208";a="939795295"
Received: from yexl-desktop.sh.intel.com ([10.239.159.26])
  by orsmga002.jf.intel.com with ESMTP; 23 Mar 2016 01:53:11 -0700
X-Mailer: git-send-email 2.6.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289603>

This is a re-roll of 

   http://article.gmane.org/gmane.comp.version-control.git/286873

It is almost a rewrite of v1, Changes include:

 - Make commit_patch_id() a publib helper function, so it can be available to other modules.

 - The new option "--base" will not only record the base commit id(a public well-known commit),
   but also the prerequisite patches's patch ids, then the 0day test robot could get these info,
   thus to checkout the well-known base tree-ish, apply the prerequisite patches and then the
   patches being send can be applied to correct tree to be evaluated. (0day catches every patch
   series to LKML and maintains a patch-id => commit-id database for in-flight patches.)

 - For developers' convenience, we propose a new format.base configuration to track the base commit
   automatically, if current branch the developer work on has its remote-tracking branch,
   the base commit would be the tip commit of the remote branch, if current branch is not tracked
   with any remote branch(eg. checkout by a local branch or a commit), thus its upstream could not
   be obtained, it will just record the parent commit-id of the patch series, as well as patch-id for
   reference.

   so here is the text UI:

   1) for the cases that exact base commit could be obtained(eithor from manual input --base=<base-commit-id>
	   or from upstream if base=auto is set) 

	 ** base-commit-info **
	 base-commit: ab5d01a29eb7380ceab070f0807c2939849c44bc
	 prerequisite-patch-id: 61400f965fdc0c2fbe8ad9cb5316c3efe6e05c14
	 prerequisite-patch-id: 063a398ef398647d8d839e6f9090d38ea9e0551c

   2) for cases that exact base commit is failed to obtained
	
	 ** parent-commit-info **
	 parent-commit: ab5d01a29eb7380ceab070f0807c2939849c44bc
	 parent-patch-id: caf2dae24db5b4c49a6c4134dd6d9908e898424b

Thanks for fengguang and junio's suggestions and prototype of implementation.

Thanks,
Xiaolong.

Xiaolong Ye (4):
  patch-ids: make commit_patch_id() a public helper function
  format-patch: add '--base' option to record base tree info
  format-patch: introduce --base=auto option
  format-patch: introduce format.base configuration

 Documentation/git-format-patch.txt |  20 ++++++
 builtin/log.c                      | 137 +++++++++++++++++++++++++++++++++++++
 patch-ids.c                        |   2 +-
 patch-ids.h                        |   2 +
 4 files changed, 160 insertions(+), 1 deletion(-)

-- 
2.8.0.rc4.4.ga41a987

** base-commit-info **
base-commit: 808ecd4cca75acac5e4868f15d3e647fc73698d3
