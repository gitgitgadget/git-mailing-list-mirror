From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: gitview: Use git ls-remote to find the tag and branch details
Date: Wed, 22 Feb 2006 21:37:18 +0530
Message-ID: <43FC8C36.5060309@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050008080802010304030201"
X-From: git-owner@vger.kernel.org Wed Feb 22 17:08:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBwWZ-0001n5-NE
	for gcvg-git@gmane.org; Wed, 22 Feb 2006 17:07:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWBVQH2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Feb 2006 11:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWBVQH2
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Feb 2006 11:07:28 -0500
Received: from pproxy.gmail.com ([64.233.166.177]:46453 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932311AbWBVQH1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Feb 2006 11:07:27 -0500
Received: by pproxy.gmail.com with SMTP id w49so1786382pyg
        for <git@vger.kernel.org>; Wed, 22 Feb 2006 08:07:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type;
        b=Q4YVuoeeTODilmImn27yAC2xedkACeZmaeQCKyIkHJW9czSDpRIut5RRJbNEL9QYhNnSXJZomUzxYW+0fGtzGdF7yc2Fp1/htzynauUU32Iubb1hZ3+At4SfxQsE7dFry/D6GcJhmWEPC6JGmIeSaY6N2Js9RX01WkXHt+lyU9A=
Received: by 10.35.78.13 with SMTP id f13mr675745pyl;
        Wed, 22 Feb 2006 08:07:26 -0800 (PST)
Received: from ?192.168.2.11? ( [59.92.206.254])
        by mx.gmail.com with ESMTP id m39sm178652pye.2006.02.22.08.07.22;
        Wed, 22 Feb 2006 08:07:24 -0800 (PST)
User-Agent: Mail/News 1.5 (X11/20060213)
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	aneesh.kumar@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16601>

This is a multi-part message in MIME format.
--------------050008080802010304030201
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------050008080802010304030201
Content-Type: text/plain;
 name*0="0002-gitview-Use-git-ls-remote-to-find-the-tag-and-branch-detail";
 name*1="s.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0002-gitview-Use-git-ls-remote-to-find-the-tag-and-branch-de";
 filename*1="tails.txt"


From: Junio C Hamano <junkio@cox.net>
This fix the below bug

Junio C Hamano <junkio@cox.net> writes:

>
> It does not work in my repository, since you do not seem to
> handle branch and tag names with slashes in them.  All of my
> topic branches live in directories with two-letter names
> (e.g. ak/gitview).

Also use ${GIT_DIR} directly  so that it works with below environment setup

GIT_DIR=/home/opensource/Test\ Output/git-devel/.git

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>

---

 contrib/gitview/gitview |   54 ++++++++++++-----------------------------------
 1 files changed, 14 insertions(+), 40 deletions(-)

ecd82bdd8399b84ada1f4fc0c720a88ae0735a94
diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
index 0e52c78..76a1b67 100755
--- a/contrib/gitview/gitview
+++ b/contrib/gitview/gitview
@@ -56,20 +56,6 @@ def show_date(epoch, tz):
 
 	return time.strftime("%Y-%m-%d %H:%M:%S", time.gmtime(secs))
 
-def get_sha1_from_tags(line):
-	fp = os.popen("git cat-file -t " + line)
-	entry = string.strip(fp.readline())
-	fp.close()
-	if (entry == "commit"):
-		return line
-	elif (entry == "tag"):
-		fp = os.popen("git cat-file tag "+ line)
-		entry = string.strip(fp.readline())
-		fp.close()
-		obj = re.split(" ", entry)
-		if (obj[0] == "object"):
-			return obj[1]
-	return None
 
 class CellRendererGraph(gtk.GenericCellRenderer):
 	"""Cell renderer for directed graph.
@@ -467,32 +453,20 @@ class GitView:
 		respective sha1 details """
 
 		self.bt_sha1 = { }
-		git_dir = os.getenv("GIT_DIR")
-		if (git_dir == None):
-			git_dir = ".git"
-
-		#FIXME the path seperator
-		ref_files = os.listdir(git_dir + "/refs/tags")
-		for file in ref_files:
-			fp = open(git_dir + "/refs/tags/"+file)
-			sha1 = get_sha1_from_tags(string.strip(fp.readline()))
-			try:
-				self.bt_sha1[sha1].append(file)
-			except KeyError:
-				self.bt_sha1[sha1] = [file]
-			fp.close()
-
-
-		#FIXME the path seperator
-		ref_files = os.listdir(git_dir + "/refs/heads")
-		for file in ref_files:
-			fp = open(git_dir + "/refs/heads/" + file)
-			sha1 = get_sha1_from_tags(string.strip(fp.readline()))
-			try:
-				self.bt_sha1[sha1].append(file)
-			except KeyError:
-				self.bt_sha1[sha1] = [file]
-			fp.close()
+		ls_remote = re.compile('^(.{40})\trefs/([^^]+)(?:\\^(..))?$');
+		fp = os.popen('git ls-remote "${GIT_DIR:-.git}"')
+		while 1:
+			line = string.strip(fp.readline())
+			if line == '':
+				break
+			m = ls_remote.match(line)
+			if not m:
+				continue
+			(sha1, name) = (m.group(1), m.group(2))
+			if not self.bt_sha1.has_key(sha1):
+				self.bt_sha1[sha1] = []
+			self.bt_sha1[sha1].append(name)
+		fp.close()
 
 
 	def construct(self):
-- 
1.2.0-dirty


--------------050008080802010304030201--
