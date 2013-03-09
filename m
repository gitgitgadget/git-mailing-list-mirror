From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Replace strcmp_icase with strequal_icase
Date: Sat, 9 Mar 2013 17:21:55 +0700
Message-ID: <20130309102155.GA11616@lanh>
References: <1362818574-16873-1-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sat Mar 09 11:22:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEGvM-0005Lw-2l
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 11:22:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756419Ab3CIKWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 05:22:06 -0500
Received: from mail-da0-f49.google.com ([209.85.210.49]:34782 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756128Ab3CIKWF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 05:22:05 -0500
Received: by mail-da0-f49.google.com with SMTP id t11so322241daj.36
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 02:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=2b6OL/XUKqGl70f9WFrKXO32AvsgSDQsvEqd5p3UGkE=;
        b=DfPGF/0OxVEzoWgTumQW30b0qexGftAz9kTYVDdTa7GRy5ihx2SyeY4KcHYNvxuaxJ
         Mq4zR/LgxXGdSOne+F5XKS+O7CLNe+Ijv3hpTRJPBSWLx2onVFYP4Gp6gtOX9hhrkwlT
         htoLHY7iuM85UYDMt9nli0cRw+xUrx7T8uYEs6Xd6i356w9Pa/QIDgPsQbVyeEQ+P0pk
         EJFTelVBZYSy5du6S/veQog1xvNC8Bi12BvGfhzUFErC+hn41v1Vv2ssyve9VGguh9Z7
         kvASV6+0JN6Q1ZUoij0S2E6KcL2SXJNO+QyCPhbmJf0uUoLSPLwwJKZtiQt671t7+0Yc
         bp7w==
X-Received: by 10.68.231.42 with SMTP id td10mr10174717pbc.174.1362824523650;
        Sat, 09 Mar 2013 02:22:03 -0800 (PST)
Received: from lanh ([115.74.63.193])
        by mx.google.com with ESMTPS id kb3sm9603068pbc.21.2013.03.09.02.21.59
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 09 Mar 2013 02:22:02 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 09 Mar 2013 17:21:55 +0700
Content-Disposition: inline
In-Reply-To: <1362818574-16873-1-git-send-email-iveqy@iveqy.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217717>

On Sat, Mar 09, 2013 at 09:42:54AM +0100, Fredrik Gustafsson wrote:
> To improve performance.
> git status before:
> user    0m0.020s
> user    0m0.024s
> user    0m0.024s
> user    0m0.020s
> user    0m0.024s
> user    0m0.028s
> user    0m0.024s
> user    0m0.024s
> user    0m0.016s
> user    0m0.028s
> 
> git status after:
> user    0m0.012s
> user    0m0.008s
> user    0m0.008s
> user    0m0.008s
> user    0m0.008s
> user    0m0.008s
> user    0m0.008s
> user    0m0.004s
> user    0m0.008s
> user    0m0.016s

I tested a slightly different version that checks ignore_case, inlines
if possible and replaces one more strncmp_icase call site (the top
call site in webkit.git). The numbers are impressive (well not as
impressive as yours, but I guess it depends on the actual .gitignore
patterns). On top of my 3/3

        before      after
user    0m0.508s    0m0.392s
user    0m0.511s    0m0.394s
user    0m0.513s    0m0.405s
user    0m0.516s    0m0.407s
user    0m0.516s    0m0.407s
user    0m0.518s    0m0.410s
user    0m0.519s    0m0.412s
user    0m0.524s    0m0.415s
user    0m0.527s    0m0.415s
user    0m0.534s    0m0.417s

I still need to run the test suite. Then maybe reroll my series with
this.

-- 8< --
diff --git a/dir.c b/dir.c
index 2a91d14..6a9b4b7 100644
--- a/dir.c
+++ b/dir.c
@@ -21,6 +21,24 @@ static int read_directory_recursive(struct dir_struct *dir, const char *path, in
 	int check_only, const struct path_simplify *simplify);
 static int get_dtype(struct dirent *de, const char *path, int len);
 
+static inline strnequal_icase(const char *first, const char *second, int length)
+{
+	if (ignore_case) {
+		while (length && toupper(*first) == toupper(*second)) {
+			first++;
+			second++;
+			length--;
+		}
+	} else {
+		while (length && *first == *second) {
+			first++;
+			second++;
+			length--;
+		}
+	}
+	return length == 0;
+}
+
 inline int git_fnmatch(const char *pattern, const char *string,
 		       int flags, int prefix)
 {
@@ -611,11 +629,11 @@ int match_basename(const char *basename, int basenamelen,
 {
 	if (prefix == patternlen) {
 		if (patternlen == basenamelen &&
-		    !strncmp_icase(pattern, basename, patternlen))
+		    strnequal_icase(pattern, basename, patternlen))
 			return 1;
 	} else if (flags & EXC_FLAG_ENDSWITH) {
 		if (patternlen - 1 <= basenamelen &&
-		    !strncmp_icase(pattern + 1,
+		    strnequal_icase(pattern + 1,
 				   basename + basenamelen - patternlen + 1,
 				   patternlen - 1))
 			return 1;
@@ -649,7 +667,7 @@ int match_pathname(const char *pathname, int pathlen,
 	 */
 	if (pathlen < baselen + 1 ||
 	    (baselen && pathname[baselen] != '/') ||
-	    (baselen && strncmp_icase(pathname, base, baselen)))
+	    (baselen && !strnequal_icase(pathname, base, baselen)))
 		return 0;
 
 	namelen = baselen ? pathlen - baselen - 1 : pathlen;
@@ -663,7 +681,7 @@ int match_pathname(const char *pathname, int pathlen,
 		if (prefix > namelen)
 			return 0;
 
-		if (strncmp_icase(pattern, name, prefix))
+		if (!strnequal_icase(pattern, name, prefix))
 			return 0;
 		pattern += prefix;
 		name    += prefix;
-- 8< --
