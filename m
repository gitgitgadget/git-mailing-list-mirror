From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v2 11/22] i18n: bisect: simplify error message for i18n
Date: Mon, 23 May 2016 19:27:30 +0000
Message-ID: <1464031661-18988-12-git-send-email-vascomalmeida@sapo.pt>
References: <1464031661-18988-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 21:30:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4vYX-00025H-Kp
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 21:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880AbcEWT3p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 15:29:45 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:50841 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753676AbcEWT3m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 15:29:42 -0400
Received: (qmail 747 invoked from network); 23 May 2016 19:29:40 -0000
Received: (qmail 4065 invoked from network); 23 May 2016 19:29:40 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 23 May 2016 19:29:39 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1464031661-18988-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295372>

The message was not being extracted by xgettext, although it was marked
for translation, seemingly because it contained a command substitution.
Moreover, eval_gettext should be used instead of gettext for strings
with substitution.

See step 4. of section 15.5.2.1 Preparing Shell Scripts for
Internationalization from gettext manual [1]:
"Simplify translatable strings so that they don't contain command
substitution ("`...`" or "$(...)") [...]"

[1] http://www.gnu.org/software/gettext/manual/gettext.html#Preparing-Shell-Scripts

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 git-bisect.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 5d1cb00..737bf05 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -277,8 +277,9 @@ bisect_state() {
 	0,*)
 		die "$(gettext "Please call 'bisect_state' with at least one argument.")" ;;
 	1,"$TERM_BAD"|1,"$TERM_GOOD"|1,skip)
-		rev=$(git rev-parse --verify $(bisect_head)) ||
-			die "$(gettext "Bad rev input: $(bisect_head)")"
+		bisected_head=$(bisect_head)
+		rev=$(git rev-parse --verify "$bisected_head") ||
+			die "$(eval_gettext "Bad rev input: \$bisected_head")"
 		bisect_write "$state" "$rev"
 		check_expected_revs "$rev" ;;
 	2,"$TERM_BAD"|*,"$TERM_GOOD"|*,skip)
-- 
2.7.3
