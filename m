From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/4] vcs-svn: make buffer_skip_bytes return length read
Date: Tue, 28 Dec 2010 04:48:21 -0600
Message-ID: <20101228104821.GB13360@burratino>
References: <20101228104503.GA5422@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 11:49:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXX7R-0002cO-48
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 11:49:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271Ab0L1Ksq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 05:48:46 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:59097 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753190Ab0L1Kso (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 05:48:44 -0500
Received: by gxk9 with SMTP id 9so1152833gxk.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 02:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=vE1vsUXmyL3AfQfu+naiAO99o9EcZbeAnCL7ddZoheI=;
        b=WcZCrzAWPjMykQCZv0Bk/mKyhiYJF+o1MP5Cc274WRvTGTLb1M2Cg6k9syF+hVmFi/
         8e3lH7dnkGe/SP1WVd+2ObbShv8QHiNvT7muPvB+DKTcTSqqhW+k3rvuCKQGPfVo5M6a
         2N9lvyBMcYcjro5DxsVdCKx4s2kr/YWJIH1zk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OO8d3rsyG9VxUkpgEwuJZIWMOMnOz0gMCbD5mMHwCsIM5HmCZhI9yhBOtE6NxRpYNH
         8t+1Y0nS/VMWlG6KfVapPvxpV55Df55bsflLTZ3/SljYdMuYOJOemISF3UJBOroe/L5c
         Y0ZSlVNjCj+EmR0VxEZDtymcnkty2r9FBiaZ4=
Received: by 10.151.7.11 with SMTP id k11mr3196391ybi.310.1293533323081;
        Tue, 28 Dec 2010 02:48:43 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id c4sm10856175ybn.15.2010.12.28.02.48.41
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 02:48:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101228104503.GA5422@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164236>

Date: Sun, 10 Oct 2010 21:44:21 -0500

Currently there is no way to detect when input ended if it ended
early during buffer_skip_bytes.  Tell the calling program how many
bytes were actually skipped for easier debugging.

Existing callers will still ignore early EOF.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/line_buffer.c   |   13 +++++++------
 vcs-svn/line_buffer.h   |    2 +-
 vcs-svn/line_buffer.txt |    3 ++-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index 1b5ac8a..58e076f 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -86,14 +86,15 @@ void buffer_copy_bytes(uint32_t len)
 	}
 }
 
-void buffer_skip_bytes(uint32_t len)
+uint32_t buffer_skip_bytes(uint32_t nbytes)
 {
-	uint32_t in;
-	while (len > 0 && !feof(infile) && !ferror(infile)) {
-		in = len < COPY_BUFFER_LEN ? len : COPY_BUFFER_LEN;
-		in = fread(byte_buffer, 1, in, infile);
-		len -= in;
+	uint32_t done = 0;
+	while (done < nbytes && !feof(infile) && !ferror(infile)) {
+		uint32_t len = nbytes - done;
+		uint32_t in = len < COPY_BUFFER_LEN ? len : COPY_BUFFER_LEN;
+		done += fread(byte_buffer, 1, in, infile);
 	}
+	return done;
 }
 
 void buffer_reset(void)
diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
index 5a19873..b9dd929 100644
--- a/vcs-svn/line_buffer.h
+++ b/vcs-svn/line_buffer.h
@@ -7,7 +7,7 @@ int buffer_ferror(void);
 char *buffer_read_line(void);
 char *buffer_read_string(uint32_t len);
 void buffer_copy_bytes(uint32_t len);
-void buffer_skip_bytes(uint32_t len);
+uint32_t buffer_skip_bytes(uint32_t len);
 void buffer_reset(void);
 
 #endif
diff --git a/vcs-svn/line_buffer.txt b/vcs-svn/line_buffer.txt
index 8906fb1..a08ad8a 100644
--- a/vcs-svn/line_buffer.txt
+++ b/vcs-svn/line_buffer.txt
@@ -52,7 +52,8 @@ Functions
 
 `buffer_skip_bytes`::
 	Discards `len` bytes from the input stream (stopping early
-	if necessary because of an error or eof).
+	if necessary because of an error or eof).  Return value is
+	the number of bytes successfully read.
 
 `buffer_reset`::
 	Deallocates non-static buffers.
-- 
1.7.2.3.554.gc9b5c.dirty
