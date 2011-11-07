From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCHv2] blame.c: Properly initialize strbuf after calling textconv_object(),
 again
Date: Mon, 07 Nov 2011 18:33:34 +0100
Message-ID: <4EB8166E.9000703@gmail.com>
References: <4EB7FEE6.9000609@gmail.com> <20111107164946.GD27055@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 07 18:35:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNT6r-000677-Ux
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 18:35:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933040Ab1KGRfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 12:35:45 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34935 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932701Ab1KGRfp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 12:35:45 -0500
Received: by bke11 with SMTP id 11so3818619bke.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 09:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=/P5M8BRG3iMDShQU0hVfAhEEk9aA/m2DkzKGK8FUvLE=;
        b=H4h5xExEsF8/VfaB/z9/S2JSzBLmtHg/JzG41vloNWx8PIQHFI5PHE4lvc0fBJnxCH
         aBDyCwZcBxUMXfuPef3Mu0TlOWiM8eua/JJREuHuCovsUiaxgsQZvrjFna71uh9rVGcx
         XdaghVIUz3is+nxsXluR/zLrzpgi92q7NrkQM=
Received: by 10.204.14.208 with SMTP id h16mr20607319bka.2.1320687343732;
        Mon, 07 Nov 2011 09:35:43 -0800 (PST)
Received: from [130.73.68.203] (jambul.zib.de. [130.73.68.203])
        by mx.google.com with ESMTPS id z13sm14895700bkw.8.2011.11.07.09.35.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 Nov 2011 09:35:43 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20111107164946.GD27055@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185005>

2564aa4 started to initialize buf.alloc, but that should actually be one
more byte than the string length due to the trailing \0. Also, do not
modify buf.alloc out of the strbuf code. Use the existing strbuf_attach
instead.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 builtin/blame.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 86c0537..80febbe 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2096,6 +2096,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	if (!contents_from || strcmp("-", contents_from)) {
 		struct stat st;
 		const char *read_from;
+		char *buf_ptr;
 		unsigned long buf_len;
 
 		if (contents_from) {
@@ -2113,10 +2114,8 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 		switch (st.st_mode & S_IFMT) {
 		case S_IFREG:
 			if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV) &&
-			    textconv_object(read_from, mode, null_sha1, &buf.buf, &buf_len)) {
-				buf.alloc = buf_len;
-				buf.len = buf_len;
-			}
+			    textconv_object(read_from, mode, null_sha1, &buf_ptr, &buf_len))
+				strbuf_attach(&buf, buf_ptr, buf_len, buf_len + 1);
 			else if (strbuf_read_file(&buf, read_from, st.st_size) != st.st_size)
 				die_errno("cannot open or read '%s'", read_from);
 			break;
-- 
1.7.8.rc0.47.gf2c75.dirty
