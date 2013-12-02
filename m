From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BUG] git mv file directory/ creates the file directory
Date: Mon, 2 Dec 2013 20:35:44 +0700
Message-ID: <20131202133544.GA8755@lanh>
References: <vpqli03sh61.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Dec 02 14:31:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnTah-0003jw-0v
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 14:31:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561Ab3LBNbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 08:31:07 -0500
Received: from mail-pd0-f175.google.com ([209.85.192.175]:53771 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515Ab3LBNbF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 08:31:05 -0500
Received: by mail-pd0-f175.google.com with SMTP id w10so17990410pde.20
        for <git@vger.kernel.org>; Mon, 02 Dec 2013 05:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qJz7uNNVDh/M2rThAF1ov/aN9WV6h2vbkWX6L4Doh0c=;
        b=PtDiE05PVtCvGywtKmg6BfhO/CFH/IAvw+ozuKZnZ6h1ktVBqxXADFS3/l4bBSkOxa
         e6uG7KwrTgAztvahTaKytrZrWk0RsGQ02J2iP021z+rbLuzkcSisQDQXiLKJZVOLB5iD
         ncMt5qyo1fHbRbc57/E96zAFIwQw7OvNdr14iHQGNJW1z+a8OmCRerycHbO93A9L9N/w
         7ILatFyUJSbzh1O8dVDafJJscBXN/jz9AeyqK5sxD4g/dE+Lf1HDWn2mNLp5zq0fSp2W
         iGyOMzMfxp1aP6um822JCIXhipgsNHQRNbE3AWEM1LI+VfYFbdcd5atmKdNUgeldwIV2
         tbQw==
X-Received: by 10.69.29.107 with SMTP id jv11mr3655340pbd.147.1385991062860;
        Mon, 02 Dec 2013 05:31:02 -0800 (PST)
Received: from lanh ([115.73.231.156])
        by mx.google.com with ESMTPSA id ha10sm122659322pbd.17.2013.12.02.05.30.59
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 02 Dec 2013 05:31:02 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 02 Dec 2013 20:35:44 +0700
Content-Disposition: inline
In-Reply-To: <vpqli03sh61.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238630>

On Mon, Dec 02, 2013 at 11:04:06AM +0100, Matthieu Moy wrote:
> Hi,
> 
> When directory/ does not exist, I'd expect this to fail:
> 
>   git mv existing-file directory/
> 
> (note the trailing slash, to make it clear that directory/ is a
> directory). Unix's mv does fail:
> 
>   $ mv existing-file directory/
>   mv: cannot move `existing-file' to `directory/': Not a directory
> 
> Instead, "git mv" seems to do the equivalent of
> 
>   git mv existing-file directory # without trailing slash

This may be a start. Does not seem to break anything..

-- 8< --
diff --git a/builtin/mv.c b/builtin/mv.c
index 2e0e61b..0fcccd5 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -16,9 +16,12 @@ static const char * const builtin_mv_usage[] = {
 	NULL
 };
 
+#define DUP_BASENAME 1
+#define KEEP_TRAILING_SLASH 2
+
 static const char **internal_copy_pathspec(const char *prefix,
 					   const char **pathspec,
-					   int count, int base_name)
+					   int count, unsigned flags)
 {
 	int i;
 	const char **result = xmalloc((count + 1) * sizeof(const char *));
@@ -27,11 +30,12 @@ static const char **internal_copy_pathspec(const char *prefix,
 	for (i = 0; i < count; i++) {
 		int length = strlen(result[i]);
 		int to_copy = length;
-		while (to_copy > 0 && is_dir_sep(result[i][to_copy - 1]))
+		while (!(flags & KEEP_TRAILING_SLASH) &&
+		       to_copy > 0 && is_dir_sep(result[i][to_copy - 1]))
 			to_copy--;
-		if (to_copy != length || base_name) {
+		if (to_copy != length || flags & DUP_BASENAME) {
 			char *it = xmemdupz(result[i], to_copy);
-			if (base_name) {
+			if (flags & DUP_BASENAME) {
 				result[i] = xstrdup(basename(it));
 				free(it);
 			} else
@@ -87,16 +91,16 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 
 	source = internal_copy_pathspec(prefix, argv, argc, 0);
 	modes = xcalloc(argc, sizeof(enum update_mode));
-	dest_path = internal_copy_pathspec(prefix, argv + argc, 1, 0);
+	dest_path = internal_copy_pathspec(prefix, argv + argc, 1, KEEP_TRAILING_SLASH);
 	submodule_gitfile = xcalloc(argc, sizeof(char *));
 
 	if (dest_path[0][0] == '\0')
 		/* special case: "." was normalized to "" */
-		destination = internal_copy_pathspec(dest_path[0], argv, argc, 1);
+		destination = internal_copy_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
 	else if (!lstat(dest_path[0], &st) &&
 			S_ISDIR(st.st_mode)) {
 		dest_path[0] = add_slash(dest_path[0]);
-		destination = internal_copy_pathspec(dest_path[0], argv, argc, 1);
+		destination = internal_copy_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
 	} else {
 		if (argc != 1)
 			die("destination '%s' is not a directory", dest_path[0]);
-- 8< --
