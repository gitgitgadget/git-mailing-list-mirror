From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 07/10] vcs-svn: split off function to make 'ls' requests
Date: Fri, 10 Dec 2010 04:27:16 -0600
Message-ID: <20101210102716.GG26331@burratino>
References: <20101210102007.GA26298@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 10 11:27:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PR0CR-0004a5-Jb
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 11:27:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168Ab0LJK1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 05:27:34 -0500
Received: from mail-gw0-f42.google.com ([74.125.83.42]:57340 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698Ab0LJK1e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 05:27:34 -0500
Received: by gwb20 with SMTP id 20so2886991gwb.1
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 02:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=a/wgDIDH7OGm9mnbHWuOfwtnrx7N3+6W/LSTuis7PD8=;
        b=MT0kvoArXJ+51hizCVVCYHykx50CQiW8eKZ7muhR0Vt0+C8Z4SnGD2jUCNuGl42QU1
         UulssYc+u6ojtc92hfTj1zQSmH13othorxeOh2X3YBGhATCX/SfmCjDQgFZhEwWSRTk0
         lZ1+UsqVRLjYSM8xXmJ74oCD0VdmXQ3fCgXrI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZPBX/Iu1AyoU5DjlswDrH7VkIAU9bna2O6q3yYszTrEQKpmGJvgx9ZlSlWH3/YlddZ
         R2+w5e8QfMN+iblrlrSYHViNBgayAQESAVNsBxi93KlnV3AbvoErpKzMJ9HPMKDhDEFJ
         17RYaN8RQjnOKyiT9phT2Xx997k8Z5UwuoiOw=
Received: by 10.90.81.4 with SMTP id e4mr925990agb.103.1291976853272;
        Fri, 10 Dec 2010 02:27:33 -0800 (PST)
Received: from burratino (adsl-69-209-58-175.dsl.chcgil.ameritech.net [69.209.58.175])
        by mx.google.com with ESMTPS id d15sm3153808ana.35.2010.12.10.02.27.31
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 10 Dec 2010 02:27:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101210102007.GA26298@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163402>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
ls_from_rev will survive; cat_from_rev will not.

 vcs-svn/fast_export.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index cca9810..6a4a689 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -80,6 +80,15 @@ void fast_export_commit(uint32_t revision, uint32_t author, char *log,
 	printf("progress Imported commit %"PRIu32".\n\n", revision);
 }
 
+static void ls_from_rev(uint32_t rev, const uint32_t *path)
+{
+	/* ls :5 "path/to/old/file" */
+	printf("ls :%"PRIu32" \"", rev);
+	pool_print_seq(REPO_MAX_PATH_DEPTH, path, '/', stdout);
+	printf("\"\n");
+	fflush(stdout);
+}
+
 static int ends_with(const char *s, size_t len, const char *suffix)
 {
 	const size_t suffixlen = strlen(suffix);
@@ -150,12 +159,7 @@ static off_t cat_from_rev(uint32_t rev, const uint32_t *path)
 	off_t length = length;
 	struct strbuf blob_name = STRBUF_INIT;
 
-	/* ls :5 "path/to/old/file" */
-	printf("ls :%"PRIu32" \"", rev);
-	pool_print_seq(REPO_MAX_PATH_DEPTH, path, '/', stdout);
-	printf("\"\n");
-	fflush(stdout);
-
+	ls_from_rev(rev, path);
 	response = get_response_line();
 	if (parse_ls_response_line(response, &blob_name))
 		die("invalid ls response: %s", response);
-- 
1.7.2.4
