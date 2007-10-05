From: Frederick Akalin <akalin@akalin.cx>
Subject: [PATCH] gtksourceview2 support for gitview
Date: Fri,  5 Oct 2007 00:20:49 -0700
Message-ID: <1191568849-6923-1-git-send-email-akalin@akalin.cx>
Cc: Frederick Akalin <akalin@akalin.cx>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Oct 05 09:21:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdhUX-0005Ez-4m
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 09:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbXJEHUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 03:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbXJEHUr
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 03:20:47 -0400
Received: from qb-out-0506.google.com ([72.14.204.233]:42522 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbXJEHUq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 03:20:46 -0400
Received: by qb-out-0506.google.com with SMTP id e11so107048qbe
        for <git@vger.kernel.org>; Fri, 05 Oct 2007 00:20:44 -0700 (PDT)
Received: by 10.65.158.9 with SMTP id k9mr16165302qbo.1191568843882;
        Fri, 05 Oct 2007 00:20:43 -0700 (PDT)
Received: from McCarthy ( [64.81.170.89])
        by mx.google.com with ESMTPS id d2sm728568qbc.2007.10.05.00.20.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 05 Oct 2007 00:20:42 -0700 (PDT)
Received: by McCarthy (nbSMTP-1.00) for uid 1000
	(using TLSv1/SSLv3 with cipher DES-CBC3-SHA (168/168 bits))
	akalin@akalin.cx; Fri,  5 Oct 2007 00:20:51 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60042>

Added support for gtksourceview2 module (pygtksourceview 1.90.x) in
gitview.  Also refactored code that creates the source buffer and view.

Signed-off-by: Frederick Akalin <akalin@akalin.cx>
---
 contrib/gitview/gitview |   53 +++++++++++++++++++++++++++-------------------
 1 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
index 5931766..449ee69 100755
--- a/contrib/gitview/gitview
+++ b/contrib/gitview/gitview
@@ -28,11 +28,19 @@ import string
 import fcntl
 
 try:
+    import gtksourceview2
+    have_gtksourceview2 = True
+except ImportError:
+    have_gtksourceview2 = False
+
+try:
     import gtksourceview
     have_gtksourceview = True
 except ImportError:
     have_gtksourceview = False
-    print "Running without gtksourceview module"
+
+if not have_gtksourceview2 and not have_gtksourceview:
+    print "Running without gtksourceview2 or gtksourceview module"
 
 re_ident = re.compile('(author|committer) (?P<ident>.*) (?P<epoch>\d+) (?P<tz>[+-]\d{4})')
 
@@ -58,6 +66,26 @@ def show_date(epoch, tz):
 
 	return time.strftime("%Y-%m-%d %H:%M:%S", time.gmtime(secs))
 
+def get_source_buffer_and_view():
+	if have_gtksourceview2:
+		buffer = gtksourceview2.Buffer()
+		slm = gtksourceview2.LanguageManager()
+		gsl = slm.get_language("diff")
+		buffer.set_highlight_syntax(True)
+		buffer.set_language(gsl)
+		view = gtksourceview2.View(buffer)
+	elif have_gtksourceview:
+		buffer = gtksourceview.SourceBuffer()
+		slm = gtksourceview.SourceLanguagesManager()
+		gsl = slm.get_language_from_mime_type("text/x-patch")
+		buffer.set_highlight(True)
+		buffer.set_language(gsl)
+		view = gtksourceview.SourceView(buffer)
+	else:
+		buffer = gtk.TextBuffer()
+		view = gtk.TextView(buffer)
+	return (buffer, view)
+
 
 class CellRendererGraph(gtk.GenericCellRenderer):
 	"""Cell renderer for directed graph.
@@ -582,17 +610,7 @@ class DiffWindow(object):
 		hpan.pack1(scrollwin, True, True)
 		scrollwin.show()
 
-		if have_gtksourceview:
-			self.buffer = gtksourceview.SourceBuffer()
-			slm = gtksourceview.SourceLanguagesManager()
-			gsl = slm.get_language_from_mime_type("text/x-patch")
-			self.buffer.set_highlight(True)
-			self.buffer.set_language(gsl)
-			sourceview = gtksourceview.SourceView(self.buffer)
-		else:
-			self.buffer = gtk.TextBuffer()
-			sourceview = gtk.TextView(self.buffer)
-
+		(self.buffer, sourceview) = get_source_buffer_and_view()
 
 		sourceview.set_editable(False)
 		sourceview.modify_font(pango.FontDescription("Monospace"))
@@ -956,16 +974,7 @@ class GitView(object):
 		vbox.pack_start(scrollwin, expand=True, fill=True)
 		scrollwin.show()
 
-		if have_gtksourceview:
-			self.message_buffer = gtksourceview.SourceBuffer()
-			slm = gtksourceview.SourceLanguagesManager()
-			gsl = slm.get_language_from_mime_type("text/x-patch")
-			self.message_buffer.set_highlight(True)
-			self.message_buffer.set_language(gsl)
-			sourceview = gtksourceview.SourceView(self.message_buffer)
-		else:
-			self.message_buffer = gtk.TextBuffer()
-			sourceview = gtk.TextView(self.message_buffer)
+		(self.message_buffer, sourceview) = get_source_buffer_and_view()
 
 		sourceview.set_editable(False)
 		sourceview.modify_font(pango.FontDescription("Monospace"))
-- 
1.5.3.3
