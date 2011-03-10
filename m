From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 2/2] bash: complete 'git diff ...branc<TAB>'
Date: Thu, 10 Mar 2011 19:12:29 +0100
Message-ID: <1299780749-12435-2-git-send-email-szeder@ira.uka.de>
References: <7vfwrd2wbn.fsf@alter.siamese.dyndns.org>
	<1299780749-12435-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 19:13:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxkMF-0004ho-Hp
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 19:13:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753956Ab1CJSNB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Mar 2011 13:13:01 -0500
Received: from ex-e-1.perimeter.fzi.de ([141.21.8.250]:40361 "EHLO
	EX-E-1.perimeter.fzi.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753778Ab1CJSM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 13:12:59 -0500
Received: from ex-ca-ht-1.fzi.de (141.21.32.98) by EX-E-1.perimeter.fzi.de
 (141.21.8.250) with Microsoft SMTP Server (TLS) id 14.1.270.1; Thu, 10 Mar
 2011 19:12:53 +0100
Received: from localhost6.localdomain6 (141.21.7.126) by ex-ca-ht-1.fzi.de
 (141.21.32.98) with Microsoft SMTP Server (TLS) id 14.1.270.1; Thu, 10 Mar
 2011 19:12:58 +0100
X-Mailer: git-send-email 1.7.4.1.237.g62e25
In-Reply-To: <1299780749-12435-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168838>

While doing a final sanity check before merging a topic Bsomething, it
is a good idea to review what damage Bsomething branch would make, by
running:

    $ git diff ...Bsomething

Unfortunately, our completion script for 'git diff' doesn't offer
anything after '...'.  This is because 'git diff's completion function
invokes __git_complete_file() for non-option arguments to complete the
'<tree>:<path>' extended SHA-1 notation, but this helper function
doesn't support refs after '...' or '..'.  Completion of refs after
'...' or '..' is supported by the __git_complete_revlist() helper
function, but that doesn't support '<tree>:<path>'.

To support both '...<ref>' and '<tree>:<path>' notations for 'git
diff', this patch, instead of adding yet another helper function,
joins __git_complete_file() and __git_complete_revlist() into the new
common function __git_complete_revlist_file().  The old helper
functions __git_complete_file() and __git_complete_revlist() are
changed to be a direct wrapper around the new
__git_complete_revlist_file(), because they might be used in
user-supplied completion scripts and we don't want to break them.

This change will cause some wrong suggestions for other commands which
use __git_complete_file() ('git diff' and friends) or
__git_complete_revlist() ('git log' and friends), e.g. 'git diff
=2E..master:Doc<TAB>' and 'git log master:Doc<TAB>' will complete the
path to 'Documentation/', although neither commands make any sense.
However, both of these were actively wrong to begin with as soon as
the user entered the ':', so there is no real harm done.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash |   29 ++++++++++++++++--------=
-----
 1 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 344a47f..0c48f1a 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -662,11 +662,14 @@ __git_compute_merge_strategies ()
 	: ${__git_merge_strategies:=3D$(__git_list_merge_strategies)}
 }
=20
-__git_complete_file ()
+__git_complete_revlist_file ()
 {
 	local pfx ls ref cur
 	_get_comp_words_by_ref -n =3D: cur
 	case "$cur" in
+	*..?*:*)
+		return
+		;;
 	?*:*)
 		ref=3D"${cur%%:*}"
 		cur=3D"${cur#*:}"
@@ -705,17 +708,6 @@ __git_complete_file ()
 				       s/^.*	//')" \
 			-- "$cur"))
 		;;
-	*)
-		__gitcomp "$(__git_refs)"
-		;;
-	esac
-}
-
-__git_complete_revlist ()
-{
-	local pfx cur
-	_get_comp_words_by_ref -n =3D: cur
-	case "$cur" in
 	*...*)
 		pfx=3D"${cur%...*}..."
 		cur=3D"${cur#*...}"
@@ -732,6 +724,17 @@ __git_complete_revlist ()
 	esac
 }
=20
+
+__git_complete_file ()
+{
+	__git_complete_revlist_file
+}
+
+__git_complete_revlist ()
+{
+	__git_complete_revlist_file
+}
+
 __git_complete_remote_or_refspec ()
 {
 	local cur words cword
@@ -1354,7 +1357,7 @@ _git_diff ()
 		return
 		;;
 	esac
-	__git_complete_file
+	__git_complete_revlist_file
 }
=20
 __git_mergetools_common=3D"diffuse ecmerge emerge kdiff3 meld opendiff
--=20
1.7.4.1.237.g62e25
