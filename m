From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] repack: place temporary packs under .git/objects/pack/
Date: Tue, 19 Oct 2010 11:50:43 +0200
Message-ID: <cbdf4787ddaccd7105ab1661529a98257d61179b.1287481801.git.trast@student.ethz.ch>
References: <1287474040065-5649864.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Marat Radchenko <marat@slonopotamus.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 19 11:50:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P88qN-0005t0-JR
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 11:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758139Ab0JSJuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 05:50:46 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:14323 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756596Ab0JSJup (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 05:50:45 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Tue, 19 Oct
 2010 11:50:44 +0200
Received: from localhost.localdomain (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 19 Oct
 2010 11:50:44 +0200
X-Mailer: git-send-email 1.7.3.1.271.ged4d2
In-Reply-To: <1287474040065-5649864.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159316>

git-pack-objects is already careful to start out its temporary packs
under .git/objects/pack/ (cf. 8b4eb6b, Do not perform cross-directory
renames when creating packs, 2008-09-22), but git-repack did not
respond in kind so the effort was lost when the filesystem boundary is
exactly at that directory.

Let git-repack pass a path under .git/objects/pack/ as the base for
its temporary packs.

This means we might need the $PACKDIR sooner (before the pack-objects
invocation), so move the mkdir up just to be safe.

Also note that the only use of *.pack is in the find invocation way
before the pack-objects call, so the temporary packs will not suddenly
show up in any wildcards because of the directory change.

Reported-by: Marat Radchenko <marat@slonopotamus.org>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 git-repack.sh |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index 769baaf..624feec 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -52,7 +52,7 @@ true)
 esac
 
 PACKDIR="$GIT_OBJECT_DIRECTORY/pack"
-PACKTMP="$GIT_OBJECT_DIRECTORY/.tmp-$$-pack"
+PACKTMP="$PACKDIR/.tmp-$$-pack"
 rm -f "$PACKTMP"-*
 trap 'rm -f "$PACKTMP"-*' 0 1 2 3 15
 
@@ -82,6 +82,8 @@ case ",$all_into_one," in
 	;;
 esac
 
+mkdir -p "$PACKDIR" || exit
+
 args="$args $local ${GIT_QUIET:+-q} $no_reuse$extra"
 names=$(git pack-objects --keep-true-parents --honor-pack-keep --non-empty --all --reflog $args </dev/null "$PACKTMP") ||
 	exit 1
@@ -90,7 +92,6 @@ if [ -z "$names" ]; then
 fi
 
 # Ok we have prepared all new packfiles.
-mkdir -p "$PACKDIR" || exit
 
 # First see if there are packs of the same name and if so
 # if we can move them out of the way (this can happen if we
-- 
1.7.3.1.271.ged4d2
