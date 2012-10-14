From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] config, gitignore: failure to access with ENOTDIR is ok
Date: Sat, 13 Oct 2012 17:03:07 -0700
Message-ID: <20121014000307.GA11399@elie.Belkin>
References: <20121014000210.GA19094@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 14 02:03:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNBg2-0008UZ-TN
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 02:03:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971Ab2JNADU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2012 20:03:20 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43365 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461Ab2JNADT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2012 20:03:19 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so3916413pbb.19
        for <git@vger.kernel.org>; Sat, 13 Oct 2012 17:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8bnjY4kSAVM6inCEwkt5tyeNyAIJa5APTzJM9iaWmAA=;
        b=fh8yZMvuBG3q5ccbzmeulTcRGb51N9+AUBPxmo6FHQhidoGRSb+RllNLhWozD5pngL
         mrjI/ESZW2JzlGDi+uI33FaokCVOYmyPLEpZlAuEWzSCdmanDz6Kq9LqyS+D47OpwLeJ
         bpT7RMr09m8t5LCc/vEBE56UHqG9/5kRY5oIzi1zNtAlXyQTkVUMw2HSSG7Q2SS4Nv7g
         g8KEFi+seaBanHyv6Ux305pL16wxp8PvheKTlIprAIeKR9AyzByrNL4rrXQAHrXgjqRp
         SlY/CMAciqYHvXed6zNOTnvCZX6BQYyo9KlOlqlIpRcshDgXoQiV6SMoedAwXXiaD8nJ
         gd3A==
Received: by 10.68.224.138 with SMTP id rc10mr25354607pbc.34.1350172999083;
        Sat, 13 Oct 2012 17:03:19 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id iu8sm6649714pbc.71.2012.10.13.17.03.18
        (version=SSLv3 cipher=OTHER);
        Sat, 13 Oct 2012 17:03:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20121014000210.GA19094@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207586>

The access_or_warn() function is used to check for optional
configuration files like .gitconfig and .gitignore and warn when they
are not accessible due to a configuration issue (e.g., bad
permissions).  It is not supposed to complain when a file is simply
missing.

Noticed on a system where ~/.config/git was a file --- when the new
XDG_CONFIG_HOME support looks for ~/.config/git/config it should
ignore ~/.config/git instead of printing irritating warnings:

 $ git status -s
 warning: unable to access '/home/jrn/.config/git/config': Not a directory
 warning: unable to access '/home/jrn/.config/git/config': Not a directory
 warning: unable to access '/home/jrn/.config/git/config': Not a directory
 warning: unable to access '/home/jrn/.config/git/config': Not a directory

Compare v1.7.12.1~2^2 (attr:failure to open a .gitattributes file
is OK with ENOTDIR, 2012-09-13).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git-compat-util.h | 5 ++++-
 wrapper.c         | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 2fbf1fd8..f567767f 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -635,7 +635,10 @@ int rmdir_or_warn(const char *path);
  */
 int remove_or_warn(unsigned int mode, const char *path);
 
-/* Call access(2), but warn for any error besides ENOENT. */
+/*
+ * Call access(2), but warn for any error except "missing file"
+ * (ENOENT or ENOTDIR).
+ */
 int access_or_warn(const char *path, int mode);
 
 /* Warn on an inaccessible file that ought to be accessible */
diff --git a/wrapper.c b/wrapper.c
index 68739aaa..c1b919f3 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -411,7 +411,7 @@ void warn_on_inaccessible(const char *path)
 int access_or_warn(const char *path, int mode)
 {
 	int ret = access(path, mode);
-	if (ret && errno != ENOENT)
+	if (ret && errno != ENOENT && errno != ENOTDIR)
 		warn_on_inaccessible(path);
 	return ret;
 }
-- 
1.8.0.rc2
