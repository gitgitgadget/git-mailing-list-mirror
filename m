From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH 2/2] Improve the naming of guessed target repository for
	git clone
Date: Wed, 13 May 2009 22:53:33 +0200
Message-ID: <20090513205333.GA21631@blimp.localdomain>
References: <200905112208.21017.Hugo.Mildenberger@namir.de> <200905121557.18542.Hugo.Mildenberger@namir.de> <81b0412b0905120759u15f1ec73k73625a7904515792@mail.gmail.com> <200905121900.00625.Hugo.Mildenberger@namir.de> <81b0412b0905121018lbccda1fvf6c4c19417cdde00@mail.gmail.com> <20090512172452.GA32594@blimp.localdomain> <20090513180853.GB26288@blimp.localdomain>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Hugo Mildenberger <Hugo.Mildenberger@namir.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 22:53:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4LSb-0001cN-BY
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 22:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757289AbZEMUxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 16:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756990AbZEMUxn
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 16:53:43 -0400
Received: from mout2.freenet.de ([195.4.92.92]:57721 "EHLO mout2.freenet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753034AbZEMUxn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 16:53:43 -0400
Received: from [195.4.92.21] (helo=11.mx.freenet.de)
	by mout2.freenet.de with esmtpa (ID alexander.riesen@freenet.de) (port 25) (Exim 4.69 #88)
	id 1M4LSN-0002Ur-Ph; Wed, 13 May 2009 22:53:39 +0200
Received: from x4098.x.pppool.de ([89.59.64.152]:41852 helo=tigra.home)
	by 11.mx.freenet.de with esmtpsa (ID alexander.riesen@freenet.de) (TLSv1:AES256-SHA:256) (port 587) (Exim 4.69 #79)
	id 1M4LSN-0001Lr-Cs; Wed, 13 May 2009 22:53:39 +0200
Received: from blimp.localdomain (blimp.home [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 1A0F1277D8;
	Wed, 13 May 2009 22:53:34 +0200 (CEST)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id C411536D28; Wed, 13 May 2009 22:53:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090513180853.GB26288@blimp.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119102>

Strip trailing spaces off guessed target directory in builtin clone,
and replace 'control' characters with an ASCII space.

User still can have any name by specifying it explicitely after url.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

This should take care of accidental pastings inside shell quotes.
At least for the local part of the operation.
Now I'm looking at the code and think I should have stripped the
heading whitespace as well. It is much less likely to happen, though.

 builtin-clone.c |   24 ++++++++++++++++++------
 1 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 880373f..bdbe931 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -104,11 +104,12 @@ static char *get_repo_path(const char *repo, int *is_bundle)
 static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
 {
 	const char *end = repo + strlen(repo), *start;
+	char *dir;
 
 	/*
-	 * Strip trailing slashes and /.git
+	 * Strip trailing spaces, slashes and /.git
 	 */
-	while (repo < end && is_dir_sep(end[-1]))
+	while (repo < end && (is_dir_sep(end[-1]) || isspace(end[-1])))
 		end--;
 	if (end - repo > 5 && is_dir_sep(end[-5]) &&
 	    !strncmp(end - 4, ".git", 4)) {
@@ -140,10 +141,21 @@ static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
 	if (is_bare) {
 		struct strbuf result = STRBUF_INIT;
 		strbuf_addf(&result, "%.*s.git", (int)(end - start), start);
-		return strbuf_detach(&result, 0);
-	}
-
-	return xstrndup(start, end - start);
+		dir = strbuf_detach(&result, 0);
+	} else
+		dir = xstrndup(start, end - start);
+	/* replace all 'control' characters with ascii space */
+	for (start = dir; *start; ++start)
+		if (*(const unsigned char *)start < 32u)
+			dir[start - dir] = '\x20';
+	/* remove trailing spaces */
+	if (dir < start)
+		for (end = start; dir < --end; )
+			if (!isspace(*end))
+				break;
+			else
+				dir[end - dir] = '\0';
+	return dir;
 }
 
 static void strip_trailing_slashes(char *dir)
-- 
1.6.3.28.ga852b
