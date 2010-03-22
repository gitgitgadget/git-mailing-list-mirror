From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] http-backend: Don't infinite loop during die()
Date: Mon, 22 Mar 2010 07:22:04 -0700
Message-ID: <20100322142204.GB8916@spearce.org>
References: <51569EE6-A926-45DB-A588-B659750BA643@catherman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Brady Catherman <brady@catherman.org>
X-From: git-owner@vger.kernel.org Mon Mar 22 15:22:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtiWF-0006sV-U2
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 15:22:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754714Ab0CVOWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 10:22:11 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47101 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900Ab0CVOWK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 10:22:10 -0400
Received: by vws6 with SMTP id 6so395167vws.19
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 07:22:09 -0700 (PDT)
Received: by 10.220.46.2 with SMTP id h2mr3425833vcf.80.1269267729296;
        Mon, 22 Mar 2010 07:22:09 -0700 (PDT)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 25sm35721854vws.1.2010.03.22.07.22.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Mar 2010 07:22:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51569EE6-A926-45DB-A588-B659750BA643@catherman.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142933>

If stdout has already been closed by the CGI and die() gets called,
the CGI will fail to write the "Status: 500 Internal Server Error" to
the pipe, which results in die() being called again (via safe_write).
This goes on in an infinite loop until the stack overflows and the
process is killed by SIGSEGV.

Instead set a flag on the first die() invocation and perform no
action during recursive die() calls.  This way failures to write the
error messages to the stdout pipe do not result in an infinite loop.

We also now report on the death to stderr before we report to stdout,
to increase the chances that the cause of the die() invocation will
appear in the server's error log.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This patch should be put in maint.

 It doesn't fix the underlying problem Brady has found, but it
 will at least get us more information by avoiding the infinite
 loop and later SIGSEGV crash of the parent CGI.

 http-backend.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index 8c7b7d0..5c0d649 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -538,12 +538,17 @@ static void service_rpc(char *service_name)
 
 static NORETURN void die_webcgi(const char *err, va_list params)
 {
-	http_status(500, "Internal Server Error");
-	hdr_nocache();
-	end_headers();
+	static int dead;
 
-	vreportf("fatal: ", err, params);
-	exit(0);
+	if (!dead) {
+		dead = 1;
+
+		vreportf("fatal: ", err, params);
+		http_status(500, "Internal Server Error");
+		hdr_nocache();
+		end_headers();
+		exit(0);
+	}
 }
 
 static char* getdir(void)
-- 
1.6.4.rc2.182.g24de1

-- 
Shawn.
