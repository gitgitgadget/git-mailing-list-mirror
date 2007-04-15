From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 5/7] gitweb: Prototyp for selecting diffs in JavaScript
Date: Sun, 15 Apr 2007 22:46:08 +0200
Message-ID: <1176669971921-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <11766699702663-git-send-email-mkoegler@auto.tuwien.ac.at> <11766699701308-git-send-email-mkoegler@auto.tuwien.ac.at> <11766699713715-git-send-email-mkoegler@auto.tuwien.ac.at> <1176669971694-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 15 22:46:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdBcQ-00044c-Dd
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 22:46:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753911AbXDOUqY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 16:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753803AbXDOUqY
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 16:46:24 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:58503 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911AbXDOUqO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 16:46:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 024F67A4D1AB;
	Sun, 15 Apr 2007 22:46:13 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KxFaWoasWhbR; Sun, 15 Apr 2007 22:46:12 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 234B47A4D1A4; Sun, 15 Apr 2007 22:46:11 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
In-Reply-To: <1176669971694-git-send-email-mkoegler@auto.tuwien.ac.at>
Message-Id: <481946c2e3cff09ed4a623b1b20b9889666aedb0.1176659095.git.mkoegler@auto.tuwien.ac.at>
In-Reply-To: <437446e84f3aea71f74fea7ea66db4c1c326fb6b.1176659094.git.mkoegler@auto.tuwien.ac.at>
References: <437446e84f3aea71f74fea7ea66db4c1c326fb6b.1176659094.git.mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

---
This patch is only to test the other patches. I'm working on reimplementing it in perl.

 gitweb/gitweb.js   |  273 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 gitweb/gitweb.perl |    1 +
 2 files changed, 274 insertions(+), 0 deletions(-)
 create mode 100644 gitweb/gitweb.js

diff --git a/gitweb/gitweb.js b/gitweb/gitweb.js
new file mode 100644
index 0000000..2e1a94d
--- /dev/null
+++ b/gitweb/gitweb.js
@@ -0,0 +1,273 @@
+function getCookie(name)
+{
+  var name=name+"=";
+  var c=document.cookie;
+  var p=c.indexOf(name);
+  if(p==-1)
+    return null;
+  c=c.substr(p+name.length,c.length);
+  p=c.indexOf(";");
+  if(p==-1)
+    return c;
+  else
+    return c.substr(0, p);
+}
+
+function insertAfter(elem, node)
+{
+  if(node.nextSibling)
+    node.parentNode.insertBefore(elem, node.nextSibling);
+  else
+    node.parentNode.appendChild(elem);
+}
+
+function createLink(href, linktext)
+{
+  var l=document.createElement("a");
+  l.appendChild(document.createTextNode(linktext));
+  l.href=href;
+  return l;
+}
+
+function createLinkGroup(href1, basetxt, href2, difftxt)
+{
+  var l=document.createElement("span");
+  l.appendChild(document.createTextNode(" ("));
+  l.appendChild(createLink(href1, basetxt));
+  l.appendChild(document.createTextNode(" | "));
+  l.appendChild(createLink(href2, difftxt));
+  l.appendChild(document.createTextNode(") "));
+  return l;
+}
+
+function GitRef()
+{
+    this.t=null;
+    this.h=null;
+    this.hb=null;
+    this.f=null;
+    this.ToRef=ToRef;
+}
+
+function ToRef()
+{
+  var parts=new Array();
+  if(this.f)
+    parts.push("f="+this.f);
+  if(this.h)
+    parts.push("h="+this.h);
+  if(this.hb)
+    parts.push("hb="+this.hb);
+  if(this.t)
+    parts.push("t="+this.t);
+  return parts.join("@");
+}
+
+function splitGitRef(ref)
+{
+  var parts=ref.split("@");
+  var res=new GitRef();
+  var i;
+  for(i=0;i<parts.length;i++)
+  {
+      var p=parts[i].split("=");
+      res[p[0]]=p[1];
+  }
+  return res;
+}
+
+function GitURL(base)
+{
+  this.base=base;
+  this.p=null;
+  this.a=null;
+  this.f=null;
+  this.fp=null;
+  this.h=null;
+  this.hp=null;
+  this.hb=null;
+  this.hpb=null;
+  this.pg=null;
+  this.o=null;
+  this.s=null;
+  this.st=null;
+  this.ToURL=ToURL;
+  this.ToRef=UrlToRef;
+  this.ToDUrl=ToDUrl;
+}
+
+function ToURL()
+{
+  var parts=new Array();
+  if(this.p)
+    parts.push("p="+this.p);
+  if(this.a)
+    parts.push("a="+this.a);
+  if(this.f)
+    parts.push("f="+this.f);
+  if(this.fp)
+    parts.push("fp="+this.fp);
+  if(this.h)
+    parts.push("h="+this.h);
+  if(this.hp)
+    parts.push("hp="+this.hp);
+  if(this.hb)
+    parts.push("hb="+this.hb);
+  if(this.hpb)
+    parts.push("hpb="+this.hpb);
+  if(this.o)
+    parts.push("o="+this.o);
+  if(this.s)
+    parts.push("s="+this.s);
+  if(this.st)
+    parts.push("st="+this.st);
+  return this.base+"?"+parts.join(";");
+}
+
+function UrlToRef(type)
+{
+    var res=new GitRef;
+    res.f=this.f;
+    res.h=this.h;
+    res.hb=this.hb;
+    res.t=type;
+    return res.ToRef();
+}
+
+function ToDUrl(type)
+{
+    var res=new GitURL(this.base);
+    res.f=this.f;
+    res.h=this.h;
+    res.hb=this.hb;
+    res.p=this.p;
+    res.a=type;
+    return res.ToURL();
+}
+
+function splitGitURL(url)
+{
+  var Urls=url.split("?");
+  var res=new GitURL(Urls[0]);
+  if(Urls.length>1)
+    {
+      var parts=Urls[1].split(";");
+      var i;
+      for(i=0;i<parts.length;i++)
+	{
+	  var p=parts[i].split("=");
+	  res[p[0]]=p[1];
+	}
+    }
+  return res;
+}
+
+function GitAddLinks()
+{
+  var links=document.getElementsByTagName("a");
+  var i;
+  for(i=0;i<links.length;i++)
+    {
+      var link=links[i];
+      if(link.innerHTML=='commit'||link.innerHTML=='tag')
+	{
+	  var url=splitGitURL(link.href);
+	  if(!url.h)
+	    continue;
+	  var l=createLinkGroup("javascript:base('"+url.ToRef('commit')+"')","base",
+				"javascript:diff('"+url.ToDUrl('commit')+"')","diff");
+	  insertAfter(l, link);
+	}
+      if(link.innerHTML=='blob')
+	{
+	  var url=splitGitURL(link.href);
+	  if(!url.h&&!(url.hb&&url.f))
+	    continue;
+	  var l=createLinkGroup("javascript:base('"+url.ToRef('blob')+"')","base",
+				"javascript:diff('"+url.ToDUrl('blob')+"')","diff");
+	  insertAfter(l, link);
+	}
+      if(link.innerHTML=='tree')
+	{
+	  var url=splitGitURL(link.href);
+	  if(!url.h&&!(url.hb&&url.f))
+	    continue;
+	  var l=createLinkGroup("javascript:base('"+url.ToRef('tree')+"')","base",
+				"javascript:diff('"+url.ToDUrl('tree')+"')","diff");
+	  insertAfter(l, link);
+	}
+    }
+}
+
+function base(ref)
+{
+  document.cookie="basename="+ref;
+}
+
+function diff(url)
+{
+  var c=getCookie("basename");
+  if (!c)
+  {
+      alert("no diff base selected");
+      return;
+  }
+  c=splitGitRef(c);
+  url=splitGitURL(url);
+  
+  if(c.t=='commit'&&url.a=='commit')
+  {
+      url.a='commitdiff';
+      if(!c.h||!url.h)
+      {
+	  alert("commit diff not possible");
+	  return;
+      }
+      url.hb=null;
+      url.f=null;
+      url.hp=c.h;
+      document.location.href=url.ToURL();
+      return;
+  }
+  if(c.t=='blob'&&url.a=='blob')
+  {
+      url.a='blobdiff';
+      url.hp=c.h;
+      url.hpb=c.hb;
+      url.fp=c.f;
+      document.location.href=url.ToURL();
+      return;
+  }
+  if(c.t=='tree'&&url.a=='tree')
+  {
+      url.a='treediff';
+      url.hpb=c.hb;
+      url.hp=c.h;
+      url.fp=c.f;
+      document.location.href=url.ToURL();
+      return;
+  } 
+  if(c.t=='commit'&&url.a=='tree')
+  {
+      url.a='treediff';
+      url.hpb=c.h;
+      url.hp=null;
+      url.fp=null;
+      document.location.href=url.ToURL();
+      return;
+  } 
+  if(c.t=='tree'&&url.a=='commit')
+  {
+      url.a='treediff';
+      url.hpb=c.hb;
+      url.hp=c.h;
+      url.fp=c.f;
+      url.hb=url.h;
+      url.h=null;
+      document.location.href=url.ToURL();
+      return;
+  } 
+  alert("diff not possible");
+}
+
+GitAddLinks();
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c2dc82d..769e755 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1860,6 +1860,7 @@ sub git_footer_html {
 		close $fd;
 	}
 
+	print '<script type="text/javascript" src="gitweb.js"></script>';
 	print "</body>\n" .
 	      "</html>";
 }
-- 
1.5.1.1.85.gf1888
