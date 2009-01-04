From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: [PATCH v2 tested] git-sh-setup: Fix scripts whose PWD is a symlink to a work-dir on OS X
Date: Sun,  4 Jan 2009 13:27:25 -0800
Message-ID: <1231104445-12531-1-git-send-email-marcel@oak.homeunix.org>
References: <AC726FD4-AE7F-4EC0-82E5-62C6D03C4E5A@marzelpan.de>
Cc: git@vger.kernel.org, jnareb@gmail.com, ae@op5.se,
	j.sixt@viscovery.net, git-dev@marzelpan.de,
	"Marcel M. Cary" <marcel@oak.homeunix.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 04 22:28:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJaWf-00025K-Q1
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 22:28:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752226AbZADV13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 16:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752134AbZADV13
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 16:27:29 -0500
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:25238 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751566AbZADV13 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jan 2009 16:27:29 -0500
Received: (qmail 860 invoked from network); 4 Jan 2009 21:27:27 -0000
Received: from unknown (HELO ordinateur.home.org) (marcel@76.231.191.38 with plain)
  by smtp123.sbc.mail.sp1.yahoo.com with SMTP; 4 Jan 2009 21:27:26 -0000
X-YMail-OSG: BWEYR.YVM1mdfdUhYxXncJus59R8qNiG03vcdPDiEjlk.X34iDy7Gag_B8noxRjGoCt8JM4hMsY5u0GBVP7ZE98niSeX7LyUeV565Hqpa7VNLsJqGxlRaMeIGlvxKUk6O3QG9Rw8Yn_SQppDeFekUYXYZ9V1BaAVlgsDwyVnUw4YdyqIky_2lhswit1VJQ--
X-Yahoo-Newman-Property: ymail-5
Received: from polliwog.home.org ([192.168.0.18] helo=localhost.localdomain)
	by ordinateur.home.org with esmtp (Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1LJaVI-0007vj-M1; Sun, 04 Jan 2009 13:27:24 -0800
X-Mailer: git-send-email 1.6.1
In-Reply-To: <AC726FD4-AE7F-4EC0-82E5-62C6D03C4E5A@marzelpan.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104541>

On Mac OS X and possibly BSDs, /bin/pwd reads PWD from the environment
if available and shows the logical path by default rather than the
physical one.

Unset PWD before running /bin/pwd in both cd_to_toplevel and its
test.

Still use the external /bin/pwd because in my Bash on Linux,
the builtin pwd prints the same result whether or not PWD is set.

Signed-off-by: Marcel M. Cary <marcel@oak.homeunix.org>
Tested-by: Marcel Koeppen <git-dev@marzelpan.de>
---

Junio C Hamano wrote:
> I think I saw a success report on the list.  Care to resend it with
> Sign-off (by you) and
> 
>         Tested-by: tester <test@er.xz> (on PLATFORM)
> 
> lines as you see necessary for application?

Same as before but with S-o-b/T-b lines.

Marcel Koeppen wrote:
> [I don't know why my replies get lost, so I dropped all individual
> recipients on this third try...]

I noticed that Brian Gernhardt's message also didn't make it to the
list, even though it was addressed to the list.  I'm not sure why.


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
