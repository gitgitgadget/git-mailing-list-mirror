From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Make git tag -s friendly to keys with comments
Date: Wed, 10 Jun 2009 01:48:51 +0200
Message-ID: <20090609234851.GA5286@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 10 01:49:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEB4V-0004wx-9q
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 01:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756985AbZFIXsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 19:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753202AbZFIXsy
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 19:48:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:50505 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752473AbZFIXsx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 19:48:53 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 1374686200A; Wed, 10 Jun 2009 01:48:52 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121237>

git tag -s has very unfriendly default method of picking key ids;
it is documented in git-tag(1) as just the e-mail, but in fact
it is "Real Name <email>". This will never pick the right default
if the key was created with a comment in the name, like:

	Petr Baudis (Sirius Labs) <pasky@ucw.cz>
	Petr Baudis (SuSE Labs) <pasky@suse.cz>

This patch makes git tag -s default to just the e-mail address,
as documented.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---

diff --git a/builtin-tag.c b/builtin-tag.c
index e544430..9901925 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -165,8 +165,10 @@ static int do_sign(struct strbuf *buffer)
 	int i, j;
 
 	if (!*signingkey) {
-		if (strlcpy(signingkey, git_committer_info(IDENT_ERROR_ON_NO_NAME),
-				sizeof(signingkey)) > sizeof(signingkey) - 1)
+		char *commit_email = strchr(git_committer_info(IDENT_ERROR_ON_NO_NAME), '<');
+		assert(commit_email);
+		if (strlcpy(signingkey, commit_email, sizeof(signingkey))
+				> sizeof(signingkey) - 1)
 			return error("committer info too long.");
 		bracket = strchr(signingkey, '>');
 		if (bracket)

-- 
				Petr "Pasky" Baudis
The lyf so short, the craft so long to lerne. -- Chaucer
