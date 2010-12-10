From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 04/10] vcs-svn: make apply_delta caller retrieve preimage
Date: Fri, 10 Dec 2010 04:23:58 -0600
Message-ID: <20101210102358.GD26331@burratino>
References: <20101210102007.GA26298@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 10 11:24:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR09E-0003CD-P2
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 11:24:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754686Ab0LJKYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 05:24:16 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:48545 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754628Ab0LJKYP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 05:24:15 -0500
Received: by gyb11 with SMTP id 11so1938983gyb.19
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 02:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=U+LuMqooFKiPmnD+TPfH0VEke61MSjdQrE3kM8goqlA=;
        b=qR2DEoFaUDokiPUNEPoZh2mrQa+kcsIHwwbVKW30PlEee7Le7GEPNyvmiNqCzEMzGF
         I9tcXAU2N3ifQs21SXxOhL+5o2rIGKEgRR4M1Amm1g/kDwHYKL3rOROmwq0sJWY3fzW1
         S3Jlg3cqE0aIlPNIAlOoTKr5y5labQG/8XQoI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DHgwJHMvLVDgKUF3m4YG8WI3sARn80vOFomCQYCgilqMXZWBcx7GINjTDVZcvFFMDM
         F6a/WAQrMeFfBQmLB3MJw7tc24qiEfx/kHSO0D2/SLRQlB6A3OP/i1UvUi4pb2zysz0F
         D2LTRNOuwbCPD7fRSB4+839StxarWaIIuP73A=
Received: by 10.150.133.20 with SMTP id g20mr1114863ybd.146.1291976654792;
        Fri, 10 Dec 2010 02:24:14 -0800 (PST)
Received: from burratino (adsl-69-209-58-175.dsl.chcgil.sbcglobal.net [69.209.58.175])
        by mx.google.com with ESMTPS id l4sm323022ybj.21.2010.12.10.02.24.13
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 10 Dec 2010 02:24:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101210102007.GA26298@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163399>

The preimage argument to apply_delta is currently a mark, but some
callers might want to use a preimage named by sha1 or by revision
number and path instead.  Let the caller take care of that.

The preimage_len argument represents the length of the preimage that
will appear followed by a newline in the REPORT_FD stream, or -1 to
just use an empty preimage.  apply_delta is renamed to delta_apply so
callers that have not been updated can be detected at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
The special-cased behavior of -1 won't need to survive.

 vcs-svn/fast_export.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index daac201..4168184 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -129,25 +129,23 @@ static off_t cat_mark(uint32_t mark)
 	return length;
 }
 
-static long apply_delta(uint32_t mark, off_t len, struct line_buffer *input,
-			uint32_t old_mark, uint32_t old_mode)
+static long delta_apply(uint32_t mark, off_t len, struct line_buffer *input,
+			off_t preimage_len, uint32_t old_mode)
 {
 	long ret;
-	off_t preimage_len = 0;
 	struct view preimage = {REPORT_FILENO, 0, STRBUF_INIT};
 	FILE *out;
 
 	if (init_postimage() || !(out = buffer_tmpfile_rewind(&postimage)))
 		die("cannot open temporary file for blob retrieval");
-	if (old_mark)
-		preimage_len = cat_mark(old_mark);
 	if (old_mode == REPO_MODE_LNK) {
 		strbuf_addstr(&preimage.buf, "link ");
-		preimage_len += strlen("link ");
+		if (preimage_len >= 0)
+			preimage_len += strlen("link ");
 	}
 	if (svndiff0_apply(input, len, &preimage, out))
 		die("cannot apply delta");
-	if (old_mark) {
+	if (preimage_len >= 0) {
 		/* Read the remainder of preimage and trailing newline. */
 		if (move_window(&preimage, preimage_len, 1))
 			die("cannot seek to end of input");
@@ -180,7 +178,9 @@ void fast_export_blob_delta(uint32_t mode, uint32_t mark,
 	long postimage_len;
 	if (len > maximum_signed_value_of_type(off_t))
 		die("enormous delta");
-	postimage_len = apply_delta(mark, (off_t) len, input, old_mark, old_mode);
+	postimage_len = delta_apply(mark, (off_t) len, input,
+						old_mark ? cat_mark(old_mark) : -1,
+						old_mode);
 	if (mode == REPO_MODE_LNK) {
 		buffer_skip_bytes(&postimage, strlen("link "));
 		postimage_len -= strlen("link ");
-- 
1.7.2.4
