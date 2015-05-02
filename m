From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: multiple source file extensions
Date: Sat, 2 May 2015 09:04:32 +0700
Message-ID: <20150502020431.GA15775@lanh>
References: <CACnwZYed_aHzLsbkJVm=OnydXw-CPi-Zm9V7928rzvpaFMNENw@mail.gmail.com>
 <CANuW5x3OBWNDnHeVbH7ZQaj5AUAingea6crJ0cF9AHFjcJE_bQ@mail.gmail.com>
 <20150502011100.GB5634@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josh Hagins <hagins.josh@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 02 04:04:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoMnD-0000JQ-Tf
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 04:04:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbbEBCEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 22:04:22 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:32874 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbbEBCEV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 22:04:21 -0400
Received: by pdbnk13 with SMTP id nk13so108138059pdb.0
        for <git@vger.kernel.org>; Fri, 01 May 2015 19:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=bVF1sk2ktQAOI5uaogH/f0FGL5CdrDKyHWVK1gs9X5M=;
        b=nSBRActp1tHKe2YhcFCY/wCCWqX5qi19ih7uCRTZ1lNNLDeUeZi4t5k0JCSuon/Xni
         efMrUTx7D+QJLegaExhnacFtL6O8DJqAst+BDoCaLl5jyl06H8+zqjB/WKCD1+LJ1KBW
         G0GIDGuIITTJD+uYcrF3dsc8MOUPp9ru0cpXn7FjvcShPNdgMlsNrhK5TBoPoVxE8i86
         JG7skRmqf0R3nV6sNBr74SYE8f+J6yJvg/RSXRiQiZWxYtBdWUKrLCrJjZY6HopG8UKO
         ETrbXARcS7ZF/Qf0tPlc75+SbZSJVrhzTEwuqMDhbBA9dZpwLDjF8jxOt2YvzyNDARjY
         +EmQ==
X-Received: by 10.66.218.193 with SMTP id pi1mr18427834pac.152.1430532261118;
        Fri, 01 May 2015 19:04:21 -0700 (PDT)
Received: from lanh ([115.73.247.43])
        by mx.google.com with ESMTPSA id pm1sm6017236pdb.89.2015.05.01.19.04.17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2015 19:04:20 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 02 May 2015 09:04:32 +0700
Content-Disposition: inline
In-Reply-To: <20150502011100.GB5634@peff.net>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268207>

On Fri, May 01, 2015 at 09:11:01PM -0400, Jeff King wrote:
> Unfortunately there is no way to use curly braces with git's pathspec,
> so you have to write out three separate `*` arguments rather than using
> the shell-style {cc,cpp,h}.

Noted. Need to add curly brace support in pathspec :-)

>   git grep pattern -- '*.cc' '*.cpp' '*.h'
> 
> Note that the "--" is important (it's what tells git "these are
> pathspecs and not revision names"; normally git will guess if you are
> passing literal pathnames, but the glob patterns fool the guessing
> machinery).

I'm having something like below to avoid the need for "--" in this
case. Probably a good time to throw it out and get some feedback. I
think it's a good change and does not compromise our ambiguity check..

This patch is modified just for reading so it may not build. The real
series takes care of "--" for both wildcard and magic pathspec. But I
don't think we need to see it now.

-- 8< --
Subject: [PATCH] Avoid the need of "--" when wildcard pathspec is used

When "--" is lacking from the command line and a command can take both
revs and paths, the idea is if an argument can be seen as both an
extended SHA-1 and a path, then "--" is required or git refuses to
continue. It's currently implemented as:

 (1) if an argument is rev, then it must not exist in worktree

 (2) else, it must exist in worktree

 (3) else, "--" is required.

These rules work for literal paths, but when non-literal pathspec is
involved, it almost always requires the user to add "--" because it
fails (2) and (1) is really rarely met (take "*.c" for example,
(1) is met if there is a ref named "*.c").

This patch modifies the rules a bit by considering any valid (*)
wildcard pathspec "exist in worktree". The rules become:

 (1) if an arg is a rev, then it must either exist in worktree or not
     be a valid wildcard pathspec.

 (2) else, it either exists in worktree or is a wildcard pathspec

 (3) else, "--" is required.

With the new rules, "--" is not needed most of the time when wildcard
pathspec is involved.
---
 setup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 979b13f..1055b82 100644
--- a/setup.c
+++ b/setup.c
@@ -140,7 +140,9 @@ int check_filename(const char *prefix, const char *arg)
 		if (arg[2] == '\0') /* ":/" is root dir, always exists */
 			return 1;
 		name = arg + 2;
-	} else if (prefix)
+	} else if (!no_wildcard(arg))
+		return 1;
+	else if (prefix)
 		name = prefix_filename(prefix, strlen(prefix), arg);
 	else
 		name = arg;
-- 
2.3.0.rc1.137.g477eb31

-- 8< --
 
