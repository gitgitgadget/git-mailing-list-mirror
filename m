From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH ugit] Allow user to choose history browser tool
Date: Thu, 3 Jan 2008 13:08:17 +0100
Message-ID: <e5bfff550801030408w1512e458x136f6be0371c13c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: davvid@gmail.com
X-From: git-owner@vger.kernel.org Thu Jan 03 13:08:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAOsS-0000ey-VF
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 13:08:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421AbYACMIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2008 07:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753394AbYACMIT
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 07:08:19 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:55274 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753127AbYACMIS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2008 07:08:18 -0500
Received: by rv-out-0910.google.com with SMTP id k20so5712265rvb.1
        for <git@vger.kernel.org>; Thu, 03 Jan 2008 04:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=SHFo/bpuaxNRgrbF4HMwHIpSeeuBBaA7HeCzbJopIm8=;
        b=NueVH1vYFkJlX2byEAQOwA5kPNXL+17BKkTerrv/sonfaGSLg/qzwKGq/tsy3BUUG56sofYo8o1Xr4Te0zuBF0s9oqcXvAwEPYdAT0PnPZ6h70xUXwDhLZszQezZa1sakwsK7SEb6FCAC0QMiGwzcaeY5tn3KTckprJ58iaznaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=VgfK0HrzZB4ITtA49E2JM6UrdS2OirvXVxXwadREyAgg84OCiJFsjBI6VODzD726P378MnVXls/dRUtdcNVsx33bzOrjBh2ssxjzDTgJVFVLHUXd95rSIihlBIKs9biXBVdVJ3+juOUFYzRcS4n9DMz7QtfOdu684IYF1ICLBF0=
Received: by 10.141.141.3 with SMTP id t3mr8000772rvn.213.1199362097354;
        Thu, 03 Jan 2008 04:08:17 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Thu, 3 Jan 2008 04:08:17 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69523>

 Instead of hard linking gitk let the user set
 the preferred history visualization tool in settings dialog.

Signed-off by:  Marco Costalba <mcostalba@gmail.com>
---

A thing I was not able to figure out is how to save the settings
so that at restart of ugit the saved setting is found
again (instead of selecting the default 'gitk')

Anyhow a really nice tool this ugit thing, you managed to
playing catch-up with git-gui really fast.


 ugitlibs/controllers.py    |    6 ++++--
 ugitlibs/models.py         |    6 +++++-
 ugitlibs/utilcontroller.py |    5 ++++-
 ui/optionsgui.ui           |   39 +++++++++++++++++++++++++++------------
 4 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/ugitlibs/controllers.py b/ugitlibs/controllers.py
index 411f1c1..6ad7b43 100644
--- a/ugitlibs/controllers.py
+++ b/ugitlibs/controllers.py
@@ -441,11 +441,13 @@ class Controller(QObserver):

 	def viz_all(self):
 		'''Visualizes the entire git history using gitk.'''
-		utils.fork('gitk','--all')
+		browser = self.model.get_history_browser()
+		utils.fork(browser,'--all')

 	def viz_current(self):
 		'''Visualizes the current branch's history using gitk.'''
-		utils.fork('gitk', self.model.get_branch())
+		browser = self.model.get_history_browser()
+		utils.fork(browser, self.model.get_branch())

 	# These actions monitor window resizes, splitter changes, etc.
 	def move_event(self, event):
diff --git a/ugitlibs/models.py b/ugitlibs/models.py
index 3c7ec9b..fe71362 100644
--- a/ugitlibs/models.py
+++ b/ugitlibs/models.py
@@ -117,6 +117,7 @@ class Model(model.Model):
 			'ugit.fontui.size':12,
 			'ugit.fontdiff': '',
 			'ugit.fontdiff.size':12,
+			'ugit.history_browser_line': 'gitk',
 			}

 		default_dict = self.__config_defaults
@@ -251,7 +252,10 @@ class Model(model.Model):
 				self.subtree_types.append(self.types[idx])
 				self.subtree_sha1s.append(self.sha1s[idx])
 				self.subtree_names.append(name)
-	
+
+	def get_history_browser(self):
+		return self.get_param('global.ugit.history_browser_line')
+
 	def get_tree_node(self, idx):
 		return (self.get_types()[idx],
 			self.get_sha1s()[idx],
diff --git a/ugitlibs/utilcontroller.py b/ugitlibs/utilcontroller.py
index 12a7399..c6f87a7 100644
--- a/ugitlibs/utilcontroller.py
+++ b/ugitlibs/utilcontroller.py
@@ -108,12 +108,15 @@ class OptionsController(QObserver):

 			'global.ugit.fontui.size': 'main_font_spinbox',
 			'global.ugit.fontui': 'main_font_combo',
+
+			'global.ugit.history_browser_line': 'history_browser_line',
 		}

 		for m,v in model_to_view.iteritems():
 			self.model_to_view(m,v)

 		self.add_signals('textChanged(const QString&)',
+				view.history_browser_line,
 				view.local_name_line,
 				view.global_name_line,
 				view.local_email_line,
@@ -132,7 +135,7 @@ class OptionsController(QObserver):
 				view.global_diffcontext_spinbox,
 				view.local_verbosity_spinbox,
 				view.global_verbosity_spinbox)
-	
+
 		self.add_signals('currentFontChanged(const QFont&)',
 				view.main_font_combo,
 				view.diff_font_combo)
diff --git a/ui/optionsgui.ui b/ui/optionsgui.ui
index 31bff84..a6fc1cf 100644
--- a/ui/optionsgui.ui
+++ b/ui/optionsgui.ui
@@ -8,8 +8,8 @@
    <rect>
     <x>0</x>
     <y>0</y>
-    <width>543</width>
-    <height>313</height>
+    <width>598</width>
+    <height>399</height>
    </rect>
   </property>
   <property name="windowTitle" >
@@ -23,7 +23,7 @@
      </property>
     </widget>
    </item>
-   <item row="0" column="1" >
+   <item row="0" column="1" colspan="2" >
     <widget class="QSpinBox" name="main_font_spinbox" >
      <property name="minimum" >
       <number>8</number>
@@ -33,7 +33,7 @@
      </property>
     </widget>
    </item>
-   <item row="0" column="2" colspan="4" >
+   <item row="0" column="3" colspan="4" >
     <widget class="QFontComboBox" name="main_font_combo" >
      <property name="currentFont" >
       <font>
@@ -49,7 +49,7 @@
      </property>
     </widget>
    </item>
-   <item row="1" column="1" >
+   <item row="1" column="1" colspan="2" >
     <widget class="QSpinBox" name="diff_font_spinbox" >
      <property name="minimum" >
       <number>8</number>
@@ -59,19 +59,33 @@
      </property>
     </widget>
    </item>
-   <item row="1" column="2" colspan="4" >
+   <item row="1" column="3" colspan="4" >
     <widget class="QFontComboBox" name="diff_font_combo" >
      <property name="fontFilters" >
       <set>QFontComboBox::MonospacedFonts</set>
      </property>
      <property name="currentFont" >
       <font>
-       <family>Courier</family>
+       <family>Liberation Mono</family>
       </font>
      </property>
     </widget>
    </item>
-   <item row="2" column="0" colspan="3" >
+   <item row="2" column="0" >
+    <widget class="QLabel" name="label_11" >
+     <property name="text" >
+      <string>History browser</string>
+     </property>
+    </widget>
+   </item>
+   <item row="2" column="1" colspan="6" >
+    <widget class="QLineEdit" name="history_browser_line" >
+     <property name="text" >
+      <string/>
+     </property>
+    </widget>
+   </item>
+   <item row="3" column="0" colspan="4" >
     <widget class="QGroupBox" name="local_groupbox" >
      <property name="title" >
       <string>Local Repository</string>
@@ -151,7 +165,7 @@
      </layout>
     </widget>
    </item>
-   <item row="2" column="3" colspan="3" >
+   <item row="3" column="4" colspan="3" >
     <widget class="QGroupBox" name="globalGroupBox" >
      <property name="title" >
       <string>Global (All Repositories)</string>
@@ -231,7 +245,7 @@
      </layout>
     </widget>
    </item>
-   <item row="3" column="0" colspan="4" >
+   <item row="4" column="0" colspan="5" >
     <spacer>
      <property name="orientation" >
       <enum>Qt::Horizontal</enum>
@@ -244,7 +258,7 @@
      </property>
     </spacer>
    </item>
-   <item row="3" column="4" >
+   <item row="4" column="5" >
     <widget class="QPushButton" name="save_button" >
      <property name="text" >
       <string>Save</string>
@@ -254,7 +268,7 @@
      </property>
     </widget>
    </item>
-   <item row="3" column="5" >
+   <item row="4" column="6" >
     <widget class="QPushButton" name="cancel_button" >
      <property name="text" >
       <string>Cancel</string>
@@ -264,4 +278,5 @@
   </layout>
  </widget>
  <resources/>
+ <connections/>
 </ui>
-- 
1.5.4.rc2.14.geab82
