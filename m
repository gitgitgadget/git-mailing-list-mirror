From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 6/9] setup: split off a function to handle hitting ceiling
 in repo search
Date: Sat, 24 Jul 2010 06:26:41 -0500
Message-ID: <20100724112640.GF16054@burratino>
References: <1279886651-14590-1-git-send-email-pclouds@gmail.com>
 <20100724111505.GC7150@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 24 13:27:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcctQ-00069v-9V
	for gcvg-git-2@lo.gmane.org; Sat, 24 Jul 2010 13:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755299Ab0GXL1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jul 2010 07:27:43 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46457 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754276Ab0GXL1m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jul 2010 07:27:42 -0400
Received: by iwn7 with SMTP id 7so1098077iwn.19
        for <git@vger.kernel.org>; Sat, 24 Jul 2010 04:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=MjZh+4WWL4f5QOw9jiBO9G+BydOJwr5uzqj9EGCDoM4=;
        b=cQv/Jjbvj8ZKaUPyy5zxZCypQ7s7+cDFss0w7mUMRe4EK/Tl7zY7ttZ32pF9P+wHUw
         6pDRyhv229wd5AWr+piAPlWlpM8h8syGG8I4z9iFIGWNHmxg++oC+Stzolmzs9nIp/2L
         /tzdyBMAJLooZFOKJVF1V8+r4YL90Y9YHXVHg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Xt60Q85L33QXQG9RBBr0A+Hs6H8vit9NDrCsZsJYwTpsS2xkFPu/A/ifIgtFrasDYp
         YZClg28wOem1y43eFo1PEw1qHzWvNWzIALuS42QCal3k15DYFc9+1hXgEg1jgUMPPn4C
         UIFrVWSlSN3A3zBvtgeR3K0+UYUcgxpEvPAFE=
Received: by 10.231.148.83 with SMTP id o19mr5410588ibv.112.1279970861615;
        Sat, 24 Jul 2010 04:27:41 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id g31sm1252645ibh.22.2010.07.24.04.27.41
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 24 Jul 2010 04:27:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100724111505.GC7150@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151617>

Perhaps some day, other similar conditions (hitting the mount point,
hitting the root of the file system) will share this code.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 setup.c |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/setup.c b/setup.c
index ec11c46..9fc05e2 100644
--- a/setup.c
+++ b/setup.c
@@ -378,6 +378,16 @@ static const char *setup_bare_git_dir(const char *work_tree_env,
 	return NULL;
 }
 
+static const char *setup_nongit(const char *cwd, int *nongit_ok)
+{
+	if (!nongit_ok)
+		die("Not a git repository (or any of the parent directories): %s", DEFAULT_GIT_DIR_ENVIRONMENT);
+	if (chdir(cwd))
+		die_errno("Cannot come back to cwd");
+	*nongit_ok = 1;
+	return NULL;
+}
+
 /*
  * We cannot decide in this function whether we are in the work tree or
  * not, since the config can only be read _after_ this function was called.
@@ -443,15 +453,8 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			return setup_bare_git_dir(work_tree_env, offset,
 							len, cwd, nongit_ok);
 		while (--offset > ceil_offset && cwd[offset] != '/');
-		if (offset <= ceil_offset) {
-			if (nongit_ok) {
-				if (chdir(cwd))
-					die_errno("Cannot come back to cwd");
-				*nongit_ok = 1;
-				return NULL;
-			}
-			die("Not a git repository (or any of the parent directories): %s", DEFAULT_GIT_DIR_ENVIRONMENT);
-		}
+		if (offset <= ceil_offset)
+			return setup_nongit(cwd, nongit_ok);
 		if (one_filesystem) {
 			if (stat("..", &buf)) {
 				cwd[offset] = '\0';
-- 
1.7.2.rc3.593.g19611.dirty
