From: Moritz Neeb <lists@moritzneeb.de>
Subject: [PATCH v2 2/6] bisect: read bisect paths with strbuf_getline()
Date: Mon, 22 Feb 2016 02:15:40 +0100
Message-ID: <56CA613C.1080106@moritzneeb.de>
References: <56CA5DBB.8040006@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 02:24:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXfEJ-00062t-KR
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 02:24:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605AbcBVBXy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 20:23:54 -0500
Received: from moritzneeb.de ([78.47.1.106]:55735 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752587AbcBVBXv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 20:23:51 -0500
Received: from [192.168.1.3] (x55b377aa.dyn.telefonica.de [85.179.119.170])
	by moritzneeb.de (Postfix) with ESMTPSA id D440E1C0F5;
	Mon, 22 Feb 2016 02:23:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1456104230;
	bh=oXDuv2VvuF8iotL25n8pDGtNnamuHloqUIRaKLFB7P4=;
	h=From:Subject:To:References:Cc:Date:In-Reply-To:From;
	b=G+4vMSsdpqudS6wtM641h2Smun2Ex9KeuVG75Cey24xEAn/TpfI04qB+HGLYcnFY+
	 1fNTQi5Gu7vlSmoa+bryMQmMu990LTN82bHAoWLpxMeHsrPhPI7NUK9X7jrOtQxJeh
	 YWI4JwZWa39mgz6uKsLOs/uLRD4vM34lu+lEkGYw=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <56CA5DBB.8040006@moritzneeb.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286858>

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
 -- 2.7.1.345.gc14003e
