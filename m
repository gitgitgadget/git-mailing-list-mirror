From: Yann Dirson <ydirson@free.fr>
Subject: [PATCH 5/6] Assume a note ref starting with refs must not be prepended refs/notes/.
Date: Sat, 18 Jun 2011 23:06:47 +0200
Message-ID: <1308431208-13353-6-git-send-email-ydirson@free.fr>
References: <201106151253.57908.johan@herland.net>
 <1308431208-13353-1-git-send-email-ydirson@free.fr>
Cc: Yann Dirson <ydirson@free.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 18 23:07:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QY2jr-0007jg-PK
	for gcvg-git-2@lo.gmane.org; Sat, 18 Jun 2011 23:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753033Ab1FRVHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jun 2011 17:07:07 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:42447 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752968Ab1FRVHE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2011 17:07:04 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 0D305D480B9;
	Sat, 18 Jun 2011 23:06:57 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.76)
	(envelope-from <ydirson@free.fr>)
	id 1QY2jF-0003VA-Pg; Sat, 18 Jun 2011 23:06:53 +0200
X-Mailer: git-send-email 1.7.5.3
In-Reply-To: <1308431208-13353-1-git-send-email-ydirson@free.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175988>

This caused strange behaviour when "git notes" was asked to manipulate
refs/<anything> outside of refs/notes/: it was attempting to use
refs/notes/refs/<anything>.

Dying early this way should avoid the need to check for the
refs/notes/ prefix in several places.

Signed-off-by: Yann Dirson <ydirson@free.fr>
---
 notes.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/notes.c b/notes.c
index 12afc02..c6a82da 100644
--- a/notes.c
+++ b/notes.c
@@ -1289,6 +1289,8 @@ void expand_notes_ref(struct strbuf *sb, int allow_remotes)
 		return; /* we're happy */
 	else if (!prefixcmp(sb->buf, "notes/"))
 		strbuf_insert(sb, 0, "refs/", 5);
+	else if (!prefixcmp(sb->buf, "refs/"))
+		die(_("Not a notes reference: %s"), sb->buf);
 	else
 		strbuf_insert(sb, 0, "refs/notes/", 11);
 }
-- 
1.7.5.3
