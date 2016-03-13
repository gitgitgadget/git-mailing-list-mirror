From: Sven Strickroth <sven@cs-ware.de>
Subject: [PATCH] commit: do not lose SQUASH_MSG contents
Date: Sun, 13 Mar 2016 19:39:53 +0100
Message-ID: <56E5B3F9.6070404@cs-ware.de>
References: <56DAB71E.6000509@cs-ware.de> <56DE5272.2080009@cs-ware.de>
 <xmqq60wwlt0s.fsf@gitster.mtv.corp.google.com>
 <xmqqfuvzil3y.fsf@gitster.mtv.corp.google.com>
 <xmqqziu7h01f.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 13 19:40:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afAw0-0001x9-HP
	for gcvg-git-2@plane.gmane.org; Sun, 13 Mar 2016 19:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639AbcCMSkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Mar 2016 14:40:08 -0400
Received: from srv1.79p.de ([213.239.234.118]:57308 "EHLO srv1.79p.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752589AbcCMSkG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Mar 2016 14:40:06 -0400
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: from [IPv6:2003:88:6f3c:2000:7d0a:1ba9:ec79:ce58] (p200300886F3C20007D0A1BA9EC79CE58.dip0.t-ipconnect.de [IPv6:2003:88:6f3c:2000:7d0a:1ba9:ec79:ce58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: sven@cs-ware.de)
	by srv1.79p.de (Postfix) with ESMTPSA id BCF2A224476;
	Sun, 13 Mar 2016 19:39:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs-ware.de;
	s=mail2015b; t=1457894399;
	bh=LES0K4MAPZBH0lCwWi22S8ZuCBNcXV1Get1VSrb8t98=;
	h=Subject:To:References:From:Date:In-Reply-To;
	b=o6Rh9WYwrE7JFZl32mI3z7WapEVtTudU6KS77f8iMRpiTYcXIKhZ6sB0wU+KLcYTW
	 NSvYCt0oViq7TmQcMtU9R702hYIe43n9g24CIbYAkYwv+eOC2Be1a8ifFJ1J8vFoDG
	 2wbnj65Pys1eP0Gh0+kOc0NuclcKKUUQ0ajc1b3gOoopDHx6YbtOib5pAXjB5Yeilf
	 bhjRDjZtWkSyOD98eJAJDoV903oqaLIES69df+qr2s87b/w1mR8t2Rh5tCN+S+HZz+
	 chzbiAbMkeQ82RHPrAVCLdArMdt39z/2YoJJ+3ZzfARox7hRZvwcEzxFjRKtGNiDUf
	 fC3MdQkAHD9Hg==
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <xmqqziu7h01f.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288759>

When concluding a conflicted "git merge --squash", the command
failed to read SQUASH_MSG that was prepared by "git merge", and
showed only the "# Conflicts:" list of conflicted paths.

Place the contents from SQUASH_MSG at the beginning, just like we
show the commit log skeleton first when concluding a normal merge,
and then show the "# Conflicts:" list, to help the user write the
log message for the resulting commit.

Signed-off-by: Sven Strickroth <sven@cs-ware.de>
---
 builtin/commit.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d054f84..d40b788 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -726,9 +726,18 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				      &sb, &ctx);
 		hook_arg1 = "message";
 	} else if (!stat(git_path_merge_msg(), &statbuf)) {
+		/*
+		 * prepend SQUASH_MSG here if it exists and a
+		 * "merge --squash" was originally performed
+		*/
+		if (!stat(git_path_squash_msg(), &statbuf)) {
+			if (strbuf_read_file(&sb, git_path_squash_msg(), 0) < 0)
+				die_errno(_("could not read SQUASH_MSG"));
+			hook_arg1 = "squash";
+		} else
+			hook_arg1 = "merge";
 		if (strbuf_read_file(&sb, git_path_merge_msg(), 0) < 0)
 			die_errno(_("could not read MERGE_MSG"));
-		hook_arg1 = "merge";
 	} else if (!stat(git_path_squash_msg(), &statbuf)) {
 		if (strbuf_read_file(&sb, git_path_squash_msg(), 0) < 0)
 			die_errno(_("could not read SQUASH_MSG"));
-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
