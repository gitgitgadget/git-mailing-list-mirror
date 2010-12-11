From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH db/vcs-svn-incremental] vcs-svn: quote all paths passed to
 fast-import
Date: Sat, 11 Dec 2010 17:11:23 -0600
Message-ID: <20101211231123.GA31179@burratino>
References: <20101210102007.GA26298@burratino>
 <DD24C01C-19FD-424B-B602-E9BB1A930805@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: David Michael Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Sun Dec 12 00:11:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRYbL-0006NE-4L
	for gcvg-git-2@lo.gmane.org; Sun, 12 Dec 2010 00:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024Ab0LKXLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Dec 2010 18:11:32 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55047 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816Ab0LKXLc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Dec 2010 18:11:32 -0500
Received: by yxt3 with SMTP id 3so2706775yxt.19
        for <git@vger.kernel.org>; Sat, 11 Dec 2010 15:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Q2ZcVsKJna4BA9u0CnmPE5tkTqmid03ERST1S7o5hzw=;
        b=vu9ioxgF2TZ8GWYjG2E8TCaaWM3CTb8iRGjFNbK6Z4jfZCiaOq8me96EduPh7mSXKm
         Rfy+mro9xOs6cWEmpv7Qkiky+6DdMnPpVtZi0TNKeGEq8+ccN8a6/QXNhNMCXRSxg9e9
         KkXjC1yaKAhU7sREwWMznn9INkIrLVEShxY18=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XeNzer9SDapXjUrLydFYX5exbxODI7fCpVkV0CZgMW1rEiaLlCojYdqcNI0NkNmzjX
         7HBd6CvCYXNGwPn19Gw3FuzukYjN8/ZayOa9zuHXI+du9um0055ryU30wUSs0ijpk1jW
         5M6izGi3jdp68Kknr+rw3YM+ZI8oZx5X56haA=
Received: by 10.150.11.3 with SMTP id 3mr3786422ybk.113.1292109091386;
        Sat, 11 Dec 2010 15:11:31 -0800 (PST)
Received: from burratino (adsl-69-209-48-248.dsl.chcgil.ameritech.net [69.209.48.248])
        by mx.google.com with ESMTPS id 26sm2908367yhl.23.2010.12.11.15.11.29
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 11 Dec 2010 15:11:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <DD24C01C-19FD-424B-B602-E9BB1A930805@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163464>

Filenames with linefeeds or double quotes need to be quoted if
fast-import is not to misinterpret them.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/fast_export.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 7856ff2..2d2a6b2 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -31,19 +31,18 @@ static int init_postimage(void)
 
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
 
 void fast_export_modify(uint32_t depth, const uint32_t *path, uint32_t mode,
 			const char *dataref)
 {
 	/* Mode must be 100644, 100755, 120000, or 160000. */
-	printf("M %06"PRIo32" %s ", mode, dataref);
-	pool_print_seq(depth, path, '/', stdout);
-	putchar('\n');
+	printf("M %06"PRIo32" %s \"", mode, dataref);
+	pool_print_seq_q(depth, path, '/', stdout);
+	printf("\"\n");
 }
 
 static char gitsvnline[MAX_GITSVN_LINE_LEN];
-- 
1.7.2.4
