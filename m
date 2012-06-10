From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC] git-blame.el: truncate author to avoid jagged left edge
 of code
Date: Sun, 10 Jun 2012 03:24:37 -0500
Message-ID: <20120610082437.GA29674@burratino>
References: <87vdgm3e1k.fsf@osv.gnss.ru>
 <20110204014315.GB28525@elie>
 <87tygkm8h7.fsf@krank.kagedal.org>
 <201102041103.10770.jnareb@gmail.com>
 <87r5bom7g3.fsf@krank.kagedal.org>
 <87oc6sm1ef.fsf@krank.kagedal.org>
 <20110211022928.GA24775@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Alexandre Julliard <julliard@winehq.org>, git@vger.kernel.org,
	Kevin Ryde <user42@zip.com.au>, Sergei Organov <osv@javad.com>,
	=?utf-8?Q?R=C3=BCdiger?= Sonderfeld <ruediger@c-plusplus.de>
To: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Sun Jun 10 10:26:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SddT8-0003E4-Dk
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 10:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465Ab2FJIYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jun 2012 04:24:54 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61506 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152Ab2FJIYt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 04:24:49 -0400
Received: by yhmm54 with SMTP id m54so2014868yhm.19
        for <git@vger.kernel.org>; Sun, 10 Jun 2012 01:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=FkgxRo3S1RyKpaCvfsoLW6dQrDyzN6SqR2RyLktfLmQ=;
        b=xcilEyagEY19UDxv/pBcK2zs043F3CZPdVM9zF3ZNyIZiDsr0YZ7Ne+ff2tNXdkOjr
         6gP3ixTBXLSZCa9J5cTbbZrf1wpeLHA/dc6/X0qSekSK7NbmxDZcu58Iv2UpKN7DLkB4
         HOn7xAgH/bvv6Xk4tUfNpGiyytI6Np1KfEYMuGCOGv0HepCYMQUxGzyCAoQEsdtPJnBX
         zd7Wis7v9Aghk6DamNYT9IPPhNDunFSAlzF6JWqBSTTsL0G7+4D0ZZWRNI1ydp/iIM8F
         pHHB6XPcLVcLFxq0HWQ4bfVgFlZLMjoamqm9lq320ZJmn57HFbkPs3r1lEAkyLIza+WY
         ZNDw==
Received: by 10.101.179.5 with SMTP id g5mr4693968anp.64.1339316688190;
        Sun, 10 Jun 2012 01:24:48 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id x42sm42169051yhd.3.2012.06.10.01.24.43
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Jun 2012 01:24:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110211022928.GA24775@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199576>

Without this patch, the author column in git-blame-mode spills
over in some rows:

	822a7d <ramsay@ramsay1.demon.co.uk>:const char git_usage_
	f2dd8c <jon.seymour@gmail.com>: "git [--version] [--exec-
	a1bea2 <josh@joshtriplett.org>: "           [-p|--paginat
	a1bea2 <josh@joshtriplett.org>: "           [--git-dir=<p
	293b07 <trast@student.ethz.ch>: "           [-c name=valu
	62b469 <stepan.nemec@gmail.com>:        "           <comm
	822a7d <ramsay@ramsay1.demon.co.uk>:

As a result, code meant to line up does not line up correctly and the
colored code area has a jagged left edge.

Specify a maximum width for the autohr email address in the default
blame prefix (i.e., use %20.20A instead of %20A) to fix it.

	822a7d <ramsay@ramsay1.demon.c:const char git_usage_strin
	f2dd8c <jon.seymour@gmail.com>: "git [--version] [--exec-

The (format) function used to implement format-spec has supported
precision specifiers like ".20" in emacs since 2002-12-09, so this
should be safe.

Helped-by: Kevin Ryde <user42@zip.com.au>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
In February of 2011, I wrote:

>  - email addresses are often longer than 20 characters.  Does
>    format-spec provide a way to truncate to a certain length,
>    so the prefixes can line up?

Better late than never, I guess.  Sensible?

 contrib/emacs/git-blame.el |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/emacs/git-blame.el b/contrib/emacs/git-blame.el
index d351cfb6..137d5ba9 100644
--- a/contrib/emacs/git-blame.el
+++ b/contrib/emacs/git-blame.el
@@ -102,7 +102,7 @@
   :group 'git-blame)
 
 (defcustom git-blame-prefix-format
-  "%h %20A:"
+  "%h %20.20A:"
   "The format of the prefix added to each line in `git-blame'
 mode. The format is passed to `format-spec' with the following format keys:
 
-- 
1.7.10
