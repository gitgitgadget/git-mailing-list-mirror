From: Stephen Boyd <sboyd@codeaurora.org>
Subject: git rev-list | git cherry-pick --stdin is leaky
Date: Mon, 29 Apr 2013 17:11:04 -0700
Message-ID: <517F0C18.8060703@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 30 02:11:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWyA4-0003r5-Uf
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 02:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758750Ab3D3ALG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 20:11:06 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:46399 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758756Ab3D3ALE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 20:11:04 -0400
X-IronPort-AV: E=Sophos;i="4.87,576,1363158000"; 
   d="scan'208";a="42742824"
Received: from pdmz-ns-snip_115.254.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.115.254])
  by wolverine02.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Apr 2013 17:11:04 -0700
Received: from [10.46.166.8] (pdmz-ns-snip_218_1.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 4112C10004BF
	for <git@vger.kernel.org>; Mon, 29 Apr 2013 17:11:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222887>

(resending since the attachment seems to make vger sad)

Hi,

I'm running git rev-list | git cherry-pick --stdin on a range of about
300 commits. Eventually the chery-pick dies with:

    error: cannot fork() for commit: Cannot allocate memory

Running valgrind shows me that the tree traversal code is leaking
gigabytes of memory (particularly unpack_callback). Since cherry-pick is
a very long running process all these allocations are never freed and
eventually I run out of memory. The worst offender and summary is:

==7986== 938,956,692 (929,961,582 direct, 8,995,110 indirect) bytes in
7,765,439 blocks are definitely lost in loss record 257 of 257
==7986==    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
==7986==    by 0x4FAF57: xcalloc (wrapper.c:119)
==7986==    by 0x4F5281: unpack_callback (unpack-trees.c:539)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==
==7986== LEAK SUMMARY:
==7986==    definitely lost: 2,514,117,692 bytes in 21,210,861 blocks
==7986==    indirectly lost: 885,481,947 bytes in 10,165,801 blocks
==7986==      possibly lost: 650,712,395 bytes in 6,014,309 blocks
==7986==    still reachable: 7,734,870 bytes in 47,794 blocks
==7986==         suppressed: 0 bytes in 0 blocks

This is against recent git.git
(89740333e8d398f1da701e9023675321bbb9a85b). A workaround is to limit the
amount of commits per cherry-pick invocation, but can we somehow fix the
leaks?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
