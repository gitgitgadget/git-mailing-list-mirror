From: "Schalk, Ken" <ken.schalk@intel.com>
Subject: RE: [PATCH] Avoid rename/add conflict when contents are identical
Date: Wed, 1 Sep 2010 13:15:32 -0700
Message-ID: <EF9FEAB3A4B7D245B0801936B6EF4A2533DBB8@azsmsx503.amr.corp.intel.com>
References: <5C4EA6C5B30E6B45A9164CB3A26A0D326F79D9AA04@azsmsx503.amr.corp.intel.com>
	<7vd3tnmht0.fsf@alter.siamese.dyndns.org>
	<EF9FEAB3A4B7D245B0801936B6EF4A25262E13@azsmsx503.amr.corp.intel.com>
 <AANLkTik2op0_Cq13EGit17ja+zCdmbM6WXJ=rfhQMnOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 01 22:16:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oqtj8-0007Xp-PI
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 22:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754648Ab0IAUQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Sep 2010 16:16:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:35793 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753055Ab0IAUQE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Sep 2010 16:16:04 -0400
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 01 Sep 2010 13:15:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.56,305,1280732400"; 
   d="scan'208";a="833979178"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
  by fmsmga001.fm.intel.com with ESMTP; 01 Sep 2010 13:15:37 -0700
Received: from azsmsx604.amr.corp.intel.com (10.2.161.34) by
 azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server (TLS)
 id 8.2.254.0; Wed, 1 Sep 2010 13:15:36 -0700
Received: from azsmsx503.amr.corp.intel.com ([10.2.121.76]) by
 azsmsx604.amr.corp.intel.com ([10.2.161.34]) with mapi; Wed, 1 Sep 2010
 13:15:36 -0700
Thread-Topic: [PATCH] Avoid rename/add conflict when contents are identical
Thread-Index: ActGmXtlhO/RuxD6TZ+oQKm+74+9cgDeLF8g
In-Reply-To: <AANLkTik2op0_Cq13EGit17ja+zCdmbM6WXJ=rfhQMnOQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155075>

>Due to this this (and maybe all the tests) need to depend on the
>SYMLINKS prereq.

Here's a third attempt with no use of symlinks in the test:

Skip the entire rename/add conflict case if the file added on the
other branch has the same contents as the file being renamed.  This
avoids giving the user an extra copy of the same file and presenting a
conflict that is confusing and pointless.

A simple test of this case has been added in
t/t3030-merge-recursive.sh.

Signed-off-by: Ken Schalk <ken.schalk@intel.com>
---
 merge-recursive.c          |    6 ++++++
 t/t3030-merge-recursive.sh |   39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index fb6aa4a..a2fba84 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -955,6 +955,12 @@ static int process_renames(struct merge_options *o,
                                                        ren1->pair->two : NULL,
                                                        branch1 == o->branch1 ?
                                                        NULL : ren1->pair->two, 1);
+                       } else if ((dst_other.mode == ren1->pair->two->mode) &&
+                                  sha_eq(dst_other.sha1, ren1->pair->two->sha1)) {
+                               /* Added file on the other side
+                                  identical to the file being
+                                  renamed: clean merge */
+                               update_file(o, 1, ren1->pair->two->sha1, ren1->pair->two->mode, ren1_dst);
                        } else if (!sha_eq(dst_other.sha1, null_sha1)) {
                                const char *new_path;
                                clean_merge = 0;
diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index d541544..b23bd9f 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -23,6 +23,8 @@ test_expect_success 'setup 1' '
        git branch df-3 &&
        git branch remove &&
        git branch submod &&
+       git branch copy &&
+       git branch rename &&

        echo hello >>a &&
        cp a d/e &&
@@ -248,6 +250,24 @@ test_expect_success 'setup 7' '
        git commit -m "make d/ a submodule"
 '

+test_expect_success 'setup 8' '
+
+       git checkout rename &&
+       git mv a e &&
+       git add e &&
+       test_tick &&
+       git commit -m "rename a->e"
+'
+
+test_expect_success 'setup 9' '
+
+       git checkout copy &&
+       cp a e &&
+       git add e &&
+       test_tick &&
+       git commit -m "copy a->e"
+'
+
 test_expect_success 'merge-recursive simple' '

        rm -fr [abcd] &&
@@ -580,4 +600,23 @@ test_expect_failure 'merge-recursive simple w/submodule result' '
        test_cmp expected actual
 '

+test_expect_success 'merge-recursive copy vs. rename' '
+
+       git checkout -f copy &&
+       git merge rename &&
+       ( git ls-tree -r HEAD ; git ls-files -s ) >actual &&
+       (
+               echo "100644 blob $o0   b"
+               echo "100644 blob $o0   c"
+               echo "100644 blob $o0   d/e"
+               echo "100644 blob $o0   e"
+               echo "100644 $o0 0      b"
+               echo "100644 $o0 0      c"
+               echo "100644 $o0 0      d/e"
+               echo "100644 $o0 0      e"
+       ) >expected &&
+       test_cmp expected actual
+'
+
+
 test_done
--
1.7.0
