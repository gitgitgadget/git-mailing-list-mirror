From: Moritz Neeb <lists@moritzneeb.de>
Subject: [PATCH v3 2/7] bisect: read bisect paths with strbuf_getline()
Date: Sun, 28 Feb 2016 06:13:33 +0100
Message-ID: <56D281FD.1070707@moritzneeb.de>
References: <56D28092.9090209@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 28 06:15:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZthm-00036z-6q
	for gcvg-git-2@plane.gmane.org; Sun, 28 Feb 2016 06:15:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbcB1FPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2016 00:15:33 -0500
Received: from moritzneeb.de ([78.47.1.106]:36998 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721AbcB1FPb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2016 00:15:31 -0500
Received: from [192.168.1.3] (x4db4d017.dyn.telefonica.de [77.180.208.23])
	by moritzneeb.de (Postfix) with ESMTPSA id 4720C1C113;
	Sun, 28 Feb 2016 06:15:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456636530;
	bh=RxTBqAYK+XxIbz+ItVje2BXTEUYlEWciGs/7cVQzlGo=;
	h=From:Subject:To:References:Cc:Date:In-Reply-To:From;
	b=qnYtAUSmyhN2DuhkO7CXZoqpdQzVnZ1DBVHivJPlIQRWMdwZC7qr2Jglg4DYm08xh
	 hv4ckdY2j/fBO2j+6gXg9LEWPtYxChAOr9pwvgj7nLOd0KuhLSo8SEMdBU1G1PceBP
	 ep2HWsKVFZTKiuGi1Xqb4vf7fF/NNdDAMWQ1eRkI=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <56D28092.9090209@moritzneeb.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287746>

The file BISECT_NAMES is written by "git rev-parse --sq-quote" via
sq_quote_argv() when starting a bisection. It can contain pathspecs
to narrow down the search. When reading it back, it should be expected that
sq_dequote_to_argv_array() is able to parse this file. In fact, the
previous commit ensures this.

As the content is of type "text", that means there is no logic expecting
CR, strbuf_getline_lf() will be replaced by strbuf_getline().

Apart from whitespace added and removed in quote.c, no more whitespaces
are expexted. While it is technically possible, we have never advertised
this file to be editable by user, or encouraged them to do so, thus
the call to strbuf_trim() turns obsolete in various ways.

For the case that this file is modified nonetheless, in an invalid way
such that dequoting fails, the error message is broadened to both cases:
bad quoting and unexpected whitespace.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
---
 bisect.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/bisect.c b/bisect.c
index 06ec54e..e2df02f 100644
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
