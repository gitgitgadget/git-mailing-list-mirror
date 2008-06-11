From: Chris Ridd <chris.ridd@isode.com>
Subject: [PATCH] Improve sed portability
Date: Wed, 11 Jun 2008 14:09:19 +0100
Message-ID: <1213189759-11565-1-git-send-email-chris.ridd@isode.com>
Mime-Version: 1.0
Cc: Chris Ridd <chris.ridd@isode.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 11 15:16:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6QBY-0003Q3-8d
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 15:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbYFKNP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 09:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbYFKNP0
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 09:15:26 -0400
Received: from rufus.isode.com ([62.3.217.251]:57930 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751196AbYFKNPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 09:15:25 -0400
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Jun 2008 09:15:24 EDT
Received: from localhost.localdomain (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (smtp internal) via TCP with ESMTP 
          id <SE=OfwBZBKpX@rufus.isode.com>; Wed, 11 Jun 2008 14:09:19 +0100
X-Mailer: git-send-email 1.5.3.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84608>

On Solaris /usr/bin/sed apparently fails to process input that doesn't
end in a \n. Consequently constructs like

  re=$(printf '%s' foo | sed -e 's/bar/BAR/g' $)

cause re to be set to the empty string. Such a construct is used in
git-submodule.sh.

Changing the printf to add a \n seems the safest change. The
POSIX-compliant seds shipped with Solaris do not have this problem.

Signed-off-by: Chris Ridd <chris.ridd@isode.com>
---
 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 1007372..e515bcc 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -73,7 +73,7 @@ resolve_relative_url ()
 module_name()
 {
 	# Do we have "submodule.<something>.path = $1" defined in .gitmodules file?
-	re=$(printf '%s' "$1" | sed -e 's/[].[^$\\*]/\\&/g')
+	re=$(printf "%s\n" "$1" | sed -e 's/[].[^$\\*]/\\&/g')
 	name=$( git config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
 		sed -n -e 's|^submodule\.\(.*\)\.path '"$re"'$|\1|p' )
        test -z "$name" &&
-- 
1.5.3.6
