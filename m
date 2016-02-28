From: Moritz Neeb <lists@moritzneeb.de>
Subject: [PATCH v3 7/7] wt-status: read rebase todolist with strbuf_getline()
Date: Sun, 28 Feb 2016 06:14:12 +0100
Message-ID: <56D28224.9010005@moritzneeb.de>
References: <56D28092.9090209@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 28 06:15:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZtho-00036z-Hp
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 06:15:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbcB1FPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 00:15:41 -0500
Received: from moritzneeb.de ([78.47.1.106]:37012 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721AbcB1FPg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 00:15:36 -0500
Received: from [192.168.1.3] (x4db4d017.dyn.telefonica.de [77.180.208.23])
	by moritzneeb.de (Postfix) with ESMTPSA id 2A4961C0B1;
	Sun, 28 Feb 2016 06:15:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456636535;
	bh=BcCGR8iDtulbKDAvjCNqhv3jf6af3ExBGwdgKsMIxwI=;
	h=From:Subject:To:References:Cc:Date:In-Reply-To:From;
	b=eldVuUHEsr9G6k8i7Kwjq+18RsS/ql/EmXi/RMue7VvWbESw9CRYCamTIh7O4dqeW
	 bFWxBpqWxiaWQHtPiO3OZjYk94P2Q93RP3/FPfQcH5r32FoVtkTA+ivifWWZRTaLMT
	 s+iKQ69hBpKB/o4ENXVhVqEZYFm/mf/aDFE+Vfhk=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <56D28092.9090209@moritzneeb.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287745>

In read_rebase_todolist() the files $GIT_DIR/rebase-merge/done and
$GIT_DIR/rebase-merge/git-rebase-todo are read to collect status
information.

The access to this file should always happen via git rebase, e.g. via
"git rebase -i" or "git rebase --edit-todo". We can assume, that this
interface handles the preprocessing of whitespaces, especially CRLFs
correctly. Thus in this codepath we can remove the call to strbuf_trim().

For documenting the input as expecting "text" input, strbuf_getline_lf()
is still replaced by strbuf_getline().

Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
---
 wt-status.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index ab4f80d..8047cf2 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1076,10 +1076,9 @@ static void read_rebase_todolist(const char *fname, struct string_list *lines)
 	if (!f)
 		die_errno("Could not open file %s for reading",
 			  git_path("%s", fname));
-	while (!strbuf_getline_lf(&line, f)) {
+	while (!strbuf_getline(&line, f)) {
 		if (line.len && line.buf[0] == comment_line_char)
 			continue;
-		strbuf_trim(&line);
 		if (!line.len)
 			continue;
 		abbrev_sha1_in_line(&line);
-- 
2.4.3
