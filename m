From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/4] vcs-svn: make buffer_copy_bytes return length read
Date: Tue, 28 Dec 2010 04:49:36 -0600
Message-ID: <20101228104936.GC13360@burratino>
References: <20101228104503.GA5422@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 11:50:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXX8e-0002vF-0A
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 11:50:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318Ab0L1KuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 05:50:03 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61648 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753192Ab0L1Kt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 05:49:59 -0500
Received: by gyb11 with SMTP id 11so3729329gyb.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 02:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=my2/h+aooJCwYYBFwcoTlENy9bEpK5JqOZ73l62cbH0=;
        b=RZU9hm3beyXGcZgq7YE8NC1vQhX6qirVxWoVGpd9hRnSPIKq4PPM5YjF9iO6heAY78
         PJ5q+QCf6M6OQX0LI4ULgieJgPYbEWMdrFw1pcFgIl1K3p7SLwMyIqsSQ4g8R3bH14w7
         9NRgf0CgmU8teiTGmaqKMV3R73/k+xunLuFLE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=udkjlAWYfnyob+9SHQ19FuKg08vPXM/6EuzlIpSPcI+kX/30oLiIK1mlM5FXZTQ10U
         nix2d9PcDJAhbjTV+yxfjRsBCikPkch88hh6yOfZAf4XgU9a/ex+W8zW4Bjiw+jy78Fn
         ju2P518UGsWvsAn9TII1WfX3kUY9Sf/Aa0rSY=
Received: by 10.236.105.240 with SMTP id k76mr11120413yhg.96.1293533398482;
        Tue, 28 Dec 2010 02:49:58 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id z23sm3413727yhc.24.2010.12.28.02.49.56
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 02:49:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101228104503.GA5422@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164237>

Currently buffer_copy_bytes does not report to its caller whether
it encountered an early end of file.

Add a return value representing the number of bytes read (but not
the number of bytes copied).  This way all three unusual conditions
can be distinguished: input error with buffer_ferror, output error
with ferror(outfile), input error or early end of input by checking
the return value.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Intuitive?

 vcs-svn/line_buffer.c |   18 +++++++++---------
 vcs-svn/line_buffer.h |    3 ++-
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index 58e076f..36f177c 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -71,19 +71,19 @@ char *buffer_read_string(uint32_t len)
 	return ferror(infile) ? NULL : s;
 }
 
-void buffer_copy_bytes(uint32_t len)
+uint32_t buffer_copy_bytes(uint32_t nbytes)
 {
-	uint32_t in;
-	while (len > 0 && !feof(infile) && !ferror(infile)) {
-		in = len < COPY_BUFFER_LEN ? len : COPY_BUFFER_LEN;
+	uint32_t done = 0;
+	while (done < nbytes && !feof(infile) && !ferror(infile)) {
+		uint32_t len = nbytes - done;
+		uint32_t in = len < COPY_BUFFER_LEN ? len : COPY_BUFFER_LEN;
 		in = fread(byte_buffer, 1, in, infile);
-		len -= in;
+		done += in;
 		fwrite(byte_buffer, 1, in, stdout);
-		if (ferror(stdout)) {
-			buffer_skip_bytes(len);
-			return;
-		}
+		if (ferror(stdout))
+			return done + buffer_skip_bytes(nbytes - done);
 	}
+	return done;
 }
 
 uint32_t buffer_skip_bytes(uint32_t nbytes)
diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
index b9dd929..7766636 100644
--- a/vcs-svn/line_buffer.h
+++ b/vcs-svn/line_buffer.h
@@ -6,7 +6,8 @@ int buffer_deinit(void);
 int buffer_ferror(void);
 char *buffer_read_line(void);
 char *buffer_read_string(uint32_t len);
-void buffer_copy_bytes(uint32_t len);
+/* Returns number of bytes read (not necessarily written). */
+uint32_t buffer_copy_bytes(uint32_t len);
 uint32_t buffer_skip_bytes(uint32_t len);
 void buffer_reset(void);
 
-- 
1.7.2.3.554.gc9b5c.dirty
