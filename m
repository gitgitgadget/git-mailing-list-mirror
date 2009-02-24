From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 11/23] builtin-remote: rename variable and eliminate redundant function call
Date: Tue, 24 Feb 2009 04:50:59 -0500
Message-ID: <c2de944b2fc5315c2d0f88cb16ad8b17033329a7.1235467368.git.jaysoffian@gmail.com>
References: <cover.1235467368.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 10:55:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbtzx-0002Ej-RK
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 10:54:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754671AbZBXJvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 04:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753917AbZBXJvr
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 04:51:47 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:15777 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754541AbZBXJvm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 04:51:42 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1005621yxm.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 01:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=IeZ7wmYBX15Fdu+qALeRG+PLCO4sngup21tcJWnDyso=;
        b=xk3/uT4bKUSEQpZq1pBbzeu6gHjFqKDu+/MmHaUeAXpBrdlxPw0FVGfMvSKYadCQZ+
         0eKoGEVhSRgRah2MfFy97zz6ScwhWWLVzshFxsB8i5Les1zBEpnnxjIsLGR71N83+nCX
         NJnd2U9B6lvGdbVWlcNH+jkjSuqFtguqyfuNU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=JNbnQmPGQgiyqgdO6+LMY4Z9VPq/9jDs+ilXRiNaNqQpxIvUfJeXpQ6Iif/HLTVvYc
         b8o+qBOtg064JZ5S/RqT+feop+OnPcUJm1cps3o+iZ1SpOoKUnJBZFa9C/0fCnGEC0Ut
         VQ/cjlYNFGsl7Tl6EuOKCzwkqg84JF64Ev4HI=
Received: by 10.100.140.15 with SMTP id n15mr5519484and.17.1235469101153;
        Tue, 24 Feb 2009 01:51:41 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id b29sm6390719ana.11.2009.02.24.01.51.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 01:51:40 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235467368.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111267>

The variable name "remote" is used as both a "char *" and as a "struct
remote *"; this is confusing, so rename the former to remote_name.

There is no need to call "sort_string_list(&branch_list)" as branch_list
is populated via string_list_insert(), which maintains its order.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin-remote.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 608c0f3..48d668e 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -144,7 +144,7 @@ static int add(int argc, const char **argv)
 }
 
 struct branch_info {
-	char *remote;
+	char *remote_name;
 	struct string_list merge;
 };
 
@@ -183,9 +183,9 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 			item->util = xcalloc(sizeof(struct branch_info), 1);
 		info = item->util;
 		if (type == REMOTE) {
-			if (info->remote)
+			if (info->remote_name)
 				warning("more than one branch.%s", key);
-			info->remote = xstrdup(value);
+			info->remote_name = xstrdup(value);
 		} else {
 			char *space = strchr(value, ' ');
 			value = abbrev_branch(value);
@@ -207,7 +207,6 @@ static void read_branches(void)
 	if (branch_list.nr)
 		return;
 	git_config(config_read_branches, NULL);
-	sort_string_list(&branch_list);
 }
 
 struct ref_states {
@@ -489,7 +488,7 @@ static int mv(int argc, const char **argv)
 	for (i = 0; i < branch_list.nr; i++) {
 		struct string_list_item *item = branch_list.items + i;
 		struct branch_info *info = item->util;
-		if (info->remote && !strcmp(info->remote, rename.old)) {
+		if (info->remote_name && !strcmp(info->remote_name, rename.old)) {
 			strbuf_reset(&buf);
 			strbuf_addf(&buf, "branch.%s.remote", item->string);
 			if (git_config_set(buf.buf, rename.new)) {
@@ -599,7 +598,7 @@ static int rm(int argc, const char **argv)
 	for (i = 0; i < branch_list.nr; i++) {
 		struct string_list_item *item = branch_list.items + i;
 		struct branch_info *info = item->util;
-		if (info->remote && !strcmp(info->remote, remote->name)) {
+		if (info->remote_name && !strcmp(info->remote_name, remote->name)) {
 			const char *keys[] = { "remote", "merge", NULL }, **k;
 			for (k = keys; *k; k++) {
 				strbuf_reset(&buf);
@@ -742,7 +741,7 @@ static int show(int argc, const char **argv)
 			struct branch_info *info = branch->util;
 			int j;
 
-			if (!info->merge.nr || strcmp(*argv, info->remote))
+			if (!info->merge.nr || strcmp(*argv, info->remote_name))
 				continue;
 			printf("  Remote branch%s merged with 'git pull' "
 				"while on branch %s\n   ",
-- 
1.6.2.rc1.291.g83eb
