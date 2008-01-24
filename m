From: Robert Schiele <rschiele@gmail.com>
Subject: [PATCH] some systems don't have (and need) sys/select.h
Date: Thu, 24 Jan 2008 19:34:46 +0100
Message-ID: <20080124183446.GJ30676@schiele.dyndns.org>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 19:35:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI6v5-0005yN-At
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 19:35:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbYAXSev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 13:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752530AbYAXSev
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 13:34:51 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:5409 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379AbYAXSeu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 13:34:50 -0500
Received: by fg-out-1718.google.com with SMTP id e21so321637fga.17
        for <git@vger.kernel.org>; Thu, 24 Jan 2008 10:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from:reply-to;
        bh=MUGFsKdNALyFoto2ZfNfTEGDwrf99QfKxu33OKLLRxQ=;
        b=j4iTVh8n40bikVNbD2TLljeNqzIO+XPZmju1B0qGSmPeqqAvRaOEWTJJGgEyfhsWYQZnJqFdrz3ZI2mAciEF5gHWXkDWv8oLN91phUn5NM6nDvybS5bxZN3geyUnEH4CsoUVHUDXmJSV0zTtOhKz3M/0wkoLhm/XAwb2O6Xul1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from:reply-to;
        b=GLPWUA4fGJy4g4RMELscnOx6pUF6OhtlRDpDLWyt8vRxlZlGUZBAYuno9rlbE2swP3VdbCuEV/DXXzPYuH+jP+u48bzEp3bUdhRq/cbGA97EkPFLiO3BZXrYCYFJJ0DTjHFwWWjsQDJqNouuLCWQycBfSNcw5/0Zasnh7au9Ivw=
Received: by 10.86.71.1 with SMTP id t1mr909759fga.33.1201199688926;
        Thu, 24 Jan 2008 10:34:48 -0800 (PST)
Received: from sigkill.schiele.dyndns.org ( [91.18.121.55])
        by mx.google.com with ESMTPS id l12sm1102056fgb.8.2008.01.24.10.34.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Jan 2008 10:34:48 -0800 (PST)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id 186152A8CF; Thu, 24 Jan 2008 19:34:47 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71644>

The select stuff is already in sys/time.h on on some systems like HP-UX
thus we should not include sys/select.h in that case.

Signed-off-by: Robert Schiele <rschiele@gmail.com>
---
This patch replaces my previously sent patch
"HP-UX traditionally has no sys/select.h".

 Makefile          |    5 +++++
 git-compat-util.h |    2 ++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 5aac0c0..c9e54b1 100644
--- a/Makefile
+++ b/Makefile
@@ -42,6 +42,8 @@ all::
 #
 # Define NO_MKDTEMP if you don't have mkdtemp in the C library.
 #
+# Define NO_SYS_SELECT_H if you don't have sys/select.h.
+#
 # Define NO_SYMLINK_HEAD if you never want .git/HEAD to be a symbolic link.
 # Enable it on Windows.  By default, symrefs are still used.
 #
@@ -635,6 +637,9 @@ ifdef NO_UNSETENV
 	COMPAT_CFLAGS += -DNO_UNSETENV
 	COMPAT_OBJS += compat/unsetenv.o
 endif
+ifdef NO_SYS_SELECT_H
+	BASIC_CFLAGS += -DNO_SYS_SELECT_H
+endif
 ifdef NO_MMAP
 	COMPAT_CFLAGS += -DNO_MMAP
 	COMPAT_OBJS += compat/mmap.o
diff --git a/git-compat-util.h b/git-compat-util.h
index b6ef544..4df90cb 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -68,7 +68,9 @@
 #include <sys/poll.h>
 #include <sys/socket.h>
 #include <sys/ioctl.h>
+#ifndef NO_SYS_SELECT_H
 #include <sys/select.h>
+#endif
 #include <assert.h>
 #include <regex.h>
 #include <netinet/in.h>
-- 
1.5.2.4
