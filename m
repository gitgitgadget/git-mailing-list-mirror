From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 03/10] vcs-svn: introduce cat_mark function to retrieve a
 marked blob
Date: Fri, 10 Dec 2010 04:23:03 -0600
Message-ID: <20101210102303.GC26331@burratino>
References: <20101210102007.GA26298@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 10 11:23:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR08L-0002ox-DX
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 11:23:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754574Ab0LJKXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 05:23:20 -0500
Received: from mail-gx0-f180.google.com ([209.85.161.180]:34210 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747Ab0LJKXU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 05:23:20 -0500
Received: by gxk19 with SMTP id 19so2129695gxk.11
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 02:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6lG1SlQh8CP3MLnfz/R+6pcW21uvO4wITdRI8PB8pUY=;
        b=BfkxSPi22t7/+6ZfELR3Ir8eN7Ca9D6pY9gVeDZPu/dpofyw1/6xOuFQIlmpDcF0Em
         quCBuVRfBcA826bnKTrWvWaCjkGXVAlN0NGs1iDyzeezHrlGKGP3/ToTg3bAKrjIylL7
         V+Wpnz/zCwlR/B2si/Vwyf2kmuKovopCn0MBo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Sm2b0Wp2DTSkgP2UW1PwdT65zp+lAnK0a+RarlKBu999/X3johK9UpsKp7ZiPuMQ9R
         P775zk65g7hgWBN/NVl0sneNidhpCVCZXUhM76lUNcOwXjQ3UQBxvS2jY3e3p1zSCrl/
         ClfOexRDmAmV/5NELt3TSS5n7zhYHGoMVVU9E=
Received: by 10.42.178.1 with SMTP id bk1mr359016icb.55.1291976599391;
        Fri, 10 Dec 2010 02:23:19 -0800 (PST)
Received: from burratino (adsl-69-209-58-175.dsl.chcgil.sbcglobal.net [69.209.58.175])
        by mx.google.com with ESMTPS id 34sm2505514ibi.2.2010.12.10.02.23.17
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 10 Dec 2010 02:23:18 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101210102007.GA26298@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163398>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
A blind alley.  But it demonstrates how this works.

 vcs-svn/fast_export.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 093ce1d..daac201 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -116,6 +116,19 @@ static const char *get_response_line(void)
 	return response_line.buf;
 }
 
+static off_t cat_mark(uint32_t mark)
+{
+	const char *response;
+	off_t length = length;
+
+	printf("cat-blob :%"PRIu32"\n", mark);
+	fflush(stdout);
+	response = get_response_line();
+	if (parse_cat_response_line(response, &length))
+		die("invalid cat-blob response: %s", response);
+	return length;
+}
+
 static long apply_delta(uint32_t mark, off_t len, struct line_buffer *input,
 			uint32_t old_mark, uint32_t old_mode)
 {
@@ -126,14 +139,8 @@ static long apply_delta(uint32_t mark, off_t len, struct line_buffer *input,
 
 	if (init_postimage() || !(out = buffer_tmpfile_rewind(&postimage)))
 		die("cannot open temporary file for blob retrieval");
-	if (old_mark) {
-		const char *response;
-		printf("cat-blob :%"PRIu32"\n", old_mark);
-		fflush(stdout);
-		response = get_response_line();
-		if (parse_cat_response_line(response, &preimage_len))
-			die("invalid cat-blob response: %s", response);
-	}
+	if (old_mark)
+		preimage_len = cat_mark(old_mark);
 	if (old_mode == REPO_MODE_LNK) {
 		strbuf_addstr(&preimage.buf, "link ");
 		preimage_len += strlen("link ");
-- 
1.7.2.4
