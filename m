From: Petr Baudis <pasky@suse.cz>
Subject: Re: CGit and repository list
Date: Sat, 13 Sep 2008 00:48:17 +0200
Message-ID: <20080912224817.GF10360@machine.or.cz>
References: <19449377.post@talk.nabble.com> <20080912145804.GF10544@machine.or.cz> <8c5c35580809120810s69e8ec4fnf2a629d4cf575901@mail.gmail.com> <200809121812.40920.johan@herland.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="i9LlY+UWpKt15+FH"
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Kristian H??gsberg <hoegsberg@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Sep 13 00:49:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeHSD-0003O8-57
	for gcvg-git-2@gmane.org; Sat, 13 Sep 2008 00:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753883AbYILWsU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 18:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753482AbYILWsU
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 18:48:20 -0400
Received: from w241.dkm.cz ([62.24.88.241]:50775 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752558AbYILWsT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 18:48:19 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id CC987393A36E; Sat, 13 Sep 2008 00:48:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200809121812.40920.johan@herland.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95784>


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 12, 2008 at 06:12:40PM +0200, Johan Herland wrote:
> On Friday 12 September 2008, Lars Hjemli wrote:
> > On Fri, Sep 12, 2008 at 4:58 PM, Petr Baudis <pasky@suse.cz> wrote:
> > > it seems that cgit
> > > requires all the repositories explicitly listed in the config file.
> > > Do you plan to remove this limitation in the future?
> >
> > Not really, I'd rather add another command (or a commandline option)
> > to generate an include-file for cgitrc by scanning directory-trees
> > for git repos. I've CC'd Kristian since I believe he's got such a
> > script running for freedesktop.org; if so, maybe it could be
> > included/used as basis for something similar in cgit?
> 
> Here's a script I wrote for locating repos and generating repo 
> lists/configs for cgit, gitweb and hgwebdir (yes, this handles hg repos 
> as well). It works either as a CGI script (producing a list of detected 
> repos in HTML format), or from the command-line. It's only been tested 
> on an experimental DVCS server at $dayjob, so you might have to change 
> things to make it work in your scenario.
> 
> If there is interest in this, I can create a public repo and we can keep 
> improving on it.

Thanks. The script was a bit more scary than I thought, but in the end I
managed to generate something. There are trailing dots in project names,
but I'm not going to waste time on that anymore - this has long gone
over the 20 minutes I originally alotted the project anyway; I hope cgit
will gain a builtin capability for this in the future, since this is
still quite a pain. Attached is a random patch for your script I had to
use, FWIW.

Unfortunately, the recommended RewriteRule is not working - it does not
play well together with query parameters cgit is using, so e.g. browsing
past commits does not work. What RewriteRule should I use instead?

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates

--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="repofinder.diff"

--- repofinder-orig.py	2008-09-13 00:44:22.000000000 +0200
+++ repofinder.py	2008-09-13 00:44:47.000000000 +0200
@@ -244,7 +244,7 @@
 			if (self.group):
 				assert name.startswith(self.group.path)
 				name = name[len(self.group.path):]
-			name = name.strip("/")
+			name = name.strip("/srv/git/")
 			self._name = self.nameFromPath(name)
 		return self._name
 	name = property(getName)
@@ -267,7 +267,10 @@
 		"""Return a (name, email) tuple with our best guess as to who
 		   owns this repo
 		"""
-		return (self.ownerName, self.ownerEmail)
+		__o = self.ownerName
+		if (__o is None):
+			__o = ''
+		return (__o, self.ownerEmail)
 	owner = property(getOwner)
 
 	def getDescription (self):
@@ -286,14 +289,15 @@
 
 	@staticmethod
 	def nameFromPath (path):
-		if path.endswith(".git"): path = path[:-4]
+		if path.endswith(".git"): path = path[:-5]
 		path = path.rstrip("/")
 		return path
 
 	@staticmethod
 	def cloneUrlFromPath (path):
 		if path.endswith("/.git"): path = path[:-5]
-		return "ssh://%s%s" % (Settings['ServerName'], path)
+		path = path.strip("/srv/git")
+		return "git://%s/%sgit" % (Settings['ServerName'], path)
 
 	def __init__ (self, path):
 		Repo.__init__(self, path)
@@ -316,6 +320,9 @@
 	def getOwnerEmail (self):
 		if self._ownerEmail is None:
 			self._ownerEmail = self.config.get("user.email")
+		if self._ownerEmail is None:
+			try: self._ownerEmail = open(os.path.join(self.path, "owner")).read().strip()
+			except: pass
 		return Repo.getOwnerEmail(self)
 	ownerEmail = property(getOwnerEmail)
 
@@ -592,12 +599,12 @@
 		for repo in sorted(group.repos):
 			url = repo.path
 			if url.endswith("/.git"): url = url[:-5]
-			url = url.strip("/")
+			url = url.strip("/srv/git/")
 			print >>self.f, "repo.url=%s" % (url)
 			print >>self.f, "repo.path=%s" % (repo.path)
 			print >>self.f, "repo.name=%s" % (repo.name)
 			print >>self.f, "repo.desc=%s" % (repo.description)
-			print >>self.f, "repo.owner=%s <%s>" % repo.owner
+			print >>self.f, "repo.owner=%s%s" % repo.owner
 			print >>self.f, "repo.clone-url=%s" % (repo.clone)
 			print >>self.f, ""
 

--i9LlY+UWpKt15+FH--
