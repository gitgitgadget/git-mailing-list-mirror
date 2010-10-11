From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 06/16] vcs-svn: Improve support for reading large files
Date: Sun, 10 Oct 2010 21:46:24 -0500
Message-ID: <20101011024624.GF1553@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino>
 <20100809215719.GA4203@burratino>
 <20100810125317.GB3921@kytes>
 <20101011023435.GA706@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 11 04:49:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P58SO-0002ls-D8
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 04:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916Ab0JKCtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 22:49:39 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59618 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752898Ab0JKCtj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 22:49:39 -0400
Received: by gyg13 with SMTP id 13so607838gyg.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 19:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=py9xRVEAAqm1mRmKE0FGxWVz6aEUiFcXl5OU7Mjstfw=;
        b=jUGoVpeLmK0h1W7w+9L3iPU8e48Op37AeW9Eoa9kfgb3536by4wnhODjIQwP8E29Wn
         IMwvmn+xWh3CWr6ckEE1joB29ghG583f4TmIv1ut7MO7O382mw+6WTXSIYsrP5i5MYid
         3XY0IvkB2tSE9cshhUz7Or3XbyuNkvyqUp9lE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=v+ZdFL8FpGF3fFs3+UZtSbiuNtj02iwzuVSZph5JtPn/tf4Bdq/m4bk11/bnSeiPR7
         7gnTNDHgDIifjleFnFQ0rT2zqZuT09ROH/DMfdSZo+Hzi1ji8AqJQobqhtvjECPxcwU2
         NpezQ1rSnEFvEdJZG/iIwjU+EO/WKOl7GARdY=
Received: by 10.151.38.9 with SMTP id q9mr6070897ybj.261.1286765378337;
        Sun, 10 Oct 2010 19:49:38 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id r36sm2309639yba.0.2010.10.10.19.49.37
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 19:49:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101011023435.GA706@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158736>

Tweak the line_buffer API to permit seeking and cat-ing segments
longer than 4 GiB.  This would be particularly useful for applying
deltas that remove a large segment from the middle of a file.

Callers would still have to be updated to take advantage of this.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Since off_t is a signed type, on systems with 32-bit file offsets,
this might make things worse.  Is that worth worrying about?

 vcs-svn/line_buffer.c |    8 ++++----
 vcs-svn/line_buffer.h |    4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index 999368b..fd1d3c3 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -56,7 +56,7 @@ char *buffer_read_string(struct line_buffer *buf, uint32_t len)
 	return ferror(buf->infile) ? NULL : buf->blob_buffer.buf;
 }
 
-void buffer_copy_bytes(struct line_buffer *buf, uint32_t len)
+void buffer_copy_bytes(struct line_buffer *buf, off_t len)
 {
 	char byte_buffer[COPY_BUFFER_LEN];
 	uint32_t in;
@@ -72,12 +72,12 @@ void buffer_copy_bytes(struct line_buffer *buf, uint32_t len)
 	}
 }
 
-uint32_t buffer_skip_bytes(struct line_buffer *buf, uint32_t nbytes)
+off_t buffer_skip_bytes(struct line_buffer *buf, off_t nbytes)
 {
-	uint32_t done = 0;
+	off_t done = 0;
 	while (done < nbytes && !feof(buf->infile) && !ferror(buf->infile)) {
 		char byte_buffer[COPY_BUFFER_LEN];
-		uint32_t len = nbytes - done;
+		off_t len = nbytes - done;
 		uint32_t in = len < COPY_BUFFER_LEN ? len : COPY_BUFFER_LEN;
 		done += fread(byte_buffer, 1, in, buf->infile);
 	}
diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
index 2796ba7..2849faa 100644
--- a/vcs-svn/line_buffer.h
+++ b/vcs-svn/line_buffer.h
@@ -16,8 +16,8 @@ int buffer_init(struct line_buffer *buf, const char *filename);
 int buffer_deinit(struct line_buffer *buf);
 char *buffer_read_line(struct line_buffer *buf);
 char *buffer_read_string(struct line_buffer *buf, uint32_t len);
-void buffer_copy_bytes(struct line_buffer *buf, uint32_t len);
-uint32_t buffer_skip_bytes(struct line_buffer *buf, uint32_t len);
+void buffer_copy_bytes(struct line_buffer *buf, off_t len);
+off_t buffer_skip_bytes(struct line_buffer *buf, off_t len);
 void buffer_reset(struct line_buffer *buf);
 
 #endif
-- 
1.7.2.3
