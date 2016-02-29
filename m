From: Moritz Neeb <lists@moritzneeb.de>
Subject: [PATCH v4 4/7] notes copy --stdin: read lines with strbuf_getline()
Date: Mon, 29 Feb 2016 09:36:36 +0100
Message-ID: <56D40314.7040608@moritzneeb.de>
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
	id 1aaJLj-0003pn-1g
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 09:38:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752726AbcB2Iib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 03:38:31 -0500
Received: from moritzneeb.de ([78.47.1.106]:39564 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752149AbcB2Ii0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 03:38:26 -0500
Received: from [192.168.1.3] (x4db4d1fb.dyn.telefonica.de [77.180.209.251])
	by moritzneeb.de (Postfix) with ESMTPSA id 362F11C045;
	Mon, 29 Feb 2016 09:38:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456735105;
	bh=arKfElWwlaoEsuwKVoJVeWxoIh1lsxc3fkAVI2sUr7o=;
	h=From:Subject:To:References:Cc:Date:In-Reply-To:From;
	b=dx8739NraiFUS4k5k7z13AaCVFi4MO9edSlBaIKUn9MerFu0Q+wy2040aPAzYH4b2
	 NktZYBbmrtjIxnX3B2iSchlHqlvRXFWtzY1hnl6n2QPsBJBqbnL4RVSXsHVM4hzvTN
	 5AfkcwQHpnj8gmGMC7VqguJr3+6PHW6x9StKOlO8=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <56D401C2.8020100@moritzneeb.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287807>

The format of a line that is expected when copying notes via stdin
is "sha1 sha1". As this is text-only, strbuf_getline() should be used
instead of strbuf_getline_lf(), as documentation of this fact.

When reading with strbuf_getline() the trimming of split[1] can be
removed.  It was necessary before to remove potential CRs inserted
through a dos editor.

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
2.4.3
