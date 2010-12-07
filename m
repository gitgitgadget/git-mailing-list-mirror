From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Improved error messages when temporary file creation
 fails
Date: Tue, 7 Dec 2010 13:09:20 -0600
Message-ID: <20101207190920.GA22587@burratino>
References: <20101207181633.GF25767@bzzt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Arnout Engelen <arnouten@bzzt.net>
X-From: git-owner@vger.kernel.org Tue Dec 07 20:09:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ2uw-0003kR-Vv
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 20:09:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295Ab0LGTJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 14:09:33 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38797 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055Ab0LGTJd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 14:09:33 -0500
Received: by vws16 with SMTP id 16so254764vws.19
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 11:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=mpsfl67OGRo17pq/eJQIUZz/loMDZJ3148wbu8H98f4=;
        b=pu2q8FvJtGFge7v+iTH8N0VpqPru/WK8UItD0nAHLWzfqX1xXSA3gkxBuegHfTF5aK
         VXhJphVakhNqbATQbkfgQdibS1tVmAfa+h8wALRZOsMbUDSSLlSqLVhVinJHnBKesvM5
         3RoM8hEH60M0spLsxP5eC/IQnTXfqGB6h6DkU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PXQVVya4T8N4fX5h3fZq4R5qGHzzxwvh8vhzoWpnZZKa8ukGnzaQt72bwarASRRYAg
         yDFv/qw/TVHM3zMId7h58EskQFWsAgDxHIkMeHPlaIa5neTOI+21bW6gD7bC8tzX5BZJ
         2hx6+ULkab+Nxa2HpfG6ew1WiLXKIognqhMTw=
Received: by 10.220.164.70 with SMTP id d6mr1968608vcy.130.1291748972378;
        Tue, 07 Dec 2010 11:09:32 -0800 (PST)
Received: from burratino ([68.255.109.73])
        by mx.google.com with ESMTPS id y14sm878702vch.4.2010.12.07.11.09.30
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Dec 2010 11:09:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101207181633.GF25767@bzzt.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163114>

Arnout Engelen wrote:

> +			die_errno("Unable to create temporary file '%s' at %s", 
> +				template, getcwd(NULL, 0));

This is a Linux libc/glibc-specific extension, alas.  On other platforms
it would print "(null)" or segfault.

Here's some other assorted tweaks.  I didn't bother to find your old
patch in the mailing list archive to take a fuller change description
from.

Hope that helps,
Jonathan
---
diff --git a/test-mktemp.c b/test-mktemp.c
index d392fa7..2e3b134 100644
--- a/test-mktemp.c
+++ b/test-mktemp.c
@@ -7,10 +7,9 @@
 
 int main(int argc, char *argv[])
 {
-	if (argc != 2) {
+	if (argc != 2)
 		usage("Expected 1 parameter defining the temporary file template");
-	}
-	xmkstemp(strdup(argv[1]));
+	xmkstemp(xstrdup(argv[1]));
 
 	return 0;
 }
diff --git a/wrapper.c b/wrapper.c
index 6640c87..cb9c9ad 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -197,19 +197,18 @@ FILE *xfdopen(int fd, const char *mode)
 int xmkstemp(char *template)
 {
 	int fd;
-	char origtemplate[255];
-	strlcpy(origtemplate, template, 255);
+	char origtemplate[256];
+	strlcpy(origtemplate, template, sizeof(origtemplate));
 
 	fd = mkstemp(template);
 	if (fd < 0) {
+		int saved_errno = errno;
+
 		if (!template[0])
 			template = origtemplate;
-
-		if (is_absolute_path(template))
-			die_errno("Unable to create temporary file '%s'", template);
-		else
-			die_errno("Unable to create temporary file '%s' at %s", 
-				template, getcwd(NULL, 0));
+		template = make_nonrelative_path(template);
+		errno = saved_errno;
+		die_errno("Unable to create temporary file '%s'", template);
 	}
 	return fd;
 }
@@ -330,19 +329,18 @@ int gitmkstemps(char *pattern, int suffix_len)
 int xmkstemp_mode(char *template, int mode)
 {
 	int fd;
-	char origtemplate[255];
-	strlcpy(origtemplate, template, 255);
+	char origtemplate[256];
+	strlcpy(origtemplate, template, sizeof(origtemplate));
 
 	fd = git_mkstemp_mode(template, mode);
 	if (fd < 0) {
+		int saved_errno = errno;
+
 		if (!template[0])
 			template = origtemplate;
-
-		if (is_absolute_path(template))
-			die_errno("Unable to create temporary file '%s'", template);
-		else
-			die_errno("Unable to create temporary file '%s' at %s", 
-				template, getcwd(NULL, 0));
+		template = make_nonrelative_path(template);
+		errno = saved_errno;
+		die_errno("Unable to create temporary file '%s'", template);
 	}
 	return fd;
 }
