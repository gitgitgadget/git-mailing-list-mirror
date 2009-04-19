From: Alex Blewitt <alex.blewitt@gmail.com>
Subject: [EGIT PATCH] Add support for writing/appending .gitignore file
Date: Sun, 19 Apr 2009 14:09:32 +0100
Message-ID: <AFFAB806-28F7-4D48-B603-B7B96052B0F3@gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Apr 19 15:11:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvWni-0007rN-RQ
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 15:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758159AbZDSNJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 09:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757929AbZDSNJi
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 09:09:38 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:49792 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757847AbZDSNJh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 09:09:37 -0400
Received: by ewy24 with SMTP id 24so804849ewy.37
        for <git@vger.kernel.org>; Sun, 19 Apr 2009 06:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date:cc
         :x-mailer;
        bh=/ZJ456qQbnVmdfYImKJXzN4pa7336+83yJWrL51TgcA=;
        b=Ro+LinMcZc9F4KwecChaAFly9bKY7nX1EeyJPUBAMnnmpXOcDR2HgunaDPh50SOb80
         2+qEI9mmFIxPJGe4BBi8zf11+K3S6CyA/OlU/uk1L9YOcDrlNXC8a8U5fGk2xMWrUi3p
         8tIAyyfNos3UaesPPWDiCxet+blEW1dRt+guY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:cc:x-mailer;
        b=iMaBrF8dNUMTrVlaigRuz+2JCMdFKzLSvp7EZbBx/Mk8OMspI/Vo8pEvTmrhZ5MzJZ
         5xfOyLAgZ0/PHliqTWrYiMdoTu+XbhBfwq/TWSdexWAKK4U89Nk9/8FzqLkli0qQk0T9
         Q8nCYJlDYEOO1R0mmfcn08aRTfYcZPUhYit3E=
Received: by 10.210.131.1 with SMTP id e1mr3732632ebd.41.1240146575832;
        Sun, 19 Apr 2009 06:09:35 -0700 (PDT)
Received: from apple.int.bandlem.com (server.bandlem.com [217.155.97.60])
        by mx.google.com with ESMTPS id 7sm450813eyb.10.2009.04.19.06.09.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Apr 2009 06:09:35 -0700 (PDT)
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116893>

This is in addition to the other patches mailed earlier and attached  
with issue 64

 From 34fd7fc8cd721c4f44b5b31d3d5960f89b59bf8b Mon Sep 17 00:00:00 2001
From: Alex Blewitt <alex.blewitt@gmail.com>
Date: Sun, 19 Apr 2009 14:03:46 +0100
Subject: [PATCH] Added support for writing/appending .gitignore file

---
  .../egit/ui/internal/actions/IgnoreAction.java     |   48 +++++++++++ 
++++++---
  1 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/ 
actions/IgnoreAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ 
ui/internal/actions/IgnoreAction.java
index 1215823..832b098 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/ 
IgnoreAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/ 
IgnoreAction.java
@@ -7,7 +7,17 @@
    
*******************************************************************************/
  package org.spearce.egit.ui.internal.actions;

+import java.io.ByteArrayInputStream;
+import java.io.ByteArrayOutputStream;
+import java.io.IOException;
+import java.io.UnsupportedEncodingException;
+
+import org.eclipse.core.resources.IContainer;
+import org.eclipse.core.resources.IFile;
  import org.eclipse.core.resources.IResource;
+import org.eclipse.core.runtime.CoreException;
+import org.eclipse.core.runtime.NullProgressMonitor;
+import org.eclipse.core.runtime.Path;
  import org.eclipse.jface.action.IAction;
  import org.eclipse.team.core.Team;

@@ -17,17 +27,43 @@
   */
  public class IgnoreAction extends RepositoryAction {
  	
+	private static final String GITIGNORE_ENCODING = "UTF-8";
+	private static final String GITIGNORE = ".gitignore";
+
  	@SuppressWarnings("restriction")
  	@Override
  	public void run(IAction action) {
-
+		NullProgressMonitor m = new NullProgressMonitor();
  		IResource[] resources = getSelectedResources();
-		for (IResource resource : resources) {
-			// NB This does the same thing in DecoratableResourceAdapter, but  
neither currently consult .gitignore
-			if (!Team.isIgnoredHint(resource))
-			{
-				// TODO Actually add to .gitignore here
+		try {
+			for (IResource resource : resources) {
+				// TODO This is pretty inefficient; multiple ignores in the same  
directory cause multiple writes.
+				// NB This does the same thing in DecoratableResourceAdapter, but  
neither currently consult .gitignore
+				if (!Team.isIgnoredHint(resource)) {
+					IContainer container = resource.getParent();
+					IFile gitignore = container.getFile(new Path(GITIGNORE));
+					String entry = "/" + resource.getName() + "\n"; //$NON-NLS-1$  // 
$NON-NLS-2$
+					// TODO What is the character set and new-line convention?
+					if(gitignore.exists()) {
+						// This is ugly. CVS uses an internal representation of  
the .gitignore to re-write/overwrite each time.
+						ByteArrayOutputStream out = new ByteArrayOutputStream(2048);
+						out.write(entry.getBytes(GITIGNORE_ENCODING)); // TODO Default  
encoding?
+						gitignore.appendContents(new  
ByteArrayInputStream(out.toByteArray()),true,true,m);
+					} else {
+						ByteArrayInputStream bais = new  
ByteArrayInputStream( entry.getBytes(GITIGNORE_ENCODING) ); //$NON- 
NLS-1$
+						gitignore.create( bais,true,m);					
+					}
+				}
  			}
+		} catch (UnsupportedEncodingException e) {
+			// TODO Auto-generated catch block
+			e.printStackTrace();
+		} catch (CoreException e) {
+			// TODO Auto-generated catch block
+			e.printStackTrace();
+		} catch (IOException e) {
+			// TODO Auto-generated catch block
+			e.printStackTrace();
  		}
  		return;
  	}
-- 
1.6.2.2
