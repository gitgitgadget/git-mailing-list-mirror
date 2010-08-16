From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 6/6] Support case folding in git fast-import when core.ignorecase=true
Date: Mon, 16 Aug 2010 21:38:14 +0200
Message-ID: <8cc8aeccf7fb9af6a67487a55cfacb19c9910ecd.1281985411.git.j6t@kdbg.org>
References: <cover.1281985411.git.j6t@kdbg.org>
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 16 21:39:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ol5Wo-0007Pw-H4
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 21:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188Ab0HPTif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Aug 2010 15:38:35 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:59118 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932185Ab0HPTie (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Aug 2010 15:38:34 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id B05F02C400F;
	Mon, 16 Aug 2010 21:38:33 +0200 (CEST)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 4B72519F7CF;
	Mon, 16 Aug 2010 21:38:33 +0200 (CEST)
X-Mailer: git-send-email 1.7.1.402.gf1eeb
In-Reply-To: <cover.1281985411.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153671>

From: Joshua Jensen <jjensen@workspacewhiz.com>

When core.ignorecase=true, imported file paths will be folded to match
existing directory case.

Signed-off-by: Joshua Jensen <jjensen@workspacewhiz.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 fast-import.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 1e5d66e..82df00e 100644
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
 			if (!slash1 || !S_ISDIR(e->versions[1].mode))
 				goto del_entry;
 			if (!e->tree)
@@ -1577,7 +1578,7 @@ static int tree_content_get(
 
 	for (i = 0; i < t->entry_count; i++) {
 		e = t->entries[i];
-		if (e->name->str_len == n && !strncmp(p, e->name->str_dat, n)) {
+		if (e->name->str_len == n && !strncmp_icase(p, e->name->str_dat, n)) {
 			if (!slash1) {
 				memcpy(leaf, e, sizeof(*leaf));
 				if (e->tree && is_null_sha1(e->versions[1].sha1))
-- 
1.7.1.402.gf1eeb
