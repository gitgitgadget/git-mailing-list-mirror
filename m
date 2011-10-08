From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 3/9] completion: make refs completion consistent for local and
	remote repos
Date: Sat,  8 Oct 2011 16:54:37 +0200
Message-ID: <1318085683-29830-4-git-send-email-szeder@ira.uka.de>
References: <1318085683-29830-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 08 16:55:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCYJa-0000T5-7F
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 16:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752244Ab1JHOzp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Oct 2011 10:55:45 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:60366 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178Ab1JHOzo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2011 10:55:44 -0400
Received: from localhost6.localdomain6 (p5B130863.dip0.t-ipconnect.de [91.19.8.99])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0LcrNk-1QmG2I3F68-00iBcq; Sat, 08 Oct 2011 16:55:43 +0200
X-Mailer: git-send-email 1.7.7.187.ga41de
In-Reply-To: <1318085683-29830-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:g0vS1KvG6mOW8g85Aj2pNYZl5ZfCWpTp/+BfIUjOoK0
 0mOVVbrQ+iCU6uXVxgcRllAV5JILvUv9tdYtnc/vLQaNY/AKre
 Pm4FgtavZfxYBSjKr7h6nd5MUV6XqRGpRhcGhe46UlzXb9PkfT
 axfCv9Hkl9aDx1ZeWJp+FDBe6TuwX1kfDyHmBFYAnyMJi3U01R
 HCyA3/+EljvpZjFzyFMMNVS+105MOWTIv/k9bF7L/smxhiJYkx
 JdweZydLoGpWBHFOcg7y+IIkQFRDNAUF+8QvkQ6oqD9MXFxI+F
 qA0AJpPJ7psAb+wtkMxTdOt8JjktxMO39Xet7CRvCzCuXGPsRE
 ZaWjAOHcuBB4XCBhgKmrdKc8VWgyyxL/jMtgviG72I+CveztjN
 ATdRa0qcEKdvA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183147>

=46or a local repository the __git_refs() completion helper function
lists refs under 'refs/(tags|heads|remotes)/', plus some special refs
like HEAD and ORIG_HEAD.  For a remote repository, however, it lists
all refs.

=46ix this inconsistency by specifying refs filter patterns for 'git
ls-remote' to only list refs under 'refs/(tags|heads|remotes)/'.

=46or now this makes it impossible to complete refs outside of
'refs/(tags|heads|remotes)/' in a remote repository, but a followup
patch will resurrect that.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 86de0bf4..6b5dc5cd 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -615,13 +615,11 @@ __git_refs ()
 		fi
 		return
 	fi
-	for i in $(git ls-remote "$dir" 2>/dev/null); do
+	for i in $(git ls-remote "$dir" HEAD ORIG_HEAD 'refs/tags/*' 'refs/he=
ads/*' 'refs/remotes/*' 2>/dev/null); do
 		case "$is_hash,$i" in
 		y,*) is_hash=3Dn ;;
 		n,*^{}) is_hash=3Dy ;;
-		n,refs/tags/*) is_hash=3Dy; echo "${i#refs/tags/}" ;;
-		n,refs/heads/*) is_hash=3Dy; echo "${i#refs/heads/}" ;;
-		n,refs/remotes/*) is_hash=3Dy; echo "${i#refs/remotes/}" ;;
+		n,refs/*) is_hash=3Dy; echo "${i#refs/*/}" ;;
 		n,*) is_hash=3Dy; echo "$i" ;;
 		esac
 	done
--=20
1.7.7.187.ga41de
