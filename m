From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 01/15] vcs-svn: Check for errors from open()
Date: Fri, 19 Nov 2010 18:46:06 -0600
Message-ID: <20101120004606.GB17445@burratino>
References: <20101118050023.GA14861@burratino>
 <20101120004525.GA17445@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 20 01:47:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJbbY-00089x-5G
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 01:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755303Ab0KTAqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 19:46:55 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:47667 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754715Ab0KTAqy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 19:46:54 -0500
Received: by gxk23 with SMTP id 23so3101237gxk.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 16:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=0TzuAZ21T4CDDI8/04KXNf3kcKAkpUKSOxyOYj4bi5g=;
        b=OuZY+Mp9sDhp1HE169lPQGaDeCftzFTgmHjNCX2eecY8VvWVXm8tlMJ23+rer4bDn8
         zTes8uxFB+7Q6ATDarNmiAZZEO2yTkOBkO8sEbv6IfkeeVOZg9gc8hSWR8BIzCxYN/Xw
         GObGd2TnOe0aeNFZWOHelyQyPUjqnBth2KwKY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Bgx7W21kVhOC3HDpB2Krnm50+9DBBrK8JpO5LN1W/+J+DQHEm2Q2J8oA1GkCkecjhr
         BbG44nvBOflDZNve3c7XXSwYxcK1saFi/abieqnaN9iWUTRKjyr5/5Wfi247YiWbxlI3
         zOnMvGFk3jF8qE4jjbwa4c5QuPbKa6R9ej+aA=
Received: by 10.100.13.19 with SMTP id 19mr1938296anm.129.1290214014156;
        Fri, 19 Nov 2010 16:46:54 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id c39sm2440048anc.21.2010.11.19.16.46.52
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 19 Nov 2010 16:46:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101120004525.GA17445@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161801>

test-svn-fe segfaults when passed a bogus path.  Simplify debugging by
exiting with a meaningful error message instead.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Doesn't belong in this series, just something I noticed while
debugging.

 contrib/svn-fe/svn-fe.c |    3 ++-
 test-svn-fe.c           |    3 ++-
 vcs-svn/svndump.c       |    6 ++++--
 vcs-svn/svndump.h       |    2 +-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/contrib/svn-fe/svn-fe.c b/contrib/svn-fe/svn-fe.c
index a2677b0..35db24f 100644
--- a/contrib/svn-fe/svn-fe.c
+++ b/contrib/svn-fe/svn-fe.c
@@ -8,7 +8,8 @@
 
 int main(int argc, char **argv)
 {
-	svndump_init(NULL);
+	if (svndump_init(NULL))
+		return 1;
 	svndump_read((argc > 1) ? argv[1] : NULL);
 	svndump_deinit();
 	svndump_reset();
diff --git a/test-svn-fe.c b/test-svn-fe.c
index 77cf78a..b42ba78 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -9,7 +9,8 @@ int main(int argc, char *argv[])
 {
 	if (argc != 2)
 		usage("test-svn-fe <file>");
-	svndump_init(argv[1]);
+	if (svndump_init(argv[1]))
+		return 1;
 	svndump_read(NULL);
 	svndump_deinit();
 	svndump_reset();
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 6b64c1b..db11851 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -290,14 +290,16 @@ void svndump_read(const char *url)
 		handle_revision();
 }
 
-void svndump_init(const char *filename)
+int svndump_init(const char *filename)
 {
-	buffer_init(filename);
+	if (buffer_init(filename))
+		return error("cannot open %s: %s", filename, strerror(errno));
 	repo_init();
 	reset_dump_ctx(~0);
 	reset_rev_ctx(0);
 	reset_node_ctx(NULL);
 	init_keys();
+	return 0;
 }
 
 void svndump_deinit(void)
diff --git a/vcs-svn/svndump.h b/vcs-svn/svndump.h
index 93c412f..df9ceb0 100644
--- a/vcs-svn/svndump.h
+++ b/vcs-svn/svndump.h
@@ -1,7 +1,7 @@
 #ifndef SVNDUMP_H_
 #define SVNDUMP_H_
 
-void svndump_init(const char *filename);
+int svndump_init(const char *filename);
 void svndump_read(const char *url);
 void svndump_deinit(void);
 void svndump_reset(void);
-- 
1.7.2.3
