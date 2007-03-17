From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: [RFC] More diff possibilities in gitweb
Date: Sat, 17 Mar 2007 16:17:31 +0100
Message-ID: <20070317151731.GA32571@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 16:17:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSafK-00080i-P8
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 16:17:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbXCQPRj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 17 Mar 2007 11:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbXCQPRj
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 11:17:39 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:43866 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbXCQPRi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 11:17:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id C481870E11BA
	for <git@vger.kernel.org>; Sat, 17 Mar 2007 16:17:32 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0uJQvJYqHb6S for <git@vger.kernel.org>;
	Sat, 17 Mar 2007 16:17:32 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id EF12870E11B3; Sat, 17 Mar 2007 16:17:31 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42442>

Compared to eg. viewcvs, gitweb offers fewer possibilies to do a diff.
With viewcvs, you can compare arbitrary version of a file; gitweb only
offers diff to previous (or sometimes current) version.

As git offers an infinite number of possible (and maybe useful) diffs,
I added to each each compareable object two links:
* "base": Select this object as parent
* "diff": Diff against the last select parent

The selected parent object is stored as a cookie, so it is possible to
do a diff between objects shown on different pages.

The whole is implemented in JavaScript on the client side (tested with
IE 6 and Mozilla). On the server side, only the JavaScript file is
included in the output (see below). The link generation is done
completely in the browser.

The patch offers the following possibilies:
* Compare any commit with an other commit
  Passes the hashes of the two commits as h and hp to commitdiff
  function. The output includes the message of one commit, which can
  be confusing.
* Compare any blob with an other blob
  This feature is based on the blobdiff function. There are two types
  of blob:
  - blobs in the tree view can be compared with any blob in the tree vi=
ew.
  - blobs in the history view can only be compared with any blob with
    the same file name in the history view.
* Compare trees
  gitweb currently has no function for comparing trees. I currently
  misused blobdiff for this. The content of the diff is OK, only the
  filenames are wrong/destroyed. Additionally gitweb issus some "Use
  of uninitialized value" message to the error log.

  A proper implementation would need new function in gitweb.cgi,
  basically git_commitdiff removing the requirement, that the hashes
  must be a commit.

Is there an interest these function?

mfg Martin K=F6gler

Patch for gitweb.cgi (in function git_footer_html):
---------------------------------------------------
=20
+        print '<script type=3D"text/javascript" src=3D"gitweb.js"></sc=
ript>';
         print "</body>\n" .
               "</html>";

=46ile gitweb.js:
---------------
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
      if(link.innerHTML=3D=3D'commit')
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
	  if(!url.h)
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
      if(c.h&&url.h)
      {
	  url.hb=3Dnull;
	  url.hp=3Dc.h;
	  url.fp=3Dc.f;
      }=20
      else if (c.hb&&url.hb&&url.f&&c.f)
      {
	  if (url.f!=3Dc.f)
	  {
	      alert("file name do not match");
	      return;
	  }
	  url.h=3Dnull;
	  url.hpb=3Dc.hb;
	  url.fp=3Dc.f;
      }
      else
      {
	  alert("blob diff not possible");
	  return;
      }
      document.location.href=3Durl.ToURL();
      return;
  }
  if(c.t=3D=3D'tree'&&url.a=3D=3D'tree')
  {
      url.a=3D'blobdiff';
      if(c.h&&url.h)
      {
	  url.hb=3Dnull;
	  url.hp=3Dc.h;
	  url.fp=3Dc.f;
	  document.location.href=3Durl.ToURL();
	  return;
      }=20
  }
  alert("diff not possible");
}

GitAddLinks();
