From: Moritz Neeb <lists@moritzneeb.de>
Subject: [PATCH v3 5/7] notes copy --stdin: read lines with strbuf_getline()
Date: Sun, 28 Feb 2016 06:13:53 +0100
Message-ID: <56D28211.5060101@moritzneeb.de>
References: <56D28092.9090209@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 28 06:15:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZthx-0003CP-1w
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 06:15:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbcB1FPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 00:15:39 -0500
Received: from moritzneeb.de ([78.47.1.106]:37012 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750798AbcB1FPe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 00:15:34 -0500
Received: from [192.168.1.3] (x4db4d017.dyn.telefonica.de [77.180.208.23])
	by moritzneeb.de (Postfix) with ESMTPSA id 30E8D1C119;
	Sun, 28 Feb 2016 06:15:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456636533;
	bh=tcfoe29PQuHk9V3fPCxAZOKPJVJJTyLX6+7e/qVk3EA=;
	h=From:Subject:To:References:Cc:Date:In-Reply-To:From;
	b=ZWiaPqQJtr8vWcutrmc6B7O/sz/YbUEC3Q0ME/o5HZvemz92KRVzs7kllEe1ssCg3
	 Azo2WDoq3OUDHRJzRBqo0Ff7KWx7gIu+98C0DwvjWliRFkKdTRZzem0zn+GWuxnksM
	 kYp+FJMnow+Z2D4AhAfaXW0iAXaxwTmlnSU1Nb4E=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <56D28092.9090209@moritzneeb.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287749>

The format of a line that is expected when copying notes via stdin
is "sha1 sha1". As this is text-only, strbuf_getline() can be used
instead of strbuf_getline_lf().

When reading with strbuf_getline() the trimming can be removed.
It was necessary before to remove potential CRs inserted through
a dos editor.

Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
---
 builtin/notes.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 22909c7..660c0b7 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -290,12 +290,11 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 		t = &default_notes_tree;
 	}
 
-	while (strbuf_getline_lf(&buf, stdin) != EOF) {
+	while (strbuf_getline(&buf, stdin) != EOF) {
 		unsigned char from_obj[20], to_obj[20];
 		struct string_list split = STRING_LIST_INIT_DUP;
 		int err;
 
-		strbuf_rtrim(&buf);
 		string_list_split(&split, buf.buf, ' ', -1);
 
 		if (split.nr != 2)
-- 
2.4.3
