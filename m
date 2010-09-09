From: "Schalk, Ken" <ken.schalk@intel.com>
Subject: RE: [PATCH 2/3] merge-recursive: Small code cleanup
Date: Thu, 9 Sep 2010 13:23:26 -0700
Message-ID: <EF9FEAB3A4B7D245B0801936B6EF4A25593A57@azsmsx503.amr.corp.intel.com>
References: <AANLkTimz8qSwefp137-D+vEbsf6soG51u0im9EC911_O@mail.gmail.com>
	<1283806070-22027-3-git-send-email-newren@gmail.com>
	<EF9FEAB3A4B7D245B0801936B6EF4A254B6BBD@azsmsx503.amr.corp.intel.com>
 <AANLkTim5AA7mnAhkbqJaFcUv9vniTVG7siOMxE+y=ehf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"gitster@pobox.com" <gitster@pobox.com>,
	"oinksocket@letterboxes.org" <oinksocket@letterboxes.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 10 01:58:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Otr0i-0005ci-SU
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 01:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757077Ab0IIX61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 19:58:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:24073 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754085Ab0IIX60 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Sep 2010 19:58:26 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP; 09 Sep 2010 16:58:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.56,343,1280732400"; 
   d="scan'208";a="553145217"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
  by orsmga002.jf.intel.com with ESMTP; 09 Sep 2010 16:58:24 -0700
Received: from azsmsx604.amr.corp.intel.com (10.2.161.34) by
 azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server (TLS)
 id 8.2.254.0; Thu, 9 Sep 2010 13:23:28 -0700
Received: from azsmsx503.amr.corp.intel.com ([10.2.121.76]) by
 azsmsx604.amr.corp.intel.com ([10.2.161.34]) with mapi; Thu, 9 Sep 2010
 13:23:28 -0700
Thread-Topic: [PATCH 2/3] merge-recursive: Small code cleanup
Thread-Index: ActPHnOQooFlMxj2QdqzrqmNi+E0EwBPbsBg
In-Reply-To: <AANLkTim5AA7mnAhkbqJaFcUv9vniTVG7siOMxE+y=ehf@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155911>

>Perhaps you could submit another patch changing your testcase back to
>using a symlink to make sure someone like me doesn't break your
>original testcase in the future?

Here's a patch relative to my last one.  Rather than restoring the previous test, I added it so that platforms with no symlink support can still test copy vs. rename and platforms with symlink support can also test rename vs. rename/symlink.

Signed-off-by: Ken Schalk <ken.schalk@intel.com>
---
 t/t3030-merge-recursive.sh |   36 +++++++++++++++++++++++++++++++++++-
 1 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index b23bd9f..9514ae2 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -25,6 +25,10 @@ test_expect_success 'setup 1' '
        git branch submod &&
        git branch copy &&
        git branch rename &&
+       if test_have_prereq SYMLINKS
+       then
+               git branch rename-ln
+       fi &&

        echo hello >>a &&
        cp a d/e &&
@@ -256,7 +260,17 @@ test_expect_success 'setup 8' '
        git mv a e &&
        git add e &&
        test_tick &&
-       git commit -m "rename a->e"
+       git commit -m "rename a->e" &&
+       if test_have_prereq SYMLINKS
+       then
+               git checkout rename-ln &&
+               git mv a e &&
+               ln -s e a &&
+               git add a e &&
+               test_tick &&
+               git commit -m "rename a->e, symlink a->e"
+       fi
+
 '

 test_expect_success 'setup 9' '
@@ -618,5 +632,25 @@ test_expect_success 'merge-recursive copy vs. rename' '
        test_cmp expected actual
 '

+if test_have_prereq SYMLINKS
+then
+       test_expect_success 'merge-recursive rename vs. rename/symlink' '
+
+               git checkout -f rename &&
+               git merge rename-ln &&
+               ( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+               (
+                       echo "100644 blob $o0   b"
+                       echo "100644 blob $o0   c"
+                       echo "100644 blob $o0   d/e"
+                       echo "100644 blob $o0   e"
+                       echo "100644 $o0 0      b"
+                       echo "100644 $o0 0      c"
+                       echo "100644 $o0 0      d/e"
+                       echo "100644 $o0 0      e"
+               ) >expected &&
+               test_cmp expected actual
+       '
+fi

 test_done
--
1.7.0
