From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 11/12] vcs-svn: handle filenames with dq correctly
Date: Sun, 6 Mar 2011 17:13:37 -0600
Message-ID: <20110306231337.GM24327@elie>
References: <20101210102007.GA26298@burratino>
 <20110306225419.GA24327@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 07 00:13:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwN91-0001YK-JG
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 00:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754938Ab1CFXNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2011 18:13:43 -0500
Received: from mail-gw0-f51.google.com ([74.125.83.51]:57591 "EHLO
	mail-gw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754919Ab1CFXNm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 18:13:42 -0500
Received: by gwb15 with SMTP id 15so2204209gwb.10
        for <git@vger.kernel.org>; Sun, 06 Mar 2011 15:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=COZbwIRV2kxRlX6CjKfqBbV7Ws3Ly+3HW/gmtCClcwA=;
        b=eiBPUgZjo3mxovPwiR3ikXriHHBbgloIe2gXIW2YZXfhJG4JmKopIUuZQaULZQXfwQ
         GQC7ErBXKjy5vnkRlliBuLTpJx/PfgtnZ0Oj2LvKEPxcunyaEvRi0jbR57KLwQa06bB6
         SAWq0p50rZW99s0mJYga1aZk+wQ3ghSEK7vdk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZOpqwwYv3sF3VUsOOCz4k631/LARLOALbHf31pZOv9hIgdctLiJfbiM7hSl3tQypat
         g3CStbRn9MUwoeyg9d4Pbye9/yjo0h2F/tW1Hg6bs7ItQZ1dyFG8NQ3QZeiso2BBPMC6
         ObGvfLkx4O6bw44XQyc9h0sezkTjNy18fIX6M=
Received: by 10.150.95.1 with SMTP id s1mr3672625ybb.226.1299453221693;
        Sun, 06 Mar 2011 15:13:41 -0800 (PST)
Received: from elie (adsl-69-209-66-207.dsl.chcgil.ameritech.net [69.209.66.207])
        by mx.google.com with ESMTPS id w1sm1304688ybl.9.2011.03.06.15.13.39
        (version=SSLv3 cipher=OTHER);
        Sun, 06 Mar 2011 15:13:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110306225419.GA24327@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168558>

Date: Sat, 11 Dec 2010 17:08:51 -0600

Quote paths passed to fast-import so filenames with double quotes are
not misinterpreted.

One might imagine this could help with filenames with newlines, too,
but svn does not allow those.

Helped-by: David Barr <daivd.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/fast_export.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 4d57efa..9c03f3e 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -34,10 +34,9 @@ void fast_export_reset(void)
 
 void fast_export_delete(uint32_t depth, const uint32_t *path)
 {
-	putchar('D');
-	putchar(' ');
-	pool_print_seq(depth, path, '/', stdout);
-	putchar('\n');
+	printf("D \"");
+	pool_print_seq_q(depth, path, '/', stdout);
+	printf("\"\n");
 }
 
 static void fast_export_truncate(uint32_t depth, const uint32_t *path, uint32_t mode)
@@ -54,9 +53,9 @@ void fast_export_modify(uint32_t depth, const uint32_t *path, uint32_t mode,
 		fast_export_truncate(depth, path, mode);
 		return;
 	}
-	printf("M %06"PRIo32" %s ", mode, dataref);
-	pool_print_seq(depth, path, '/', stdout);
-	putchar('\n');
+	printf("M %06"PRIo32" %s \"", mode, dataref);
+	pool_print_seq_q(depth, path, '/', stdout);
+	printf("\"\n");
 }
 
 static char gitsvnline[MAX_GITSVN_LINE_LEN];
@@ -97,9 +96,9 @@ void fast_export_end_commit(uint32_t revision)
 static void ls_from_rev(uint32_t rev, uint32_t depth, const uint32_t *path)
 {
 	/* ls :5 path/to/old/file */
-	printf("ls :%"PRIu32" ", rev);
-	pool_print_seq(depth, path, '/', stdout);
-	putchar('\n');
+	printf("ls :%"PRIu32" \"", rev);
+	pool_print_seq_q(depth, path, '/', stdout);
+	printf("\"\n");
 	fflush(stdout);
 }
 
-- 
1.7.4.1
