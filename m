From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/9] vcs-svn: drop no-op reset methods
Date: Fri, 6 Jul 2012 12:13:19 -0500
Message-ID: <20120706171319.GB31001@burratino>
References: <7v62b4ksw2.fsf@alter.siamese.dyndns.org>
 <CAFfmPPOWZz8JF_BVKvnAVp0VUDzxPiVSqjG7ATPx3CVztDF=cw@mail.gmail.com>
 <20120607003904.GB4065@burratino>
 <7vtxynk81p.fsf@alter.siamese.dyndns.org>
 <20120706171040.GA31001@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Michael Barr <davidbarr@google.com>,
	Florian Achleitner <florian.achleitner2.6.31@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 19:13:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnC5y-0004qP-A8
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 19:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757587Ab2GFRNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 13:13:25 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:39041 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757567Ab2GFRNY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 13:13:24 -0400
Received: by ghrr11 with SMTP id r11so8835508ghr.19
        for <git@vger.kernel.org>; Fri, 06 Jul 2012 10:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8Qw/K7cbIAWcpocchaeLXLslxZMVvyVXz4BcY08aKf4=;
        b=VJqLq/W4CF6kjeuC+GRLjBHoOozTouuYwTWX2HuI8ytKOvRFkBGzI8TwZktjB/ny2Q
         0oXzd6NWJsgh6nhjKlDfh2zugN1F3TDj+f92H9Plh/SwS+G1JsOhWJ9XthaXbYbn0zlC
         RtGn8repx1ZLgV11Si+at3G2/lCd6KmLIfxJB9mD2yBcn0xegYqPPf3g2fSnKfPYIu21
         oJDH6+yTyl0Uz2ywNubSUtk6DPrGuajmZDcQz+qXi9bMLhUzPA5yjQorsISRKlzoTE7p
         4TA95DEqweS/tqzR0jY9ppGF/H+SzXTaB/pQuHmbHwsbvlAdZZhDuDdsMCsi0a6NqjxR
         Q/zA==
Received: by 10.42.140.4 with SMTP id i4mr9305263icu.18.1341594803844;
        Fri, 06 Jul 2012 10:13:23 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id dc7sm2809867igc.13.2012.07.06.10.13.22
        (version=SSLv3 cipher=OTHER);
        Fri, 06 Jul 2012 10:13:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120706171040.GA31001@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201125>

From: David Barr <davidbarr@google.com>
Date: Fri, 1 Jun 2012 00:41:30 +1000

Since v1.7.5~42^2~6 (vcs-svn: remove buffer_read_string)
buffer_reset() does nothing thus fast_export_reset() also.

Signed-off-by: David Barr <davidbarr@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Incorporates fixes from $gmane/198955.  No other changes.

 test-line-buffer.c    |    1 -
 test-svn-fe.c         |    2 --
 vcs-svn/fast_export.c |    5 -----
 vcs-svn/fast_export.h |    1 -
 vcs-svn/line_buffer.c |    4 ----
 vcs-svn/line_buffer.h |    1 -
 vcs-svn/svndump.c     |    2 --
 7 files changed, 16 deletions(-)

diff --git a/test-line-buffer.c b/test-line-buffer.c
index 7ec9b13c..ef1d7bae 100644
--- a/test-line-buffer.c
+++ b/test-line-buffer.c
@@ -87,6 +87,5 @@ int main(int argc, char *argv[])
 		die("input error");
 	if (ferror(stdout))
 		die("output error");
-	buffer_reset(&stdin_buf);
 	return 0;
 }
diff --git a/test-svn-fe.c b/test-svn-fe.c
index 332a5f71..83633a21 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -31,9 +31,7 @@ static int apply_delta(int argc, char *argv[])
 		die_errno("cannot close preimage");
 	if (buffer_deinit(&delta))
 		die_errno("cannot close delta");
-	buffer_reset(&preimage);
 	strbuf_release(&preimage_view.buf);
-	buffer_reset(&delta);
 	return 0;
 }
 
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index b823b851..b4be91cc 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -42,11 +42,6 @@ void fast_export_deinit(void)
 		die_errno("error closing fast-import feedback stream");
 }
 
-void fast_export_reset(void)
-{
-	buffer_reset(&report_buffer);
-}
-
 void fast_export_delete(const char *path)
 {
 	putchar('D');
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
index aa629f54..8823aca1 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -6,7 +6,6 @@ struct line_buffer;
 
 void fast_export_init(int fd);
 void fast_export_deinit(void);
-void fast_export_reset(void);
 
 void fast_export_delete(const char *path);
 void fast_export_modify(const char *path, uint32_t mode, const char *dataref);
diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index 01fcb842..57cc1cec 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -124,7 +124,3 @@ off_t buffer_skip_bytes(struct line_buffer *buf, off_t nbytes)
 	}
 	return done;
 }
-
-void buffer_reset(struct line_buffer *buf)
-{
-}
diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
index 8901f214..ee23b4f4 100644
--- a/vcs-svn/line_buffer.h
+++ b/vcs-svn/line_buffer.h
@@ -14,7 +14,6 @@ struct line_buffer {
 int buffer_init(struct line_buffer *buf, const char *filename);
 int buffer_fdinit(struct line_buffer *buf, int fd);
 int buffer_deinit(struct line_buffer *buf);
-void buffer_reset(struct line_buffer *buf);
 
 int buffer_tmpfile_init(struct line_buffer *buf);
 FILE *buffer_tmpfile_rewind(struct line_buffer *buf);	/* prepare to write. */
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 644fdc71..f6c0d4c8 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -499,8 +499,6 @@ void svndump_deinit(void)
 
 void svndump_reset(void)
 {
-	fast_export_reset();
-	buffer_reset(&input);
 	strbuf_release(&dump_ctx.uuid);
 	strbuf_release(&dump_ctx.url);
 	strbuf_release(&rev_ctx.log);
-- 
1.7.10.4
