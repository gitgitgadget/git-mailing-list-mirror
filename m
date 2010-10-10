From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 2/3] bisect: improve error msg of 'bisect reset' when original
	HEAD is deleted
Date: Sun, 10 Oct 2010 23:48:57 +0200
Message-ID: <1286747338-8521-2-git-send-email-szeder@ira.uka.de>
References: <1286747338-8521-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 10 23:49:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P53ld-0006rL-0W
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 23:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949Ab0JJVtM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Oct 2010 17:49:12 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:52014 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab0JJVtL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 17:49:11 -0400
Received: from [127.0.1.1] (p5B130D54.dip0.t-ipconnect.de [91.19.13.84])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MKMnS-1P5bjG1SNC-001DIl; Sun, 10 Oct 2010 23:49:08 +0200
X-Mailer: git-send-email 1.7.3.1.148.g2fffa
In-Reply-To: <1286747338-8521-1-git-send-email-szeder@ira.uka.de>
X-Provags-ID: V02:K0:ok+qBAb6xW8lkWl8VerbYyVD7I9hKPOkIfaDMlKWWul
 I76yjHDyvYu2O7zEDyWclQmkqSyqaS9jh759iEG+7GbJl3Ik6Y
 2KAULvVqMfSG0dlDzLfxMsKfYAT9Q56VeVwQUU97tJ41ZItjKO
 utqU4oH25eNQQsNHfbtzybnlgtL5lZ3zAQNTU/KAP2z5cb2zPk
 2gNqbIf/9JxfSMjf23u9A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158718>

'git bisect reset' (without the optional <commit> argument) returns to
the original HEAD from where the bisection was started.  However,
when, for whatever reason, the user deleted the original HEAD before
invoking 'git bisect reset', then all he gets is an error message from
'git checkout':

  fatal: invalid reference: somebranch

Let's try to be more helpful with an error message better describing
what went wrong and a suggestion about how to resolve the situation:

  Could not check out original HEAD 'somebranch'. Try 'git bisect reset=
 <commit>'.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 git-bisect.sh |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 3a4bf81..68fcff6 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -316,7 +316,12 @@ bisect_reset() {
 	*)
 	    usage ;;
 	esac
-	git checkout "$branch" -- && bisect_clean_state
+	if git checkout "$branch" -- ; then
+		bisect_clean_state
+	else
+		die "Could not check out original HEAD '$branch'." \
+				"Try 'git bisect reset <commit>'."
+	fi
 }
=20
 bisect_clean_state() {
--=20
1.7.3.1.148.g2fffa
