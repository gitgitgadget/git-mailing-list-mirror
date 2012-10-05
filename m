From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: Rebase doesn't restore branch pointer back on out of memory
Date: Fri,  5 Oct 2012 00:53:09 -0400
Message-ID: <1349412790-6087-1-git-send-email-andrew.kw.w@gmail.com>
References: <506E1327.1070602@gmail.com>
Cc: alex.kostikov@gmail.com, Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 08:42:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK1bk-0005eE-OO
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 08:42:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022Ab2JEGls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2012 02:41:48 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:56734 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847Ab2JEGlr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 02:41:47 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so2997449iea.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 23:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=gYcWzUu1UGDGtqAs+5bRrfjGAowPOy1V2ON+AOhxzL4=;
        b=FhR1qj/jwsuU0wEFKTTwFrGfA8QVQ/p169Xq8LPI7mhLvdCkr9+mvgPgbBY3P2QthK
         pbmraqo1VDo9V3ZTQ8KhU6nU61Xa2eC/iw+6PKzH/7SSWSnPYoTQxkLFnEub6xqw8rPY
         YiNShH37c44S3K7r9uilZR8seuJKL+pZx7hU3cqit2K4+oTm5FYLOPvztc7hJaVs+xbW
         Iyn70VNS9Of/OQj0i2nK/fhsmVf1wp5T7iouYvqjzJlpPu5pwUt0xIt14VzGCuaxyB1R
         fFecsQYNQhttxAlKS+Eb5TfjIfZUQIhHsWRItXdGlY/rZrPEzMSvEhBpr52/4aGff1h1
         gAGg==
Received: by 10.50.185.194 with SMTP id fe2mr121175igc.60.1349412973802;
        Thu, 04 Oct 2012 21:56:13 -0700 (PDT)
Received: from localhost.localdomain ([69.165.255.59])
        by mx.google.com with ESMTPS id p8sm99609igl.16.2012.10.04.21.56.11
        (version=SSLv3 cipher=OTHER);
        Thu, 04 Oct 2012 21:56:12 -0700 (PDT)
X-Mailer: git-send-email 1.8.0.rc0.18.gf84667d
In-Reply-To: <506E1327.1070602@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207071>

'format-patch' is failing due to out of memory, and the error not being caught.
So 'rebase' thinks 'am' has completed successfully and continue on with
cleanup. i.e. move_to_original_branch
So the user loses commits from the original head, and have to rely on reflog to
return to the original head.

Since the exit status of 'format-patch' is not available, we have to use ||
with 'format-patch' to handle the error.  Also, when 'format-patch' fails, the
state_dir does not necessarily exist, so I'm putting the 'format-patch-failed'
file inside GIT_DIR. Is there a better location to put such a file?

The way I handle the error feels a bit bruteforced.  Any suggestions on a
better way to handle the error?

I also thought about separating 'format-patch' and 'am' into two separate
commands, and use an intermediate file to store the output of 'format-patch'.
But the intermediate file could get very big, so it didn't seem like a good
idea.

Andrew Wong (1):
  rebase: Handle cases where format-patch fails

 git-rebase--am.sh | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

-- 
1.8.0.rc0.18.gf84667d
