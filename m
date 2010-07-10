From: "Pickens, James E" <james.e.pickens@intel.com>
Subject: [BUG] 'diff A...B' fails with multiple merge bases
Date: Fri, 9 Jul 2010 18:15:45 -0700
Message-ID: <3BA20DF9B35F384F8B7395B001EC3FB36CF674AE@azsmsx507.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 10 03:16:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXOfr-00008e-5r
	for gcvg-git-2@lo.gmane.org; Sat, 10 Jul 2010 03:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566Ab0GJBPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 21:15:55 -0400
Received: from mga09.intel.com ([134.134.136.24]:33960 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186Ab0GJBPy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jul 2010 21:15:54 -0400
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP; 09 Jul 2010 18:15:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.55,176,1278313200"; 
   d="scan'208";a="637122995"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
  by orsmga001.jf.intel.com with ESMTP; 09 Jul 2010 18:15:49 -0700
Received: from azsmsx001.amr.corp.intel.com (10.2.167.98) by
 azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server (TLS)
 id 8.2.176.0; Fri, 9 Jul 2010 18:15:47 -0700
Received: from azsmsx507.amr.corp.intel.com ([10.2.121.87]) by
 azsmsx001.amr.corp.intel.com ([10.2.167.98]) with mapi; Fri, 9 Jul 2010
 18:15:47 -0700
Thread-Topic: [BUG] 'diff A...B' fails with multiple merge bases
Thread-Index: AcsfzWxysTcQHrW6TDOKP/yJJ4K9hg==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150705>

Hi,

The command 'git diff A...B' is supposed to be equivalent to 'git diff $(git
merge-base A B) B'.  But when there are multiple merge bases between A and B,
the former gives no output.  Here's a recipe to reproduce the problem:

    git init
    git commit --allow-empty -m 1
    git checkout -b A
    touch file1
    git add file1
    git commit -m A
    git checkout master
    touch file2
    git add file2
    git commit -m B
    git checkout -b B
    git merge A
    git checkout A
    git merge master
    git diff A...B
    git diff $(git merge-base A B) B

The diff commands at the end will give different results.  It bisects to:

commit b75271d93a9e4be960d53fc4f955802530e0e733
Author: Matt McCutchen <matt@mattmccutchen.net>
Date:   Fri Oct 10 21:56:15 2008 -0400

    "git diff <tree>{3,}": do not reverse order of arguments

    According to the message of commit 0fe7c1de16f71312e6adac4b85bddf0d62a47168,
    "git diff" with three or more trees expects the merged tree first followed by
    the parents, in order.  However, this command reversed the order of its
    arguments, resulting in confusing diffs.  A comment /* Again, the revs are all
    reverse */ suggested there was a reason for this, but I can't figure out the
    reason, so I removed the reversal of the arguments.  Test case included.


I verified that if I revert that commit, 'diff A...B' works as expected, but
test t4013-diff-various.sh fails.  The failing command is 'git diff master
master^ side'.  I don't understand what that command is supposed to do, so I
didn't go any further.

Am I right that this is a bug, and if so can someone help to address it?

James
