From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] t/: Replace diff [-u|-U0] with test_cmp to allow	compilation
 with old diff
Date: Wed, 23 Jul 2008 19:55:16 -0500
Message-ID: <neKEpiQ6TDrat4FtxWT_LcPGI8nmQO5Oe7HnTQHhjsnD317-ccG_yw@cipher.nrlssc.navy.mil>
References: <0GfECozN3g0ZvAESKMi76RyOVHEb2OhhwET9GWmEm7pbzYQJub50UlWpZtBa7MGn1UGb-7mzbzE@cipher.nrlssc.navy.mil> <E23rxnPh0xeYPsUuTseZ3Y6bteX3uHIcbLzTlyVPsX_N5fqcvRp1vA@cipher.nrlssc.navy.mil> <20080724001916.GP32057@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Jul 24 02:57:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLp8k-0000q2-N9
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 02:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbYGXA4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 20:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbYGXA4E
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 20:56:04 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:55424 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbYGXA4D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 20:56:03 -0400
Received: by mail.nrlssc.navy.mil id m6O0tGv5013206; Wed, 23 Jul 2008 19:55:17 -0500
In-Reply-To: <20080724001916.GP32057@genesis.frugalware.org>
X-OriginalArrivalTime: 24 Jul 2008 00:55:16.0644 (UTC) FILETIME=[F0053640:01C8ED27]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89822>

Miklos Vajna wrote:
> On Tue, Jul 22, 2008 at 04:17:43PM -0500, Brandon Casey <casey@nrlssc.navy.mil> wrote:
>>  t/t0002-gitfile.sh               |    2 +-
>>  t/t1002-read-tree-m-u-2way.sh    |   12 ++++++------
>>  t/t2201-add-update-typechange.sh |   10 +++++-----
>>  3 files changed, 12 insertions(+), 12 deletions(-)
> 
> Hmm, after applying this patch, I have:
> 
> ~/git/t$ git grep 'diff -U'
> t1002-read-tree-m-u-2way.sh:     diff -U0 M.out 4.out >4diff.out
> t1002-read-tree-m-u-2way.sh:     diff -U0 M.out 5.out >5diff.out
> t1002-read-tree-m-u-2way.sh:     diff -U0 M.out 14.out >14diff.out
> t1002-read-tree-m-u-2way.sh:     diff -U0 M.out 15.out >15diff.out
> 
> Any reason you left this out? ;-)

I have the patch below in my repo so I can run this test. (copy/pasted
and white-space corrupted since I haven't figured out how to reply to a
message and import a patch correctly using thunderbird).

As you can see I just replaced the 'diff -U0' with 'git diff -U0' and then
stripped off the git bits from the diff in the compare_change() function.

I think there is probably a better way to fix this, so I left it out.

Thinking about it now, it would have made sense to hold off on the part of
the patch I submitted which applies to t1002-read-tree-m-u-2way.sh until I
had a solution for the rest of these 'diff -U0's.

-brandon


diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2way.sh
index aa9dd58..5e40cec 100755
--- a/t/t1002-read-tree-m-u-2way.sh
+++ b/t/t1002-read-tree-m-u-2way.sh
@@ -14,6 +14,8 @@ _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 compare_change () {
        sed >current \
+           -e '1{/^diff --git /d;}' \
+           -e '2{/^index /d;}' \
            -e '/^--- /d; /^+++ /d; /^@@ /d;' \
            -e 's/^\(.[0-7][0-7][0-7][0-7][0-7][0-7]\) '"$_x40"' /\1 X /' "$1"
        test_cmp expected current
@@ -75,7 +77,7 @@ test_expect_success \
      git update-index --add yomin &&
      git read-tree -m -u $treeH $treeM &&
      git ls-files --stage >4.out || return 1
-     diff -U0 M.out 4.out >4diff.out
+     git diff -U0 --no-index M.out 4.out >4diff.out
      compare_change 4diff.out expected &&
      check_cache_at yomin clean &&
      sum bozbar frotz nitfol >actual4.sum &&
@@ -94,7 +96,7 @@ test_expect_success \
      echo yomin yomin >yomin &&
      git read-tree -m -u $treeH $treeM &&
      git ls-files --stage >5.out || return 1
-     diff -U0 M.out 5.out >5diff.out
+     git diff -U0 --no-index M.out 5.out >5diff.out
      compare_change 5diff.out expected &&
      check_cache_at yomin dirty &&
      sum bozbar frotz nitfol >actual5.sum &&
@@ -206,7 +208,7 @@ test_expect_success \
      git update-index --add nitfol &&
      git read-tree -m -u $treeH $treeM &&
      git ls-files --stage >14.out || return 1
-     diff -U0 M.out 14.out >14diff.out
+     git diff -U0 --no-index M.out 14.out >14diff.out
      compare_change 14diff.out expected &&
      sum bozbar frotz >actual14.sum &&
      grep -v nitfol M.sum > expected14.sum &&
@@ -227,7 +229,7 @@ test_expect_success \
      echo nitfol nitfol nitfol >nitfol &&
      git read-tree -m -u $treeH $treeM &&
      git ls-files --stage >15.out || return 1
-     diff -U0 M.out 15.out >15diff.out
+     git diff -U0 --no-index M.out 15.out >15diff.out
      compare_change 15diff.out expected &&
      check_cache_at nitfol dirty &&
      sum bozbar frotz >actual15.sum &&
-- 
1.5.6.2
