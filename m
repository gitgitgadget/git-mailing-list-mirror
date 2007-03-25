From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Supporting more gitweb diff possibities
Date: Sun, 25 Mar 2007 22:26:42 +0200
Message-ID: <20070325202642.GA20201@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 25 22:26:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVZIg-0007n2-KZ
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 22:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbXCYU0r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 25 Mar 2007 16:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752311AbXCYU0r
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 16:26:47 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:41398 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbXCYU0q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 16:26:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 65FAE73515C1;
	Sun, 25 Mar 2007 22:26:43 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ocdZVFYs8Rcv; Sun, 25 Mar 2007 22:26:42 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id B8F91735ADF8; Sun, 25 Mar 2007 22:26:42 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43061>

I have done a first series of 6 patches, which improves blobdiff and
adds treediff.

[PATCH] gitweb: show no difference message

This patch shows an "no difference" message instead of nothing for
equal objects.

[PATCH] gitweb: Support comparing blobs with different names

This patch adds support for comparing objects with different file
names using hb/hbp.

[PATCH] gitweb: link base commit (hpb) to blobdiff output

Add link the parent commit, as there is currently no such link.

[PATCH] gitweb: support filename prefix in git_patchset_body
[PATCH] gitweb: support filename prefix in git_difftree_body
[PATCH] gitweb: Add treediff

These 3 patches add the treediff method. Its a complete reworked
verion. As git-diff-tree outputs relativ patches (discards part of the
compared tree objects), the first two patches are necessary to produce
correct links in the treediff output.

I do not see many possibilties for code sharing with git_commitdiff:
The only large portion of common code is calling git-diff-tree. I
don't think that this would justify the more complex code.

To test these patches, I still use a JavaScript implementation (see
below). I'm working on the server side implementation.

The next patch, I'm currently working on, will introduce a wrapper for =
all
calls to
$cgi->a({-href =3D> href([Parameter])}, [Title])=20

mfg Martin K=F6gler

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 71d0933..db58319 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1837,6 +1837,7 @@ sub git_footer_html {
 		close $fd;
 	}
=20
+	print '<script type=3D"text/javascript" src=3D"gitweb.js"></script>';
 	print "</body>\n" .
 	      "</html>";
 }


gitweb.js:
----------
function getCookie(name)
{
  var name=3Dname+"=3D";
  var c=3Ddocument.cookie;
  var p=3Dc.indexOf(name);
  if(p=3D=3D-1)
    return null;
  c=3Dc.substr(p+name.length,c.length);
  p=3Dc.indexOf(";");
  if(p=3D=3D-1)
    return c;
  else
    return c.substr(0, p);
}

function insertAfter(elem, node)
{
  if(node.nextSibling)
    node.parentNode.insertBefore(elem, node.nextSibling);
  else
    node.parentNode.appendChild(elem);
}

function createLink(href, linktext)
{
  var l=3Ddocument.createElement("a");
  l.appendChild(document.createTextNode(linktext));
  l.href=3Dhref;
  return l;
}

function createLinkGroup(href1, basetxt, href2, difftxt)
{
  var l=3Ddocument.createElement("span");
  l.appendChild(document.createTextNode(" ("));
  l.appendChild(createLink(href1, basetxt));
  l.appendChild(document.createTextNode(" | "));
  l.appendChild(createLink(href2, difftxt));
  l.appendChild(document.createTextNode(") "));
  return l;
}

function GitRef()
{
    this.t=3Dnull;
    this.h=3Dnull;
    this.hb=3Dnull;
    this.f=3Dnull;
    this.ToRef=3DToRef;
}

function ToRef()
{
  var parts=3Dnew Array();
  if(this.f)
    parts.push("f=3D"+this.f);
  if(this.h)
    parts.push("h=3D"+this.h);
  if(this.hb)
    parts.push("hb=3D"+this.hb);
  if(this.t)
    parts.push("t=3D"+this.t);
  return parts.join("@");
}

function splitGitRef(ref)
{
  var parts=3Dref.split("@");
  var res=3Dnew GitRef();
  var i;
  for(i=3D0;i<parts.length;i++)
  {
      var p=3Dparts[i].split("=3D");
      res[p[0]]=3Dp[1];
  }
  return res;
}

function GitURL(base)
{
  this.base=3Dbase;
  this.p=3Dnull;
  this.a=3Dnull;
  this.f=3Dnull;
  this.fp=3Dnull;
  this.h=3Dnull;
  this.hp=3Dnull;
  this.hb=3Dnull;
  this.hpb=3Dnull;
  this.pg=3Dnull;
  this.o=3Dnull;
  this.s=3Dnull;
  this.st=3Dnull;
  this.ToURL=3DToURL;
  this.ToRef=3DUrlToRef;
  this.ToDUrl=3DToDUrl;
}

function ToURL()
{
  var parts=3Dnew Array();
  if(this.p)
    parts.push("p=3D"+this.p);
  if(this.a)
    parts.push("a=3D"+this.a);
  if(this.f)
    parts.push("f=3D"+this.f);
  if(this.fp)
    parts.push("fp=3D"+this.fp);
  if(this.h)
    parts.push("h=3D"+this.h);
  if(this.hp)
    parts.push("hp=3D"+this.hp);
  if(this.hb)
    parts.push("hb=3D"+this.hb);
  if(this.hpb)
    parts.push("hpb=3D"+this.hpb);
  if(this.o)
    parts.push("o=3D"+this.o);
  if(this.s)
    parts.push("s=3D"+this.s);
  if(this.st)
    parts.push("st=3D"+this.st);
  return this.base+"?"+parts.join(";");
}

function UrlToRef(type)
{
    var res=3Dnew GitRef;
    res.f=3Dthis.f;
    res.h=3Dthis.h;
    res.hb=3Dthis.hb;
    res.t=3Dtype;
    return res.ToRef();
}

function ToDUrl(type)
{
    var res=3Dnew GitURL(this.base);
    res.f=3Dthis.f;
    res.h=3Dthis.h;
    res.hb=3Dthis.hb;
    res.p=3Dthis.p;
    res.a=3Dtype;
    return res.ToURL();
}

function splitGitURL(url)
{
  var Urls=3Durl.split("?");
  var res=3Dnew GitURL(Urls[0]);
  if(Urls.length>1)
    {
      var parts=3DUrls[1].split(";");
      var i;
      for(i=3D0;i<parts.length;i++)
	{
	  var p=3Dparts[i].split("=3D");
	  res[p[0]]=3Dp[1];
	}
    }
  return res;
}

function GitAddLinks()
{
  var links=3Ddocument.getElementsByTagName("a");
  var i;
  for(i=3D0;i<links.length;i++)
    {
      var link=3Dlinks[i];
      if(link.innerHTML=3D=3D'commit'||link.innerHTML=3D=3D'tag')
	{
	  var url=3DsplitGitURL(link.href);
	  if(!url.h)
	    continue;
	  var l=3DcreateLinkGroup("javascript:base('"+url.ToRef('commit')+"')"=
,"base",
				"javascript:diff('"+url.ToDUrl('commit')+"')","diff");
	  insertAfter(l, link);
	}
      if(link.innerHTML=3D=3D'blob')
	{
	  var url=3DsplitGitURL(link.href);
	  if(!url.h&&!(url.hb&&url.f))
	    continue;
	  var l=3DcreateLinkGroup("javascript:base('"+url.ToRef('blob')+"')","=
base",
				"javascript:diff('"+url.ToDUrl('blob')+"')","diff");
	  insertAfter(l, link);
	}
      if(link.innerHTML=3D=3D'tree')
	{
	  var url=3DsplitGitURL(link.href);
	  if(!url.h&&!(url.hb&&url.f))
	    continue;
	  var l=3DcreateLinkGroup("javascript:base('"+url.ToRef('tree')+"')","=
base",
				"javascript:diff('"+url.ToDUrl('tree')+"')","diff");
	  insertAfter(l, link);
	}
    }
}

function base(ref)
{
  document.cookie=3D"basename=3D"+ref;
}

function diff(url)
{
  var c=3DgetCookie("basename");
  if (!c)
  {
      alert("no diff base selected");
      return;
  }
  c=3DsplitGitRef(c);
  url=3DsplitGitURL(url);
 =20
  if(c.t=3D=3D'commit'&&url.a=3D=3D'commit')
  {
      url.a=3D'commitdiff';
      if(!c.h||!url.h)
      {
	  alert("commit diff not possible");
	  return;
      }
      url.hb=3Dnull;
      url.f=3Dnull;
      url.hp=3Dc.h;
      document.location.href=3Durl.ToURL();
      return;
  }
  if(c.t=3D=3D'blob'&&url.a=3D=3D'blob')
  {
      url.a=3D'blobdiff';
      url.h=3Dc.h;
      url.hpb=3Dc.hb;
      url.fp=3Dc.f;
      document.location.href=3Durl.ToURL();
      return;
  }
  if(c.t=3D=3D'tree'&&url.a=3D=3D'tree')
  {
      url.a=3D'treediff';
      url.hpb=3Dc.hb;
      url.hp=3Dc.h;
      url.fp=3Dc.f;
      document.location.href=3Durl.ToURL();
      return;
  }=20
  if(c.t=3D=3D'commit'&&url.a=3D=3D'tree')
  {
      url.a=3D'treediff';
      url.hpb=3Dc.h;
      url.hp=3Dnull;
      url.fp=3Dnull;
      document.location.href=3Durl.ToURL();
      return;
  }=20
  if(c.t=3D=3D'tree'&&url.a=3D=3D'commit')
  {
      url.a=3D'treediff';
      url.hpb=3Dc.hb;
      url.hp=3Dc.h;
      url.fp=3Dc.f;
      url.hb=3Durl.h;
      url.h=3Dnull;
      document.location.href=3Durl.ToURL();
      return;
  }=20
  alert("diff not possible");
}

GitAddLinks();
