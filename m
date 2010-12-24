From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/4] vcs-svn: eliminate global byte_buffer
Date: Fri, 24 Dec 2010 02:08:53 -0600
Message-ID: <20101224080853.GB29681@burratino>
References: <20101224080505.GA29681@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 24 09:09:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PW2iG-0007gn-2T
	for gcvg-git-2@lo.gmane.org; Fri, 24 Dec 2010 09:09:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751944Ab0LXIJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Dec 2010 03:09:04 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:37384 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833Ab0LXIJD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Dec 2010 03:09:03 -0500
Received: by gxk9 with SMTP id 9so249882gxk.19
        for <git@vger.kernel.org>; Fri, 24 Dec 2010 00:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7JGf3/8P9So6cOIiOSYVJ+fq+wRx3i/guJozfLeDhkc=;
        b=X0b8o9+1KD+eVn73GgsvkQ2b4fTGsimy8yoO9LsMLOXFoe3S4RnTzBEfkrDMEhUjUb
         sigkyAXgwn95SmIcXuKO1UrqSCN1ItkBaA6jLZGsG+A+eNZ4j5LEGMqWJx6kmWWO2B4E
         q5ALQiwtTlwTFtr3KOl3vPY9k5OE/in3SRScU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Si7kTrjMSKS/EQPbjdusWpDGPge26m6bFY3w9tubmZq6ZxGcO9pFo90kdd0bTov52x
         vSo+HM5G54t4TxItvbg5oeEvy76Uht7obtPBKY74xymeqH3b/nUoFSH0BOf2uP6Mx8Tc
         mGt9r/vzAH/OQU37uHAtv1JTct8YE6OknyMLw=
Received: by 10.90.114.5 with SMTP id m5mr477216agc.25.1293178142916;
        Fri, 24 Dec 2010 00:09:02 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id x36sm13560411anx.14.2010.12.24.00.09.01
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Dec 2010 00:09:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101224080505.GA29681@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164147>

Date: Sun, 10 Oct 2010 21:37:10 -0500

The data stored in byte_buffer[] is always either discarded or
written to stdout immediately.  No need for it to persist between
function calls.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
For the line_buffer library.  Decreases BSS size.  Increase stack
overhead of two I/O functions by 4096 bytes.  Performance effect
hasn't been measured.  Alas there is no stdio wrapper for sendfile; if
there were, we could eliminate the buffer altogether.

Of course the goal is to make line_buffer more easily reusable, by
eliminating _all_ global state.  I assume David would like this but I
don't remember if he said so.

 vcs-svn/line_buffer.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index 1543567..f22c94f 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -14,7 +14,6 @@
 obj_pool_gen(blob, char, 4096)
 
 static char line_buffer[LINE_BUFFER_LEN];
-static char byte_buffer[COPY_BUFFER_LEN];
 static FILE *infile;
 
 int buffer_init(const char *filename)
@@ -68,6 +67,7 @@ char *buffer_read_string(uint32_t len)
 
 void buffer_copy_bytes(uint32_t len)
 {
+	char byte_buffer[COPY_BUFFER_LEN];
 	uint32_t in;
 	while (len > 0 && !feof(infile) && !ferror(infile)) {
 		in = len < COPY_BUFFER_LEN ? len : COPY_BUFFER_LEN;
@@ -83,6 +83,7 @@ void buffer_copy_bytes(uint32_t len)
 
 void buffer_skip_bytes(uint32_t len)
 {
+	char byte_buffer[COPY_BUFFER_LEN];
 	uint32_t in;
 	while (len > 0 && !feof(infile) && !ferror(infile)) {
 		in = len < COPY_BUFFER_LEN ? len : COPY_BUFFER_LEN;
-- 
1.7.2.3.554.gc9b5c.dirty
