From: Yann Simon <yann.simon.fr@gmail.com>
Subject: [PATCH JGIT] In the commit dialog, deal with Signed-off-by not on
 the last line
Date: Fri, 20 Feb 2009 09:09:53 +0100
Message-ID: <499E6551.8080707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 20 09:11:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaQTu-000804-1e
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 09:11:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545AbZBTIJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 03:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753040AbZBTIJ7
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 03:09:59 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:45955 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841AbZBTIJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 03:09:57 -0500
Received: by fg-out-1718.google.com with SMTP id 16so1714522fgg.17
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 00:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=1DAJAA7qKMk1LNqE4T2GT2wM6JBJBm580B6MFwLD/tI=;
        b=IS657r5PBB2diXfcPDEdbFrzfe2suGhqIfKnNM4c+/vQpqeujwELOPabVND57w0TSS
         ILdt0FyddlYyfgN9QHcgXrGojtMwv1XhaC7Y9pURHmm47nrNRbSjSWAmd0DBEy4QmcN0
         8Pup4OADmU2eAlk0Bk7yH80RkzG8t1O0wHnSI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=fFv6gFRFv0rceXW+VJkKcmpFS5NzuQ9ec5nI3/9Iv7cn4BUdEx0LVhUmuX6XTVHv7G
         ZsQZ6y7RMNMQJo6CKnuprnK8JfDNkILnR1gFfUMh6zV2ott5hAAgMZLWa1MYIFb2hGrc
         1dvEF6LjeZtC7b24eCnyHAVy24bBRrJluuyMA=
Received: by 10.86.73.1 with SMTP id v1mr889227fga.52.1235117395327;
        Fri, 20 Feb 2009 00:09:55 -0800 (PST)
Received: from ?10.11.2.21? (port-87-193-216-74.static.qsc.de [87.193.216.74])
        by mx.google.com with ESMTPS id e20sm6670027fga.56.2009.02.20.00.09.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Feb 2009 00:09:54 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110811>

The previous implementation made the assumption that
the Signed-off-by is always on the last line.

Correct this assumption and deal with Signed-off-by everywhere in
the commit message.

Signed-off-by: Yann Simon <yann.simon.fr@gmail.com>
---
I found the problem with whitespace corruptions.
yann

 .../egit/ui/internal/dialogs/CommitDialog.java     |   65 ++++++++++++--------
 1 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
index bbe7193..403d69d 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/CommitDialog.java
@@ -179,14 +179,16 @@ public void keyPressed(KeyEvent arg0) {
 		if (committer != null)
 			committerText.setText(committer);
 		committerText.addModifyListener(new ModifyListener() {
+			String oldCommitter = committerText.getText();
 			public void modifyText(ModifyEvent e) {
 				if (signedOffButton.getSelection()) {
 					// the commit message is signed
 					// the signature must be updated
-					String oldCommitText = commitText.getText();
-					oldCommitText = removeLastLine(oldCommitText);
-					oldCommitText = signOff(oldCommitText);
-					commitText.setText(oldCommitText);
+					String neuCommitter = committerText.getText();
+					String oldSignOff = getSignedOff(oldCommitter);
+					String neuSignOff = getSignedOff(neuCommitter);
+					commitText.setText(replaceSignOff(commitText.getText(), oldSignOff, neuSignOff));
+					oldCommitter = neuCommitter;
 				}
 			}
 		});
@@ -230,12 +232,16 @@ public void widgetDefaultSelected(SelectionEvent arg0) {
 
 		signedOffButton.addSelectionListener(new SelectionListener() {
 			public void widgetSelected(SelectionEvent arg0) {
+				String curText = commitText.getText();
 				if (signedOffButton.getSelection()) {
 					// add signed off line
-					commitText.setText(signOff(commitText.getText()));
+					commitText.setText(signOff(curText));
 				} else {
 					// remove signed off line
-					commitText.setText(removeLastLine(commitText.getText()));
+					curText = replaceSignOff(curText, getSignedOff(), "");
+					if (curText.endsWith(Text.DELIMITER + Text.DELIMITER))
+						curText = curText.substring(0, curText.length() - Text.DELIMITER.length());
+					commitText.setText(curText);
 				}
 			}
 
@@ -279,11 +285,19 @@ public void modifyText(ModifyEvent e) {
 	}
 
 	private void updateSignedOffButton() {
-		signedOffButton.setSelection(getLastLine(commitText.getText()).equals(getSignedOff()));
+		String curText = commitText.getText();
+		if (!curText.endsWith(Text.DELIMITER))
+			curText += Text.DELIMITER;
+
+		signedOffButton.setSelection(curText.indexOf(getSignedOff() + Text.DELIMITER) != -1);
 	}
 
 	private String getSignedOff() {
-		return Constants.SIGNED_OFF_BY_TAG + committerText.getText();
+		return getSignedOff(committerText.getText());
+	}
+
+	private String getSignedOff(String signer) {
+		return Constants.SIGNED_OFF_BY_TAG + signer;
 	}
 
 	private String signOff(String input) {
@@ -299,32 +313,33 @@ private String signOff(String input) {
 	}
 
 	private String getLastLine(String input) {
-		String output = removeLastLineBreak(input);
+		String output = input;
 		int breakLength = Text.DELIMITER.length();
 
-		// get the last line
+		// remove last line break if exist
 		int lastIndexOfLineBreak = output.lastIndexOf(Text.DELIMITER);
+		if (lastIndexOfLineBreak != -1 && lastIndexOfLineBreak == output.length() - breakLength)
+			output = output.substring(0, output.length() - breakLength);
+
+		// get the last line
+		lastIndexOfLineBreak = output.lastIndexOf(Text.DELIMITER);
 		return lastIndexOfLineBreak == -1 ? output : output.substring(lastIndexOfLineBreak + breakLength, output.length());
 	}
 
-	private String removeLastLine(String input) {
-		String output = removeLastLineBreak(input);
+	private String replaceSignOff(String input, String oldSignOff, String newSignOff) {
+		assert input != null;
+		assert oldSignOff != null;
+		assert newSignOff != null;
 
-		// remove the last line if possible
-		int lastIndexOfLineBreak = output.lastIndexOf(Text.DELIMITER);
-		return lastIndexOfLineBreak == -1 ? "" : output.substring(0, lastIndexOfLineBreak); //$NON-NLS-1$
-	}
-
-	private String removeLastLineBreak(String input) {
-		String output = input;
-		int breakLength = Text.DELIMITER.length();
+		String curText = input;
+		if (!curText.endsWith(Text.DELIMITER))
+			curText += Text.DELIMITER;
 
-		// remove last line break if exist
-		int lastIndexOfLineBreak = output.lastIndexOf(Text.DELIMITER);
-		if (lastIndexOfLineBreak != -1 && lastIndexOfLineBreak == output.length() - breakLength)
-			output = output.substring(0, output.length() - breakLength);
+		int indexOfSignOff = curText.indexOf(oldSignOff + Text.DELIMITER);
+		if (indexOfSignOff == -1)
+			return input;
 
-		return output;
+		return input.substring(0, indexOfSignOff) + newSignOff + input.substring(indexOfSignOff + oldSignOff.length(), input.length());
 	}
 
 	private Menu getContextMenu() {
-- 
1.6.1.2
