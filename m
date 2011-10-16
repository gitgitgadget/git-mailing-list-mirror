From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 5/6] git-p4: keyword flattening fixes
Date: Sun, 16 Oct 2011 10:46:52 -0400
Message-ID: <20111016144652.GH22144@arf.padd.com>
References: <20111016144215.GC22144@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Luke Diamand <luke@diamand.org>, Chris Li <git@chrisli.org>,
	Stefano Lattarini <stefano.lattarini@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 16 16:47:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFRzf-0006z1-Um
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 16:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754442Ab1JPOrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 10:47:12 -0400
Received: from honk.padd.com ([74.3.171.149]:57955 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753429Ab1JPOrL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 10:47:11 -0400
Received: from arf.padd.com (unknown [50.55.131.180])
	by honk.padd.com (Postfix) with ESMTPSA id 06B3B1FEA;
	Sun, 16 Oct 2011 07:47:11 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 66454313B8; Sun, 16 Oct 2011 10:46:52 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20111016144215.GC22144@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183720>

Join the text before looking for keywords.  There is nothing to
prevent the p4 output marshaller from splitting in the middle of a
keyword, although it has never been known to happen.

Also remove the (?i) regexp modifier; perforce keywords are
documented as case-sensitive.

Remove the "\n" end-character match.  I don't know why that is
in there, and every keyword in a fairly large production p4 repository
always ends with a $.

Acked-by: Luke Diamand <luke@diamand.org>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4 |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 6b91595..55b1667 100755
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
1.7.7
