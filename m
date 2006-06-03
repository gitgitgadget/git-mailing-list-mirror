From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Importing Mozilla CVS into git
Date: Sat, 3 Jun 2006 16:47:36 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606031631480.5498@g5.osdl.org>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
 <9e4733910606012100s7ace4721le6fbfbcaadfb6c43@mail.gmail.com>
 <46a038f90606012116t478edacex72a441544f395af4@mail.gmail.com>
 <200606040116.38036.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Jon Smirl <jonsmirl@gmail.com>,
	Keith Packard <keithp@keithp.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 04 01:48:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fmfqb-0001s9-6q
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 01:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWFCXr6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Jun 2006 19:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbWFCXr6
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Jun 2006 19:47:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33233 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750730AbWFCXr5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jun 2006 19:47:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k53Nlc2g011108
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 3 Jun 2006 16:47:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k53NlaR3027093;
	Sat, 3 Jun 2006 16:47:37 -0700
To: "Robin Rosenberg (list subscriber)" 
	<robin.rosenberg.lists@dewire.com>
In-Reply-To: <200606040116.38036.robin.rosenberg.lists@dewire.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21232>



On Sun, 4 Jun 2006, Robin Rosenberg (list subscriber) wrote:
> 
> (Yet) Another problem is that many windows tools use CR LF as the line ending.
> Almost all windows editors default to CRLF and some detect existing line 
> endings. No editing with notepad anymore. Of course that is a problem 
> regardless of whether a git or cvs client is used. You'll get these big 
> everything-changed commits that alter between CRLF and LF.

The only sane approach there (if you want to be at all cross-platform) is 
to just force everybody to _commit_ in UNIX '\n'-only format. Especially 
as most Windows tools probably handle that fine on reading (just have 
trouble writing them).

And that shouldn't actually be that hard to do. The most trivial approach 
is to have just a pre-trigger on commits, but let's face it, that would 
not be a good "full" solution. A better one is to just make the whole
"git update-index" thing just have a "automatically ignore CR/LF" mode.

Which really shouldn't be that hard. I think it's literally a matter of 
teaching "index_fd()" in sha1_file.c to recognize text-files, and remove 
CR/LF from them. All done (except to add the flag that enables the 
detection, of course - just so that sane systems won't have the overhead 
or the "corrupt binary files" issue).

Something like this is TOTALLY UNTESTED!

(You also need to teach "diff" to ignore differences in cr/lf, and this 
patch is bad because it's unconditional, and probably doesn't work 
anyway, but hey, the idea is possibly sound. Maybe)

		Linus
---
diff --git a/sha1_file.c b/sha1_file.c
index aea0f40..6dc6a3f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1740,9 +1740,30 @@ int index_pipe(unsigned char *sha1, int 
 	return ret;
 }
 
+static unsigned long autodetect_crlf(unsigned char *src, unsigned long size)
+{
+	unsigned long newsize = 0;
+	unsigned char *dst = src;
+	unsigned char last = 0;
+
+	while (size) {
+		unsigned char c = *src++;
+		if (last == '\r' && c == '\n') {
+			dst[-1] = '\n';
+		} else {
+			newsize++;
+			dst++;
+			if (dst != src)
+				dst[-1] = c;
+		}
+		last = c;
+	}
+	return newsize;
+}
+
 int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object, const char *type)
 {
-	unsigned long size = st->st_size;
+	unsigned long size = st->st_size, use_size;
 	void *buf;
 	int ret;
 	unsigned char hdr[50];
@@ -1755,12 +1776,15 @@ int index_fd(unsigned char *sha1, int fd
 	if (buf == MAP_FAILED)
 		return -1;
 
-	if (!type)
+	use_size = size;
+	if (!type) {
 		type = blob_type;
+		use_size = autodetect_crlf(buf, size);
+	}
 	if (write_object)
-		ret = write_sha1_file(buf, size, type, sha1);
+		ret = write_sha1_file(buf, use_size, type, sha1);
 	else {
-		write_sha1_file_prepare(buf, size, type, sha1, hdr, &hdrlen);
+		write_sha1_file_prepare(buf, use_size, type, sha1, hdr, &hdrlen);
 		ret = 0;
 	}
 	if (size)
