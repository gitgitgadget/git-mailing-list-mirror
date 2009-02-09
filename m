From: Yann Simon <yann.simon.fr@gmail.com>
Subject: [PATCH JGIT] Use previous author when amending a commit
Date: Mon, 09 Feb 2009 10:30:57 +0100
Message-ID: <498FF7D1.8030905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 09 10:32:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWSVE-000217-J3
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 10:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400AbZBIJbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 04:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752017AbZBIJbE
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 04:31:04 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:42002 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598AbZBIJbB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 04:31:01 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1003254fgg.17
        for <git@vger.kernel.org>; Mon, 09 Feb 2009 01:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=ozPzjDncMl97pPxOgTxaXnpCbHjfoJe2w+vAlKJuYsw=;
        b=suPhLU7Xrf+H8XLwIB4RAFgiSf7//vWWojLQ57w0QAznTVli7mNbPJmD57J+ni3iKA
         +L4AqoUL1H5zYhUFcT46qvKj1cV9s6EDxp+PghbIN+HFcd3pCw1Olav/AtiI1uX8l+wi
         LTLD354QtC1fHzeZS33WiVA1D2G7BmsJHYLos=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=ugSwAF9DbVuJBoHFv+FfWBeSl/jNoAjKiMVlb2mOuOF3gUAGwMZjZVKSTDUwnc+OxQ
         S3Yj/B6FzaG3OX/N93SHxa7ihGdxfkBfmXtsygCIhPiH65jJVSO++figLTpqMlRRFqj+
         HsDvRYvWO81Heh4FDJxy7fAzS2sreJ2fABPHo=
Received: by 10.86.70.3 with SMTP id s3mr2590858fga.78.1234171859500;
        Mon, 09 Feb 2009 01:30:59 -0800 (PST)
Received: from ?10.11.2.21? (port-87-193-216-74.static.qsc.de [87.193.216.74])
        by mx.google.com with ESMTPS id 4sm533433fge.44.2009.02.09.01.30.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Feb 2009 01:30:58 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109060>

In the commit dialog, when amending the commit, the author of the
previous commit is proposed as default in the author field.

Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>
---
 .../egit/ui/internal/actions/CommitAction.java     |    5 ++++-
 .../egit/ui/internal/dialogs/CommitDialog.java     |   12 ++++++++++++
 2 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
index ae26770..d30172f 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
@@ -118,8 +118,11 @@ public void run(IAction act) {
 		commitDialog.setFileList(files);
 		commitDialog.setAuthor(author);
 
-		if (previousCommit != null)
+		if (previousCommit != null) {
 			commitDialog.setPreviousCommitMessage(previousCommit.getMessage());
+			PersonIdent previousAuthor = previousCommit.getAuthor();
+			commitDialog.setPreviousAuthor(previousAuthor.getName() + " <" + previousAuthor.getEmailAddress() + ">");
+		}
 
 		if (commitDialog.open() != IDialogConstants.OK_ID)
 			return;
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
index fede948..b122fb8 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
@@ -175,6 +175,7 @@ public void keyPressed(KeyEvent arg0) {
 			amendingButton.setSelection(amending);
 			amendingButton.setEnabled(false); // if already set, don't allow any changes
 			commitText.setText(previousCommitMessage);
+			authorText.setText(previousAuthor);
 		} else if (!amendAllowed) {
 			amendingButton.setEnabled(false);
 		}
@@ -189,6 +190,7 @@ public void widgetSelected(SelectionEvent arg0) {
 					if (curText.length() > 0)
 						curText += "\n"; //$NON-NLS-1$
 					commitText.setText(curText + previousCommitMessage);
+					authorText.setText(previousAuthor);
 				}
 			}
 
@@ -334,6 +336,7 @@ public void setCommitMessage(String s) {
 
 	private String commitMessage = ""; //$NON-NLS-1$
 	private String author = null;
+	private String previousAuthor = null;
 	private boolean signedOff = false;
 	private boolean amending = false;
 	private boolean amendAllowed = true;
@@ -470,6 +473,15 @@ public void setAuthor(String author) {
 	}
 
 	/**
+	 * Pre-set the previous author if amending the commit
+	 *
+	 * @param previousAuthor
+	 */
+	public void setPreviousAuthor(String previousAuthor) {
+		this.previousAuthor = previousAuthor;
+	}
+
+	/**
 	 * @return whether to auto-add a signed-off line to the message
 	 */
 	public boolean isSignedOff() {
-- 
1.6.0.4
