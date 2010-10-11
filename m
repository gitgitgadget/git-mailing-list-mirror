From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 08/16] vcs-svn: Let callers peek ahead to find stream end
Date: Sun, 10 Oct 2010 21:47:54 -0500
Message-ID: <20101011024754.GH1553@burratino>
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
X-From: git-owner@vger.kernel.org Mon Oct 11 04:51:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P58Tr-0003Qc-7d
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 04:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953Ab0JKCvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 22:51:10 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:57216 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937Ab0JKCvI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 22:51:08 -0400
Received: by gyg13 with SMTP id 13so608068gyg.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 19:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=USiRofWuVAdWEPkQRDOuPiVKIZFGmml659NVON1wAaA=;
        b=tvKCrrKUaXUHcJt0iM13wNYJS8NfCt5Cdk4qxQ2RIBRz3BWuMWR/wEAydZ85g40N29
         YyCdn2wqpksJFiIC0faX6Inei6PXOy2b0XoY+2qKKypvGXK3RrdQKR25YKWtwm4713vJ
         xBjjfTcC3CBjz071upvGaUw1gEIJooOL534Fs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MwKfgulsogvWbxyKwmLv9n5ybnFwI6XcuonPujtTEM79IblS6b3w++2VizTcEsT5PP
         IonD6/UlBWQ7cEadIEO5jEKRWog70XNfxaie5ZliMEMEDwriUG1EuoUmjkK8KZ4mw++0
         +i0Tl8+A2EawPIqmtY3TIhCXwWoZpDpyNt37I=
Received: by 10.236.95.47 with SMTP id o35mr10578585yhf.99.1286765468269;
        Sun, 10 Oct 2010 19:51:08 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id u30sm523258yhc.29.2010.10.10.19.51.07
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 19:51:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101011023435.GA706@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158738>

The buffer_at_eof() function returns 1 if and only if all input from
the input stream has been exhausted (because of EOF or error).  The
implementation calls fgetc() followed by ungetc() to force an EOF
condition when there is no more input remaining.

Like many functions in the line_buffer API, this function is not
thread-safe.  It could be made to be so with a mutex if needed.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/line_buffer.c |   10 ++++++++++
 vcs-svn/line_buffer.h |    1 +
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index 6dd0189..19caa21 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -27,6 +27,16 @@ int buffer_deinit(struct line_buffer *buf)
 	return err;
 }
 
+int buffer_at_eof(struct line_buffer *buf)
+{
+	int ch;
+	if ((ch = fgetc(buf->infile)) == EOF)
+		return 1;
+	if (ungetc(ch, buf->infile) == EOF)
+		return error("cannot unget %c: %s\n", ch, strerror(errno));
+	return 0;
+}
+
 /* Read a line without trailing newline. */
 char *buffer_read_line(struct line_buffer *buf)
 {
diff --git a/vcs-svn/line_buffer.h b/vcs-svn/line_buffer.h
index 873b0e4..0269aed 100644
--- a/vcs-svn/line_buffer.h
+++ b/vcs-svn/line_buffer.h
@@ -14,6 +14,7 @@ struct line_buffer {
 
 int buffer_init(struct line_buffer *buf, const char *filename);
 int buffer_deinit(struct line_buffer *buf);
+int buffer_at_eof(struct line_buffer *buf);
 char *buffer_read_line(struct line_buffer *buf);
 char *buffer_read_string(struct line_buffer *buf, uint32_t len);
 void buffer_read_binary(struct strbuf *sb, uint32_t len, struct line_buffer *f);
-- 
1.7.2.3
