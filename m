From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Makefile: do not set setgid bit on directories on
 GNU/kFreeBSD
Date: Mon, 3 Oct 2011 01:41:20 -0500
Message-ID: <20111003064120.GA24396@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Salinger <Petr.Salinger@seznam.cz>
X-From: git-owner@vger.kernel.org Mon Oct 03 08:43:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAcFb-00032n-9v
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 08:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133Ab1JCGlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 02:41:37 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45645 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888Ab1JCGlf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 02:41:35 -0400
Received: by iaqq3 with SMTP id q3so4678916iaq.19
        for <git@vger.kernel.org>; Sun, 02 Oct 2011 23:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=bEnMYz3J5fcAqV8HQAhzMSOjijE52Gb8ABIYAZo7GR0=;
        b=IbCdgC2siKXUmO3upybZpwuCuIRoejizkEpMhSiDCL2kq7b8PyxmU1UAJ2xrWHmb+7
         EVKyq3zi/oEaCI5LWs2sA7CeiQfCEb0jqzBPDOYk7cC7Unf5vqeJFyfdZX6dDwk+uClc
         X03B7hc8ZPJNyxdl5L88tmd90GZuX3w4ScuyI=
Received: by 10.42.149.74 with SMTP id u10mr7152484icv.215.1317624094939;
        Sun, 02 Oct 2011 23:41:34 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id fy35sm27378204ibb.4.2011.10.02.23.41.34
        (version=SSLv3 cipher=OTHER);
        Sun, 02 Oct 2011 23:41:34 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182626>

The g+s bit on directories to make group ownership inherited is a
SysVism --- BSD and most of its descendants do not need it since they
do the sane thing by default without g+s.  In fact, on some
filesystems (but not all --- tmpfs works this way but UFS does not),
the kernel of FreeBSD does not even allow non-root users to set setgid
bit on directories and produces errors when one tries:

	$ git init --shared dir
	fatal: Could not make /tmp/dir/.git/refs writable by group

Since the setgid bit would only mean "do what you were going to do
already", it's better to avoid setting it.  Accordingly, ever since
v1.5.5-rc0~59^2 (Do not use GUID on dir in git init --share=all on
FreeBSD, 2008-03-05), git on true FreeBSD has done exactly that.  Set
DIR_HAS_BSD_GROUP_SEMANTICS in the makefile for GNU/kFreeBSD, too, so
machines that use glibc with the kernel of FreeBSD get the same fix.

This fixes t0001-init.sh and t1301-shared-repo.sh on GNU/kFreeBSD
when running tests with --root pointing to a directory that uses
tmpfs.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Sorry to have taken so long to send this one out.  Anyway, it seems
to me like the right thing to do.  Petr, what do you think?

 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 8d6d4515..924749ed 100644
--- a/Makefile
+++ b/Makefile
@@ -820,6 +820,7 @@ ifeq ($(uname_S),GNU/kFreeBSD)
 	NO_STRLCPY = YesPlease
 	NO_MKSTEMPS = YesPlease
 	HAVE_PATHS_H = YesPlease
+	DIR_HAS_BSD_GROUP_SEMANTICS = YesPlease
 endif
 ifeq ($(uname_S),UnixWare)
 	CC = cc
-- 
1.7.7.rc1
