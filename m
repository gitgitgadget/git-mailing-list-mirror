From: Vadim Zeitlin <vz-git@zeitlins.org>
Subject: [PATCH] Avoid false positives in label detection in cpp diff hunk header regex.
Date: Fri, 22 Mar 2013 13:43:52 +0000 (UTC)
Message-ID: <loom.20130322T144107-601@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 22 14:44:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ2Gy-0002Bv-LX
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 14:44:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932625Ab3CVNoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 09:44:17 -0400
Received: from plane.gmane.org ([80.91.229.3]:53442 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753929Ab3CVNoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 09:44:16 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1UJ2Go-000261-TV
	for git@vger.kernel.org; Fri, 22 Mar 2013 14:44:35 +0100
Received: from ip-208.net-89-3-60.rev.numericable.fr ([89.3.60.208])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 14:44:34 +0100
Received: from vz-git by ip-208.net-89-3-60.rev.numericable.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 14:44:34 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 89.3.60.208 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:19.0) Gecko/20100101 Firefox/19.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218801>

A C++ method start such as

        void
        foo::bar()

wasn't recognized by cpp diff driver as it mistakenly included "foo::bar" as a
label. However the colon in a label can't be followed by another colon, so
recognize this case specially to correctly detect C++ methods using this style.

Signed-off-by: Vadim Zeitlin <vz-git@zeitlins.org>
---
 userdiff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/userdiff.c b/userdiff.c
index ea43a03..9415586 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -125,7 +125,7 @@ PATTERNS("tex",
"^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
         "\\\\[a-zA-Z@]+|\\\\.|[a-zA-Z0-9\x80-\xff]+"),
 PATTERNS("cpp",
         /* Jump targets or access declarations */
-        "!^[ \t]*[A-Za-z_][A-Za-z_0-9]*:.*$\n"
+        "!^[ \t]*[A-Za-z_][A-Za-z_0-9]*:([^:].*$|$)\n"
         /* C/++ functions/methods at top level */
         "^([A-Za-z_][A-Za-z_0-9]*([ \t*]+[A-Za-z_][A-Za-z_0-9]*([ \t]*::[
\t]*[^[:space:]]+)?){1,}[ \t]*\\([^;]*)$\n"
         /* compound type at top level */
--
1.8.2.135.g7b592fa
