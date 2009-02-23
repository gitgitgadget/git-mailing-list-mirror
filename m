From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 01/13] remote: rename variable and eliminate redundant function call
Date: Mon, 23 Feb 2009 01:28:49 -0500
Message-ID: <3d0d9b7fe0d4f7c52a0790fedba0da8f37b70720.1235368324.git.jaysoffian@gmail.com>
References: <cover.1235368324.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 23 07:31:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbULJ-00072Y-Ma
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 07:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbZBWG3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 01:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751847AbZBWG3L
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 01:29:11 -0500
Received: from yw-out-2324.google.com ([74.125.46.29]:65371 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbZBWG3J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 01:29:09 -0500
Received: by yw-out-2324.google.com with SMTP id 5so749063ywh.1
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 22:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=EoJVYzPWGy2ye3WiTdEwEtnXtMtxdwQ9bkpKziGneAA=;
        b=iZ/xFT+gEx5V6Ahio9F0sBYslFbDUBtNKDVY1nF2+uGOVcFK9Nhj4Esb59oawbvbpw
         zznR/W+lpCTmTG/5etreXS4WpspeDMbW5PZgOueX+2jF1rgWNNpF5iU86q49QFPu2Gka
         ISJYRf4Wx4TjJ8YpfSpIYgokNerSwSbfphbPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=KwwvdiaAiurxdsdmVyE7ET8w358elZKk6hKDHPXW82cn+yExUtPh1pMXIGyqUgATOP
         6rPCDIKOLoRh6CMHjIqY0f+YVMfI1hu6KEmfo/kYEIJ3XqaQJwZaDQ5fF/KJwhQtPWrx
         oL1zNep30yB824hsLZyDxQNTRZZOoMZNn/Grk=
Received: by 10.100.120.19 with SMTP id s19mr3478294anc.149.1235370547770;
        Sun, 22 Feb 2009 22:29:07 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id d38sm7231129and.49.2009.02.22.22.29.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 22 Feb 2009 22:29:07 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.223.gfed32
In-Reply-To: <cover.1235368324.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111092>

The variable name "remote" is used as both a "char *" and as a "struct
remote *"; this is confusing, so rename the former to remote_name.

There is no need to call "sort_string_list(&branch_list)" as branch_list
is populated via string_list_insert(), which maintains its order.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 builtin-remote.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index d6958d4..1603219 100644
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
@@ -490,7 +489,7 @@ static int mv(int argc, const char **argv)
 	for (i = 0; i < branch_list.nr; i++) {
 		struct string_list_item *item = branch_list.items + i;
 		struct branch_info *info = item->util;
-		if (info->remote && !strcmp(info->remote, rename.old)) {
+		if (info->remote_name && !strcmp(info->remote_name, rename.old)) {
 			strbuf_reset(&buf);
 			strbuf_addf(&buf, "branch.%s.remote", item->string);
 			if (git_config_set(buf.buf, rename.new)) {
@@ -600,7 +599,7 @@ static int rm(int argc, const char **argv)
 	for (i = 0; i < branch_list.nr; i++) {
 		struct string_list_item *item = branch_list.items + i;
 		struct branch_info *info = item->util;
-		if (info->remote && !strcmp(info->remote, remote->name)) {
+		if (info->remote_name && !strcmp(info->remote_name, remote->name)) {
 			const char *keys[] = { "remote", "merge", NULL }, **k;
 			for (k = keys; *k; k++) {
 				strbuf_reset(&buf);
@@ -743,7 +742,7 @@ static int show(int argc, const char **argv)
 			struct branch_info *info = branch->util;
 			int j;
 
-			if (!info->merge.nr || strcmp(*argv, info->remote))
+			if (!info->merge.nr || strcmp(*argv, info->remote_name))
 				continue;
 			printf("  Remote branch%s merged with 'git pull' "
 				"while on branch %s\n   ",
-- 
1.6.2.rc1.223.gfed32
