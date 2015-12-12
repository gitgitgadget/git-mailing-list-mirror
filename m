From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] completion: fix completing unstuck email alias arguments
Date: Sat, 12 Dec 2015 01:18:18 +0100
Message-ID: <1449879498-1516-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jacob Keller <jacob.keller@gmail.com>, git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 12 01:18:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7Xtp-0002X4-TF
	for gcvg-git-2@plane.gmane.org; Sat, 12 Dec 2015 01:18:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754947AbbLLASy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Dec 2015 19:18:54 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:49838 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754060AbbLLASx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Dec 2015 19:18:53 -0500
Received: from x4db27576.dyn.telefonica.de ([77.178.117.118] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1a7Xtg-0005EV-FF; Sat, 12 Dec 2015 01:18:49 +0100
X-Mailer: git-send-email 2.7.0.rc0.37.g77d69b9
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1449879529.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282292>

Completing unstuck form of email aliases doesn't quite work:

  $ git send-email --to <TAB>
  alice   bob     cecil
  $ git send-email --to a<TAB>
  alice   bob     cecil

While listing email aliases works as expected, the second case should
just complete to 'alice', but it keeps offering all email aliases
instead.

The cause for this behavior is that in this case we mistakenly tell
__gitcomp() explicitly that the current word to be completed is empty,
while in reality it is not.  As a result __gitcomp() doesn't filter
out non-matching aliases, so all aliases end up being offered over and
over again.

=46ix this by not passing the current word to be completed to
__gitcomp() and letting it go the default route and grab it from the
'$cur' variable.  Don't pass empty prefix either, because it's assumed
to be empty when unspecified, so it's not necessary.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

On top of the recently merged dfbe5eeb32 (completion: add support for
completing email aliases, 2015-11-19).

 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 111b05302b..d9b995799c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1716,7 +1716,7 @@ _git_send_email ()
 	--to|--cc|--bcc|--from)
 		__gitcomp "
 		$(git --git-dir=3D"$(__gitdir)" send-email --dump-aliases 2>/dev/nul=
l)
-		" "" ""
+		"
 		return
 		;;
 	esac
--=20
2.7.0.rc0.37.g77d69b9
