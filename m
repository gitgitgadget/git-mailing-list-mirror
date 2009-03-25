From: Johan Herland <johan@herland.net>
Subject: [PATCH/RFC 1/7] Clarify documentation on permissions in shared
 repositories
Date: Wed, 25 Mar 2009 22:37:29 +0100
Message-ID: <200903252237.29367.johan@herland.net>
References: <200903250105.05808.johan@herland.net>
 <7v63hybaqd.fsf@gitster.siamese.dyndns.org>
 <200903252236.03010.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 22:39:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmaoT-0005tL-Hd
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 22:39:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756474AbZCYVhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 17:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756447AbZCYVhf
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 17:37:35 -0400
Received: from mx.getmail.no ([84.208.15.66]:35386 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756284AbZCYVhe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 17:37:34 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KH30098R02J8F00@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 25 Mar 2009 22:37:31 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KH300MZR02H6I10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 25 Mar 2009 22:37:31 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.3.25.212528
User-Agent: KMail/1.11.1 (Linux/2.6.28-ARCH; KDE/4.2.1; x86_64; ; )
In-reply-to: <200903252236.03010.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114672>

The "core.sharedRepository" config variable (and, by extension, the
"--shared" argument to "git init") can be used to loosen repository
permissions for users with a safe umask, but it can not be used to
tighten repository permissions for users with a more lenient umask.

This patch updates the documentation to clarify the current behaviour.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/config.txt   |   15 +++++++++++----
 Documentation/git-init.txt |   12 ++++++++----
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 089569a..d5befd5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -294,10 +294,17 @@ core.sharedRepository::
 	repository will be readable by all users, additionally to being
 	group-shareable. When 'umask' (or 'false'), git will use permissions
 	reported by umask(2). When '0xxx', where '0xxx' is an octal number,
-	files in the repository will have this mode value. '0xxx' will override
-	user's umask value, and thus, users with a safe umask (0077) can use
-	this option. Examples: '0660' is equivalent to 'group'. '0640' is a
-	repository that is group-readable but not group-writable.
+	files in the repository will have (at least) this mode value. '0xxx'
+	will override a safer umask value, and thus, users with a safe umask
+	(0077) can use this option to loosen the repository permissions.
+	Examples: '0660' is equivalent to 'group'. '0640' is a repository
+	that is group-readable but not group-writable (unless umask allows
+	group-writability).
+	Note: Even when not set to 'umask' (or 'false') this option is still
+	combined with the umask to produce the actual mode value. For
+	example, if umask is 0022, setting 'group' (or '0660') will not make
+	the repository non world-readable (the actual mode value will in fact
+	be '0664').
 	See linkgit:git-init[1]. False by default.
 
 core.warnAmbiguousRefs::
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 71749c0..bddc01b 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -45,6 +45,7 @@ repository.  When specified, the config variable "core.sharedRepository" is
 set so that files and directories under `$GIT_DIR` are created with the
 requested permissions.  When not specified, git will use permissions reported
 by umask(2).
+When specified, the permissions will still be no stricter than the umask.
 
 The option can have the following values, defaulting to 'group' if no value
 is given:
@@ -58,11 +59,14 @@ is given:
  - 'all' (or 'world' or 'everybody'): Same as 'group', but make the repository
    readable by all users.
 
- - '0xxx': '0xxx' is an octal number and each file will have mode '0xxx'
+ - '0xxx': '0xxx' is an octal number and each file will have (at least) this
+   mode value.
    Any option except 'umask' can be set using this option. '0xxx' will
-   override users umask(2) value, and thus, users with a safe umask (0077)
-   can use this option. '0640' will create a repository which is group-readable
-   but not writable. '0660' is equivalent to 'group'.
+   override a safer umask(2) value (but not a more permissive umask), and
+   thus, users with a safe umask (e.g. 0077) can use this option to loosen
+   repository permissions. '0640' will create a repository which is
+   group-readable but not writable (unless umask allows group-writability).
+   '0660' is equivalent to 'group'.
 
 By default, the configuration flag receive.denyNonFastForwards is enabled
 in shared repositories, so that you cannot force a non fast-forwarding push
-- 
1.6.2.1.473.g92672
