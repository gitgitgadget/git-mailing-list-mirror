From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] t1020-subdirectory: test alias expansion in a
 subdirectory
Date: Mon, 8 Nov 2010 17:20:56 +0700
Message-ID: <20101108102056.GA12366@do>
References: <627dc7921dc64a16063e77d542cf9edb22631ddd.1289205059.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Nov 08 11:22:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFOre-00018Z-HC
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 11:22:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753648Ab0KHKWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 05:22:06 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33991 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753414Ab0KHKWE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 05:22:04 -0500
Received: by pzk28 with SMTP id 28so798749pzk.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 02:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=Dki9QsYDDWdnQq1FZz3jjOr2FXiyMwI5NrzyhiAeiws=;
        b=MxT9ZxN5bRRudPvymNhXQPKf2lTT0GHgcXWaGDSH2wUnB2L3RAfR85QLEQFOs+Qf33
         ISdrvtlr/+ZbenQNQ/Q16buqJ0Ppv8wzxGSi9epxLjhcG/Dw3+i1Cker5eyG8l6wx4NR
         ciVsoFw3V6YrviVgdsRDwhnoSQjNHN23TSPxM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ape+dbSEQXrWb6j8UFS7eP22rF+eObUFVbzUsjTCKcgwwBHfGnfod+jKcknLMsIZP5
         3fBVK5PCC8SpXSxFXf6lGAuAnC48hu1RGe5EzQyYETMWU6kcq4ef41Ak5eNsK8aJRZ+X
         iVVUlmeT8OlQtytG3qN57r8/5FNoiRBzUqTRU=
Received: by 10.142.172.9 with SMTP id u9mr270584wfe.197.1289211723616;
        Mon, 08 Nov 2010 02:22:03 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.196.139])
        by mx.google.com with ESMTPS id q13sm7858542wfc.17.2010.11.08.02.21.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Nov 2010 02:22:01 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 08 Nov 2010 17:20:56 +0700
Content-Disposition: inline
In-Reply-To: <627dc7921dc64a16063e77d542cf9edb22631ddd.1289205059.git.git@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160917>

On Mon, Nov 08, 2010 at 09:32:03AM +0100, Michael J Gruber wrote:
> Add a test for alias expansion in a subdirectory of the worktree.
> 
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> 
> ---
>     65f3a9e (Remove all logic from get_git_work_tree(), 2010-11-01) breaks this test,
>     which is why I am adding it.

How about squashing this in?

--8<--
Subject: Allow set_git_work_tree() to be called more than once

Usually one of the setup functions is called once. However alias
handling code needs to look ahead in $GIT_DIR/config for aliases. So
set_git_work_tree() may be called twice: once when alias is searched,
once when the actual command is run.

Loosen the condition and let it through. We can stricten it back when
alias handling is fixed.
---
diff --git a/environment.c b/environment.c
index 6db00da..f0d0b07 100644
--- a/environment.c
+++ b/environment.c
@@ -128,8 +128,6 @@ const char *get_git_dir(void)
 	return git_dir;
 }
 
-static int git_work_tree_initialized;
-
 /*
  * Note.  This works only before you used a work tree.  This was added
  * primarily to support git-clone to work in a new repository it just
@@ -137,9 +135,7 @@ static int git_work_tree_initialized;
  */
 void set_git_work_tree(const char *new_work_tree)
 {
-	if (git_work_tree_initialized)
-		die("internal error: work tree has already been set");
-	git_work_tree_initialized = 1;
+	free(work_tree);
 	work_tree = xstrdup(make_absolute_path(new_work_tree));
 }
 
--8<--
-- 
Duy
