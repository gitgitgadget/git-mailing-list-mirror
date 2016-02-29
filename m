From: Moritz Neeb <lists@moritzneeb.de>
Subject: [PATCH v4 5/7] notes copy --stdin: split lines with
 string_list_split()
Date: Mon, 29 Feb 2016 09:36:27 +0100
Message-ID: <56D4030B.8000303@moritzneeb.de>
References: <56D401C2.8020100@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 29 09:38:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaJLj-0003pn-KS
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 09:38:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574AbcB2Iia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 03:38:30 -0500
Received: from moritzneeb.de ([78.47.1.106]:39568 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752507AbcB2IiX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 03:38:23 -0500
Received: from [192.168.1.3] (x4db4d1fb.dyn.telefonica.de [77.180.209.251])
	by moritzneeb.de (Postfix) with ESMTPSA id 612161C117;
	Mon, 29 Feb 2016 09:38:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456735102;
	bh=GJfp4luzB32GUG5pWawnOHWf+MfXAIBMUdje/Stz3NU=;
	h=From:Subject:To:References:Cc:Date:In-Reply-To:From;
	b=vS6aF09K0+jI+Goet2tPWcHgahvUnSaGLDsizOFJJIdqRSv+ep8PwiJex8WBGwsj+
	 oqFKVkoD4GdviRe53O89arD8M9zaQhId/Z5zJco6jy3FjWCZ4Fo1JuERBQ1eWYusJq
	 9lVuK+gzVuA8z//wA7Z9tivztaX/qjovbnNc5dKY=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <56D401C2.8020100@moritzneeb.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287811>

strbuf_split() has the unfortunate behavior of leaving the
separator character on the end of the split components, thus
placing the burden of manually removing the separator on the
caller. It's also heavyweight in that each split component is a
full-on strbuf. We need neither feature of strbuf_split() so
let's use string_list_split() instead since it removes the
separator character and returns an array of simple NUL-terminated
strings.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
---
 builtin/notes.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 706ec11..715fade 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -292,17 +292,16 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 
 	while (strbuf_getline(&buf, stdin) != EOF) {
 		unsigned char from_obj[20], to_obj[20];
-		struct strbuf **split;
+		struct string_list split = STRING_LIST_INIT_DUP;
 		int err;
 
-		split = strbuf_split(&buf, ' ');
-		if (!split[0] || !split[1])
+		string_list_split(&split, buf.buf, ' ', -1);
+		if (split.nr != 2)
 			die(_("Malformed input line: '%s'."), buf.buf);
-		strbuf_rtrim(split[0]);
-		if (get_sha1(split[0]->buf, from_obj))
-			die(_("Failed to resolve '%s' as a valid ref."), split[0]->buf);
-		if (get_sha1(split[1]->buf, to_obj))
-			die(_("Failed to resolve '%s' as a valid ref."), split[1]->buf);
+		if (get_sha1(split.items[0].string, from_obj))
+			die(_("Failed to resolve '%s' as a valid ref."), split.items[0].string);
+		if (get_sha1(split.items[1].string, to_obj))
+			die(_("Failed to resolve '%s' as a valid ref."), split.items[1].string);
 
 		if (rewrite_cmd)
 			err = copy_note_for_rewrite(c, from_obj, to_obj);
@@ -312,11 +311,11 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 
 		if (err) {
 			error(_("Failed to copy notes from '%s' to '%s'"),
-			      split[0]->buf, split[1]->buf);
+			      split.items[0].string, split.items[1].string);
 			ret = 1;
 		}
 
-		strbuf_list_free(split);
+		string_list_clear(&split, 0);
 	}
 
 	if (!rewrite_cmd) {
-- 
2.4.3
