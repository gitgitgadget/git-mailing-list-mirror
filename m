From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: [PATCH] gitview: annotation support
Date: Thu, 19 Apr 2007 22:26:03 +0530
Message-ID: <11770017633282-git-send-email-aneesh.kumar@gmail.com>
Cc: junkio@cox.net, aneesh.kumar@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 19 18:56:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeZvo-0005kO-5s
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 18:56:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766877AbXDSQ4O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 12:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766878AbXDSQ4O
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 12:56:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:13803 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1766877AbXDSQ4M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 12:56:12 -0400
Received: by ug-out-1314.google.com with SMTP id 44so715252uga
        for <git@vger.kernel.org>; Thu, 19 Apr 2007 09:56:10 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        b=qdXY7SyvG7KB/LT5EuQnltLndZNdqt6KWrJ6IP7cLAHijrrCwK+2qIWejAnZPxXl262NSXDkOBqXCnyBI4lRIgVxop8LNO9THlmF1Qyrd/RIq4A4/9jUOeMiRmwAvPsgLRZse7xMVYYY6pCKACk3PAjX+To66K9jD6hP1syOIn8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=PpqhagxSaepCKU6TzQtCBra5hucfoqfN3zfNQ8ttewzOpIweQ4cV+x1jKD7s+6dO4kmMkAsemyHN5rPGSFVBwt4jFd5kn6rk2vQoL9xwyxkrfCANh0GeC0rTL7mE6r27Ppashz8hXC/QSmWoRP9evHeKhdpF6+KYGjU1aF80Icg=
Received: by 10.82.185.12 with SMTP id i12mr3123653buf.1177001770554;
        Thu, 19 Apr 2007 09:56:10 -0700 (PDT)
Received: from localhost ( [59.92.166.69])
        by mx.google.com with ESMTP id g30sm5111699ugd.2007.04.19.09.56.06;
        Thu, 19 Apr 2007 09:56:09 -0700 (PDT)
X-Mailer: git-send-email 1.5.1.1.135.gf948-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45030>

List files modifed as a part of the commit in the diff window
Support annotation of the file listed in the diff window
Support history browsing in the annotation window.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>
---
 contrib/gitview/gitview |  260 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 256 insertions(+), 4 deletions(-)

diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
index 521b2fc..4b8cde1 100755
--- a/contrib/gitview/gitview
+++ b/contrib/gitview/gitview
@@ -10,7 +10,8 @@ GUI browser for git repository
 This program is based on bzrk by Scott James Remnant <scott@ubuntu.com>
 """
 __copyright__ = "Copyright (C) 2006 Hewlett-Packard Development Company, L.P."
-__author__    = "Aneesh Kumar K.V <aneesh.kumar@hp.com>"
+__copyright__ = "Copyright (C) 2007 Aneesh Kumar K.V <aneesh.kumar@gmail.com"
+__author__    = "Aneesh Kumar K.V <aneesh.kumar@gmail.com>"
 
 
 import sys
@@ -24,6 +25,7 @@ import gobject
 import cairo
 import math
 import string
+import fcntl
 
 try:
     import gtksourceview
@@ -337,6 +339,186 @@ class Commit:
 		fp.close()
 		return diff
 
+class AnnotateWindow:
+	"""Annotate window.
+	This object represents and manages a single window containing the
+	annotate information of the file
+	"""
+
+	def __init__(self):
+		self.window = gtk.Window(gtk.WINDOW_TOPLEVEL)
+		self.window.set_border_width(0)
+		self.window.set_title("Git repository browser annotation window")
+
+		# Use two thirds of the screen by default
+		screen = self.window.get_screen()
+		monitor = screen.get_monitor_geometry(0)
+		width = int(monitor.width * 0.66)
+		height = int(monitor.height * 0.66)
+		self.window.set_default_size(width, height)
+
+	def add_file_data(self, filename, commit_sha1, line_num):
+		fp = os.popen("git cat-file blob " + commit_sha1 +":"+filename)
+		i = 1;
+		for line in fp.readlines():
+			line = string.strip(line)
+			self.model.append(None, ["HEAD", filename, line, i])
+			i = i+1
+		fp.close()
+
+		# now set the cursor position
+		self.treeview.set_cursor(line_num-1)
+		self.treeview.grab_focus()
+
+	def _treeview_cursor_cb(self, *args):
+		"""Callback for when the treeview cursor changes."""
+		(path, col) = self.treeview.get_cursor()
+		commit_sha1 = self.model[path][0]
+		commit_msg = ""
+		fp = os.popen("git cat-file commit " + commit_sha1)
+		for line in fp.readlines():
+			commit_msg =  commit_msg + line
+		fp.close()
+
+		self.commit_buffer.set_text(commit_msg)
+
+	def _treeview_row_activated(self, *args):
+		"""Callback for when the treeview row gets selected."""
+		(path, col) = self.treeview.get_cursor()
+		commit_sha1 = self.model[path][0]
+		filename    = self.model[path][1]
+		line_num    = self.model[path][3]
+
+		window = AnnotateWindow();
+		fp = os.popen("git rev-parse "+ commit_sha1 + "~1")
+		commit_sha1 = string.strip(fp.readline())
+		fp.close()
+		window.annotate(filename, commit_sha1, line_num)
+
+	def data_ready(self, source, condition):
+		while (1):
+			try :
+				buffer = source.read(8192)
+			except:
+				# resource temporary not available
+				return True
+
+			if (len(buffer) == 0):
+				gobject.source_remove(self.io_watch_tag)
+				source.close()
+				return False
+
+			for buff in buffer.split("\n"):
+				annotate_line = re.compile('^([0-9a-f]{40}) (.+) (.+) (.+)$')
+				m = annotate_line.match(buff)
+				if not m:
+					annotate_line = re.compile('^(filename) (.+)$')
+					m = annotate_line.match(buff)
+					if not m:
+						continue
+					filename = m.group(2)
+				else:
+					self.commit_sha1 = m.group(1)
+					self.source_line = int(m.group(2))
+					self.result_line = int(m.group(3))
+					self.count	    = int(m.group(4))
+					#set the details only when we have the file name
+					continue
+
+				while (self.count > 0):
+					# set at result_line + count-1 the sha1 as commit_sha1
+					self.count = self.count - 1
+					iter = self.model.iter_nth_child(None, self.result_line + self.count-1)
+					self.model.set(iter, 0, self.commit_sha1, 1, filename, 3, self.source_line)
+
+
+	def annotate(self, filename, commit_sha1, line_num):
+		# verify the commit_sha1 specified has this filename
+
+		fp = os.popen("git ls-tree "+ commit_sha1 + " -- " + filename)
+		line = string.strip(fp.readline())
+		if line == '':
+			# pop up the message the file is not there as a part of the commit
+			fp.close()
+			dialog = gtk.MessageDialog(parent=None, flags=0,
+					type=gtk.MESSAGE_WARNING, buttons=gtk.BUTTONS_CLOSE,
+					message_format=None)
+			dialog.set_markup("The file %s is not present in the parent commit %s" % (filename, commit_sha1))
+			dialog.run()
+			dialog.destroy()
+			return
+
+		fp.close()
+
+		vpan = gtk.VPaned();
+		self.window.add(vpan);
+		vpan.show()
+
+		scrollwin = gtk.ScrolledWindow()
+		scrollwin.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
+		scrollwin.set_shadow_type(gtk.SHADOW_IN)
+		vpan.pack1(scrollwin, True, True);
+		scrollwin.show()
+
+		self.model = gtk.TreeStore(str, str, str, int)
+		self.treeview = gtk.TreeView(self.model)
+		self.treeview.set_rules_hint(True)
+		self.treeview.set_search_column(0)
+		self.treeview.connect("cursor-changed", self._treeview_cursor_cb)
+		self.treeview.connect("row-activated", self._treeview_row_activated)
+		scrollwin.add(self.treeview)
+		self.treeview.show()
+
+		cell = gtk.CellRendererText()
+		cell.set_property("width-chars", 10)
+		cell.set_property("ellipsize", pango.ELLIPSIZE_END)
+		column = gtk.TreeViewColumn("Commit")
+		column.set_resizable(True)
+		column.pack_start(cell, expand=True)
+		column.add_attribute(cell, "text", 0)
+		self.treeview.append_column(column)
+
+		cell = gtk.CellRendererText()
+		cell.set_property("width-chars", 20)
+		cell.set_property("ellipsize", pango.ELLIPSIZE_END)
+		column = gtk.TreeViewColumn("File Name")
+		column.set_resizable(True)
+		column.pack_start(cell, expand=True)
+		column.add_attribute(cell, "text", 1)
+		self.treeview.append_column(column)
+
+		cell = gtk.CellRendererText()
+		cell.set_property("width-chars", 20)
+		cell.set_property("ellipsize", pango.ELLIPSIZE_END)
+		column = gtk.TreeViewColumn("Data")
+		column.set_resizable(True)
+		column.pack_start(cell, expand=True)
+		column.add_attribute(cell, "text", 2)
+		self.treeview.append_column(column)
+
+		# The commit message window
+		scrollwin = gtk.ScrolledWindow()
+		scrollwin.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
+		scrollwin.set_shadow_type(gtk.SHADOW_IN)
+		vpan.pack2(scrollwin, True, True);
+		scrollwin.show()
+
+		commit_text = gtk.TextView()
+		self.commit_buffer = gtk.TextBuffer()
+		commit_text.set_buffer(self.commit_buffer)
+		scrollwin.add(commit_text)
+		commit_text.show()
+
+		self.window.show()
+
+		self.add_file_data(filename, commit_sha1, line_num)
+
+		fp = os.popen("git blame --incremental -- " + filename + " " + commit_sha1)
+		flags = fcntl.fcntl(fp.fileno(), fcntl.F_GETFL)
+		fcntl.fcntl(fp.fileno(), fcntl.F_SETFL, flags | os.O_NONBLOCK)
+		self.io_watch_tag = gobject.io_add_watch(fp, gobject.IO_IN, self.data_ready)
+
+
 class DiffWindow:
 	"""Diff window.
 	This object represents and manages a single window containing the
@@ -355,6 +537,7 @@ class DiffWindow:
 		height = int(monitor.height * 0.66)
 		self.window.set_default_size(width, height)
 
+
 		self.construct()
 
 	def construct(self):
@@ -371,10 +554,12 @@ class DiffWindow:
 		vbox.pack_start(menu_bar, expand=False, fill=True)
 		menu_bar.show()
 
+		hpan = gtk.HPaned()
+
 		scrollwin = gtk.ScrolledWindow()
 		scrollwin.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
 		scrollwin.set_shadow_type(gtk.SHADOW_IN)
-		vbox.pack_start(scrollwin, expand=True, fill=True)
+		hpan.pack1(scrollwin, True, True)
 		scrollwin.show()
 
 		if have_gtksourceview:
@@ -388,11 +573,77 @@ class DiffWindow:
 			self.buffer = gtk.TextBuffer()
 			sourceview = gtk.TextView(self.buffer)
 
+
 		sourceview.set_editable(False)
 		sourceview.modify_font(pango.FontDescription("Monospace"))
 		scrollwin.add(sourceview)
 		sourceview.show()
 
+		# The file hierarchy: a scrollable treeview
+		scrollwin = gtk.ScrolledWindow()
+		scrollwin.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)
+		scrollwin.set_shadow_type(gtk.SHADOW_IN)
+		scrollwin.set_size_request(20, -1)
+		hpan.pack2(scrollwin, True, True)
+		scrollwin.show()
+
+		self.model = gtk.TreeStore(str, str, str)
+		self.treeview = gtk.TreeView(self.model)
+		self.treeview.set_search_column(1)
+		self.treeview.connect("cursor-changed", self._treeview_clicked)
+		scrollwin.add(self.treeview)
+		self.treeview.show()
+
+		cell = gtk.CellRendererText()
+		cell.set_property("width-chars", 20)
+		column = gtk.TreeViewColumn("Select to annotate")
+		column.pack_start(cell, expand=True)
+		column.add_attribute(cell, "text", 0)
+		self.treeview.append_column(column)
+
+		vbox.pack_start(hpan, expand=True, fill=True)
+		hpan.show()
+
+	def _treeview_clicked(self, *args):
+		"""Callback for when the treeview cursor changes."""
+		(path, col) = self.treeview.get_cursor()
+		specific_file = self.model[path][1]
+		commit_sha1 =  self.model[path][2]
+		if specific_file ==  None :
+			return
+		elif specific_file ==  "" :
+			specific_file =  None
+
+		window = AnnotateWindow();
+		window.annotate(specific_file, commit_sha1, 1)
+
+
+	def commit_files(self, commit_sha1, parent_sha1):
+		self.model.clear()
+		add  = self.model.append(None, [ "Added", None, None])
+		dele = self.model.append(None, [ "Deleted", None, None])
+		mod  = self.model.append(None, [ "Modified", None, None])
+		diff_tree = re.compile('^(:.{6}) (.{6}) (.{40}) (.{40}) (A|D|M)\s(.+)$')
+		fp = os.popen("git diff-tree -r --no-commit-id " + parent_sha1 + " " + commit_sha1)
+		while 1:
+			line = string.strip(fp.readline())
+			if line == '':
+				break
+			m = diff_tree.match(line)
+			if not m:
+				continue
+
+			attr = m.group(5)
+			filename = m.group(6)
+			if attr == "A":
+				self.model.append(add,  [filename, filename, commit_sha1])
+			elif attr == "D":
+				self.model.append(dele, [filename, filename, commit_sha1])
+			elif attr == "M":
+				self.model.append(mod,  [filename, filename, commit_sha1])
+		fp.close()
+
+		self.treeview.expand_all()
 
 	def set_diff(self, commit_sha1, parent_sha1, encoding):
 		"""Set the differences showed by this window.
@@ -406,6 +657,7 @@ class DiffWindow:
 		fp = os.popen("git diff-tree -p " + parent_sha1 + " " + commit_sha1)
 		self.buffer.set_text(unicode(fp.read(), encoding).encode('utf-8'))
 		fp.close()
+		self.commit_files(commit_sha1, parent_sha1)
 		self.window.show()
 
 	def save_menu_response(self, widget, string):
@@ -425,7 +677,7 @@ class DiffWindow:
 class GitView:
 	""" This is the main class
 	"""
-	version = "0.8"
+	version = "0.9"
 
 	def __init__(self, with_diff=0):
 		self.with_diff = with_diff
@@ -590,7 +842,7 @@ class GitView:
 		dialog = gtk.AboutDialog()
 		dialog.set_name("Gitview")
 		dialog.set_version(GitView.version)
-		dialog.set_authors(["Aneesh Kumar K.V <aneesh.kumar@hp.com>"])
+		dialog.set_authors(["Aneesh Kumar K.V <aneesh.kumar@gmail.com>"])
 		dialog.set_website("http://www.kernel.org/pub/software/scm/git/")
 		dialog.set_copyright("Use and distribute under the terms of the GNU General Public License")
 		dialog.set_wrap_license(True)
-- 
1.5.1.1.135.gf948-dirty
