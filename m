From: Sven Strickroth <sven@cs-ware.de>
Subject: [PATCH] commit: do not lose SQUASH_MSG contents
Date: Tue, 8 Mar 2016 20:03:04 +0100
Message-ID: <56DF21E8.2060209@cs-ware.de>
References: <56DAB71E.6000509@cs-ware.de> <56DE5272.2080009@cs-ware.de>
 <xmqq60wwlt0s.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 20:03:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adMuq-0001tl-73
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 20:03:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbcCHTDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 14:03:14 -0500
Received: from srv1.79p.de ([213.239.234.118]:57590 "EHLO srv1.79p.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773AbcCHTDN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 14:03:13 -0500
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: from [IPv6:2003:88:6f35:100:58e:9826:6785:be88] (p200300886F350100058E98266785BE88.dip0.t-ipconnect.de [IPv6:2003:88:6f35:100:58e:9826:6785:be88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: sven@cs-ware.de)
	by srv1.79p.de (Postfix) with ESMTPSA id 8D14D224476;
	Tue,  8 Mar 2016 20:03:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs-ware.de;
	s=mail2015b; t=1457463789;
	bh=Ep2LmIr6hpfjJpEF0N4dkA8C6piBsaxMkqUkrGFRdDU=;
	h=Subject:To:References:Cc:From:Date:In-Reply-To;
	b=bTzUQlg9Mr4yfGyadM6rdG8Q+c8A0XFHrlGEWBbpVMx/RQXLLYDPnP3TM0gAB3mez
	 ankrlTeQUjvRIQGgiynNvOIkjXznUMP5ZD/HVzEHaMZ1CXWDyGmMFun9RSQv/se73G
	 Afzisnw3N52COtw1yxczRuXUfkyoMcIEaiVtaNnBPqA7wtFzNuTgFnRlezIzMQh5a+
	 rHaZ0SfIXMKl1GGwp/uJ2sJ57NIL4LauDNu4JNYRYsDcYrRKy21IKrHOQ979ZD5Nha
	 EHL8MTtCgMfrImEcX/EGANTCxzgwuJT4Hy0Gv3UcioPc9Z83CkOvluPlEsG5kQW7K+
	 zsNywa58xzyog==
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <xmqq60wwlt0s.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288450>

When concluding a conflicted "git merge --squash", the command
failed to read SQUASH_MSG that was prepared by "git merge", and
showed only the "# Conflicts:" list of conflicted paths.

Signed-off-by: Sven Strickroth <email@cs-ware.de>
---
 builtin/commit.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d054f84..0e48e1d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -725,14 +725,18 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		format_commit_message(commit, "fixup! %s\n\n",
 				      &sb, &ctx);
 		hook_arg1 = "message";
-	} else if (!stat(git_path_merge_msg(), &statbuf)) {
-		if (strbuf_read_file(&sb, git_path_merge_msg(), 0) < 0)
-			die_errno(_("could not read MERGE_MSG"));
-		hook_arg1 = "merge";
-	} else if (!stat(git_path_squash_msg(), &statbuf)) {
-		if (strbuf_read_file(&sb, git_path_squash_msg(), 0) < 0)
-			die_errno(_("could not read SQUASH_MSG"));
-		hook_arg1 = "squash";
+	} else if (!stat(git_path_squash_msg(), &statbuf) ||
+			   !stat(git_path_merge_msg(), &statbuf)) {
+		if (!stat(git_path_squash_msg(), &statbuf)) {
+			if (strbuf_read_file(&sb, git_path_squash_msg(), 0) < 0)
+				die_errno(_("could not read SQUASH_MSG"));
+			hook_arg1 = "squash";
+		} else
+			hook_arg1 = "merge";
+		if (!stat(git_path_merge_msg(), &statbuf)) {
+			if (strbuf_read_file(&sb, git_path_merge_msg(), 0) < 0)
+				die_errno(_("could not read MERGE_MSG"));
+		}
 	} else if (template_file) {
 		if (strbuf_read_file(&sb, template_file, 0) < 0)
 			die_errno(_("could not read '%s'"), template_file);
-- 
2.7.0.windows.1
