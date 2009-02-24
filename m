From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] git-quiltimport: preserve standard input to be able to read user input
Date: Tue, 24 Feb 2009 09:00:06 +0000
Message-ID: <20090224090006.16998.qmail@c47830338ab2ae.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 10:01:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbtAZ-000316-EM
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 10:01:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754070AbZBXJAL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Feb 2009 04:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754023AbZBXJAL
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 04:00:11 -0500
Received: from a.ns.smarden.org ([212.42.242.37]:2257 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754016AbZBXJAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 04:00:09 -0500
Received: (qmail 16999 invoked by uid 1000); 24 Feb 2009 09:00:06 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111241>

When run without --author and it fails to determine an author, git
quiltimport tries `read patch_author` to get user input, but standard
input has been redirected to the patch series file.  This commit lets
quiltimport read the series file through file descriptor 3 so that the
standard input is preserved.

Reported by Uwe Kleine-K=F6nig through
 http://bugs.debian.org/515910

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 git-quiltimport.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index cebaee1..9a6ba2b 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -63,7 +63,7 @@ tmp_info=3D"$tmp_dir/info"
 commit=3D$(git rev-parse HEAD)
=20
 mkdir $tmp_dir || exit 2
-while read patch_name level garbage
+while read patch_name level garbage <&3
 do
 	case "$patch_name" in ''|'#'*) continue;; esac
 	case "$level" in
@@ -134,5 +134,5 @@ do
 		commit=3D$( (echo "$SUBJECT"; echo; cat "$tmp_msg") | git commit-tre=
e $tree -p $commit) &&
 		git update-ref -m "quiltimport: $patch_name" HEAD $commit || exit 4
 	fi
-done <"$QUILT_PATCHES/series"
+done 3<"$QUILT_PATCHES/series"
 rm -rf $tmp_dir || exit 5
--=20
1.6.1.3
