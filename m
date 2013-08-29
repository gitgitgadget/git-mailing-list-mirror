From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BUG] git-init does not respect existing separate-git-dir
Date: Thu, 29 Aug 2013 20:04:50 +0700
Message-ID: <20130829130450.GA9323@lanh>
References: <521F40E6.4040102@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ximin Luo <infinity0@gmx.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 15:01:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF1rF-0001PH-L4
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 15:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754172Ab3H2NBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 09:01:49 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:50446 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001Ab3H2NBs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 09:01:48 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa1so893841pad.5
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 06:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=wTnya751fvCnTAKrJA11EtU+2Em9McYhPdPHjt+kT2Q=;
        b=GRYdx59C9xkCE0b7cyE01lf0UasKMnH5fOdg9Pvo6Ip7FkeAYo4gbrN3NZ9sJRZc+u
         +fRQTlkN+Sm/+UV9vcNuxL1v666pfY9utWUiMdgWjYNQAsCbfB+Rp8YUIANjBkzL5UJk
         +Y6MYg6PMrpfUuxQgXKg0IZypAnUeD3NgC6eLQ5pAcBk15agHscsckMNEGFF+7SxCrvr
         NUgcjc0LODnB8hM6V3rNV+tmDRoH8rBWo9iYY+4pjh3UCf1+9V4HZGoQTZYBfzMzEV/y
         vXXFIwTh1gRv8StF8x5gXeeCQBUZlrp/FJ9evQmOIUBfa/o7WBuD3zc7KUzPwwDCD2Os
         6+aw==
X-Received: by 10.66.189.98 with SMTP id gh2mr4348649pac.60.1377781308104;
        Thu, 29 Aug 2013 06:01:48 -0700 (PDT)
Received: from lanh ([115.73.241.36])
        by mx.google.com with ESMTPSA id zq10sm40901382pab.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 06:01:47 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 29 Aug 2013 20:04:50 +0700
Content-Disposition: inline
In-Reply-To: <521F40E6.4040102@gmx.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233250>

On Thu, Aug 29, 2013 at 01:39:02PM +0100, Ximin Luo wrote:
> It should not be necessary to re-specify --separate-git-dir when re-initialising a git repo.
> 
> $ git init --separate-git-dir ../repo
> Initialized empty Git repository in /home/infinity0/tmp/repo/
> 
> $ git init
> /home/infinity0/tmp/wtree/.git/refs: Not a directory
> 1

This patch seems to work. Lightly tested.

-- 8< --
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 78aa387..d0e5b2e 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -192,6 +192,15 @@ static int create_default_files(const char *template_path)
 		die(_("insane git directory %s"), git_dir);
 	memcpy(path, git_dir, len);
 
+	if (!lstat(path, &st1) && S_ISREG(st1.st_mode)) {
+		git_dir = read_gitfile(git_dir);
+		len = strlen(git_dir);
+		if (len > sizeof(path)-50)
+			die(_("insane git directory %s"), git_dir);
+		set_git_dir(git_dir);
+		memcpy(path, git_dir, len);
+	}
+
 	if (len && path[len-1] != '/')
 		path[len++] = '/';
-- 8< -- 

> One big motivation is so "git init" can be a good "fire-and-forget"
> invocation that should work anywhere. Currently, one has to do "git
> init --separate-git-dir $(git rev-parse --git-dir)" which is a lot
> less elegant.
--
Duy
