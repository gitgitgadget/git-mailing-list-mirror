From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/7] init: plug tiny one-time memory leak
Date: Sat, 2 Oct 2010 03:31:22 -0500
Message-ID: <20101002083122.GB29638@burratino>
References: <wes62zknmki.fsf@kanis.fr>
 <7v1va760ip.fsf@alter.siamese.dyndns.org>
 <20100810032647.GA2386@burratino>
 <20101002082752.GA29638@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ivan Kanis <expire-by-2010-08-14@kanis.fr>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>,
	David Barr <david.barr@cordelta.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 02 10:34:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1xYO-00039K-23
	for gcvg-git-2@lo.gmane.org; Sat, 02 Oct 2010 10:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796Ab0JBIec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Oct 2010 04:34:32 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63152 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507Ab0JBIeb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Oct 2010 04:34:31 -0400
Received: by iwn5 with SMTP id 5so4737630iwn.19
        for <git@vger.kernel.org>; Sat, 02 Oct 2010 01:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ymkFF6OHijYCa3svpzTDYWOBQt+egmL3nu9BQLt4l5g=;
        b=Uq2HNDsExYz9T7BCRtOZOx6V78QddGuQ5uFWd3MDwg0EMAhuHJ0Jlz4cssEfx0uQBe
         Ms33+NbEIbIEOR1DEiZl1sJXx0l6Xj+A+M8Aux8aaKRpHSMnarHoNReVnR9mnGtrkdKf
         y7Rq3sU++vAzkUATTPvTxIJlHBlDXLC975838=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Sr4ewXrq596XiNvuFYkQQm1/9bV3MqWYOZ4p4s0FM+8oTRsy1mt2kKLGQvwtZ+dUNR
         RHMkf8MrnwJ1qzRr86gbTjQ7sAw4PIzPQczSnhCnelxlZvyQP9EjmMmTrYrH/9l7a7Cl
         d8z7gFL/x93oRW6ZI+KC3d1FAxWxJbPXa85Sw=
Received: by 10.231.58.201 with SMTP id i9mr6944951ibh.98.1286008470429;
        Sat, 02 Oct 2010 01:34:30 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id g31sm2219406ibh.22.2010.10.02.01.34.29
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 02 Oct 2010 01:34:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101002082752.GA29638@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157796>

The buffer used to construct paths like ".git/objects/info" and
".git/objects/pack" is allocated on the heap and never freed.

So free it.  While at it, factor out the relevant code into its own
function to make it more obvious that this data is not used elsewhere.

Noticed by valgrind while setting up tests (in test-lib).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/init-db.c |   32 +++++++++++++++++++-------------
 1 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 0271285..a9c54ea 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -294,11 +294,26 @@ static int create_default_files(const char *template_path)
 	return reinit;
 }
 
+static void create_sha1_dir(void)
+{
+	const char *sha1_dir = get_object_directory();
+	int len = strlen(sha1_dir);
+	char *path = xmalloc(len + 40);
+
+	memcpy(path, sha1_dir, len);
+
+	safe_create_dir(sha1_dir, 1);
+	strcpy(path+len, "/pack");
+	safe_create_dir(path, 1);
+	strcpy(path+len, "/info");
+	safe_create_dir(path, 1);
+
+	free(path);
+}
+
 int init_db(const char *template_dir, unsigned int flags)
 {
-	const char *sha1_dir;
-	char *path;
-	int len, reinit;
+	int reinit;
 
 	safe_create_dir(get_git_dir(), 0);
 
@@ -313,16 +328,7 @@ int init_db(const char *template_dir, unsigned int flags)
 
 	reinit = create_default_files(template_dir);
 
-	sha1_dir = get_object_directory();
-	len = strlen(sha1_dir);
-	path = xmalloc(len + 40);
-	memcpy(path, sha1_dir, len);
-
-	safe_create_dir(sha1_dir, 1);
-	strcpy(path+len, "/pack");
-	safe_create_dir(path, 1);
-	strcpy(path+len, "/info");
-	safe_create_dir(path, 1);
+	create_sha1_dir();
 
 	if (shared_repository) {
 		char buf[10];
-- 
1.7.2.3
