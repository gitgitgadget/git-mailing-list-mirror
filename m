From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 6/9] completion: query only refs/heads/ in __git_refs_remotes()
Date: Sat,  8 Oct 2011 16:54:40 +0200
Message-ID: <1318085683-29830-7-git-send-email-szeder@ira.uka.de>
References: <1318085683-29830-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 08 16:56:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCYK8-0000in-Mg
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 16:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533Ab1JHO4V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Oct 2011 10:56:21 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:62944 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400Ab1JHO4T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2011 10:56:19 -0400
Received: from localhost6.localdomain6 (p5B130863.dip0.t-ipconnect.de [91.19.8.99])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0LqaYA-1QZf4P2qaQ-00ddqY; Sat, 08 Oct 2011 16:56:16 +0200
X-Mailer: git-send-email 1.7.7.187.ga41de
In-Reply-To: <1318085683-29830-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:tSt0wKVVkIpMh9PGwIar6dKLdhkanKRY7qRSTWCkn1d
 HoRvlxW5jkkkzcwnuaQDeDQbkERBySAiF5lYrP9aPJnHbao+mX
 1RNt6twi48jO62hPAVNOyd+1kzjwMhvrOkHQm1lP2D62ux3lCm
 Y085eJ8QAdhr9wMNWHxQRrYsGdx2duJ6pdRLyfQy9JPUf86caR
 lbHoeiEu2gXRjTeg0kfrMvngHkZ7NAzA3wKH7Zi9UFT+hGB5iZ
 7XRAPdkahFxLX/jeULoADVazxTkLYttJPj3nNnsLjWXLmnjnzl
 guTWcA39JOpS5lCxifNInEZMyzf2sCWA6qUlaOME3G+CwCD3Ov
 mrTx+e2Yy/MQXxNXgL2wrwPH4FnJrr8xTHfoCCfftuzA1GLnbf
 ZFxSa9ePr8aTg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183150>

__git_refs_remotes() is used to provide completion for refspecs to set
'remote.*.fetch' config variables for branches on the given remote.
So it's really only interested in refs under 'refs/heads/', but it
queries the remote for all its refs and then filters out all refs
outside of 'refs/heads/'.

Let 'git ls-remote' do the filtering.

Also remove the unused $cmd variable from __git_refs_remotes().

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index a8d3597e..dc1d5e90 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -650,17 +650,14 @@ __git_refs2 ()
 # __git_refs_remotes requires 1 argument (to pass to ls-remote)
 __git_refs_remotes ()
 {
-	local cmd i is_hash=3Dy
-	for i in $(git ls-remote "$1" 2>/dev/null); do
-		case "$is_hash,$i" in
-		n,refs/heads/*)
+	local i is_hash=3Dy
+	for i in $(git ls-remote "$1" 'refs/heads/*' 2>/dev/null); do
+		case "$is_hash" in
+		n)
 			is_hash=3Dy
 			echo "$i:refs/remotes/$1/${i#refs/heads/}"
 			;;
-		y,*) is_hash=3Dn ;;
-		n,*^{}) is_hash=3Dy ;;
-		n,refs/tags/*) is_hash=3Dy;;
-		n,*) is_hash=3Dy; ;;
+		y) is_hash=3Dn ;;
 		esac
 	done
 }
--=20
1.7.7.187.ga41de
