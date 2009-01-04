From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: [PATCH v2 tested-v2] git-sh-setup: Fix scripts whose PWD is a symlink to a work-dir on OS X
Date: Sun,  4 Jan 2009 13:47:29 -0800
Message-ID: <1231105649-12998-1-git-send-email-marcel@oak.homeunix.org>
References: <8C7E36D0-C037-427D-B6E2-4050CC767CD0@marzelpan.de>
Cc: git@vger.kernel.org, jnareb@gmail.com, ae@op5.se,
	j.sixt@viscovery.net, git-dev@marzelpan.de,
	"Marcel M. Cary" <marcel@oak.homeunix.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 04 22:49:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJaq6-0000R9-SW
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 22:48:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758331AbZADVrf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 16:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756702AbZADVrf
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 16:47:35 -0500
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:40225 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758331AbZADVre (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jan 2009 16:47:34 -0500
Received: (qmail 8753 invoked from network); 4 Jan 2009 21:47:30 -0000
Received: from unknown (HELO ordinateur.home.org) (marcel@76.231.191.38 with plain)
  by smtp115.sbc.mail.sp1.yahoo.com with SMTP; 4 Jan 2009 21:47:29 -0000
X-YMail-OSG: mHinjIEVM1lKitqP1gP_eN9W47COVRA.ff0zW5LEfCkgoU5m6DL1JFUYQ76HS_SX45eZGpBxCK2Hr6C9tt_b6Wna1LFMUc_grDVz7XbUp3RnfJ52F8HmUPK57I5nPZd8cMGGhLvjmEbs4mSrk7WjTkNj0jL31Ca_ZtJ9d.kZvGbqGynNBgA0Ad3ezgRd_Q--
X-Yahoo-Newman-Property: ymail-5
Received: from polliwog.home.org ([192.168.0.18] helo=localhost.localdomain)
	by ordinateur.home.org with esmtp (Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1LJaoi-0007yy-Gr; Sun, 04 Jan 2009 13:47:28 -0800
X-Mailer: git-send-email 1.6.1
In-Reply-To: <8C7E36D0-C037-427D-B6E2-4050CC767CD0@marzelpan.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104542>

On Mac OS X and possibly BSDs, /bin/pwd reads PWD from the environment
if available and shows the logical path by default rather than the
physical one.

Unset PWD before running /bin/pwd in both cd_to_toplevel and its
test.

Still use the external /bin/pwd because in my Bash on Linux,
the builtin pwd prints the same result whether or not PWD is set.

Signed-off-by: Marcel M. Cary <marcel@oak.homeunix.org>
Tested-by: Marcel Koeppen <git-dev@marzelpan.de> (on Mac OS X 10.5.6)
---

> please add
> 
> Tested-by: Marcel Koeppen <git-dev@marzelpan.de> (on Mac OS X 10.5.6)

Now with the OS, in detail.


 git-sh-setup.sh           |    2 +-
 t/t2300-cd-to-toplevel.sh |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index f07d96b..2142308 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -96,7 +96,7 @@ cd_to_toplevel () {
 		..|../*|*/..|*/../*)
 			# Interpret $cdup relative to the physical, not logical, cwd.
 			# Probably /bin/pwd is more portable than passing -P to cd or pwd.
-			phys="$(/bin/pwd)/$cdup"
+			phys="$(unset PWD; /bin/pwd)/$cdup"
 			;;
 		*)
 			# There's no "..", so no need to make things absolute.
diff --git a/t/t2300-cd-to-toplevel.sh b/t/t2300-cd-to-toplevel.sh
index beddb4e..e42cbfe 100755
--- a/t/t2300-cd-to-toplevel.sh
+++ b/t/t2300-cd-to-toplevel.sh
@@ -10,12 +10,12 @@ test_cd_to_toplevel () {
 			cd '"'$1'"' &&
 			. git-sh-setup &&
 			cd_to_toplevel &&
-			[ "$(/bin/pwd)" = "$TOPLEVEL" ]
+			[ "$(unset PWD; /bin/pwd)" = "$TOPLEVEL" ]
 		)
 	'
 }
 
-TOPLEVEL="$(/bin/pwd)/repo"
+TOPLEVEL="$(unset PWD; /bin/pwd)/repo"
 mkdir -p repo/sub/dir
 mv .git repo/
 SUBDIRECTORY_OK=1
-- 
1.6.1
