From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: gitview: Fix the encoding related bug
Date: Mon, 27 Feb 2006 21:25:13 +0530
Message-ID: <440320E1.4080301@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050303020308030300060603"
X-From: git-owner@vger.kernel.org Mon Feb 27 17:01:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDkic-0007ul-GV
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 16:55:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWB0PzX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 10:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWB0PzX
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 10:55:23 -0500
Received: from pproxy.gmail.com ([64.233.166.180]:33700 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751264AbWB0PzX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2006 10:55:23 -0500
Received: by pproxy.gmail.com with SMTP id z74so755266pyg
        for <git@vger.kernel.org>; Mon, 27 Feb 2006 07:55:22 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type;
        b=fqR9LQomVLozXkVbPhvdl1IM9AlabITR/AXbZfCcjC0gwLzhxsQqKSHsqftX7jvXs/HSWw2NcgOTmj+1wBOSbO8GrNSmVI4ju5y5mxkA28deTsXDDoBgGRv5omEeRA+HHosGD3TheUxA+nbBAQ0nsrsD8JPTFqTwvpDAfDZV9oY=
Received: by 10.35.78.13 with SMTP id f13mr2181637pyl;
        Mon, 27 Feb 2006 07:55:22 -0800 (PST)
Received: from ?192.168.2.39? ( [59.92.140.66])
        by mx.gmail.com with ESMTP id m78sm1451619pye.2006.02.27.07.55.20;
        Mon, 27 Feb 2006 07:55:22 -0800 (PST)
User-Agent: Mail/News 1.5 (X11/20060213)
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16854>

This is a multi-part message in MIME format.
--------------050303020308030300060603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------050303020308030300060603
Content-Type: text/plain;
 name="0001-gitview-Fix-the-encoding-related-bug.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-gitview-Fix-the-encoding-related-bug.txt"

Subject: gitview: Fix the encoding related bug

Get the encoding information from repository and convert it to utf-8 before
passing to gtk.TextBuffer.set_text. gtk.TextBuffer.set_text work only with utf-8

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>

---

 contrib/gitview/gitview |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

0900cf4b80aa18e314aa487d84189b8237d088e7
diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
index 4e3847d..1d042e3 100755
--- a/contrib/gitview/gitview
+++ b/contrib/gitview/gitview
@@ -391,7 +391,7 @@ class DiffWindow:
 		sourceview.show()
 
 
-	def set_diff(self, commit_sha1, parent_sha1):
+	def set_diff(self, commit_sha1, parent_sha1, encoding):
 		"""Set the differences showed by this window.
 		Compares the two trees and populates the window with the
 		differences.
@@ -401,7 +401,7 @@ class DiffWindow:
 			return
 
 		fp = os.popen("git diff-tree -p " + parent_sha1 + " " + commit_sha1)
-		self.buffer.set_text(fp.read())
+		self.buffer.set_text(unicode(fp.read(), encoding).encode('utf-8'))
 		fp.close()
 		self.window.show()
 
@@ -430,6 +430,7 @@ class GitView:
 		self.window.set_border_width(0)
 		self.window.set_title("Git repository browser")
 
+		self.get_encoding()
 		self.get_bt_sha1()
 
 		# Use three-quarters of the screen by default
@@ -468,6 +469,13 @@ class GitView:
 			self.bt_sha1[sha1].append(name)
 		fp.close()
 
+	def get_encoding(self):
+		fp = os.popen("git repo-config --get i18n.commitencoding")
+		self.encoding=string.strip(fp.readline())
+		fp.close()
+		if (self.encoding == ""):
+			self.encoding = "utf-8"
+
 
 	def construct(self):
 		"""Construct the window contents."""
@@ -683,7 +691,7 @@ class GitView:
 		self.revid_label.set_text(revid_label)
 		self.committer_label.set_text(committer)
 		self.timestamp_label.set_text(timestamp)
-		self.message_buffer.set_text(message)
+		self.message_buffer.set_text(unicode(message, self.encoding).encode('utf-8'))
 
 		for widget in self.parents_widgets:
 			self.table.remove(widget)
@@ -728,7 +736,7 @@ class GitView:
 			button.set_relief(gtk.RELIEF_NONE)
 			button.set_sensitive(True)
 			button.connect("clicked", self._show_clicked_cb,
-					commit.commit_sha1, parent_id)
+					commit.commit_sha1, parent_id, self.encoding)
 			hbox.pack_start(button, expand=False, fill=True)
 			button.show()
 
@@ -967,10 +975,10 @@ class GitView:
 
 		self.treeview.grab_focus()
 
-	def _show_clicked_cb(self, widget,  commit_sha1, parent_sha1):
+	def _show_clicked_cb(self, widget,  commit_sha1, parent_sha1, encoding):
 		"""Callback for when the show button for a parent is clicked."""
 		window = DiffWindow()
-		window.set_diff(commit_sha1, parent_sha1)
+		window.set_diff(commit_sha1, parent_sha1, encoding)
 		self.treeview.grab_focus()
 
 if __name__ == "__main__":
-- 
1.2.3.g2cf3-dirty


--------------050303020308030300060603--
