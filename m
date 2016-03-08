From: Sven Strickroth <sven@cs-ware.de>
Subject: [PATCH] Also read SQUASH_MSG if a conflict on a merge squash occurred
Date: Tue, 8 Mar 2016 05:17:54 +0100
Message-ID: <56DE5272.2080009@cs-ware.de>
References: <56DAB71E.6000509@cs-ware.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 08 05:18:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ad962-0001RR-Dc
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 05:18:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753509AbcCHESG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2016 23:18:06 -0500
Received: from srv1.79p.de ([213.239.234.118]:42848 "EHLO srv1.79p.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753455AbcCHESE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2016 23:18:04 -0500
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: from [IPv6:2003:88:6f35:100:195c:a5b2:9219:92f4] (p200300886F350100195CA5B2921992F4.dip0.t-ipconnect.de [IPv6:2003:88:6f35:100:195c:a5b2:9219:92f4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: sven@cs-ware.de)
	by srv1.79p.de (Postfix) with ESMTPSA id 498E4224474;
	Tue,  8 Mar 2016 05:17:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs-ware.de;
	s=mail2015b; t=1457410679;
	bh=5u44zI86LBp1n8+yo1qlZ3lH4K5Zj3GrNOWjUzAVlX4=;
	h=Subject:References:To:Cc:From:Date:In-Reply-To;
	b=k+/wO0aindh1cKB6pxZhC6YN6IPoFZcPFoMXKeVPOErztXlq5z6Egvf+BStLfx/tv
	 yPyf6ktRvRsHESQFTXNGwnvV5XngK981qZzyR4pVESfqOpl3qSlQUBN/xQV+9wwXfQ
	 ileb3p61D2LLNRrV+4c6uiVRrGZkLR2y0RgnTwoXoh3Te1rMlizdoFDSpPvqAIMx0E
	 pXVfMEomp7azx4te38Lep4KyTtcbmhYyEiKpEgHdWyZb8Qzj9/gEYGd6sDqydy7oax
	 GRSHsjoOwNqpCDwc60QPMSw2AW3DUCMzilXKOz2jIiWGhTY3Nqp2P/6sFTf8EFx3Gk
	 RbqCj3T9/U5vg==
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <56DAB71E.6000509@cs-ware.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288415>

After a merge --squash with a conflict the commit message did
not contain the information about the squashed commits, but
only the "# Conflicts:" information.

Signed-off-by: Sven Strickroth <sven@cs-ware.de>
---
 builtin/commit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index d054f84..0405d68 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -729,6 +729,12 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		if (strbuf_read_file(&sb, git_path_merge_msg(), 0) < 0)
 			die_errno(_("could not read MERGE_MSG"));
 		hook_arg1 = "merge";
+		/* append SQUASH_MSG here if it exists and a merge --squash was originally performed */
+		if (!stat(git_path_squash_msg(), &statbuf)) {
+			if (strbuf_read_file(&sb, git_path_squash_msg(), 0) < 0)
+				die_errno(_("could not read SQUASH_MSG"));
+			hook_arg1 = "squash";
+		}
 	} else if (!stat(git_path_squash_msg(), &statbuf)) {
 		if (strbuf_read_file(&sb, git_path_squash_msg(), 0) < 0)
 			die_errno(_("could not read SQUASH_MSG"));
-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
