Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA015F9EC
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 16:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753978061; cv=none; b=gGFNgveoZcoxIohh0mb+ABiUbDtQNVv3AJJcQYKeCSGPcYVlf8mxFp9/h4E+V/llWEha9YbLKE/iSGycK1Vkp9ZtNAzYIFAsqhzp1CImDeZXDtj67EtnawKGqGVbJhsWCInWmX1sig5/dS/8DGa7h6wrpUk77OvNYvgNVOwK8gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753978061; c=relaxed/simple;
	bh=yUKZGnjPr9MWB9A6Rukzub4guRUIL2DPdEIdS3AeEbw=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=SjT6ygetT1udxIyk+GgLZnWhlk7e4G6Y63To/N9MOpnR/p89P+R3yD2VSttzVoYp/FPV2wSw8THa9twldycGyfAcvcPA/mW07eG512YIxyTB398udpd0kETd6lxEtpnYn0V87A8d/pmFF3i8bcaDN82F1n1hKezibBIC2lZvkB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4btDWD4NBrzRpKJ;
	Thu, 31 Jul 2025 18:07:36 +0200 (CEST)
Message-ID: <2295f183-038c-4751-b04d-0f1819b67b3a@kdbg.org>
Date: Thu, 31 Jul 2025 18:07:36 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
To: Git Mailing List <git@vger.kernel.org>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] interactive: do strip trailing CRLF from input
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

`git reset -p file` on a Windows CMD refuses to do anything useful
with this error message:

    (1/5) Unstage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? n
    'nly one letter is expected, got 'n

The letter 'O' at the beginning of the line is overwritten by an
apostrophe, so, clearly the parser sees the string "n\r".

strbuf_trim_trailing_newline() removes trailing CRLF from the string.
In particular, it first removes LF if present, and if that was the
case, it also removes CR if present.

git_read_line_interactively() clearly intends to remove CRLF as it
calls strbuf_trim_trailing_newline(). However, input is gathered using
strbuf_getline_lf(), which already removes the trailing LF. Now
strbuf_trim_trailing_newline() does not see LF, so that it does not
remove CR, either, and leaves it for the caller to process.

Call strbuf_getline() instead, which removes both LF and CR.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 prompt.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/prompt.c b/prompt.c
index f21c5bf1c7..706fba2a50 100644
--- a/prompt.c
+++ b/prompt.c
@@ -77,12 +77,6 @@ char *git_prompt(const char *prompt, int flags)
 
 int git_read_line_interactively(struct strbuf *line)
 {
-	int ret;
-
 	fflush(stdout);
-	ret = strbuf_getline_lf(line, stdin);
-	if (ret != EOF)
-		strbuf_trim_trailing_newline(line);
-
-	return ret;
+	return strbuf_getline(line, stdin);
 }
-- 
2.50.1.665.g4c0a7305c7
