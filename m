From: Finn Arne Gangstad <finnag@pvv.org>
Subject: [PATCH] Support \ in non-wildcard .gitignore entries
Date: Tue, 10 Feb 2009 13:11:49 +0100
Message-ID: <20090210121149.GA1226@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Feb 10 13:48:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWs2A-00071S-UH
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 13:48:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754136AbZBJMqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 07:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753910AbZBJMqf
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 07:46:35 -0500
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:50965 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637AbZBJMqf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 07:46:35 -0500
X-Greylist: delayed 2082 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Feb 2009 07:46:34 EST
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1LWrSv-0001Zv-V9; Tue, 10 Feb 2009 13:11:49 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109225>

If you had an exclude-pattern with a backslash in it, e.g. "\#foo",
this would not work, since git would do a strcmp of the exclude pattern
and the filename. Only wildcard patterns were matched with fnmatch,
which does the right thing with backslashes. We now also treat all patterns
containing backslashes as wildcards.

De-escaping the pattern while reading the .gitignore file is error prone,
since that would break patterns with both backslashes and wildcards.
E.g. "\\*.c" would be translated to "\*.c" before fnmatch got it,
and would change the meaning of the rule dramatically.

Signed-off-by: Finn Arne Gangstad <finnag@pvv.org>
---
 dir.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/dir.c b/dir.c
index cfd1ea5..2245749 100644
--- a/dir.c
+++ b/dir.c
@@ -137,7 +137,7 @@ int match_pathspec(const char **pathspec, const char *name, int namelen,
 
 static int no_wildcard(const char *string)
 {
-	return string[strcspn(string, "*?[{")] == '\0';
+	return string[strcspn(string, "*?[{\\")] == '\0';
 }
 
 void add_exclude(const char *string, const char *base,
-- 
1.6.2.rc0.11.g68cbb.dirty
