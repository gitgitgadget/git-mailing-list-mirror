From: "Schalk, Ken" <ken.schalk@intel.com>
Subject: RE: [PATCH] Avoid rename/add conflict when contents are identical
Date: Fri, 27 Aug 2010 15:14:19 -0700
Message-ID: <EF9FEAB3A4B7D245B0801936B6EF4A25262E13@azsmsx503.amr.corp.intel.com>
References: <5C4EA6C5B30E6B45A9164CB3A26A0D326F79D9AA04@azsmsx503.amr.corp.intel.com>
 <7vd3tnmht0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 28 00:14:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Op7Bt-0003tZ-H4
	for gcvg-git-2@lo.gmane.org; Sat, 28 Aug 2010 00:14:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382Ab0H0WOZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Aug 2010 18:14:25 -0400
Received: from mga01.intel.com ([192.55.52.88]:41175 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752580Ab0H0WOX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Aug 2010 18:14:23 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP; 27 Aug 2010 15:14:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.56,280,1280732400"; 
   d="scan'208";a="601194244"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
  by fmsmga002.fm.intel.com with ESMTP; 27 Aug 2010 15:14:23 -0700
Received: from azsmsx503.amr.corp.intel.com ([10.2.121.76]) by
 azsmsx601.amr.corp.intel.com ([10.2.121.193]) with mapi; Fri, 27 Aug 2010
 15:14:22 -0700
Thread-Topic: [PATCH] Avoid rename/add conflict when contents are identical
Thread-Index: Acs6hXIwclu26IVDTLGpiuy+TMD5vALr3b8w
In-Reply-To: <7vd3tnmht0.fsf@alter.siamese.dyndns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154622>

>The logic seems to be clear enough.  Could you write a test script ins=
tead
>of description in the commit log message, so that future changes to th=
e
>codebase won't break this improvement?

Here's a revised patch which fixes a problem with the earlier one and i=
ncludes a test (where =C6var Bjarmason suggested it):

Skip the entire rename/add conflict case if the file added on the
other branch has the same contents as the file being renamed.  This
avoids giving the user an extra copy of the same file and presenting a
conflict that is confusing and pointless.

A simple test of this case has been added in
t/t3030-merge-recursive.sh.

Signed-off-by: Ken Schalk <ken.schalk@intel.com>
---
 merge-recursive.c          |    6 ++++++
 t/t3030-merge-recursive.sh |   40 ++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index fb6aa4a..a2fba84 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -955,6 +955,12 @@ static int process_renames(struct merge_options *o=
,
                                                        ren1->pair->two=
 : NULL,
                                                        branch1 =3D=3D =
o->branch1 ?
                                                        NULL : ren1->pa=
ir->two, 1);
+                       } else if ((dst_other.mode =3D=3D ren1->pair->t=
wo->mode) &&
+                                  sha_eq(dst_other.sha1, ren1->pair->t=
wo->sha1)) {
+                               /* Added file on the other side
+                                  identical to the file being
+                                  renamed: clean merge */
+                               update_file(o, 1, ren1->pair->two->sha1=
, ren1->pair->two->mode, ren1_dst);
                        } else if (!sha_eq(dst_other.sha1, null_sha1)) =
{
                                const char *new_path;
                                clean_merge =3D 0;
diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index d541544..6436582 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -23,6 +23,8 @@ test_expect_success 'setup 1' '
        git branch df-3 &&
        git branch remove &&
        git branch submod &&
+       git branch mv &&
+       git branch mv-ln &&

        echo hello >>a &&
        cp a d/e &&
@@ -248,6 +250,25 @@ test_expect_success 'setup 7' '
        git commit -m "make d/ a submodule"
 '

+test_expect_success 'setup 8' '
+
+       git checkout mv-ln &&
+       git mv a e &&
+       ln -s e a &&
+       git add a e &&
+       test_tick &&
+       git commit -m "rename a->e, symlink a->e"
+'
+
+test_expect_success 'setup 9' '
+
+       git checkout mv &&
+       git mv a e &&
+       git add e &&
+       test_tick &&
+       git commit -m "rename a->e"
+'
+
 test_expect_success 'merge-recursive simple' '

        rm -fr [abcd] &&
@@ -580,4 +601,23 @@ test_expect_failure 'merge-recursive simple w/subm=
odule result' '
        test_cmp expected actual
 '

+test_expect_success 'merge-recursive rename vs. rename/symlink' '
+
+       git checkout -f mv &&
+       git merge mv-ln &&
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
