From: Moritz Neeb <lists@moritzneeb.de>
Subject: [PATCH v2 4/6] notes: read copied notes with strbuf_getline()
Date: Mon, 22 Feb 2016 02:16:16 +0100
Message-ID: <56CA6160.7010908@moritzneeb.de>
References: <56CA5DBB.8040006@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 02:24:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXfEP-0006Ek-JI
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 02:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbcBVBXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 20:23:53 -0500
Received: from moritzneeb.de ([78.47.1.106]:55739 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752300AbcBVBXw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 20:23:52 -0500
Received: from [192.168.1.3] (x55b377aa.dyn.telefonica.de [85.179.119.170])
	by moritzneeb.de (Postfix) with ESMTPSA id 356A21C05B;
	Mon, 22 Feb 2016 02:23:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456104231;
	bh=lrpL+zOZcGCpHKJSwDL1AKFoCPwKgA9Dp/8C9ZKEUBw=;
	h=From:Subject:To:References:Cc:Date:In-Reply-To:From;
	b=WS7jgW3T3xZc4mVHRQZkWoHXsZmY6ORLty2Qu/gG2loHLhd6tJ4EZL1/I1y7bSX/t
	 e4gavnkhox4IivwkyTh0Gbn8n3UyAiH8Cbw0lkxdel8YACagPwodCCGkkDPa2BxrsA
	 tS7BIUBNbn4QTu2WRX5gPgFWl8Yzijy/K2I+x+cw=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <56CA5DBB.8040006@moritzneeb.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286863>

The notes are copied from stdin. They should only contain SHA1s... Not
spaces. CR could be there, because the file/the data from stdin could
have been written via an editor that adds them.

The notes that are copied from stdin are trimmed with strbuf_rtrim() after
splitting by ' '. There is thus no logic expecting CR, so strbuf_getline_lf()
can be replaced by its CRLF counterpart.

Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
---
 builtin/notes.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index ed6f222..706ec11 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -290,7 +290,7 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 		t = &default_notes_tree;
 	}
 -	while (strbuf_getline_lf(&buf, stdin) != EOF) {
+	while (strbuf_getline(&buf, stdin) != EOF) {
 		unsigned char from_obj[20], to_obj[20];
 		struct strbuf **split;
 		int err;
@@ -299,7 +299,6 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 		if (!split[0] || !split[1])
 			die(_("Malformed input line: '%s'."), buf.buf);
 		strbuf_rtrim(split[0]);
-		strbuf_rtrim(split[1]);
 		if (get_sha1(split[0]->buf, from_obj))
 			die(_("Failed to resolve '%s' as a valid ref."), split[0]->buf);
 		if (get_sha1(split[1]->buf, to_obj))
-- 
2.7.1.345.gc14003e
