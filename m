From: Robin Stocker <robin@nibor.org>
Subject: Re: [EGIT PATCH] Show diff when double-clicking on file in commit
 dialog
Date: Mon, 09 Mar 2009 10:48:13 +0100
Message-ID: <49B4E5DD.8060302@nibor.org>
References: <49B4260D.6070501@nibor.org> <200903082259.35886.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 10:50:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgc7n-0007x8-JK
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 10:50:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753775AbZCIJsv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Mar 2009 05:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753232AbZCIJsv
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 05:48:51 -0400
Received: from securemail.seppmail.ch ([195.49.105.241]:54977 "EHLO
	securemail.seppmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753506AbZCIJst (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 05:48:49 -0400
Received: from localhost (localhost.seppmail.local [127.0.0.1])
	by securemail.seppmail.ch (Postfix) with SMTP id 87AC93C664
	for <git@vger.kernel.org>; Mon,  9 Mar 2009 10:48:24 +0100 (CET)
Received: from gnu.speedpc.ch (unknown [192.168.0.4])
	by securemail.seppmail.ch (Postfix) with ESMTPS
	for <git@vger.kernel.org>; Mon,  9 Mar 2009 10:48:22 +0100 (CET)
Received: (qmail 12698 invoked from network); 9 Mar 2009 10:48:43 +0100
Received: from nat1.ergon.ch (HELO ?224.80.41.1?) (87.239.215.2)
  by 228.if.gnu.speedpc.ch with (DHE-RSA-AES256-SHA encrypted) SMTP; 9 Mar 2009 10:48:43 +0100
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <200903082259.35886.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112682>

When double-clicking on a file in the commit dialog, a compare dialog i=
s
shown with the changes that are about to be committed. It compares the
HEAD version with the working tree version.

Signed-off-by: Robin Stocker <robin@nibor.org>
---

Robin Rosenberg schrieb:
> s=C3=B6ndag 08 mars 2009 21:09:49 skrev Robin Stocker <robin@nibor.or=
g>:
>> An essential feature I miss in EGit at the moment (apart from the
>> synchronize view [1]) is seeing what changes one is about to commit.=
 In
>> the Subclipse SVN plugin one can double-click a file in the commit
>> dialog and the diff is shown.
> Hi, Robin. I miss that too!
>=20
>> This patch is a first step for adding this to EGit. It only compares=
 the
>> index version to the working tree version as I couldn't figure out a=
n
>> easy way to get the HEAD version.
> You can look at how GitDocument does it.
>=20
>> It's more a proof of concept than a final patch. What do you think?
>=20
> I've started on an version with the diff integrated into the same dia=
log, for
> some reasons it's not done yet, but we might takes this meanwhile unl=
ess
> I complete the dialog real quick, as this is really useful, provided =
we compare
> with HEAD.

That sounds even better! For the meantime, I've updated the patch to
compare with HEAD.

-- Robin

=2E../egit/ui/internal/dialogs/CommitDialog.java     |   56 +++++++++++=
+++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialo=
gs/CommitDialog.java b/org.spearce.egit.ui/src/org/spearce/egit/ui/inte=
rnal/dialogs/CommitDialog.java
index 8b7fe45..b69a4ba 100644
--- a/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/Comm=
itDialog.java
+++ b/org.spearce.egit.ui/src/org/spearce/egit/ui/internal/dialogs/Comm=
itDialog.java
@@ -18,6 +18,8 @@
 import java.util.Comparator;
 import java.util.Iterator;
=20
+import org.eclipse.compare.CompareUI;
+import org.eclipse.compare.ITypedElement;
 import org.eclipse.core.resources.IFile;
 import org.eclipse.core.resources.IProject;
 import org.eclipse.jface.dialogs.Dialog;
@@ -52,9 +54,17 @@
 import org.eclipse.swt.widgets.Table;
 import org.eclipse.swt.widgets.TableColumn;
 import org.eclipse.swt.widgets.Text;
+import org.eclipse.team.core.RepositoryProvider;
+import org.eclipse.team.core.history.IFileHistory;
+import org.eclipse.team.core.history.IFileRevision;
+import org.eclipse.team.internal.ui.history.FileRevisionTypedElement;
 import org.eclipse.ui.model.WorkbenchLabelProvider;
+import org.spearce.egit.core.GitProvider;
+import org.spearce.egit.core.internal.storage.GitFileHistoryProvider;
 import org.spearce.egit.core.project.RepositoryMapping;
 import org.spearce.egit.ui.UIText;
+import org.spearce.egit.ui.internal.GitCompareFileRevisionEditorInput;
+import org.spearce.jgit.lib.Commit;
 import org.spearce.jgit.lib.Constants;
 import org.spearce.jgit.lib.GitIndex;
 import org.spearce.jgit.lib.PersonIdent;
@@ -262,6 +272,8 @@ public void modifyText(ModifyEvent e) {
 		resourcesTable.setLayoutData(GridDataFactory.fillDefaults().hint(600=
,
 				200).span(2,1).grab(true, true).create());
=20
+		resourcesTable.addSelectionListener(new CommitItemSelectionListener(=
));
+
 		resourcesTable.setHeaderVisible(true);
 		TableColumn statCol =3D new TableColumn(resourcesTable, SWT.LEFT);
 		statCol.setText(UIText.CommitDialog_Status);
@@ -505,6 +517,50 @@ public void widgetSelected(SelectionEvent e) {
=20
 	}
=20
+	class CommitItemSelectionListener extends SelectionAdapter {
+
+		public void widgetDefaultSelected(SelectionEvent e) {
+			IStructuredSelection selection =3D (IStructuredSelection) filesView=
er.getSelection();
+
+			CommitItem commitItem =3D (CommitItem) selection.getFirstElement();
+			if (commitItem =3D=3D null) {
+				return;
+			}
+
+			IProject project =3D commitItem.file.getProject();
+			RepositoryMapping mapping =3D RepositoryMapping.getMapping(project)=
;
+			if (mapping =3D=3D null) {
+				return;
+			}
+			Repository repository =3D mapping.getRepository();
+
+			Commit headCommit;
+			try {
+				headCommit =3D repository.mapCommit(Constants.HEAD);
+			} catch (IOException e1) {
+				headCommit =3D null;
+			}
+			if (headCommit =3D=3D null) {
+				return;
+			}
+
+			GitProvider provider =3D (GitProvider) RepositoryProvider.getProvid=
er(project);
+			GitFileHistoryProvider fileHistoryProvider =3D (GitFileHistoryProvi=
der) provider.getFileHistoryProvider();
+
+			IFileHistory fileHistory =3D fileHistoryProvider.getFileHistoryFor(=
commitItem.file, 0, null);
+
+			IFileRevision baseFile =3D fileHistory.getFileRevision(headCommit.g=
etCommitId().name());
+			IFileRevision nextFile =3D fileHistoryProvider.getWorkspaceFileRevi=
sion(commitItem.file);
+
+			ITypedElement base =3D new FileRevisionTypedElement(baseFile);
+			ITypedElement next =3D new FileRevisionTypedElement(nextFile);
+
+			GitCompareFileRevisionEditorInput input =3D new GitCompareFileRevis=
ionEditorInput(base, next, null);
+			CompareUI.openCompareDialog(input);
+		}
+
+	}
+
 	@Override
 	protected void okPressed() {
 		commitMessage =3D commitText.getText();
--=20
1.6.1.2
