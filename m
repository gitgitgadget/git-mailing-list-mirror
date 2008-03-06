From: imyousuf@gmail.com
Subject: [PATCH] - Added pre command and custom argument support to git submodule recurse command
Date: Thu,  6 Mar 2008 13:33:36 +0600
Message-ID: <1204788817-22720-4-git-send-email-imyousuf@gmail.com>
References: <1204788817-22720-1-git-send-email-imyousuf@gmail.com>
 <1204788817-22720-2-git-send-email-imyousuf@gmail.com>
 <1204788817-22720-3-git-send-email-imyousuf@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 06 08:35:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXAd5-00083r-Kl
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 08:35:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758774AbYCFHeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 02:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758752AbYCFHeY
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 02:34:24 -0500
Received: from hu-out-0506.google.com ([72.14.214.236]:41464 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758712AbYCFHeX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 02:34:23 -0500
Received: by hu-out-0506.google.com with SMTP id 19so1229660hue.21
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 23:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=RZ7GBtkJRtHm4LenbhGbmdiaHlUF+cOnwyTQdFg+C6A=;
        b=C0zi7k9W+5D/7pS+zgXGxQZk02WU+wp5zvE8vlO1vOiejXzsigbxK2HP2Uj26y5SFMAQY7ssuRrlenc9GcM7JKtk8AjtJNoBmOxofPfP98DOla5LDBpygBKRH2ArWVEx9bQKCgoCZW2733tuEdh+FgtZYfEhdfZ/uEH7vTUL4mM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GCPPUoyICpb6JacyDQa45+J5beCBWt6sa7IntoHth9aqliT+4mrMSdJTQQ1Skgt8PkOq3zqfJbPg/hX/kiIfm2Q/TOLNPv6ufYlEhvLX0wZcpvySkaTqdWiNEugseP4Kdt+V/7jXV+U4kqf0+crHb1diF5ueRU1hH9ey/bKGHGk=
Received: by 10.86.9.8 with SMTP id 8mr4260751fgi.70.1204788863078;
        Wed, 05 Mar 2008 23:34:23 -0800 (PST)
Received: from localhost ( [62.101.198.35])
        by mx.google.com with ESMTPS id q9sm3091343gve.10.2008.03.05.23.34.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Mar 2008 23:34:22 -0800 (PST)
X-Mailer: git-send-email 1.5.4.2
In-Reply-To: <1204788817-22720-3-git-send-email-imyousuf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76350>

A noteworthy change is that modules_list() is now known as
cmd_status().  There is no "submodule list" command.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * We could probably do something like this.  This first part is
   about making the command dispatcher maintainable.

   Note that I haven't seriously tested this series.  This and
   the next one are primarily to illustrate what I think the fix
   you are trying should look like.

 git-submodule.sh |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index ad9fe62..3c104e3 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -86,9 +86,9 @@ module_name()
 #
 # Clone a submodule
 #
-# Prior to calling, modules_update checks that a possibly existing
+# Prior to calling, cmd_update checks that a possibly existing
 # path is not a git repository.
-# Likewise, module_add checks that path does not exist at all,
+# Likewise, cmd_add checks that path does not exist at all,
 # since it is the location of a new submodule.
 #
 module_clone()
@@ -121,7 +121,7 @@ module_clone()
 #
 # optional branch is stored in global branch variable
 #
-module_add()
+cmd_add()
 {
        repo=$1
        path=$2
@@ -174,7 +174,7 @@ module_add()
 #
 # $@ = requested paths (default to all)
 #
-modules_init()
+cmd_init()
 {
        git ls-files --stage -- "$@" | grep -e '^160000 ' |
        while read mode sha1 stage path
@@ -207,7 +207,7 @@ modules_init()
 #
 # $@ = requested paths (default to all)
 #
-modules_update()
+cmd_update()
 {
        git ls-files --stage -- "$@" | grep -e '^160000 ' |
        while read mode sha1 stage path
@@ -266,7 +266,7 @@ set_name_rev () {
 #
 # $@ = requested paths (default to all)
 #
-modules_list()
+cmd_status()
 {
        git ls-files --stage -- "$@" | grep -e '^160000 ' |
        while read mode sha1 stage path
@@ -347,16 +347,16 @@ esac

 case "$add,$init,$update,$status,$cached" in
 1,,,,)
-       module_add "$@"
+       cmd_add "$@"
        ;;
 ,1,,,)
-       modules_init "$@"
+       cmd_init "$@"
        ;;
 ,,1,,)
-       modules_update "$@"
+       cmd_update "$@"
        ;;
 ,,,*,*)
-       modules_list "$@"
+       cmd_status "$@"
        ;;
 *)
        usage
--
1.5.3.7
