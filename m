From: Joe Ratterman <jratt0@gmail.com>
Subject: [PATCH] Add two grep config options
Date: Fri, 25 Mar 2011 16:21:11 -0500
Message-ID: <1301088071-918-1-git-send-email-jratt0@gmail.com>
Cc: Joe Ratterman <jratt0@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 25 22:21:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3ERs-0006zg-0I
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 22:21:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755116Ab1CYVVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 17:21:31 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51587 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754599Ab1CYVVa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 17:21:30 -0400
Received: by iwn34 with SMTP id 34so1469841iwn.19
        for <git@vger.kernel.org>; Fri, 25 Mar 2011 14:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=LGaoEd1NEjewob8MgazKnOEcv+tsUD6w1P4GyvP1Dco=;
        b=hGvOYJkwofA4sJ2pYEwMTxIxfjHIBC0z1JL8HBmMBUZBqSeth0QYcfAX8mTjD1N8rf
         kTob5bUnaUjeeerhv2wH8ikIWxztLE5weoInnzKaJ/kDbDdlxXVPHhUk24pCqQTtK5re
         NpChjtP2Hc3kkzF0pHQ0N0Ia0Ivcnof8sPWVM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=hYXaBh5NWon18pz3QXuygyb1Lbx7QJAqeqKi+Z6KnQzo2ywjWV6lSdq6BWoZAtu9I6
         ogkAnmAmIv/lN40sEkdG0LFGb+HHGBkyZBCyAjldS/VtQ0IltLEriCgfRJIJ9I4d7FPf
         WRSnLScTed6aI/RfWjGw/riwAegI5tasZQr0E=
Received: by 10.43.45.7 with SMTP id ui7mr1877023icb.262.1301088089626;
        Fri, 25 Mar 2011 14:21:29 -0700 (PDT)
Received: from localhost.localdomain (rchp5.rochester.ibm.com [129.42.161.50])
        by mx.google.com with ESMTPS id 8sm891886iba.4.2011.03.25.14.21.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Mar 2011 14:21:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1.3.gbe203
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170019>

grep.extended-regexp: Enabling this boolean option has the same effect
as adding "-E" to all "git grep " instantiations.  This can be
disabled by specifying "--no-extended-regexp" on a particular call.

grep.line-numbers: Enabling this boolean option has the same effect as
adding "-n" to all "git grep " instantiations.

Signed-off-by: Joe Ratterman <jratt0@gmail.com>
---
 Documentation/config.txt   |    6 ++++++
 Documentation/git-grep.txt |    9 +++++++++
 builtin/grep.c             |   10 ++++++++++
 3 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c5e1835..6b084a8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1101,6 +1101,12 @@ All gitcvs variables except for 'gitcvs.usecrlfattr' and
 is one of "ext" and "pserver") to make them apply only for the given
 access method.
 
+grep.line-numbers::
+	If set to true, enable '-n' option by default.
+
+grep.extended-regexp::
+	If set to true, enable '--extended-regexp' option by default.
+
 gui.commitmsgwidth::
 	Defines how wide the commit message window is in the
 	linkgit:git-gui[1]. "75" is the default.
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index dab0a78..71668e0 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -31,6 +31,15 @@ Look for specified patterns in the tracked files in the work tree, blobs
 registered in the index file, or blobs in given tree objects.
 
 
+CONFIGURATION
+-------------
+
+grep.line-numbers::
+	If set to true, enable '-n' option by default.
+
+grep.extended-regexp::
+	If set to true, enable '--extended-regexp' option by default.
+
 OPTIONS
 -------
 --cached::
diff --git a/builtin/grep.c b/builtin/grep.c
index fdf7131..fed9f65 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -303,6 +303,16 @@ static int grep_config(const char *var, const char *value, void *cb)
 	default: return 0;
 	}
 
+	if (!strcmp(var, "grep.extended-regexp")) {
+		opt->regflags = git_config_bool(var, value);
+		return 0;
+	}
+
+	if (!strcmp(var, "grep.line-numbers")) {
+		opt->linenum = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "color.grep"))
 		opt->color = git_config_colorbool(var, value, -1);
 	else if (!strcmp(var, "color.grep.context"))
-- 
1.7.4.1.4.g0ea33
