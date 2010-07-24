From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/9] setup: split off code to handle stumbling upon a
 repository
Date: Sat, 24 Jul 2010 06:25:32 -0500
Message-ID: <20100724112532.GE16054@burratino>
References: <1279886651-14590-1-git-send-email-pclouds@gmail.com>
 <20100724111505.GC7150@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 24 13:26:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OccsM-0005np-H9
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 13:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755196Ab0GXL0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 07:26:35 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37061 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754276Ab0GXL0e (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 07:26:34 -0400
Received: by iwn7 with SMTP id 7so1097494iwn.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 04:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=1rXM7boRv1FfdH3lWROPxaW+UQuJMSNfvCPvQOYffzE=;
        b=ogElMwPiwiJCv3rUD1m8NaUvi/Fdb6ln8UHMVl1A4Cvi0CQ/dNmNe2HcC9bfmHWKRE
         7sP/hCuAkIsMKZC1lv72wMb2cWqhtNVLVQrkxB9+9E8Leo/D0Dm3qqVHOBmZUnxQ9tKF
         ZgbeUCbNDQYx7FVfrKj8H+w7xONOM6B0KRxQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=aQkqTTIcwTB2d7fF+2M688np5UQjUBF8H9CWsUX7Ebh4dIZqcs01m2byibPKKr3nbC
         0MfN1AbtTs/pbuP66GbuvAPTVdnEepcbi1TdrZugehiXSER1zoULtg2jex4IJHg8M+y9
         CjWszBCWYO076lC3rX+NwnOPeCyIUXsSXr6vc=
Received: by 10.231.31.197 with SMTP id z5mr5125844ibc.80.1279970793480;
        Sat, 24 Jul 2010 04:26:33 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 34sm1253345ibi.18.2010.07.24.04.26.32
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 04:26:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100724111505.GC7150@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151616>

If a repository is found as an ancestor of the original
working directory, it is assumed by default to be bare.
Handle this case with its own function.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 setup.c |   34 +++++++++++++++++++++-------------
 1 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/setup.c b/setup.c
index 3d25d0f..ec11c46 100644
--- a/setup.c
+++ b/setup.c
@@ -360,6 +360,24 @@ static int cwd_contains_git_dir(const char **gitfile_dirp)
 	return is_git_directory(DEFAULT_GIT_DIR_ENVIRONMENT);
 }
 
+static const char *setup_bare_git_dir(const char *work_tree_env,
+		int offset, int len, char *cwd, int *nongit_ok)
+{
+	int root_len;
+
+	inside_git_dir = 1;
+	if (!work_tree_env)
+		inside_work_tree = 0;
+	if (offset != len) {
+		root_len = offset_1st_component(cwd);
+		cwd[offset > root_len ? offset : root_len] = '\0';
+		set_git_dir(cwd);
+	} else
+		set_git_dir(".");
+	check_repository_format_gently(nongit_ok);
+	return NULL;
+}
+
 /*
  * We cannot decide in this function whether we are in the work tree or
  * not, since the config can only be read _after_ this function was called.
@@ -421,19 +439,9 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	for (;;) {
 		if (cwd_contains_git_dir(&gitfile_dir))
 			break;
-		if (is_git_directory(".")) {
-			inside_git_dir = 1;
-			if (!work_tree_env)
-				inside_work_tree = 0;
-			if (offset != len) {
-				root_len = offset_1st_component(cwd);
-				cwd[offset > root_len ? offset : root_len] = '\0';
-				set_git_dir(cwd);
-			} else
-				set_git_dir(".");
-			check_repository_format_gently(nongit_ok);
-			return NULL;
-		}
+		if (is_git_directory("."))
+			return setup_bare_git_dir(work_tree_env, offset,
+							len, cwd, nongit_ok);
 		while (--offset > ceil_offset && cwd[offset] != '/');
 		if (offset <= ceil_offset) {
 			if (nongit_ok) {
-- 
1.7.2.rc3.593.g19611.dirty
