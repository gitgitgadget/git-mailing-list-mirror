From: =?UTF-8?q?Santi=20B=C3=A9jar?= <santi@agolina.net>
Subject: [RFC/PATCH 2/2] get_remote_merge_branch: Support for arbitrary mapping
Date: Thu, 18 Jun 2009 09:57:14 +0200
Message-ID: <1245311834-5290-4-git-send-email-santi@agolina.net>
References: <1245311834-5290-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 09:57:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHCUv-0002EP-Bd
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 09:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756896AbZFRH5H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Jun 2009 03:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756276AbZFRH5F
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 03:57:05 -0400
Received: from mail-fx0-f212.google.com ([209.85.220.212]:58064 "EHLO
	mail-fx0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756225AbZFRH5D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 03:57:03 -0400
Received: by mail-fx0-f212.google.com with SMTP id 8so844199fxm.37
        for <git@vger.kernel.org>; Thu, 18 Jun 2009 00:57:06 -0700 (PDT)
Received: by 10.103.224.17 with SMTP id b17mr822232mur.61.1245311826392;
        Thu, 18 Jun 2009 00:57:06 -0700 (PDT)
Received: from localhost (p5B0D73A2.dip.t-dialin.net [91.13.115.162])
        by mx.google.com with ESMTPS id u26sm259108mug.22.2009.06.18.00.57.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Jun 2009 00:57:05 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.2.406.gd6a466
In-Reply-To: <1245311834-5290-1-git-send-email-santi@agolina.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121803>

This function is used in "git pull --rebase" to know the tracking branc=
h.

Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
---
 git-parse-remote.sh |   21 ++++++++++++---------
 1 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 5f47b18..1aa6ffe 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -74,8 +74,6 @@ get_remote_merge_branch () {
 	    repo=3D$1
 	    shift
 	    ref=3D$1
-	    # FIXME: It should return the tracking branch
-	    #        Currently only works with the default mapping
 	    case "$ref" in
 	    +*)
 		ref=3D$(expr "z$ref" : 'z+\(.*\)')
@@ -83,13 +81,18 @@ get_remote_merge_branch () {
 	    esac
 	    expr "z$ref" : 'z.*:' >/dev/null || ref=3D"${ref}:"
 	    remote=3D$(expr "z$ref" : 'z\([^:]*\):')
-	    case "$remote" in
-	    '' | HEAD ) remote=3DHEAD ;;
-	    heads/*) remote=3D${remote#heads/} ;;
-	    refs/heads/*) remote=3D${remote#refs/heads/} ;;
-	    refs/* | tags/* | remotes/* ) remote=3D
-	    esac
+	    while true ; do
+		case "$remote" in
+		'' | HEAD ) remote=3D;;
+		heads/*) remote=3Drefs/$remote;;
+		refs/heads/*) ;;
+		refs/* | tags/* | remotes/* ) remote=3D;;
+		*) remote=3Dheads/$remote
+		esac
=20
-	    [ -n "$remote" ] && echo "refs/remotes/$repo/$remote"
+		[ -n "$remote" ] &&
+		git remote tracking $repo $remote && break
+		case "$remote" in refs/heads/* | "" ) break ; esac
+	    done
 	esac
 }
--=20
1.6.3.2.406.gd6a466
