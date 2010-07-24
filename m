From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 7/9] setup: split off get_device_or_die helper
Date: Sat, 24 Jul 2010 06:27:58 -0500
Message-ID: <20100724112758.GG16054@burratino>
References: <1279886651-14590-1-git-send-email-pclouds@gmail.com>
 <20100724111505.GC7150@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 24 13:29:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Occuh-0006aR-8m
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 13:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755359Ab0GXL3D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 07:29:03 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58788 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754276Ab0GXL3A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 07:29:00 -0400
Received: by iwn7 with SMTP id 7so1098829iwn.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 04:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Y0AC7JJyynfQM8FzuhK/jvw4Zk7YCRbOKNoCyaIvJuc=;
        b=RDCxStxJIB9sa27Nh0kYJgMrWlEjOahEk2mur8Pya6E9eKH9iqsXExHH5Up+kcS0HP
         Ys9G58zbpE4AycQRS/3GK73J/L7ETpPrcA4EV/QO8wqOfTr471nl36vXfKV13CbfRbEE
         FFPS6PhwtVbfBVp8bOhs0VEgX+ToYnhcvxUFo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Fp5m5Lyoow2fEv+6xOzHjoyLNi7JGW5AMa3vnwaLIZUdgjm2SlhXHDuJ3ymSKlqQtQ
         2/aAXpvj1fMBu6l5eW2sQtXVGByKJDuCsnyMeSY3LqQ3Qy6N85yuoCqEMFISrfsV01/A
         QiY56hV8U1WURMyYaljvzib/bwC+ANE/LGyz0=
Received: by 10.231.85.206 with SMTP id p14mr5310919ibl.89.1279970939643;
        Sat, 24 Jul 2010 04:28:59 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id n20sm1257259ibe.17.2010.07.24.04.28.59
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 04:28:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100724111505.GC7150@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151618>

This does not eliminate any code, but it skims some off of
the main loop of setup_git_directory_gently so that can be
understood more easily.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 setup.c |   25 ++++++++++++++-----------
 1 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/setup.c b/setup.c
index 9fc05e2..5fb9c54 100644
--- a/setup.c
+++ b/setup.c
@@ -388,6 +388,16 @@ static const char *setup_nongit(const char *cwd, int *nongit_ok)
 	return NULL;
 }
 
+static dev_t get_device_or_die(const char *path, const char *prefix)
+{
+	struct stat buf;
+	if (stat(path, &buf))
+		die_errno("failed to stat '%s%s%s'",
+				prefix ? prefix : "",
+				prefix ? "/" : "", path);
+	return buf.st_dev;
+}
+
 /*
  * We cannot decide in this function whether we are in the work tree or
  * not, since the config can only be read _after_ this function was called.
@@ -402,7 +412,6 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	int len, offset, ceil_offset, root_len;
 	dev_t current_device = 0;
 	int one_filesystem = 1;
-	struct stat buf;
 
 	/*
 	 * Let's assume that we are in a git repository.
@@ -441,11 +450,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	 */
 	offset = len = strlen(cwd);
 	one_filesystem = !git_env_bool("GIT_DISCOVERY_ACROSS_FILESYSTEM", 0);
-	if (one_filesystem) {
-		if (stat(".", &buf))
-			die_errno("failed to stat '.'");
-		current_device = buf.st_dev;
-	}
+	if (one_filesystem)
+		current_device = get_device_or_die(".", NULL);
 	for (;;) {
 		if (cwd_contains_git_dir(&gitfile_dir))
 			break;
@@ -456,11 +462,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		if (offset <= ceil_offset)
 			return setup_nongit(cwd, nongit_ok);
 		if (one_filesystem) {
-			if (stat("..", &buf)) {
-				cwd[offset] = '\0';
-				die_errno("failed to stat '%s/..'", cwd);
-			}
-			if (buf.st_dev != current_device) {
+			dev_t parent_device = get_device_or_die("..", cwd);
+			if (parent_device != current_device) {
 				if (nongit_ok) {
 					if (chdir(cwd))
 						die_errno("Cannot come back to cwd");
-- 
1.7.2.rc3.593.g19611.dirty
