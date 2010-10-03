From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC v3 8/8] Support case folding in git fast-import when core.ignorecase=true
Date: Sun,  3 Oct 2010 09:56:46 +0000
Message-ID: <1286099806-25774-9-git-send-email-avarab@gmail.com>
References: <4CA847D5.4000903@workspacewhiz.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Johannes Sixt <j6t@kdbg.org>, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 11:58:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2LKg-0005Kx-2W
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 11:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558Ab0JCJ5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 05:57:38 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38286 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752898Ab0JCJ5g (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 05:57:36 -0400
Received: by wyb28 with SMTP id 28so4122070wyb.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 02:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=mS9tUtihVgVdsttnE+m7/auH0NVMdkyCflwe+c6PMV8=;
        b=hufyku011P4U5iUSgP30gwh8L8/F70kv+GmQsnazPPNV9yPF0tvw6OXV+kqEye8+xr
         0qE9rni52k8ukH24esel3ygWoFJThWeJnaKjJhqKuasIHLl5pE3fQMncCwkpZHRiRVyF
         un5pmxQQy7B3AtE7Xfm7K6qgdpQ9H6Sm7dKX4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=xY6Ww3w9Blo8SaxHBhwQpjmmeEyipP25+F1MEB2hGj6OIUcS9K2G6f5O1FJN4rmwK3
         X/Cvwk2IBgIB2S52sZklcHgsYa4lO1nz74qxgYjRVLLEfAzVEHB+0qK+0olNgNq23Bx9
         CIQbEI7iLZtey+sbA8BKyXrinxtGTSuhmd6wY=
Received: by 10.227.135.71 with SMTP id m7mr6959037wbt.11.1286099855327;
        Sun, 03 Oct 2010 02:57:35 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id h29sm2968435wbc.9.2010.10.03.02.57.34
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 02:57:34 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.159.g610493
In-Reply-To: <4CA847D5.4000903@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157858>

From: Joshua Jensen <jjensen@workspacewhiz.com>

When core.ignorecase=true, imported file paths will be folded to match
existing directory case.

Signed-off-by: Joshua Jensen <jjensen@workspacewhiz.com>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
-- 
1.7.3.159.g610493
