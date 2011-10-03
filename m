From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] ident: check /etc/mailname if email is unknown
Date: Mon, 3 Oct 2011 02:44:34 -0500
Message-ID: <20111003074433.GD17289@elie>
References: <20111003045745.GA17604@elie>
 <7v8vp2iqvc.fsf@alter.siamese.dyndns.org>
 <20111003061633.GB17289@elie>
 <4E895FBD.8020904@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Matt Kraai <kraai@ftbfs.org>, Gerrit Pape <pape@smarden.org>,
	Ian Jackson <ijackson@chiark.greenend.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 03 09:44:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAdCf-0003L1-Eb
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 09:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045Ab1JCHom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 03:44:42 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56493 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175Ab1JCHok (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 03:44:40 -0400
Received: by yxl31 with SMTP id 31so3224472yxl.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 00:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=71Tg861BF/rsl3g4YabTtnUmpTf8ovk4GfY5di0FgSo=;
        b=qMzSsaBc7ncr8a8mjm12ijKCiH9eDuQBt780jz9kFz43UFfdwh1iQHBSG2ny1v9k8H
         KRXSCTq0LgR/6lyzYKBxfUrTboTQI21bmR4HyJqR0ttPrXd58MSaqjS3s1lkuAPIdjT9
         uvk+q0i0ifeKJ5AGLcI6kat9XwWgURFGxTOnc=
Received: by 10.42.28.65 with SMTP id m1mr3332584icc.81.1317627879881;
        Mon, 03 Oct 2011 00:44:39 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id t9sm27713640ibq.11.2011.10.03.00.44.38
        (version=SSLv3 cipher=OTHER);
        Mon, 03 Oct 2011 00:44:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4E895FBD.8020904@viscovery.net>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182636>

Johannes Sixt wrote:

> This warns on EACCES. Is that OK? (Just asking, I have no opinion.)

Good catch.  I was worried for a moment: could some command call
copy_email() in a loop, producing an annoyingly redundant stream of
warnings?

Luckily setup_ident() checks if git_default_email has been set to save
the trouble of computing it again.  So the behavior is to warn exactly
once when using a command that uses an ident string, which is still
more often than ideal.  It would be better to only warn if the
permissions are creating an actual problem, so the user can (1)
complain to the sysadmin and then (2) set an email address in
~/.gitconfig and move on.

We _could_ add parameters to setup_ident() to only warn if
/etc/mailname was going to be used to produce the committer ident (or
whichever ident is checked first).  That would be confusing if
GIT_COMMITTER_EMAIL is set and GIT_AUTHOR_EMAIL is not.

In the long term it would be nice to find a way to warn when the
mailname we tried to retrieve was actually going to be used, but short
of that, the least confusing behavior is to just not warn at all.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 ident.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/ident.c b/ident.c
index edb43144..6f5c885d 100644
--- a/ident.c
+++ b/ident.c
@@ -55,16 +55,9 @@ static int add_mailname_host(char *buf, size_t len)
 	FILE *mailname;
 
 	mailname = fopen("/etc/mailname", "r");
-	if (!mailname) {
-		if (errno != ENOENT)
-			warning("cannot open /etc/mailname: %s",
-				strerror(errno));
+	if (!mailname)
 		return -1;
-	}
 	if (!fgets(buf, len, mailname)) {
-		if (ferror(mailname))
-			warning("cannot read /etc/mailname: %s",
-				strerror(errno));
 		fclose(mailname);
 		return -1;
 	}
@@ -80,7 +73,6 @@ static void add_domainname(char *buf, size_t len)
 	const char *domainname;
 
 	if (gethostname(buf, len)) {
-		warning("cannot get host name: %s", strerror(errno));
 		strlcpy(buf, "(none)", len);
 		return;
 	}
-- 
1.7.7.rc1
