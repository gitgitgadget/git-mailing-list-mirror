From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/5] safe_create_leading_directories(): add "slash"
 pointer
Date: Thu, 26 Dec 2013 14:34:44 -0800
Message-ID: <20131226223444.GY20443@google.com>
References: <1387696451-32224-1-git-send-email-mhagger@alum.mit.edu>
 <1387696451-32224-4-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Dec 26 23:35:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwJWC-0005bW-CC
	for gcvg-git-2@plane.gmane.org; Thu, 26 Dec 2013 23:35:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001Ab3LZWeu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Dec 2013 17:34:50 -0500
Received: from mail-gg0-f182.google.com ([209.85.161.182]:64868 "EHLO
	mail-gg0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891Ab3LZWet (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Dec 2013 17:34:49 -0500
Received: by mail-gg0-f182.google.com with SMTP id e26so1350628gga.41
        for <git@vger.kernel.org>; Thu, 26 Dec 2013 14:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=X0yUr0TqHTcaa475ZLdrQXhEQAdWYDRX86MqdgJ1FhY=;
        b=nd2saZLzR7IDHFCsOOoJhOR3U5Gj4ueO7sANmuqaVipQcGYMhp+g+WUHOOA1Q57pzT
         Fxq7XJERPbXkyaLK1e7tcWZR7uCPDRgi2Gqb4NSURfaAwR0wHstrOCBfHljt2pDtaoy0
         0L+qTrlcFXoNVck/zWOdDrZncqBdiJlRmaS/PuzxztxdAQYy1nxR2CfGqCvsoPaJcQX/
         rdhtarIbTe+30w/hy30hbhanXOP9zBKlVqV84rLgD9HbnJt2FJYoFXnd0PxcgVcdrkyJ
         sewgMqs4sh+L4bfJUotfqGLXhP7ozfgzJ3pVdXnHChi9k/c1ORW3HvtwWXVFrrTG/vHr
         cskA==
X-Received: by 10.236.122.165 with SMTP id t25mr8528387yhh.46.1388097287931;
        Thu, 26 Dec 2013 14:34:47 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id s6sm263519yhp.15.2013.12.26.14.34.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 26 Dec 2013 14:34:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1387696451-32224-4-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239716>

Michael Haggerty wrote:

> [Subject: safe_create_leading_directories(): add "slash" pointer]

Is this a cleanup or improving the (internal) functionality of the
function somehow?  The above one-liner doesn't sum up for me in an
obvious way why this is a good change.

> Keep track of the position of the slash character separately, and

Separately from what?

> restore the slash character at a single place, at the end of the while
> loop.  This makes the next change easier to implement.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

Ah, do I understand correctly that this is about cleaning up
after the code that scribbles over 'path' in one place, to make
it harder to forget to do that cleanup as new code paths are
introduced?

It's too bad there's no variant of 'stat' and 'mkdir' that takes
a (buf, len) pair which would avoid the scribbling altogether.

> ---
>  sha1_file.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index cc9957e..dcfd35a 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -107,40 +107,40 @@ int mkdir_in_gitdir(const char *path)
>  
>  int safe_create_leading_directories(char *path)
>  {
> -	char *pos = path + offset_1st_component(path);
> +	char *next_component = path + offset_1st_component(path);

This name change is probably worth also mentioning in the commit
message (or lifting into a separate patch) so the reader doesn't get
distracted.

> +	int retval = 0;
>  
> -	while (pos) {
> +	while (!retval && next_component) {

A more usual style would be

	int ... = 0;

	while (pos) {
		...
		if (!stat(path, &st)) {
			/* path exists */
			if (!S_ISDIR(st.st_mode)) {
				... = -3;
				goto out;
			}
		} else if (...) {
			...
		}
		...
	}
 out:
	*slash = '/';
	return ...;
 }

which makes it more explicit that the slash needs to be written back.
In this example, that would look like:

	char *slash = NULL;
	int ret;

	while (pos) {
		...
		if (!slash)
			break;

		...
		if (!*pos)
			break;

		*slash = '\0';
		if (!stat(path, &st)) {
			if (!S_ISDIR(st.st_mode)) {
				ret = -3;
				goto out;
			}
		} else if (mkdir(...)) {
			if (errno == EEXIST && ...) {
				; /* ok */
			} else {
				ret = -1;
				goto out;
			}
		} else if (adjust_shared_perm(...)) {
			ret = -2;
			goto out;
		}
		*slash = '/';
	}
	ret = 0;
 out:
 	if (slash)
		*slash = '/';
	return ret;

Using retval for control flow instead makes it eight lines more
concise, which is probably worth it.

[...]
> 			if (!S_ISDIR(st.st_mode)) {
> -				*pos = '/';
> -				return -3;
> +				retval = -3;
> 			}

Now the 'if' body is one line, so we can drop the braces and save
another line. :)

One more nit: elsewhere in this file, a variable keeping track of the
return value is named 'ret', so it probably makes sense to also use
that name here.

That would mean the following changes to be potentially squashed in
(keeping 'pos' name to make the patch easier to read, s/retval/ret/,
removing unnecessary braces).  None of these tweaks are particularly
important.  Feel free to skip them --- the only comment I've made that
matters is about the commit message.

Thanks for a nice cleanup,
Jonathan

diff --git i/sha1_file.c w/sha1_file.c
index dcfd35a..18cb50a 100644
--- i/sha1_file.c
+++ w/sha1_file.c
@@ -107,40 +107,38 @@ int mkdir_in_gitdir(const char *path)
 
 int safe_create_leading_directories(char *path)
 {
-	char *next_component = path + offset_1st_component(path);
-	int retval = 0;
+	char *pos = path + offset_1st_component(path);
+	int ret = 0;
 
-	while (!retval && next_component) {
+	while (!ret && pos) {
 		struct stat st;
-		char *slash = strchr(next_component, '/');
+		char *slash = strchr(pos, '/');
 
 		if (!slash)
 			return 0;
 		while (*(slash + 1) == '/')
 			slash++;
-		next_component = slash + 1;
-		if (!*next_component)
+		pos = slash + 1;
+		if (!*pos)
 			return 0;
 
 		*slash = '\0';
 		if (!stat(path, &st)) {
 			/* path exists */
-			if (!S_ISDIR(st.st_mode)) {
-				retval = -3;
-			}
+			if (!S_ISDIR(st.st_mode))
+				ret = -3;
 		} else if (mkdir(path, 0777)) {
 			if (errno == EEXIST &&
-			    !stat(path, &st) && S_ISDIR(st.st_mode)) {
+			    !stat(path, &st) && S_ISDIR(st.st_mode))
 				; /* somebody created it since we checked */
-			} else {
-				retval = -1;
-			}
+			else
+				ret = -1;
 		} else if (adjust_shared_perm(path)) {
-			retval = -2;
+			ret = -2;
 		}
 		*slash = '/';
 	}
-	return retval;
+	return ret;
 }
 
 int safe_create_leading_directories_const(const char *path)
