From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 8/8] t1504: stop resolving symlinks in GIT_CEILING_DIRECTORIES
Date: Wed, 26 Sep 2012 21:34:50 +0200
Message-ID: <1348688090-13648-9-git-send-email-mhagger@alum.mit.edu>
References: <1348688090-13648-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 21:35:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGxOk-0004jo-0Z
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 21:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758336Ab2IZTfr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 15:35:47 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:60100 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758333Ab2IZTfo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Sep 2012 15:35:44 -0400
X-AuditID: 1207440d-b7f236d000000943-59-5063590f73a5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 2E.42.02371.F0953605; Wed, 26 Sep 2012 15:35:43 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8QJZFfm010704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 26 Sep 2012 15:35:41 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1348688090-13648-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsUixO6iqMsfmRxg8KqFx6LrSjeTRUPvFWaL
	o6csLG6vmM9ssf7dVWYHVo+/7z8weeycdZfd4+IlZY/Pm+QCWKK4bZISS8qCM9Pz9O0SuDMW
	TbvGUrBeu2LKgrcsDYxf1boYOTkkBEwkdu9rYoWwxSQu3FvP1sXIxSEkcJlR4tSWBnaQhJDA
	GSaJDa8cQWw2AV2JRT3NTCC2iICaxMS2QywgDcwCkxglejY8AGsQFvCTmPd4FiOIzSKgKvH8
	7FwWEJtXwEXi7pR3zBDbFCV+fF8DZnMKuEp82XCBDWKZi8ThV7eYJzDyLmBkWMUol5hTmqub
	m5iZU5yarFucnJiXl1qka6SXm1mil5pSuokREki8Oxj/r5M5xCjAwajEw+vpkBwgxJpYVlyZ
	e4hRkoNJSZTXOgwoxJeUn1KZkVicEV9UmpNafIhRgoNZSYT3WVZSgBBvSmJlVWpRPkxKmoNF
	SZxXbYm6n5BAemJJanZqakFqEUxWhoNDSYL3aTjQUMGi1PTUirTMnBKENBMHJ4jgAtnAA7RB
	OAKokLe4IDG3ODMdougUo6KUOO8/kAkCIImM0jy4AbCYf8UoDvSPMO8NkCoeYLqA634FNJgJ
	aPDSTSCnF5ckIqSkGhijYy62172+vuh5QNuRMjHPHr8KnvZZSr8lJ2w+663glDHLIceu/Y78
	/AaOB3fOZCxj+ZZXP9k2S/v8KzWmewcF5mzafdrkkmFiFudWzr0KWzf/Mr/QctfGt8PB3uGx
	ya/toskrkueUXEn3jF54ZqKEy7PLLCkcMurMm8J7RH84uz4zMc8UD1NiKc5INNRi 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206440>

This test used to explicitly resolve symlinks in the paths derived
from TRASH_DIRECTORY that were written to GIT_CEILING_DIRECTORIES,
because the code handling GIT_CEILING_DIRECTORIES was confused by
symlinks.  This is no longer necessary.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t1504-ceiling-dirs.sh | 67 ++++++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/t/t1504-ceiling-dirs.sh b/t/t1504-ceiling-dirs.sh
index cce87a5..a4a5202 100755
--- a/t/t1504-ceiling-dirs.sh
+++ b/t/t1504-ceiling-dirs.sh
@@ -14,8 +14,7 @@ test_fail() {
 	'
 }
 
-TRASH_ROOT="$PWD"
-ROOT_PARENT=$(dirname "$TRASH_ROOT")
+ROOT_PARENT=$(dirname "$TRASH_DIRECTORY")
 
 
 unset GIT_CEILING_DIRECTORIES
@@ -32,16 +31,16 @@ test_prefix ceil_at_parent ""
 GIT_CEILING_DIRECTORIES="$ROOT_PARENT/"
 test_prefix ceil_at_parent_slash ""
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY"
 test_prefix ceil_at_trash ""
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/"
 test_prefix ceil_at_trash_slash ""
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/sub"
 test_prefix ceil_at_sub ""
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub/"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/sub/"
 test_prefix ceil_at_sub_slash ""
 
 
@@ -56,55 +55,55 @@ export GIT_CEILING_DIRECTORIES
 GIT_CEILING_DIRECTORIES=""
 test_prefix subdir_ceil_empty "sub/dir/"
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY"
 test_fail subdir_ceil_at_trash
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/"
 test_fail subdir_ceil_at_trash_slash
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/sub"
 test_fail subdir_ceil_at_sub
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub/"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/sub/"
 test_fail subdir_ceil_at_sub_slash
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub/dir"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/sub/dir"
 test_prefix subdir_ceil_at_subdir "sub/dir/"
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub/dir/"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/sub/dir/"
 test_prefix subdir_ceil_at_subdir_slash "sub/dir/"
 
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/su"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/su"
 test_prefix subdir_ceil_at_su "sub/dir/"
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/su/"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/su/"
 test_prefix subdir_ceil_at_su_slash "sub/dir/"
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub/di"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/sub/di"
 test_prefix subdir_ceil_at_sub_di "sub/dir/"
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub/di"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/sub/di"
 test_prefix subdir_ceil_at_sub_di_slash "sub/dir/"
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/subdi"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/subdi"
 test_prefix subdir_ceil_at_subdi "sub/dir/"
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/subdi"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/subdi"
 test_prefix subdir_ceil_at_subdi_slash "sub/dir/"
 
 
-GIT_CEILING_DIRECTORIES="/foo:$TRASH_ROOT/sub"
+GIT_CEILING_DIRECTORIES="/foo:$TRASH_DIRECTORY/sub"
 test_fail second_of_two
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub:/bar"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/sub:/bar"
 test_fail first_of_two
 
-GIT_CEILING_DIRECTORIES="/foo:$TRASH_ROOT/sub:/bar"
+GIT_CEILING_DIRECTORIES="/foo:$TRASH_DIRECTORY/sub:/bar"
 test_fail second_of_three
 
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sub"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/sub"
 GIT_DIR=../../.git
 export GIT_DIR
 test_prefix git_dir_specified ""
@@ -123,41 +122,41 @@ export GIT_CEILING_DIRECTORIES
 GIT_CEILING_DIRECTORIES=""
 test_prefix sd_ceil_empty "s/d/"
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY"
 test_fail sd_ceil_at_trash
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/"
 test_fail sd_ceil_at_trash_slash
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/s"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/s"
 test_fail sd_ceil_at_s
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/s/"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/s/"
 test_fail sd_ceil_at_s_slash
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/s/d"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/s/d"
 test_prefix sd_ceil_at_sd "s/d/"
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/s/d/"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/s/d/"
 test_prefix sd_ceil_at_sd_slash "s/d/"
 
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/su"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/su"
 test_prefix sd_ceil_at_su "s/d/"
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/su/"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/su/"
 test_prefix sd_ceil_at_su_slash "s/d/"
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/s/di"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/s/di"
 test_prefix sd_ceil_at_s_di "s/d/"
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/s/di"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/s/di"
 test_prefix sd_ceil_at_s_di_slash "s/d/"
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sdi"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/sdi"
 test_prefix sd_ceil_at_sdi "s/d/"
 
-GIT_CEILING_DIRECTORIES="$TRASH_ROOT/sdi"
+GIT_CEILING_DIRECTORIES="$TRASH_DIRECTORY/sdi"
 test_prefix sd_ceil_at_sdi_slash "s/d/"
 
 
-- 
1.7.11.3
