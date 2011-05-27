From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/4] test-svn-fe: split off "test-svn-fe -d" into a separate
 function
Date: Fri, 27 May 2011 06:09:14 -0500
Message-ID: <20110527110914.GB7972@elie>
References: <BANLkTi=O9AeOZTHVLbq+rKv5k-CqNGb+LQ@mail.gmail.com>
 <BANLkTinpta+a4MAr0e2YtMa1Kr1QcJmYWg@mail.gmail.com>
 <20110525235520.GA6971@elie>
 <BANLkTinBGnCKsUOXY_RD-7yNyM7XqNTsRw@mail.gmail.com>
 <20110527110828.GA7972@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Fri May 27 13:09:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPuuy-0001rM-2S
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 13:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999Ab1E0LJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 07:09:19 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:35338 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370Ab1E0LJT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 07:09:19 -0400
Received: by yia27 with SMTP id 27so637857yia.19
        for <git@vger.kernel.org>; Fri, 27 May 2011 04:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Ntbpnxn3SZnrGspFwx0nNbEh8TOMUwQ+X7L000v9bH8=;
        b=kQ4dA7igmIFM7xbcxXolZbMFOe0/Q0FR5foDsITehsFOmJXIDpeVc4i67GZ4421yQm
         O4xFgiwowUiAQEh+O6XIhIv4jbaTL7uYWTA922Z/kIqo9ZXEjQxPbwAHROOwsK4udTf4
         2vlRqZaAz7GFZmwaMxhsgIF01xzjsqrDNnjmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TfD1pM8Qsljsvt84C9kWck9OvUQo2ED+DLMEdllM4hsYfFTCxa9nsjoNu567xpxY0V
         S+HbSfSxvklQdEbKoT8QfQJfEH2QS3J0wBKU79oGbl50IqX6DVcdXpDI9fEq6Jyf+HS/
         9O4XyOgf3EoW99QSIUAyAtR6aPqHPYByblkaM=
Received: by 10.150.103.14 with SMTP id a14mr1899059ybc.94.1306494558400;
        Fri, 27 May 2011 04:09:18 -0700 (PDT)
Received: from elie (adsl-69-209-65-98.dsl.chcgil.sbcglobal.net [69.209.65.98])
        by mx.google.com with ESMTPS id u61sm288874yhm.29.2011.05.27.04.09.17
        (version=SSLv3 cipher=OTHER);
        Fri, 27 May 2011 04:09:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110527110828.GA7972@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174606>

The helper for testing the svndiff library is getting dangerously
close to the right margin.  Split it off into a separate function so
it is easier to contemplate on its own.

In other words, this just unindents the code a little.  No functional
change intended.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 test-svn-fe.c |   54 ++++++++++++++++++++++++++++++++----------------------
 1 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/test-svn-fe.c b/test-svn-fe.c
index 66bd040..a027626 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -8,10 +8,37 @@
 #include "vcs-svn/sliding_window.h"
 #include "vcs-svn/line_buffer.h"
 
+static const char test_svnfe_usage[] =
+	"test-svn-fe (<dumpfile> | [-d] <preimage> <delta> <len>)";
+
+static int apply_delta(int argc, char *argv[])
+{
+	struct line_buffer preimage = LINE_BUFFER_INIT;
+	struct line_buffer delta = LINE_BUFFER_INIT;
+	struct sliding_view preimage_view = SLIDING_VIEW_INIT(&preimage);
+
+	if (argc != 5)
+		usage(test_svnfe_usage);
+
+	if (buffer_init(&preimage, argv[2]))
+		die_errno("cannot open preimage");
+	if (buffer_init(&delta, argv[3]))
+		die_errno("cannot open delta");
+	if (svndiff0_apply(&delta, (off_t) strtoull(argv[4], NULL, 0),
+					&preimage_view, stdout))
+		return 1;
+	if (buffer_deinit(&preimage))
+		die_errno("cannot close preimage");
+	if (buffer_deinit(&delta))
+		die_errno("cannot close delta");
+	buffer_reset(&preimage);
+	strbuf_release(&preimage_view.buf);
+	buffer_reset(&delta);
+	return 0;
+}
+
 int main(int argc, char *argv[])
 {
-	static const char test_svnfe_usage[] =
-		"test-svn-fe (<dumpfile> | [-d] <preimage> <delta> <len>)";
 	if (argc == 2) {
 		if (svndump_init(argv[1]))
 			return 1;
@@ -20,25 +47,8 @@ int main(int argc, char *argv[])
 		svndump_reset();
 		return 0;
 	}
-	if (argc == 5 && !strcmp(argv[1], "-d")) {
-		struct line_buffer preimage = LINE_BUFFER_INIT;
-		struct line_buffer delta = LINE_BUFFER_INIT;
-		struct sliding_view preimage_view = SLIDING_VIEW_INIT(&preimage);
-		if (buffer_init(&preimage, argv[2]))
-			die_errno("cannot open preimage");
-		if (buffer_init(&delta, argv[3]))
-			die_errno("cannot open delta");
-		if (svndiff0_apply(&delta, (off_t) strtoull(argv[4], NULL, 0),
-					&preimage_view, stdout))
-			return 1;
-		if (buffer_deinit(&preimage))
-			die_errno("cannot close preimage");
-		if (buffer_deinit(&delta))
-			die_errno("cannot close delta");
-		buffer_reset(&preimage);
-		strbuf_release(&preimage_view.buf);
-		buffer_reset(&delta);
-		return 0;
-	}
+
+	if (argc >= 2 && !strcmp(argv[1], "-d"))
+		return apply_delta(argc, argv);
 	usage(test_svnfe_usage);
 }
-- 
1.7.5.1
