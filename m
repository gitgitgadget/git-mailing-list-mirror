From: Moritz Neeb <lists@moritzneeb.de>
Subject: [PATCH v4 2/7] bisect: read bisect paths with strbuf_getline()
Date: Mon, 29 Feb 2016 09:36:20 +0100
Message-ID: <56D40304.30205@moritzneeb.de>
References: <56D401C2.8020100@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 29 09:38:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaJLb-0003pn-E6
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 09:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752673AbcB2IiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 03:38:25 -0500
Received: from moritzneeb.de ([78.47.1.106]:39558 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752149AbcB2IiX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 03:38:23 -0500
Received: from [192.168.1.3] (x4db4d1fb.dyn.telefonica.de [77.180.209.251])
	by moritzneeb.de (Postfix) with ESMTPSA id 7F5511C113;
	Mon, 29 Feb 2016 09:38:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456735100;
	bh=BRddajVy2lJNHYgEqUys/gJrgsB1+xgmCRlxDCL1GCI=;
	h=From:Subject:To:References:Cc:Date:In-Reply-To:From;
	b=KRwvA5rs/sYot1MiWtOs9rzIotuliWU8zrbQCiEL7FkKQCRX0oxi9vU1bFaaSL57q
	 N+xZEX6OM4UxSHxydy/gVALHiJ/lxkyUpIigD4W9U7OneX4Un4IFU+5xRpcpmWANi7
	 eSx95nEAf8xJlDmKGo0/noHG0J6CZzQiiTAqBor8=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <56D401C2.8020100@moritzneeb.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287805>

The file BISECT_NAMES is written by "git rev-parse --sq-quote" via
sq_quote_argv() when starting a bisection. It can contain pathspecs
to narrow down the search. When reading it back, it should be expected that
sq_dequote_to_argv_array() is able to parse this file. In fact, the
previous commit ensures this.

As the content is of type "text", that means there is no logic expecting
CR, strbuf_getline_lf() will be replaced by strbuf_getline().

Apart from whitespace added and removed in quote.c, no other whitespaces
are expected. While it is technically possible, we have never advertised
this file to be editable by user, or encouraged them to do so. As a
consequence, the parsing of BISECT_NAMES is tightened by removing
strbuf_trim().

For the case that this file is modified nonetheless, in an invalid way
such that dequoting fails, the error message is broadened to both cases:
bad quoting and unexpected whitespace.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
---
 bisect.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/bisect.c b/bisect.c
index 7996c29..f63aa10 100644
--- a/bisect.c
+++ b/bisect.c
@@ -440,10 +440,9 @@ static void read_bisect_paths(struct argv_array *array)
 	if (!fp)
 		die_errno("Could not open file '%s'", filename);
 
-	while (strbuf_getline_lf(&str, fp) != EOF) {
-		strbuf_trim(&str);
+	while (strbuf_getline(&str, fp) != EOF) {
 		if (sq_dequote_to_argv_array(str.buf, array))
-			die("Badly quoted content in file '%s': %s",
+			die("Badly quoted content or unexpected whitespace in file '%s': %s",
 			    filename, str.buf);
 	}
 
-- 
2.4.3
