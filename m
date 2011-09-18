From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 5/5] git-p4: keyword flattening fixes
Date: Sat, 17 Sep 2011 21:33:34 -0400
Message-ID: <20110918013334.GF4619@arf.padd.com>
References: <20110918012634.GA4578@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vitor Antunes <vitor.hda@gmail.com>,
	Luke Diamand <luke@diamand.org>, Chris Li <git@chrisli.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 18 03:33:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R56GM-0007hj-Sb
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 03:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756129Ab1IRBdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Sep 2011 21:33:38 -0400
Received: from honk.padd.com ([74.3.171.149]:59857 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753215Ab1IRBdi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Sep 2011 21:33:38 -0400
Received: from arf.padd.com (unknown [50.55.131.180])
	by honk.padd.com (Postfix) with ESMTPSA id D13C4BFC;
	Sat, 17 Sep 2011 18:33:37 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id E678E31448; Sat, 17 Sep 2011 21:33:34 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20110918012634.GA4578@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181598>

Join the text before looking for keywords.  There is nothing to
prevent the p4 output marshaller from splitting in the middle of a
keyword, although it has never been known to happen.

Also remove the (?i) regexp modifier; perforce keywords are
documented as case-sensitive.

Remove the "\n" end-character match.  I don't know why that is
in there, and every keyword in a fairly large production p4 repository
always ends with a $.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4 |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index eee288d..782b891 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1285,9 +1285,13 @@ class P4Sync(Command, P4UserMap):
         # even though in theory somebody may want that.
         if type_base in ("text", "unicode", "binary"):
             if "ko" in type_mods:
-                contents = map(lambda text: re.sub(r'(?i)\$(Id|Header):[^$]*\$', r'$\1$', text), contents)
+                text = ''.join(contents)
+                text = re.sub(r'\$(Id|Header):[^$]*\$', r'$\1$', text)
+                contents = [ text ]
             elif "k" in type_mods:
-                contents = map(lambda text: re.sub(r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$\n]*\$', r'$\1$', text), contents)
+                text = ''.join(contents)
+                text = re.sub(r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$]*\$', r'$\1$', text)
+                contents = [ text ]
 
         self.gitStream.write("M %s inline %s\n" % (git_mode, relPath))
 
-- 
1.7.6.3
