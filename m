From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: [PATCH v2 6/6] Support case folding in git fast-import when
 core.ignorecase=true
Date: Sat, 02 Oct 2010 22:32:57 -0600
Message-ID: <20101003043257.1960.60639.stgit@SlamDunk>
References: <20101003043221.1960.73178.stgit@SlamDunk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: j6t@kdbg.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 06:33:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2GG9-0005lr-4B
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 06:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617Ab0JCEdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 00:33:00 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:49493 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224Ab0JCEdA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 00:33:00 -0400
Received: (qmail 1480 invoked by uid 399); 2 Oct 2010 22:32:55 -0600
Received: from unknown (HELO ?192.168.56.1?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 2 Oct 2010 22:32:55 -0600
X-Originating-IP: 76.27.116.215
In-Reply-To: <20101003043221.1960.73178.stgit@SlamDunk>
User-Agent: StGit/0.15-60-g0641
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157825>

When core.ignorecase=true, imported file paths will be folded to match
existing directory case.

Signed-off-by: Joshua Jensen <jjensen@workspacewhiz.com>
---
 fast-import.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 2317b0f..e214048 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -156,6 +156,7 @@ Format of STDIN stream:
 #include "csum-file.h"
 #include "quote.h"
 #include "exec_cmd.h"
+#include "dir.h"
 
 #define PACK_ID_BITS 16
 #define MAX_PACK_ID ((1<<PACK_ID_BITS)-1)
@@ -1461,7 +1462,7 @@ static int tree_content_set(
 
 	for (i = 0; i < t->entry_count; i++) {
 		e = t->entries[i];
-		if (e->name->str_len == n && !strncmp(p, e->name->str_dat, n)) {
+		if (e->name->str_len == n && !strncmp_icase(p, e->name->str_dat, n)) {
 			if (!slash1) {
 				if (!S_ISDIR(mode)
 						&& e->versions[1].mode == mode
@@ -1527,7 +1528,7 @@ static int tree_content_remove(
 
 	for (i = 0; i < t->entry_count; i++) {
 		e = t->entries[i];
-		if (e->name->str_len == n && !strncmp(p, e->name->str_dat, n)) {
+		if (e->name->str_len == n && !strncmp_icase(p, e->name->str_dat, n)) {
 			if (slash1 && !S_ISDIR(e->versions[1].mode))
 				/*
 				 * If p names a file in some subdirectory, and a
@@ -1585,7 +1586,7 @@ static int tree_content_get(
 
 	for (i = 0; i < t->entry_count; i++) {
 		e = t->entries[i];
-		if (e->name->str_len == n && !strncmp(p, e->name->str_dat, n)) {
+		if (e->name->str_len == n && !strncmp_icase(p, e->name->str_dat, n)) {
 			if (!slash1) {
 				memcpy(leaf, e, sizeof(*leaf));
 				if (e->tree && is_null_sha1(e->versions[1].sha1))
