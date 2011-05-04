From: Kacper Kornet <kornet@camk.edu.pl>
Subject: Re: [PATCH 1/1] Honor $(prefix) set in config.mak* when defining
 ETC_GIT* and sysconfdir
Date: Wed, 4 May 2011 16:29:21 +0200
Message-ID: <20110504142921.GE18585@camk.edu.pl>
References: <20110428022922.GC4833@camk.edu.pl>
 <7v62py5nbp.fsf@alter.siamese.dyndns.org>
 <20110428192751.GE4833@camk.edu.pl>
 <4DBFA3C6.8060209@viscovery.net>
 <7vzkn3itb5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 16:29:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHd57-0003Zf-2K
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 16:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929Ab1EDO3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 10:29:31 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:34891 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753715Ab1EDO3a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 10:29:30 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 9BE2F5F0049;
	Wed,  4 May 2011 16:29:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id l0ZKjrJCMHQe; Wed,  4 May 2011 16:29:21 +0200 (CEST)
Received: from gatekeeper.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 93FD75F0046;
	Wed,  4 May 2011 16:29:21 +0200 (CEST)
Received: by gatekeeper.camk.edu.pl (Postfix, from userid 1293)
	id 88ED780AC5; Wed,  4 May 2011 16:29:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vzkn3itb5.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172745>

On Tue, May 03, 2011 at 10:32:14AM -0700, Junio C Hamano wrote:
> We can get rid of assignments to sysconfdir in that sense. But you spotted
> a regression. If sysconfdir is set to somewhere else, even if you set prefix
> to /usr, we should set ETC_GIT* using the value given to sysconfdir.  The
> original code did so, but the patch lost it.

Actually syconfdir was respected only when prefix was /usr. When it was
not /usr, ETC_GIT* were always set to etc/... The following version of
patch reproduces that behaviour:

>From 1a438bc0ac71a96398260b73b3c24c5e752a02f5 Mon Sep 17 00:00:00 2001
From: Kacper Kornet <draenog@pld-linux.org>
Date: Thu, 28 Apr 2011 02:42:48 +0100
Subject: [PATCH] Honor $(prefix) set in config.mak* when defining ETC_GIT*
 and sysconfdir

Definitions of ETC_GITCONFIG, ETC_GITATTRIBUTES and sysconfdir depend on
value of prefix. As prefix can be changed in config.mak.autogen, all if
blocks with conditions based on prefix should be placed after the file
is included in Makefile.

Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
---
 Makefile |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index cbc3fce..31b558e 100644
--- a/Makefile
+++ b/Makefile
@@ -291,15 +291,8 @@ sharedir = $(prefix)/share
 gitwebdir = $(sharedir)/gitweb
 template_dir = share/git-core/templates
 htmldir = share/doc/git-doc
-ifeq ($(prefix),/usr)
-sysconfdir = /etc
-ETC_GITCONFIG = $(sysconfdir)/gitconfig
-ETC_GITATTRIBUTES = $(sysconfdir)/gitattributes
-else
-sysconfdir = $(prefix)/etc
-ETC_GITCONFIG = etc/gitconfig
-ETC_GITATTRIBUTES = etc/gitattributes
-endif
+ETC_GITCONFIG = $(git_etcdir)/gitconfig
+ETC_GITATTRIBUTES = $(git_etcdir)/gitattributes
 lib = lib
 # DESTDIR=
 pathsep = :
@@ -1192,6 +1185,14 @@ endif
 -include config.mak.autogen
 -include config.mak
 
+ifeq ($(prefix),/usr)
+sysconfdir = /etc
+git_etcdir = $(sysconfdir)
+else
+sysconfdir = $(prefix)/etc
+git_etcdir = etc
+endif
+
 ifdef CHECK_HEADER_DEPENDENCIES
 COMPUTE_HEADER_DEPENDENCIES =
 USE_COMPUTED_HEADER_DEPENDENCIES =
-- 
1.7.5

-- 
  Kacper Kornet
