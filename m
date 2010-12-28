From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/4] vcs-svn: allow input errors to be detected promptly
Date: Tue, 28 Dec 2010 04:47:40 -0600
Message-ID: <20101228104740.GA13360@burratino>
References: <20101228104503.GA5422@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 11:48:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXX6C-0002Bk-Av
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 11:48:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753108Ab0L1KsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 05:48:08 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49236 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753053Ab0L1KsF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 05:48:05 -0500
Received: by yxt3 with SMTP id 3so3827081yxt.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 02:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=+/SVgBFcoKqdclCifjD2Bq07I2FfZwvst7vVgoQ7hO4=;
        b=phJT6bAWhggwetE0xevX3ER5Z/gxfC85Wjz9FaFf3V7AB/ynB/wnqkVV5wEFri0Z75
         /EEoVrbYBqbwPpMV3PaXjim+Eq/jeVuwBCjQ26nhXOZJwevDM8XlSrTObeO6lXDu2s+s
         bj8qgATWc0NswPpME1XEZnSL3uUeCAZNaXJcA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=F0FhF2IzFSBT6VDxmGjNtXO+b2lvcCvCd4sSw3ZdztOdZslqULK2mY3NSH6b3SwJDO
         9W4/MI86Owl8xMrVpKIhgKv8Vz7+MaeYjlLhct2wPW27IEVTWJPVYU3E5GE77jER/PZF
         NIIilBY04EFSBhXjUv/VMGAtc/zqbIqdDgB+0=
Received: by 10.100.141.16 with SMTP id o16mr7447506and.71.1293533283782;
        Tue, 28 Dec 2010 02:48:03 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id 2sm18874504anw.18.2010.12.28.02.48.01
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 02:48:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101228104503.GA5422@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164235>

Date: Sun, 10 Oct 2010 21:51:21 -0500

The line_buffer library silently flags input errors until
buffer_deinit time; unfortunately, by that point usually errno is
invalid.  Expose the error flag so callers can check for and
report errors early for easy debugging.

	some_error_prone_operation(...);
	if (buffer_ferror())
		return error("input error: %s", strerror(errno));

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Has been in use for a while, but still I'd be interested to know
if this is sane.

 vcs-svn/line_buffer.c |    5 +++++
 vcs-svn/line_buffer.h |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index 1543567..1b5ac8a 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -35,6 +35,11 @@ int buffer_deinit(void)
 	return err;
 }
 
+int buffer_ferror(void)
+{
+	return ferror(infile);
+}
+
 /* Read a line without trailing newline. */
 char *buffer_read_line(void)
 {
diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
index 9c78ae1..5a19873 100644
--- a/vcs-svn/line_buffer.h
+++ b/vcs-svn/line_buffer.h
@@ -3,6 +3,7 @@
 
 int buffer_init(const char *filename);
 int buffer_deinit(void);
+int buffer_ferror(void);
 char *buffer_read_line(void);
 char *buffer_read_string(uint32_t len);
 void buffer_copy_bytes(uint32_t len);
-- 
1.7.2.3.554.gc9b5c.dirty
