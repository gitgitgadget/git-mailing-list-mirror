From: Moritz Neeb <lists@moritzneeb.de>
Subject: [PATCH v3 4/7] notes copy --stdin: split lines with
 string_list_split()
Date: Sun, 28 Feb 2016 06:13:43 +0100
Message-ID: <56D28207.6080600@moritzneeb.de>
References: <56D28092.9090209@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 28 06:15:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZthm-00036z-Pb
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 06:15:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbcB1FPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 00:15:35 -0500
Received: from moritzneeb.de ([78.47.1.106]:37009 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721AbcB1FPd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 00:15:33 -0500
Received: from [192.168.1.3] (x4db4d017.dyn.telefonica.de [77.180.208.23])
	by moritzneeb.de (Postfix) with ESMTPSA id 3DE1E1C117;
	Sun, 28 Feb 2016 06:15:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456636532;
	bh=WadgowKRmgpR1V8YGKXR4doMPR1MT1UQEyqxBKPHSlY=;
	h=From:Subject:To:References:Cc:Date:In-Reply-To:From;
	b=MrdLMD0C3b/N54w7bjuVHmYKefavSaKZaR57pYWYWfcg1JbHwlumPjzDJq2OzF6wI
	 yeuX/9FucnTrgPPVJx7gOkBsHwvprGLosFeSDdDwAm7zV6wAgigEBreOBAafJ/nIvX
	 Py35PnenuqQX6WB5VCicLdZtFwpfHF8dwtlXW2dE=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <56D28092.9090209@moritzneeb.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287744>

This patch changes, how the lines are split, when reading them from
stdin to copy the notes. The advantage of string_list_split() over
strbuf_split() is that it removes the terminator, making trimming
of the left part unneccesary.

The strbuf is now rtrimmed before splitting. This is still required
to remove potential CRs. In the next step this will then be done
implicitly by strbuf_readline(). Thus, this is a preparatory refactoring,
towards a trim-free codepath.

Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
---
 builtin/notes.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index ed6f222..22909c7 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -292,18 +292,18 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 
 	while (strbuf_getline_lf(&buf, stdin) != EOF) {
 		unsigned char from_obj[20], to_obj[20];
-		struct strbuf **split;
+		struct string_list split = STRING_LIST_INIT_DUP;
 		int err;
 
-		split = strbuf_split(&buf, ' ');
-		if (!split[0] || !split[1])
+		strbuf_rtrim(&buf);
+		string_list_split(&split, buf.buf, ' ', -1);
+
+		if (split.nr != 2)
 			die(_("Malformed input line: '%s'."), buf.buf);
-		strbuf_rtrim(split[0]);
-		strbuf_rtrim(split[1]);
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
@@ -313,11 +313,11 @@ static int notes_copy_from_stdin(int force, const char *rewrite_cmd)
 
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
