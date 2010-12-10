From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 05/10] vcs-svn: split off function to export result from
 delta application
Date: Fri, 10 Dec 2010 04:25:17 -0600
Message-ID: <20101210102517.GE26331@burratino>
References: <20101210102007.GA26298@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 10 11:25:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR0AV-0003oK-CU
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 11:25:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754628Ab0LJKZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 05:25:35 -0500
Received: from mail-gw0-f66.google.com ([74.125.83.66]:63670 "EHLO
	mail-gw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846Ab0LJKZe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 05:25:34 -0500
Received: by gwj18 with SMTP id 18so1180721gwj.1
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 02:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=wI3aEhMuOgni1kzRIJ2R9guHfhe3O2lL2cBdodZNsuY=;
        b=nU2HYzl49HtXG38fSbFWQe1MexVsVaTpJCCMbSNAuri3OaSifxfBrxlyEnhUzgZhTB
         AktPo1sIDfW95bpahn7jWnwuyDGgQQ9H8sZwN8FB7wiwxGapNsGjipFQ/e6S6AKkS2iU
         JpPFOUP3HMshcWBYCsDRF55VrYrEIasP8RXlA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PwyY6e0H+FgOjOwJ5O1FaNlsUchi1RUpc4gwc6rMNh6ZbqlbTeTXZAl4SqEfAAmGmq
         npn5JtwkdeiqOrfEfUJ8Riby9+h467YsbSGNGlrkeeWfJ1OPpkDGLI8/CKUNYsaWd3x8
         ts/FliKmxHxTB/xqAB3dhQGN36lcMJ2ngUNLw=
Received: by 10.100.237.8 with SMTP id k8mr357110anh.43.1291976733578;
        Fri, 10 Dec 2010 02:25:33 -0800 (PST)
Received: from burratino (adsl-69-209-58-175.dsl.chcgil.sbcglobal.net [69.209.58.175])
        by mx.google.com with ESMTPS id x31sm3155811ana.9.2010.12.10.02.25.31
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 10 Dec 2010 02:25:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101210102007.GA26298@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163400>

In this time of heavy experimentation, we will need multiple
fast_export_blob_delta variants.  Make this easier by factoring
out the common part.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Also not needed, except perhaps as code cleanup.

 vcs-svn/fast_export.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 4168184..960b252 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -159,6 +159,18 @@ static long delta_apply(uint32_t mark, off_t len, struct line_buffer *input,
 	return ret;
 }
 
+static void record_postimage(uint32_t mark, uint32_t mode,
+				long postimage_len)
+{
+	if (mode == REPO_MODE_LNK) {
+		buffer_skip_bytes(&postimage, strlen("link "));
+		postimage_len -= strlen("link ");
+	}
+	printf("blob\nmark :%"PRIu32"\ndata %ld\n", mark, postimage_len);
+	buffer_copy_bytes(&postimage, postimage_len);
+	fputc('\n', stdout);
+}
+
 void fast_export_blob(uint32_t mode, uint32_t mark, uint32_t len, struct line_buffer *input)
 {
 	if (mode == REPO_MODE_LNK) {
@@ -181,11 +193,5 @@ void fast_export_blob_delta(uint32_t mode, uint32_t mark,
 	postimage_len = delta_apply(mark, (off_t) len, input,
 						old_mark ? cat_mark(old_mark) : -1,
 						old_mode);
-	if (mode == REPO_MODE_LNK) {
-		buffer_skip_bytes(&postimage, strlen("link "));
-		postimage_len -= strlen("link ");
-	}
-	printf("blob\nmark :%"PRIu32"\ndata %ld\n", mark, postimage_len);
-	buffer_copy_bytes(&postimage, postimage_len);
-	fputc('\n', stdout);
+	record_postimage(mark, mode, postimage_len);
 }
-- 
1.7.2.4
