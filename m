From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [BUG?] git.el: M-x git-commit-file produces error if font lock is
 disabled
Date: Thu, 3 Feb 2011 18:10:16 -0600
Message-ID: <20110204001016.GC16688@elie>
References: <87lkkgw9mg.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Ryde <user42@zip.com.au>, git@vger.kernel.org,
	David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Fri Feb 04 01:10:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl9Fu-0007ju-7Q
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 01:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754830Ab1BDAKY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 19:10:24 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:43677 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183Ab1BDAKY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 19:10:24 -0500
Received: by qyj19 with SMTP id 19so7642508qyj.19
        for <git@vger.kernel.org>; Thu, 03 Feb 2011 16:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=g2BvZnIKjgtGLY5HYh2POs1NatYQfqdIncNbQJcfan4=;
        b=vAmgkOjuDu4RcC0kzjLJAnUyg3KcxRUhYzHUSPAYAVS+ehIY0Z4Su6KaVgWTABCSwe
         gH42qlVXebr6QOOodeNumTS0dkKOVfB7+lldwtOX97pf9qdzMddo2QwmpPHsgmXKrCfr
         XH9/hJ2OfYPX5psLYF3nJXw1xpl//O3joGVto=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=WLf6m3Eq0U3vE7wop5gD6orTdOe+Kz4pxegZUygn+o2SIYiGdEWnnv4DLk0e9cAqN/
         XzpTHxyPsy3heOK4asSf8GBTdVrW9pBYrrGGATZKMkJHIJr4Ed4fMOdervRsLLwCx6up
         9imLfpqCaJXIEaBPU0T9h++JsQt/2F6gqjQbk=
Received: by 10.224.191.196 with SMTP id dn4mr10331710qab.225.1296778223268;
        Thu, 03 Feb 2011 16:10:23 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id h20sm79480qck.0.2011.02.03.16.10.21
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 03 Feb 2011 16:10:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87lkkgw9mg.fsf@wine.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166012>

Hi,

Kevin Ryde reports[1]:

> If font lock is disabled, M-x git-commit-file gets an error when setting
> up the log message edit buffer.
>
>     M-: (global-font-lock-mode 0)
>     M-x git-status
>     /some/git/directory
>     c         <- on a modified file
>
>     => Font-lock trying to use keywords before setting them up
>
> I suppose font-lock-compile-keywords should not be used if font lock is
> not enabled.  I suspect font-lock-add-keywords might be the right thing
> instead.  It seems to work for me (the code is supposed to replace the
> normal log-edit-mode keywords is it?).

and suggests a patch[2].  Does it make sense?

Ignorantly,
Jonathan

[1] http://bugs.debian.org/577834 from a while ago.
Sorry for the long delay.
[2]

 contrib/emacs/git.el |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 214930a..0c93ef1 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -1337,7 +1337,7 @@ The FILES list must be sorted."
 	  (log-edit 'git-do-commit nil '((log-edit-listfun . git-log-edit-files)
 					 (log-edit-diff-function . git-log-edit-diff)) buffer)
 	(log-edit 'git-do-commit nil 'git-log-edit-files buffer))
-      (setq font-lock-keywords (font-lock-compile-keywords git-log-edit-font-lock-keywords))
+      (font-lock-add-keywords nil git-log-edit-font-lock-keywords 'set)
       (setq paragraph-separate (concat (regexp-quote git-log-msg-separator) "$\\|Author: \\|Date: \\|Merge: \\|Signed-off-by: \\|\f\\|[ 	]*$"))
       (setq buffer-file-coding-system coding-system)
       (re-search-forward (regexp-quote (concat git-log-msg-separator "\n")) nil t))))
-- 
1.7.4
