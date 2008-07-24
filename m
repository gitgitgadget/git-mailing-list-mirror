From: "Richie Vos" <jerry.vos@gmail.com>
Subject: [EGIT PATCH] Support linked resources
Date: Wed, 23 Jul 2008 22:34:06 -0500
Message-ID: <5a27b7b0807232034t564e8d45l9f6e4bc6429cda60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 24 05:35:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLrbh-0001d5-9d
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 05:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbYGXDeK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 23:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbYGXDeI
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 23:34:08 -0400
Received: from wf-out-1314.google.com ([209.85.200.171]:15364 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbYGXDeH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 23:34:07 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3176332wfd.4
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 20:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=v5Se0Nul8kbapvL69h1bX8+ehcX8SM7f4ZoceemLmGY=;
        b=U+PC8g97mwDOcm1462dmk6EI4MNb7ADTnMn9gQSpH4bAheKUsRAc9vh8UrQH9cP3hp
         j+acT3TWlrVe6jIp52azLVKFF6uvs6U7z96j5SgX5VFzPFoKZrYiswY94wa5kifcbBXh
         +sYgrx6oUCn6StWq1nNeXaHhwHWLr+m8FOxq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=W5xlbycOpdZ/1A0RSnQT/s1xtbqod4tIEdgiYvfCocm5r7A4tsfy1QosaeJiP7h01l
         RDJBvIr3a0dvxjcqBLwqDeKkrjZYL5WqjdXIkhzWBnwJJ9osnXesQhLU/MeF4KE5jp1i
         vBUU+qQ/SBzOntJl8ZvYk1PjnVM7usJUcmFC8=
Received: by 10.142.180.11 with SMTP id c11mr235225wff.159.1216870446892;
        Wed, 23 Jul 2008 20:34:06 -0700 (PDT)
Received: by 10.142.241.5 with HTTP; Wed, 23 Jul 2008 20:34:06 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89832>

I have a project that outputs to a linked directory (for example the
project is in /projects/foo and the project outputs to /projects/bar).
This was causing egit to throw a bunch of "file is not in working
path" errors whenever I rebuilt the project or otherwise interacted
with that linked directory. I tracked it down to GitIndex's add/remove
being called on these files even though these files are not part of
the actual index.

It seems like egit shouldn't be trying to interact with the index on
these files, and after looking at it, I decided the best solution
would be to realize in the RepositoryMapping that these files do not
point to a repository.

I wasn't sure what the best solution for deciding if a file was in the
same location as the project it is referenced in, but I somewhat
modeled it off of the way GitIndex's makeKey does its validation.

Patch:
Fixed 'Path is not in working directory' error for linked resources

Signed-off-by: Reg Vos <jerry.vos@gmail.com>
---
 .../egit/core/project/RepositoryMapping.java       |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java
b/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java
index 6a0b56f..5863a49 100644
--- a/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java
+++ b/org.spearce.egit.core/src/org/spearce/egit/core/project/RepositoryMapping.java
@@ -236,6 +236,8 @@ public class RepositoryMapping {
 		IProject project = resource.getProject();
 		if (project == null)
 			return null;
+		if (!project.getLocation().isPrefixOf(resource.getLocation()))
+			return null;
 		RepositoryProvider provider = RepositoryProvider.getProvider(project);
 		if (!(provider instanceof GitProvider))
 			return null;
-- 
1.5.4.2
