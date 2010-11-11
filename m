From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH, maint] setup: make sure git_dir path is in a permanent
 buffer, getenv(3) case
Date: Thu, 11 Nov 2010 12:17:28 -0600
Message-ID: <20101111181728.GF16972@burratino>
References: <1289498903-18413-1-git-send-email-kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Thu Nov 11 19:17:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGbig-0000VJ-P2
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 19:17:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753964Ab0KKSRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 13:17:53 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64003 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492Ab0KKSRw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 13:17:52 -0500
Received: by vws13 with SMTP id 13so481577vws.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 10:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=j5C5Wqv7zXBgMgY2x1blr6n/W9IxCjrnhpmT2Cof1fg=;
        b=opcREkyh1sh6DnsYxfwAPIVZq5CUImw5WfurNnUhnmtbRIxgz/sGirwDwBqOpt1eGE
         iG7mIF8Mpg88SX6ERleYhLqay4qahhEfFWHJRs6sRTzJ2buJ+0z0tV5idm8W4MfuNavi
         ZEEQkfRo9V9CuuKJ/NE+Av6n/zRceE7NmVOWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OHGP9bK/OD0en6T5oooU1zH0WHpLEBo5mter+7N3qiQ0TtWptIIZkFQX61ylSS3s9R
         og9Pk++A2Nzdji78jaCTtxmqROzSD/vIctYykE9ZKcAuI2NL2b9hochfLTu53P/6kVYG
         O0wW1TRGm46XdYQ/Jn0EDVgnTtA9E7R4M7u08=
Received: by 10.220.178.139 with SMTP id bm11mr276548vcb.0.1289499471989;
        Thu, 11 Nov 2010 10:17:51 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id l14sm655148vcr.18.2010.11.11.10.17.50
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 10:17:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1289498903-18413-1-git-send-email-kirr@mns.spb.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161286>

Kirill Smelkov wrote:

> getenv(3) returns not-permanent buffer which may be changed by e.g.
> putenv(3) call (*).

Yikes.  Thanks for the example.

> --- a/environment.c
> +++ b/environment.c
> @@ -88,6 +88,7 @@ const char * const local_repo_env[LOCAL_REPO_ENV_SIZE + 1] = {
>  static void setup_git_env(void)
>  {
>  	git_dir = getenv(GIT_DIR_ENVIRONMENT);
> +	git_dir = git_dir ? xstrdup(git_dir) : NULL;
>  	if (!git_dir) {
>  		git_dir = read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
>  		git_dir = git_dir ? xstrdup(git_dir) : NULL;

Maybe we can avoid (some) repetition like this?

diff --git a/environment.c b/environment.c
index de5581f..942f1e4 100644
--- a/environment.c
+++ b/environment.c
@@ -87,25 +87,31 @@ const char * const local_repo_env[LOCAL_REPO_ENV_SIZE + 1] = {
 static void setup_git_env(void)
 {
 	git_dir = getenv(GIT_DIR_ENVIRONMENT);
-	if (!git_dir) {
-		git_dir = read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
-		git_dir = git_dir ? xstrdup(git_dir) : NULL;
-	}
 	if (!git_dir)
+		git_dir = read_gitfile_gently(DEFAULT_GIT_DIR_ENVIRONMENT);
+	if (git_dir)
+		git_dir = xstrdup(git_dir);
+	else
 		git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
+
 	git_object_dir = getenv(DB_ENVIRONMENT);
-	if (!git_object_dir) {
-		git_object_dir = xmalloc(strlen(git_dir) + 9);
-		sprintf(git_object_dir, "%s/objects", git_dir);
-	}
+	if (git_object_dir)
+		git_object_dir = xstrdup(git_object_dir);
+	else
+		git_object_dir = git_pathdup("objects");
+
 	git_index_file = getenv(INDEX_ENVIRONMENT);
-	if (!git_index_file) {
-		git_index_file = xmalloc(strlen(git_dir) + 7);
-		sprintf(git_index_file, "%s/index", git_dir);
-	}
+	if (git_index_file)
+		git_index_file = xstrdup(git_index_file);
+	else
+		git_index_file = git_pathdup("index");
+
 	git_graft_file = getenv(GRAFT_ENVIRONMENT);
-	if (!git_graft_file)
+	if (git_graft_file)
+		git_graft_file = xstrdup(git_graft_file);
+	else
 		git_graft_file = git_pathdup("info/grafts");
+
 	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
 		read_replace_refs = 0;
 }
