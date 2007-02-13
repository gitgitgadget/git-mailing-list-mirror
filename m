From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Tue, 13 Feb 2007 09:23:59 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702130923310.8424@woody.linux-foundation.org>
References: <45CFA30C.6030202@verizon.net> <200702130932.51601.litvinov2004@gmail.com>
 <Pine.LNX.4.63.0702131105240.1300@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0702130845330.8424@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702130919100.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alexander Litvinov <litvinov2004@gmail.com>,
	Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Feb 13 18:24:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH1OR-0005sh-Jr
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 18:24:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbXBMRYT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 12:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbXBMRYT
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 12:24:19 -0500
Received: from smtp.osdl.org ([65.172.181.24]:45059 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751014AbXBMRYS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 12:24:18 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1DHO0hB029551
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 13 Feb 2007 09:24:00 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1DHNx6T003909;
	Tue, 13 Feb 2007 09:23:59 -0800
In-Reply-To: <Pine.LNX.4.64.0702130919100.8424@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.422 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.117__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39548>



On Tue, 13 Feb 2007, Linus Torvalds wrote:
> 
> Here's a patch [...]

No. HERE's the trivial stupid patch that just marks the core places.

		Linus
---
diff --git a/diff.c b/diff.c
index aaab309..13b9b6c 100644
--- a/diff.c
+++ b/diff.c
@@ -1364,6 +1364,7 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 		s->data = xmmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
 		close(fd);
 		s->should_munmap = 1;
+		/* FIXME! CRLF -> LF conversion goes here, based on "s->path" */
 	}
 	else {
 		char type[20];
diff --git a/entry.c b/entry.c
index 0ebf0f0..c2641dd 100644
--- a/entry.c
+++ b/entry.c
@@ -89,6 +89,7 @@ static int write_entry(struct cache_entry *ce, char *path, struct checkout *stat
 			return error("git-checkout-index: unable to create file %s (%s)",
 				path, strerror(errno));
 		}
+		/* FIXME: LF -> CRLF conversion goes here, based on "ce->name" */
 		wrote = write_in_full(fd, new, size);
 		close(fd);
 		free(new);
diff --git a/sha1_file.c b/sha1_file.c
index 0d4bf80..8ad7fad 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2091,6 +2091,7 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object, con
 
 	if (!type)
 		type = blob_type;
+	/* FIXME: CRLF -> LF conversion here for blobs! We'll need the path! */
 	if (write_object)
 		ret = write_sha1_file(buf, size, type, sha1);
 	else
