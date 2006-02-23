From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: gitview: Display the lines joining commit nodes clearly.
Date: Fri, 24 Feb 2006 00:59:42 +0530
Message-ID: <43FE0D26.2080304@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070504030708040907090007"
X-From: git-owner@vger.kernel.org Thu Feb 23 20:30:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCMAA-0005xy-1K
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 20:30:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbWBWT3z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 14:29:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751518AbWBWT3z
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 14:29:55 -0500
Received: from pproxy.gmail.com ([64.233.166.176]:58898 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751504AbWBWT3y (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Feb 2006 14:29:54 -0500
Received: by pproxy.gmail.com with SMTP id t32so158242pyc
        for <git@vger.kernel.org>; Thu, 23 Feb 2006 11:29:54 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type;
        b=ct5geef5XPDvSj1A42/+EmUqZ7GIk906iErFZwCemeaDpS0j5VHU73QpVBCrXoS3QK14HZCs7H8VivM+aKuxT/TO+IUq9synE5L+DAZKmjduBnrOET3Lb1n5H4CsHVayyTVH2DLIuCEOHV9q7YY012v11j6NV9b8T06Qud79f1w=
Received: by 10.35.78.13 with SMTP id f13mr1355308pyl;
        Thu, 23 Feb 2006 11:29:53 -0800 (PST)
Received: from ?192.168.2.11? ( [59.92.135.36])
        by mx.gmail.com with ESMTP id m78sm53555pye.2006.02.23.11.29.50;
        Thu, 23 Feb 2006 11:29:53 -0800 (PST)
User-Agent: Mail/News 1.5 (X11/20060213)
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	"Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16657>

This is a multi-part message in MIME format.
--------------070504030708040907090007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


--------------070504030708040907090007
Content-Type: text/plain;
 name*0="0001-gitview-Display-the-lines-joining-commit-nodes-clearly.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-gitview-Display-the-lines-joining-commit-nodes-clearly.";
 filename*1="txt"


Since i wanted to limit the graph box size i was resetting
the window after an index of 5. This result in line joining
commit nodes to pass over nodes which are not related. The
changes fixes the same

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@gmail.com>

---

 contrib/gitview/gitview |   48 ++++++++++++++++++++++++++++++++++-------------
 1 files changed, 35 insertions(+), 13 deletions(-)

3fcd411c65b2c6f84052d69ca05766e45a34682e
diff --git a/contrib/gitview/gitview b/contrib/gitview/gitview
index 4b52eb7..b04df74 100755
--- a/contrib/gitview/gitview
+++ b/contrib/gitview/gitview
@@ -823,6 +823,7 @@ class GitView:
 		self.colours = {}
 		self.nodepos = {}
 		self.incomplete_line = {}
+		self.commits = []
 
 		index = 0
 		last_colour = 0
@@ -840,12 +841,7 @@ class GitView:
 
 			commit = Commit(commit_lines)
 			if (commit != None ):
-				(out_line, last_colour, last_nodepos) = self.draw_graph(commit,
-										index, out_line,
-										last_colour,
-										last_nodepos)
-				self.index[commit.commit_sha1] = index
-				index += 1
+				self.commits.append(commit)
 
 			# Skip the '\0
 			commit_lines = []
@@ -854,6 +850,14 @@ class GitView:
 
 		fp.close()
 
+		for commit in self.commits:
+			(out_line, last_colour, last_nodepos) = self.draw_graph(commit,
+										index, out_line,
+										last_colour,
+										last_nodepos)
+			self.index[commit.commit_sha1] = index
+			index += 1
+
 		self.treeview.set_model(self.model)
 		self.treeview.show()
 
@@ -869,13 +873,6 @@ class GitView:
 			last_nodepos = 0
 
 		# Add the incomplete lines of the last cell in this
-		for sha1 in self.incomplete_line.keys():
-			if ( sha1 != commit.commit_sha1):
-				for pos in self.incomplete_line[sha1]:
-					in_line.append((pos, pos, self.colours[sha1]))
-			else:
-				del self.incomplete_line[sha1]
-
 		try:
 			colour = self.colours[commit.commit_sha1]
 		except KeyError:
@@ -897,6 +894,14 @@ class GitView:
 			self.colours[commit.parent_sha1[0]] = colour
 			self.nodepos[commit.parent_sha1[0]] = node_pos
 
+		for sha1 in self.incomplete_line.keys():
+			if ( sha1 != commit.commit_sha1):
+				self.draw_incomplete_line(sha1, node_pos,
+						out_line, in_line, index)
+			else:
+				del self.incomplete_line[sha1]
+
+
 		in_line.append((node_pos, self.nodepos[commit.parent_sha1[0]],
 					self.colours[commit.parent_sha1[0]]))
 
@@ -936,6 +941,23 @@ class GitView:
 		except KeyError:
 			self.incomplete_line[sha1] = [self.nodepos[sha1]]
 
+	def draw_incomplete_line(self, sha1, node_pos, out_line, in_line, index):
+		for idx, pos in enumerate(self.incomplete_line[sha1]):
+			if(pos == node_pos):
+				out_line.append((pos,
+					pos+0.5, self.colours[sha1]))
+				self.incomplete_line[sha1][idx] = pos = pos+0.5
+			try:
+				next_commit = self.commits[index+1]
+				if (next_commit.commit_sha1 == sha1 and pos != int(pos)):
+				# join the line back to the node point 
+				# This need to be done only if we modified it
+					in_line.append((pos, pos-0.5, self.colours[sha1]))
+					continue;
+			except IndexError:
+				pass
+			in_line.append((pos, pos, self.colours[sha1]))
+
 
 	def _go_clicked_cb(self, widget, revid):
 		"""Callback for when the go button for a parent is clicked."""
-- 
1.2.3.g2cf3-dirty


--------------070504030708040907090007--
