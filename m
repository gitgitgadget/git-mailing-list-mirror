From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/4] vcs-svn: cap number of bytes read from sliding view
Date: Fri, 27 May 2011 06:11:00 -0500
Message-ID: <20110527111059.GC7972@elie>
References: <BANLkTi=O9AeOZTHVLbq+rKv5k-CqNGb+LQ@mail.gmail.com>
 <BANLkTinpta+a4MAr0e2YtMa1Kr1QcJmYWg@mail.gmail.com>
 <20110525235520.GA6971@elie>
 <BANLkTinBGnCKsUOXY_RD-7yNyM7XqNTsRw@mail.gmail.com>
 <20110527110828.GA7972@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Fri May 27 13:11:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPuwl-0002wf-6U
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 13:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476Ab1E0LLF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 07:11:05 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:35400 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891Ab1E0LLE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 07:11:04 -0400
Received: by yia27 with SMTP id 27so638260yia.19
        for <git@vger.kernel.org>; Fri, 27 May 2011 04:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=X/fgzOfi5EEPW8GpQub9ok5GX1xeEedL7B/CDSMMGS8=;
        b=J/zAMqCMoYh6MYuwEjduWPWbsAepKza7Dft0HatUo6e18dSLDLE3oczNI8ZEFBuuGA
         HoRuF2goVjOIBHeyCaa47gOpMfRPfylPCk1s35+E8Tcbh9rCRKtsBXsQZo2lCRN2cOic
         6zYL6IwCZAnd8fpQ8yZAh5HqZy8SY3I91Vcmw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZbOmUVecJhWdwPz5+9oyxjfB8u4HiLgFVIn4wHKbuwKTViffB/ytoib9/+40XdzFVw
         w4J5BGUoRj3t41HMoc0xu8ni9fI3a6izXziu1QSlqlfWrv8+nwgFQvFH1VO5q4RVoWeF
         fQ5Tjo7yVBfktVsYH7jmqk84+AmhgcZbtqDqw=
Received: by 10.236.77.227 with SMTP id d63mr2758728yhe.9.1306494663820;
        Fri, 27 May 2011 04:11:03 -0700 (PDT)
Received: from elie (adsl-69-209-65-98.dsl.chcgil.ameritech.net [69.209.65.98])
        by mx.google.com with ESMTPS id w70sm289694yhl.3.2011.05.27.04.11.02
        (version=SSLv3 cipher=OTHER);
        Fri, 27 May 2011 04:11:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110527110828.GA7972@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174607>

Introduce a "max_off" field in struct sliding_view, roughly speaking
representing a maximum number of bytes that can be read from "file".
More precisely, if it is set to a nonnegative integer, a call to
move_window() attempting to put the right endpoint beyond that offset
will return an error instead.  A value of -1 disables the check.

The idea is to use this when applying Subversion-format deltas to
prevent reads past the end of the preimage (which has known length).
Without such a check, corrupt deltas would cause svn-fe to block
indefinitely when data in the input pipe is exhausted.

Inspired-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 test-svn-fe.c            |    2 +-
 vcs-svn/sliding_window.c |    2 ++
 vcs-svn/sliding_window.h |    3 ++-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/test-svn-fe.c b/test-svn-fe.c
index a027626..332a5f7 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -15,7 +15,7 @@ static int apply_delta(int argc, char *argv[])
 {
 	struct line_buffer preimage = LINE_BUFFER_INIT;
 	struct line_buffer delta = LINE_BUFFER_INIT;
-	struct sliding_view preimage_view = SLIDING_VIEW_INIT(&preimage);
+	struct sliding_view preimage_view = SLIDING_VIEW_INIT(&preimage, -1);
 
 	if (argc != 5)
 		usage(test_svnfe_usage);
diff --git a/vcs-svn/sliding_window.c b/vcs-svn/sliding_window.c
index 1b8d987..1bac7a4 100644
--- a/vcs-svn/sliding_window.c
+++ b/vcs-svn/sliding_window.c
@@ -54,6 +54,8 @@ int move_window(struct sliding_view *view, off_t off, size_t width)
 		return -1;
 	if (off < view->off || off + width < view->off + view->width)
 		return error("invalid delta: window slides left");
+	if (view->max_off >= 0 && view->max_off < off + width)
+		return error("delta preimage ends early");
 
 	file_offset = view->off + view->buf.len;
 	if (off < file_offset) {
diff --git a/vcs-svn/sliding_window.h b/vcs-svn/sliding_window.h
index ed0bfdd..b43a825 100644
--- a/vcs-svn/sliding_window.h
+++ b/vcs-svn/sliding_window.h
@@ -7,10 +7,11 @@ struct sliding_view {
 	struct line_buffer *file;
 	off_t off;
 	size_t width;
+	off_t max_off;	/* -1 means unlimited */
 	struct strbuf buf;
 };
 
-#define SLIDING_VIEW_INIT(input)	{ (input), 0, 0, STRBUF_INIT }
+#define SLIDING_VIEW_INIT(input, len)	{ (input), 0, 0, (len), STRBUF_INIT }
 
 extern int move_window(struct sliding_view *view, off_t off, size_t width);
 
-- 
1.7.5.1
