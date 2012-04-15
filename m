From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: [PATCHv2] Add details about svn-fe's dumpfile parsing
Date: Sun, 15 Apr 2012 17:10:46 +0100
Message-ID: <4F8AF306.8070804@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 15 18:10:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJS2T-0002HU-Kt
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 18:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754973Ab2DOQKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 12:10:52 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:55046 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754793Ab2DOQKv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Apr 2012 12:10:51 -0400
Received: from aamtaout01-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120415161048.GYJU21612.mtaout03-winn.ispmail.ntl.com@aamtaout01-winn.ispmail.ntl.com>;
          Sun, 15 Apr 2012 17:10:48 +0100
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout01-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120415161048.GOCF10211.aamtaout01-winn.ispmail.ntl.com@[192.168.0.2]>;
          Sun, 15 Apr 2012 17:10:48 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=yXtjXN6ItgYA:10 a=Zm2vQYg1M6cA:10 a=u4BGzq-dJbcA:10 a=8nJEP1OIZ-IA:10 a=qOz2pZ_4AAAA:8 a=LPzGSBu71lIJFYahiXMA:9 a=wPNLvfGTeEIA:10 a=7qzHkXPk5l4A:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195570>

The documentation for the SVN dumpfile format says that "property key/value
pairs may be interpreted as binary data in any encoding by client tools".
Documenting svn-fe's interpretation helps authors of related tools, while
explaining limitations helps ordinary users import their SVN repositories.

The "INPUT FORMAT" section is aimed at authors of tools that interact with
svn-fe, so it particularly addresses assumptions that authors might make after
dealing with svn itself.

The "BUGS" section is aimed at ordinary users, so it only explains what readers
need to know when importing a repository.  In particular, users don't need to
know that other characters in the range 0x01-0x1F are imported correctly, even
though they were all disabled in Subversion 1.2.0.  The text in this section is
based largely on an example sent by Jonathan Nieder, with minor changes to suit
the surrounding style.

Signed-off-by: Andrew Sayers <andrew-git@pileofstuff.org>
---
 contrib/svn-fe/svn-fe.txt |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
index 1128ab2..3872b9d 100644
--- a/contrib/svn-fe/svn-fe.txt
+++ b/contrib/svn-fe/svn-fe.txt
@@ -32,6 +32,13 @@ Subversion's repository dump format is documented in full in
 Files in this format can be generated using the 'svnadmin dump' or
 'svk admin dump' command.
 
+Unlike Subversion, 'svn-fe' interprets property key/value pairs as
+null-terminated binary strings.  This means it will accept content
+that Subversion normally wouldn't produce (such as filenames
+containing tab characters) or would refuse to parse (such as usernames
+containing Latin-1 characters).  However, like Subversion it will
+handle newlines incorrectly in filenames (see BUGS below).
+
 OUTPUT FORMAT
 -------------
 The fast-import format is documented by the git-fast-import(1)
@@ -65,6 +72,12 @@ Empty directories and unknown properties are silently discarded.
 
 The exit status does not reflect whether an error was detected.
 
+Due to limitations in the Subversion dumpfile format, 'svn-fe' does
+not support filenames with newlines.  'svn add' has forbidden such
+filenames since version 1.2.0, but some historical repositories still
+contain them.  An import can appear to succeed and produce incorrect
+results when such pathological filenames are present.
+
 SEE ALSO
 --------
 git-svn(1), svn2git(1), svk(1), git-filter-branch(1), git-fast-import(1),
-- 
1.7.1
