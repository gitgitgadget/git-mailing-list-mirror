From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v3 1/2] rebase-i: explicitly accept tab as separator in commands
Date: Thu,  1 Oct 2015 10:18:41 +0200
Message-ID: <1443687522-14311-1-git-send-email-Matthieu.Moy@imag.fr>
References: <xmqq8u7n7ikl.fsf@gitster.mtv.corp.google.com>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Galan=20R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Oct 01 10:19:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhZ53-0006B5-Rf
	for gcvg-git-2@plane.gmane.org; Thu, 01 Oct 2015 10:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756188AbbJAIS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2015 04:18:59 -0400
Received: from mx2.imag.fr ([129.88.30.17]:56119 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751740AbbJAIS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2015 04:18:57 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t918IktN032219
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Thu, 1 Oct 2015 10:18:46 +0200
Received: from estrop.imag.fr (estrop.imag.fr [129.88.7.56])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t918Ilnw025607;
	Thu, 1 Oct 2015 10:18:47 +0200
Received: from moy by estrop.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1ZhZ4h-0003nH-Jq; Thu, 01 Oct 2015 10:18:47 +0200
X-Mailer: git-send-email 2.5.0.402.g8854c44
In-Reply-To: <xmqq8u7n7ikl.fsf@gitster.mtv.corp.google.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 01 Oct 2015 10:18:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t918IktN032219
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1444292331.75636@Mi+nK3oxU53Qlh15FPIdRw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278889>

The git-rebase-todo is parsed several times with different parsers. In
principle, the user input is normalized by transform_todo_ids and
further parsing can be stricter.

In case the user wrote

pick deadbeef<TAB>commit message

the parser of transform_todo_ids was considering the sha1 to be
"deadbeef<TAB>commit", and was leaving the tab in the transformed sheet.
In practice, this went unnoticed since the actual command interpretation
was done later in do_next which did accept the tab as a separator.

Make it explicit in the code of transform_todo_ids that tabs are
accepted. This way, code that mimicks it will also accept tabs as
separator.

A similar construct appears in skip_unnecessary_picks, but this one
comes after transform_todo_ids, hence reads the normalized format, so it
needs not be changed.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
This is new in v3.

 git-rebase--interactive.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index f01637b..0d77429 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -729,8 +729,8 @@ transform_todo_ids () {
 			# that do not have a SHA-1 at the beginning of $rest.
 			;;
 		*)
-			sha1=$(git rev-parse --verify --quiet "$@" ${rest%% *}) &&
-			rest="$sha1 ${rest#* }"
+			sha1=$(git rev-parse --verify --quiet "$@" ${rest%%[	 ]*}) &&
+			rest="$sha1 ${rest#*[	 ]}"
 			;;
 		esac
 		printf '%s\n' "$command${rest:+ }$rest"
-- 
2.5.0.402.g8854c44
