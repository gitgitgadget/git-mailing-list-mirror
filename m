From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/1] Honor $(prefix) set in config.mak* when defining
 ETC_GIT* and sysconfdir
Date: Mon, 09 May 2011 10:24:55 +0200
Message-ID: <4DC7A4D7.2050401@viscovery.net>
References: <20110428192751.GE4833@camk.edu.pl> <4DBFA3C6.8060209@viscovery.net> <7vzkn3itb5.fsf@alter.siamese.dyndns.org> <4DC0E99E.6090402@viscovery.net> <20110504135827.GC18585@camk.edu.pl> <4DC1653A.7000000@viscovery.net> <7v4o5afht7.fsf@alter.siamese.dyndns.org> <7vwri5c27e.fsf@alter.siamese.dyndns.org> <20110505142910.GA31229@camk.edu.pl> <4DC2B814.5070507@viscovery.net> <20110505150036.GB31229@camk.edu.pl> <7vd3jxb16s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kacper Kornet <kornet@camk.edu.pl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 09 10:25:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJLmA-0005Vw-MH
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 10:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753504Ab1EIIZD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 04:25:03 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:48646 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753422Ab1EIIZB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 04:25:01 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QJLlv-0005dz-Ul; Mon, 09 May 2011 10:24:56 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A80221660F;
	Mon,  9 May 2011 10:24:55 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <7vd3jxb16s.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173208>

Am 5/5/2011 17:46, schrieb Junio C Hamano:
> Kacper Kornet <kornet@camk.edu.pl> writes:
> 
>> Should the patch be based on main or on the previous patch that was
>> merged to next?
> 
> After having this much discussion, it is preferrable to have a patch
> relative to what you have in 'next' (2910bf5) as a fix-up, explaining "The
> initial version does not cover these cases / has these problems" to
> summarize the discussion so far, followed by explanation of the
> incremental change "Fix this and that by doing ...".
> 
> We could revert what is in 'next' and start from scratch, but then it is
> likely that the thought process will be lost when you write the log
> message.

I'd implement it like this, discarding Kacper's patch, but I'm not sure
whether the commit message summarizes the discussion sufficiently. Let me
know whether you want a version based on top of Kacper's patch, or how
else to proceed.

Of your two patches regarding configure --sysconfdir, only the second
(e8de44bc05) is needed on top of this patch.

--- 8< ---
From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] Honor $(prefix) set in config.mak* when defining ETC_GIT*

Notice that the prefix specified for the build influenced the definitions
of ETC_GITCONFIG and ETC_GITATTRIBUTES only when it was exactly '/usr'.
Kacper Kornet noticed that this was furthermore only the case when the
build was triggered using 'make prefix=/usr', i.e., the prefix was given
on the command line; it did not work when the prefix was specified in
config.mak because this file is included much later in the Makefile.

To fix this, move the conditional after the inclusion of config.mak.

Additionally, it is desirable to specify the etc directory for a build
(for example, a build with prefix /usr/local may still want to have the
system configuration in /etc/gitconfig). For this purpose, promote the
variable 'sysconfdir' from a helper variable to a configuration
variable. The prefix check that was moved must now be wrapped so that it
does not override sysconfdir setting given in config.mak.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 Makefile |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index ca4b38e..10d6bd5 100644
--- a/Makefile
+++ b/Makefile
@@ -274,8 +274,7 @@ STRIP ?= strip
 #   mandir
 #   infodir
 #   htmldir
-#   ETC_GITCONFIG (but not sysconfdir)
-#   ETC_GITATTRIBUTES
+#   sysconfdir
 # can be specified as a relative path some/where/else;
 # this is interpreted as relative to $(prefix) and "git" at
 # runtime figures out where they are based on the path to the executable.
@@ -291,15 +290,8 @@ sharedir = $(prefix)/share
 gitwebdir = $(sharedir)/gitweb
 template_dir = share/git-core/templates
 htmldir = share/doc/git-doc
-ifeq ($(prefix),/usr)
-sysconfdir = /etc
 ETC_GITCONFIG = $(sysconfdir)/gitconfig
 ETC_GITATTRIBUTES = $(sysconfdir)/gitattributes
-else
-sysconfdir = $(prefix)/etc
-ETC_GITCONFIG = etc/gitconfig
-ETC_GITATTRIBUTES = etc/gitattributes
-endif
 lib = lib
 # DESTDIR=
 pathsep = :
@@ -1192,6 +1184,14 @@ endif
 -include config.mak.autogen
 -include config.mak
 
+ifndef sysconfdir
+ifeq ($(prefix),/usr)
+sysconfdir = /etc
+else
+sysconfdir = etc
+endif
+endif
+
 ifdef CHECK_HEADER_DEPENDENCIES
 COMPUTE_HEADER_DEPENDENCIES =
 USE_COMPUTED_HEADER_DEPENDENCIES =
-- 
1.7.4.1.317.g0b25
