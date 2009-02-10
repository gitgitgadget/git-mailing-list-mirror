From: Yann Simon <yann.simon.fr@gmail.com>
Subject: [PATCH JGIT] Deal with the signed-off in the commit text dialog
Date: Tue, 10 Feb 2009 13:55:32 +0100
Message-ID: <49917944.6030309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 10 13:57:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWsB2-0001tF-FN
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 13:57:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754585AbZBJMzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 07:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754635AbZBJMzi
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 07:55:38 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:55651 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754601AbZBJMzg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 07:55:36 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1305672fgg.17
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 04:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=cxG/J8vDMXRTOG7w7G5uZWAZYKEi9/96gL3+tBYzSBo=;
        b=NEUK4l95FjnHK/pwrEzOw4SMPtxNdtKhT4SxS4uUxpuiWohk1M+VLOKFajG4EKBYM+
         3uhw46EWZj7YbuiMyhkQNwKIE1bCeMiuhR4mKJo89fzKxcDKMjC6ElGuukheETaeURyC
         BUxe5DX9NZr5lXcy4yJNzGZEIRyo1WJRzrqtw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=HAcP0n3yGGUgmY5xvxcGQe63JNrzv7qZCL1yuVvgeoMZFdxDYyW8Zi2iQnpLcBhEe0
         nbTEhpGHwFnQaMOq1egtHjcWnxlPaJrOJeyDl21GVCbpvdqBY1fhOvbEGAfuBA0N8xAU
         dYAS/mYJmIswvx1b6Q3zdIV1wpUTK7BUaF4ro=
Received: by 10.86.59.18 with SMTP id h18mr1536994fga.45.1234270534348;
        Tue, 10 Feb 2009 04:55:34 -0800 (PST)
Received: from ?10.11.2.21? (port-87-193-216-74.static.qsc.de [87.193.216.74])
        by mx.google.com with ESMTPS id e11sm1437521fga.50.2009.02.10.04.55.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Feb 2009 04:55:33 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109226>

The user can see and edit the signed-off in the commit dialog
before committing.

Updating the committer updates the signed-off.

For new lines in the commit dialog, use Text.DELIMITER for
plateform neutrality.

Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>
---
 .../egit/ui/internal/actions/CommitAction.java     |   10 +--
 .../egit/ui/internal/dialogs/CommitDialog.java     |   88 +++++++++++++++++++-
 .../src/org/spearce/jgit/lib/Constants.java        |    3 +
 3 files changed, 92 insertions(+), 9 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
index d619bd7..5996596 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/actions/CommitAction.java
@@ -171,7 +171,7 @@ private void performCommit(CommitDialog commitDialog, String commitMessage)
 		}
 
 		try {
-			commitMessage = doCommits(commitDialog, commitMessage, treeMap);
+			doCommits(commitDialog, commitMessage, treeMap);
 		} catch (IOException e) {
 			throw new TeamException("Committing changes", e);
 		}
@@ -180,7 +180,7 @@ private void performCommit(CommitDialog commitDialog, String commitMessage)
 		}
 	}
 
-	private String doCommits(CommitDialog commitDialog, String commitMessage,
+	private void doCommits(CommitDialog commitDialog, String commitMessage,
 			HashMap<Repository, Tree> treeMap) throws IOException, TeamException {
 
 		final String author = commitDialog.getAuthor();
@@ -208,11 +208,6 @@ private String doCommits(CommitDialog commitDialog, String commitMessage,
 			}
 			Commit commit = new Commit(repo, parentIds);
 			commit.setTree(tree);
-			commitMessage = commitMessage.replaceAll("\r", "\n");
-			if (commitDialog.isSignedOff())
-				commitMessage += "\n\nSigned-off-by: " + committerIdent.getName() + " <"
-								+ committerIdent.getEmailAddress() + ">";
-
 			commit.setMessage(commitMessage);
 			commit.setAuthor(new PersonIdent(authorIdent, commitDate, timeZone));
 			commit.setCommitter(new PersonIdent(committerIdent, commitDate, timeZone));
@@ -228,7 +223,6 @@ private String doCommits(CommitDialog commitDialog, String commitMessage,
 						+ " to commit " + commit.getCommitId() + ".");
 			}
 		}
-		return commitMessage;
 	}
 
 	private void prepareTrees(IFile[] selectedItems,
diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
index 9d062cc..ec1d85d 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
@@ -33,6 +33,8 @@
 import org.eclipse.swt.SWT;
 import org.eclipse.swt.events.KeyAdapter;
 import org.eclipse.swt.events.KeyEvent;
+import org.eclipse.swt.events.ModifyEvent;
+import org.eclipse.swt.events.ModifyListener;
 import org.eclipse.swt.events.SelectionAdapter;
 import org.eclipse.swt.events.SelectionEvent;
 import org.eclipse.swt.events.SelectionListener;
@@ -176,6 +178,18 @@ public void keyPressed(KeyEvent arg0) {
 		committerText.setLayoutData(GridDataFactory.fillDefaults().grab(true, false).create());
 		if (committer != null)
 			committerText.setText(committer);
+		committerText.addModifyListener(new ModifyListener() {
+			public void modifyText(ModifyEvent e) {
+				if (signedOffButton.getSelection()) {
+					// the commit message is signed
+					// the signature must be updated
+					String oldCommitText = commitText.getText();
+					oldCommitText = removeLastLine(oldCommitText);
+					oldCommitText = signOff(oldCommitText);
+					commitText.setText(oldCommitText);
+				}
+			}
+		});
 
 		amendingButton = new Button(container, SWT.CHECK);
 		if (amending) {
@@ -214,6 +228,29 @@ public void widgetDefaultSelected(SelectionEvent arg0) {
 		signedOffButton.setText(UIText.CommitDialog_AddSOB);
 		signedOffButton.setLayoutData(GridDataFactory.fillDefaults().grab(true, false).span(2, 1).create());
 
+		signedOffButton.addSelectionListener(new SelectionListener() {
+			public void widgetSelected(SelectionEvent arg0) {
+				if (signedOffButton.getSelection()) {
+					// add signed off line
+					commitText.setText(signOff(commitText.getText()));
+				} else {
+					// remove signed off line
+					commitText.setText(removeLastLine(commitText.getText()));
+				}
+			}
+
+			public void widgetDefaultSelected(SelectionEvent arg0) {
+				// Empty
+			}
+		});
+
+		commitText.addModifyListener(new ModifyListener() {
+			public void modifyText(ModifyEvent e) {
+				updateSignedOffButton();
+			}
+		});
+		updateSignedOffButton();
+
 		Table resourcesTable = new Table(container, SWT.H_SCROLL | SWT.V_SCROLL
 				| SWT.FULL_SELECTION | SWT.MULTI | SWT.CHECK | SWT.BORDER);
 		resourcesTable.setLayoutData(GridDataFactory.fillDefaults().hint(600,
@@ -241,6 +278,55 @@ public void widgetDefaultSelected(SelectionEvent arg0) {
 		return container;
 	}
 
+	private void updateSignedOffButton() {
+		signedOffButton.setSelection(getLastLine(commitText.getText()).equals(getSignedOff()));
+	}
+
+	private String getSignedOff() {
+		return Constants.SIGNED_OFF_BEGINNING + committerText.getText();
+	}
+
+	private String signOff(String input) {
+		String output = input;
+		if (!output.endsWith(Text.DELIMITER))
+			output += Text.DELIMITER;
+
+		// if the last line is not a signed off (amend a commit), had a line break
+		if (!getLastLine(output).startsWith(Constants.SIGNED_OFF_BEGINNING))
+			output += Text.DELIMITER;
+		output += getSignedOff();
+		return output;
+	}
+
+	private String getLastLine(String input) {
+		String output = removeLastLineBreak(input);
+		int breakLength = Text.DELIMITER.length();
+
+		// get the last line
+		int lastIndexOfLineBreak = output.lastIndexOf(Text.DELIMITER);
+		return lastIndexOfLineBreak == -1 ? output : output.substring(lastIndexOfLineBreak + breakLength, output.length());
+	}
+
+	private String removeLastLine(String input) {
+		String output = removeLastLineBreak(input);
+
+		// remove the last line if possible
+		int lastIndexOfLineBreak = output.lastIndexOf(Text.DELIMITER);
+		return lastIndexOfLineBreak == -1 ? "" : output.substring(0, lastIndexOfLineBreak); //$NON-NLS-1$
+	}
+
+	private String removeLastLineBreak(String input) {
+		String output = input;
+		int breakLength = Text.DELIMITER.length();
+
+		// remove last line break if exist
+		int lastIndexOfLineBreak = output.lastIndexOf(Text.DELIMITER);
+		if (lastIndexOfLineBreak != -1 && lastIndexOfLineBreak == output.length() - breakLength)
+			output = output.substring(0, output.length() - breakLength);
+
+		return output;
+	}
+
 	private Menu getContextMenu() {
 		Menu menu = new Menu(filesViewer.getTable());
 		MenuItem item = new MenuItem(menu, SWT.PUSH);
@@ -330,7 +416,7 @@ private static String getFileStatus(IFile file) {
 	 * @return The message the user entered
 	 */
 	public String getCommitMessage() {
-		return commitMessage;
+		return commitMessage.replaceAll(Text.DELIMITER, "\n"); //$NON-NLS-1$;
 	}
 
 	/**
diff --git a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
index b0a5b22..13e1012 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/lib/Constants.java
@@ -246,6 +246,9 @@
 	/** Default value for the user name if no other information is available */
 	public static final String UNKNOWN_USER_DEFAULT = "unknown-user";
 
+	/** Beginning of the signed of */
+	public static final String SIGNED_OFF_BEGINNING = "Signed-off-by: ";
+
 	/**
 	 * Create a new digest function for objects.
 	 * 
-- 
1.6.0.4
