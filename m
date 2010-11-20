From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 6/8] vcs-svn: Let caller set up sliding window for delta
 preimage
Date: Sat, 20 Nov 2010 13:28:45 -0600
Message-ID: <20101120192845.GG17823@burratino>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
 <20101120192153.GA17823@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 20 20:28:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJt7K-0002yk-7F
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 20:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754784Ab0KTT2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Nov 2010 14:28:54 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60333 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753Ab0KTT2x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Nov 2010 14:28:53 -0500
Received: by yxf34 with SMTP id 34so3369534yxf.19
        for <git@vger.kernel.org>; Sat, 20 Nov 2010 11:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=OrvoJJijTCS1Y5oNGxCqE80KXaKAseD0bXTeghBv5Jw=;
        b=XYTh4ZUT4LSJN+WR+0y3KLTfczCV++V5GRcw1O7oSUS8xP5haa5S4NGbwD5A72993P
         I3P35NXO/j9mRrME5fLAq0mrw2K1v52Q2WEEl7HTR6tBGXo3qY7Qim/BMvBnV8uWBqpc
         us3ZtspH7T1Q8mIA36N3FU0lXYv4LnxmYkVPY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=BsZ66W3JfSQXFdhRRvPdd4dBNXXCOoN3+DHFeas3dLorWKa31axBIQxqDz/g5RLBK4
         4hZHvcF7vSviF9aNHuJYPGpr1DUUgcYGwuNhKkFeglw627saPQ/JGoJ9htPwrtndaX56
         W6Vj9xo8kO1awiB0kF6/8duIUzO5REeLCVWBs=
Received: by 10.150.198.10 with SMTP id v10mr6083277ybf.129.1290281332783;
        Sat, 20 Nov 2010 11:28:52 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id p20sm731694ybe.5.2010.11.20.11.28.51
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 20 Nov 2010 11:28:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101120192153.GA17823@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161836>

The content of symlinks starts with the word "link " in SVN's
worldview, so we need to prepend that text the sake of delta
application.  Move responsibility for setting up the input state from
svndiff0_apply to the calling program, so programs have a chance to
seed the sliding window with text of their choice.

[jn: extracted from the patch "svn-fe: Use the --report-fd feature"]

Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
I'm a big fan of this trick.

 test-svn-fe.c     |    8 +++++---
 vcs-svn/svndiff.c |   23 ++++++++---------------
 vcs-svn/svndiff.h |    3 ++-
 3 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/test-svn-fe.c b/test-svn-fe.c
index 4ea0cd6..64f63cf 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -5,6 +5,7 @@
 #include "git-compat-util.h"
 #include "vcs-svn/svndump.h"
 #include "vcs-svn/svndiff.h"
+#include "vcs-svn/sliding_window.h"
 #include "vcs-svn/line_buffer.h"
 
 int main(int argc, char *argv[])
@@ -22,20 +23,21 @@ int main(int argc, char *argv[])
 		return 0;
 	}
 	if (argc == 5 && !strcmp(argv[1], "-d")) {
-		int preimage_fd = -1;
 		struct line_buffer delta = LINE_BUFFER_INIT;
-		preimage_fd = open(argv[2], O_RDONLY);
+		int preimage_fd = open(argv[2], O_RDONLY);
+		struct view preimage_view = {preimage_fd, 0, STRBUF_INIT};
 		if (preimage_fd < 0)
 			die_errno("cannot open preimage");
 		if (buffer_init(&delta, argv[3]))
 			die_errno("cannot open delta");
 		if (svndiff0_apply(&delta, (off_t) strtoull(argv[4], NULL, 0),
-				   preimage_fd, stdout))
+				   &preimage_view, stdout))
 			return 1;
 		if (close(preimage_fd))
 			die_errno("cannot close preimage");
 		if (buffer_deinit(&delta))
 			die_errno("cannot close delta");
+		strbuf_release(&preimage_view.buf);
 		buffer_reset(&delta);
 		return 0;
 	}
diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
index ef3a921..308c734 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -283,31 +283,24 @@ static int apply_one_window(struct line_buffer *delta, off_t *delta_len,
 }
 
 int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
-		   int preimage_fd, FILE *postimage)
+			struct view *preimage_view, FILE *postimage)
 {
-	struct view preimage_view = {preimage_fd, 0, STRBUF_INIT};
-	assert(delta && preimage_fd >= 0 && postimage);
+	assert(delta && preimage_view && postimage);
 
 	if (read_magic(delta, &delta_len))
-		goto fail;
+		return -1;
 	while (delta_len > 0) {	/* For each window: */
 		off_t pre_off = pre_off;
 		size_t pre_len;
 		if (read_offset(delta, &pre_off, &delta_len) ||
 		    read_length(delta, &pre_len, &delta_len) ||
-		    move_window(&preimage_view, pre_off, pre_len) ||
+		    move_window(preimage_view, pre_off, pre_len) ||
 		    apply_one_window(delta, &delta_len,
-				     &preimage_view, postimage))
-			goto fail;
-		if (delta_len && buffer_at_eof(delta)) {
-			error("Delta ends early! (%"PRIu64" bytes remaining)",
+				     preimage_view, postimage))
+			return -1;
+		if (delta_len && buffer_at_eof(delta))
+			return error("Delta ends early! (%"PRIu64" bytes remaining)",
 			      (uint64_t) delta_len);
-			goto fail;
-		}
 	}
-	strbuf_release(&preimage_view.buf);
 	return 0;
- fail:
-	strbuf_release(&preimage_view.buf);
-	return -1;
 }
diff --git a/vcs-svn/svndiff.h b/vcs-svn/svndiff.h
index 9003d6e..bb5afd0 100644
--- a/vcs-svn/svndiff.h
+++ b/vcs-svn/svndiff.h
@@ -2,8 +2,9 @@
 #define SVNDIFF_H_
 
 #include "line_buffer.h"
+#include "sliding_window.h"
 
 extern int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
-				int preimage_fd, FILE *postimage);
+				struct view *preimage_view, FILE *postimage);
 
 #endif
-- 
1.7.2.3
