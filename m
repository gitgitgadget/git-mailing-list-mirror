From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 4/5] gitweb: Selecting diffs in JavaScript
Date: Sun,  2 Sep 2007 16:46:07 +0200
Message-ID: <11887443693825-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <11887443682216-git-send-email-mkoegler@auto.tuwien.ac.at> <11887443692839-git-send-email-mkoegler@auto.tuwien.ac.at> <11887443693783-git-send-email-mkoegler@auto.tuwien.ac.at> <11887443693173-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Sep 02 16:47:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRqjD-0000zE-Ma
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 16:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755151AbXIBOqj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 10:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755507AbXIBOqj
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 10:46:39 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:45586 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753666AbXIBOqO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 10:46:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 6B72F680D72F;
	Sun,  2 Sep 2007 16:46:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xj2DiEMzIw3o; Sun,  2 Sep 2007 16:46:10 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 4B839743738E; Sun,  2 Sep 2007 16:46:09 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
In-Reply-To: <11887443693173-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57331>

The adds support for selecting arbitrary diffs, if the client browser supports
JavaScript.

It is no possible to hide/show all diff links.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 Makefile           |    6 +-
 git-instaweb.sh    |    7 +
 gitweb/gitweb.js   |  360 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 gitweb/gitweb.perl |   11 ++
 4 files changed, 383 insertions(+), 1 deletions(-)
 create mode 100644 gitweb/gitweb.js

diff --git a/Makefile b/Makefile
index 2decdfb..1582dfa 100644
--- a/Makefile
+++ b/Makefile
@@ -168,6 +168,7 @@ GITWEB_HOMETEXT = indextext.html
 GITWEB_CSS = gitweb.css
 GITWEB_LOGO = git-logo.png
 GITWEB_FAVICON = git-favicon.png
+GITWEB_JS = gitweb.js
 GITWEB_SITE_HEADER =
 GITWEB_SITE_FOOTER =
 
@@ -817,13 +818,14 @@ gitweb/gitweb.cgi: gitweb/gitweb.perl
 	    -e 's|++GITWEB_CSS++|$(GITWEB_CSS)|g' \
 	    -e 's|++GITWEB_LOGO++|$(GITWEB_LOGO)|g' \
 	    -e 's|++GITWEB_FAVICON++|$(GITWEB_FAVICON)|g' \
+	    -e 's|++GITWEB_JS++|$(GITWEB_JS)|g' \
 	    -e 's|++GITWEB_SITE_HEADER++|$(GITWEB_SITE_HEADER)|g' \
 	    -e 's|++GITWEB_SITE_FOOTER++|$(GITWEB_SITE_FOOTER)|g' \
 	    $< >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
 
-git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css
+git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css gitweb/gitweb.js
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
@@ -832,6 +834,8 @@ git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/gitweb.css
 	    -e '/@@GITWEB_CGI@@/d' \
 	    -e '/@@GITWEB_CSS@@/r gitweb/gitweb.css' \
 	    -e '/@@GITWEB_CSS@@/d' \
+	    -e '/@@GITWEB_JS@@/r gitweb/gitweb.js' \
+	    -e '/@@GITWEB_JS@@/d' \
 	    $@.sh > $@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
diff --git a/git-instaweb.sh b/git-instaweb.sh
index b79c6b6..960486e 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -227,8 +227,15 @@ gitweb_css () {
 EOFGITWEB
 }
 
+gitweb_js () {
+	cat > "$1" <<\EOFGITWEB
+@@GITWEB_JS@@
+EOFGITWEB
+}
+
 gitweb_cgi $GIT_DIR/gitweb/gitweb.cgi
 gitweb_css $GIT_DIR/gitweb/gitweb.css
+gitweb_js $GIT_DIR/gitweb/gitweb.js
 
 case "$httpd" in
 *lighttpd*)
diff --git a/gitweb/gitweb.js b/gitweb/gitweb.js
new file mode 100644
index 0000000..fd4178a
--- /dev/null
+++ b/gitweb/gitweb.js
@@ -0,0 +1,360 @@
+/* Javascript functions for gitweb
+
+  (C) 2007 Martin Koegler <mkoegler@auto.tuwien.ac.at>
+
+  This file is licensed under the GPL v2, or (at your option) any later version.
+*/
+
+function getCookie (name)
+{
+  var name = name + "=";
+  var c = document.cookie;
+  var p = c.indexOf (name);
+  if (p == -1)
+    return null;
+  c = c.substr (p + name.length, c.length);
+  p = c.indexOf (";");
+  if (p == -1)
+    return c;
+  else
+    return c.substr (0, p);
+}
+
+function insertAfter (elem, node)
+{
+  if (node.nextSibling)
+    node.parentNode.insertBefore (elem, node.nextSibling);
+  else
+    node.parentNode.appendChild (elem);
+}
+
+function createLink (href, linktext)
+{
+  var l = document.createElement ("a");
+  l.appendChild (document.createTextNode (linktext));
+  l.href = href;
+  return l;
+}
+
+function createLinkGroup (href1, basetxt, href2, difftxt)
+{
+  var l = document.createElement ("span");
+  l.className = 'difflinks';
+  l.appendChild (document.createTextNode (" ("));
+  l.appendChild (createLink (href1, basetxt));
+  l.appendChild (document.createTextNode (" | "));
+  l.appendChild (createLink (href2, difftxt));
+  l.appendChild (document.createTextNode (") "));
+  return l;
+}
+
+function GitRef ()
+{
+  this.t = null;
+  this.h = null;
+  this.hb = null;
+  this.f = null;
+  this.p = null;
+  this.ToRef = ToRef;
+}
+
+function ToRef ()
+{
+  var parts = new Array ();
+  if (this.f)
+    parts.push ("f=" + this.f);
+  if (this.h)
+    parts.push ("h=" + this.h);
+  if (this.hb)
+    parts.push ("hb=" + this.hb);
+  if (this.t)
+    parts.push ("t=" + this.t);
+  if (this.p)
+    parts.push ("p=" + this.p);
+  return parts.join ("@");
+}
+
+function splitGitRef (ref)
+{
+  var parts = ref.split ("@");
+  var res = new GitRef ();
+  var i;
+  for (i = 0; i < parts.length; i++)
+    {
+      var p = parts[i].split ("=");
+      res[p[0]] = p[1];
+    }
+  return res;
+}
+
+function GitURL (base)
+{
+  this.base = base;
+  this.p = null;
+  this.a = null;
+  this.f = null;
+  this.fp = null;
+  this.h = null;
+  this.hp = null;
+  this.hb = null;
+  this.hpb = null;
+  this.pg = null;
+  this.o = null;
+  this.s = null;
+  this.st = null;
+  this.ToURL = ToURL;
+  this.ToRef = UrlToRef;
+  this.ToDUrl = ToDUrl;
+}
+
+function ToURL ()
+{
+  var parts = new Array ();
+  if (this.p)
+    parts.push ("p=" + this.p);
+  if (this.a)
+    parts.push ("a=" + this.a);
+  if (this.f)
+    parts.push ("f=" + this.f);
+  if (this.fp)
+    parts.push ("fp=" + this.fp);
+  if (this.h)
+    parts.push ("h=" + this.h);
+  if (this.hp)
+    parts.push ("hp=" + this.hp);
+  if (this.hb)
+    parts.push ("hb=" + this.hb);
+  if (this.hpb)
+    parts.push ("hpb=" + this.hpb);
+  if (this.o)
+    parts.push ("o=" + this.o);
+  if (this.s)
+    parts.push ("s=" + this.s);
+  if (this.st)
+    parts.push ("st=" + this.st);
+  return this.base + "?" + parts.join (";");
+}
+
+function UrlToRef (type)
+{
+  var res = new GitRef;
+  res.f = this.f;
+  res.h = this.h;
+  res.hb = this.hb;
+  res.t = type;
+  res.p = this.p;
+  return res.ToRef ();
+}
+
+function ToDUrl (type)
+{
+  var res = new GitURL (this.base);
+  res.f = this.f;
+  res.h = this.h;
+  res.hb = this.hb;
+  res.p = this.p;
+  res.a = type;
+  return res.ToURL ();
+}
+
+function splitGitURL (url)
+{
+  var Urls = url.split ("?");
+  var res = new GitURL (Urls[0]);
+  if (Urls.length > 1)
+    {
+      var parts = Urls[1].split (";");
+      var i;
+      for (i = 0; i < parts.length; i++)
+	{
+	  var p = parts[i].split ("=");
+	  res[p[0]] = p[1];
+	}
+    }
+  return res;
+}
+
+function base (ref)
+{
+  document.cookie = "basename=" + ref;
+}
+
+function diff (url)
+{
+  var c = getCookie ("basename");
+  if (!c)
+    {
+      alert ("no diff base selected");
+      return;
+    }
+  c = splitGitRef (c);
+  url = splitGitURL (url);
+
+  if (c.p != url.p)
+    {
+      alert ("base object in an other repository");
+      return;
+    }
+
+  if (c.t == 'commit' && url.a == 'commit')
+    {
+      url.a = 'commitdiff';
+      if (!c.h || !url.h)
+	{
+	  alert ("commit diff not possible");
+	  return;
+	}
+      url.hb = null;
+      url.f = null;
+      url.hp = c.h;
+      document.location.href = url.ToURL ();
+      return;
+    }
+  if (c.t == 'blob' && url.a == 'blob')
+    {
+      url.a = 'blobdiff';
+      url.hp = c.h;
+      url.hpb = c.hb;
+      url.fp = c.f;
+      document.location.href = url.ToURL ();
+      return;
+    }
+  if (c.t == 'tree' && url.a == 'tree')
+    {
+      url.a = 'treediff';
+      url.hpb = c.hb;
+      url.hp = c.h;
+      url.fp = c.f;
+      document.location.href = url.ToURL ();
+      return;
+    }
+  if (c.t == 'commit' && url.a == 'tree')
+    {
+      url.a = 'treediff';
+      url.hpb = c.h;
+      url.hp = null;
+      url.fp = null;
+      document.location.href = url.ToURL ();
+      return;
+    }
+  if (c.t == 'tree' && url.a == 'commit')
+    {
+      url.a = 'treediff';
+      url.hpb = c.hb;
+      url.hp = c.h;
+      url.fp = c.f;
+      url.hb = url.h;
+      url.h = null;
+      document.location.href = url.ToURL ();
+      return;
+    }
+  alert ("diff not possible");
+}
+
+function GitAddLinks ()
+{
+  var links = document.getElementsByTagName ("a");
+  var i;
+
+  for (i = 0; i < links.length; i++)
+    {
+      var link = links[i];
+      var url = splitGitURL (link.href);
+      if (link.innerHTML == 'commit' || link.innerHTML == 'tag')
+	{
+	  if (!url.h)
+	    continue;
+	  var l =
+	    createLinkGroup ("javascript:base('" + url.ToRef ('commit') +
+			     "')", "base",
+			     "javascript:diff('" + url.ToDUrl ('commit') +
+			     "')", "diff");
+	  insertAfter (l, link);
+	}
+      if (link.innerHTML == 'blob')
+	{
+	  if (!url.h && !(url.hb && url.f))
+	    continue;
+	  var l =
+	    createLinkGroup ("javascript:base('" + url.ToRef ('blob') + "')",
+			     "base",
+			     "javascript:diff('" + url.ToDUrl ('blob') + "')",
+			     "diff");
+	  insertAfter (l, link);
+	}
+      if (link.innerHTML == 'tree')
+	{
+	  if (!url.h && !(url.hb && url.f))
+	    continue;
+	  var l =
+	    createLinkGroup ("javascript:base('" + url.ToRef ('tree') + "')",
+			     "base",
+			     "javascript:diff('" + url.ToDUrl ('tree') + "')",
+			     "diff");
+	  insertAfter (l, link);
+	}
+    }
+}
+
+function ShowHideLinks (action)
+{
+  var tags = document.getElementsByTagName ("span");
+
+  for (i = 0; i < tags.length; i++)
+    {
+      var tag = tags[i];
+      if (tag.className == 'difflinks')
+	{
+	  if (action)
+	    tag.style.display = 'inline';
+	  else
+	    tag.style.display = 'none';
+	}
+    }
+
+}
+
+var LinkState=-1;
+var saveonload;
+
+function GitShowLinks ()
+{
+  if (LinkState == -1)
+    {
+      GitAddLinks();
+      LinkState = 1;
+      document.cookie = "showdiff=1";
+      document.getElementById ('difflinks').innerHTML = 'hide difflinks';
+    }	
+  else if (LinkState == 1)
+    {
+      ShowHideLinks (false);
+      LinkState = 0;
+      document.cookie = "showdiff=0";
+      document.getElementById ('difflinks').innerHTML = 'show difflinks';
+    }
+  else
+    {
+      ShowHideLinks (true);
+      LinkState = 1;
+      document.cookie = "showdiff=1";
+      document.getElementById ('difflinks').innerHTML = 'hide difflinks';
+    }
+}
+
+function GitAddLinkElement ()
+{
+    document.getElementById ('difflinkdiv').innerHTML = 
+      ' | <a id="difflinks" href="javascript:GitShowLinks()">show difflinks</a>';
+    var show = getCookie ('showdiff');
+    if (show == '1')
+      {
+	saveonload = window.onload;
+	window.onload = function ()
+	  {
+	    if (saveonload)
+	       saveonload();
+	    GitShowLinks();
+	  }
+      }
+}
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4081f51..2531133 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -61,6 +61,8 @@ our $stylesheet = undef;
 our $logo = "++GITWEB_LOGO++";
 # URI of GIT favicon, assumed to be image/png type
 our $favicon = "++GITWEB_FAVICON++";
+# URI of gitweb.js
+our $gitwebjs = "++GITWEB_JS++";
 
 # URI and label (title) of GIT logo link
 #our $logo_url = "http://www.kernel.org/pub/software/scm/git/docs/";
@@ -2313,6 +2315,10 @@ EOF
 		print qq(<link rel="shortcut icon" href="$favicon" type="image/png"/>\n);
 	}
 
+	if (defined $gitwebjs) {
+		print qq(<script src="$gitwebjs" type="text/javascript"></script>\n);
+	}
+
 	print "</head>\n" .
 	      "<body>\n";
 
@@ -2449,6 +2455,11 @@ sub git_print_page_nav {
 		 map { $_ eq $current ?
 		       $_ : $cgi->a({-href => href(%{$arg{$_}})}, "$_")
 		 } @navs);
+
+	if (defined $gitwebjs) {
+		print '<span id="difflinkdiv"></span><script type="text/javascript">GitAddLinkElement();</script>';
+	}
+
 	print "<br/>\n$extra<br/>\n" .
 	      "</div>\n";
 }
-- 
1.5.3.rc7.849.g2f5f
