From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH (amend)] cvsserver: Add asciidoc documentation for new database backend configuration
Date: Thu, 12 Apr 2007 16:43:36 +0200
Message-ID: <11763890161953-git-send-email-frank@lichtenheld.de>
References: <7v64879rwd.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org, Frank Lichtenheld <frank@lichtenheld.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 12 16:44:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hc0X1-0000y2-AT
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 16:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbXDLOoL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 10:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992546AbXDLOoL
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 10:44:11 -0400
Received: from mail.lenk.info ([217.160.134.107]:2420 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932290AbXDLOoK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 10:44:10 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1Hc0Wl-0005Bd-Lu; Thu, 12 Apr 2007 16:43:59 +0200
Received: from p54b0ded2.dip.t-dialin.net ([84.176.222.210] helo=goedel.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1Hc0Ws-0006FM-SE; Thu, 12 Apr 2007 16:44:07 +0200
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1Hc0WO-0003JV-Sm; Thu, 12 Apr 2007 16:43:36 +0200
X-Mailer: git-send-email 1.5.1
In-Reply-To: <7v64879rwd.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44338>

Documents the new configuration variables and the variable
substitution mechanism.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 Documentation/git-cvsserver.txt |   93 +++++++++++++++++++++++++++++++++++++--
 1 files changed, 89 insertions(+), 4 deletions(-)

 Reworded the section about git-cvsserver needing to update the
 database.

diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 2cf8153..9fbaf75 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -65,11 +65,12 @@ env variable, you can rename git-cvsserver to cvs.
 
 ------
 Note: you need to ensure each user that is going to invoke git-cvsserver has
-write access to the log file and to the git repository. When offering anon
-access via pserver, this means that the nobody user should have write access
-to at least the sqlite database at the root of the repository.
+write access to the log file and to the database (see
+<<dbbackend,Database Backend>>. If you want to offer write access over
+SSH, the users of course also need write access to the git repository itself.
 
-Both configuration variables can also be overriden for a specific method of
+[[configaccessmethod]]
+All configuration variables can also be overriden for a specific method of
 access. Valid method names are "ext" (for SSH access) and "pserver". The
 following example configuration would disable pserver access while still
 allowing access over SSH.
@@ -105,6 +106,90 @@ Example:
      cvs co -d project-master master
 ------
 
+[[dbbackend]]
+Database Backend
+----------------
+
+git-cvsserver uses one database per git head (i.e. CVS module) to
+store information about the repository for faster access. The
+database doesn't contain any persitent data and can be completly
+regenerated from the git repository at any time. The database
+needs to be updated (i.e. written to) after every commit.
+
+If the commit is done directly by using git (as opposed to
+using git-cvsserver) the update will need to happen on the
+next repository access by git-cvsserver, independent of
+access method and requested operation.
+
+That means that even if you offer only read access (e.g. by using
+the pserver method), git-cvsserver should have write access to
+the database to work reliably (otherwise you need to make sure
+that the database if up-to-date all the time git-cvsserver is run).
+
+By default it uses SQLite databases in the git directory, named
+`gitcvs.<module_name>.sqlite`. Note that the SQLite backend creates
+temporary files in the same directory as the database file on
+write so it might not be enough to grant the users using
+git-cvsserver write access to the database file without granting
+them write access to the directory, too.
+
+You can configure the database backend with the following
+configuration variables:
+
+Configuring database backend
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+git-cvsserver uses the Perl DBI module. Please also read
+its documentation if changing these variables, especially
+about `DBI->connect()`.
+
+gitcvs.dbname::
+	Database name. The exact meaning depends on the
+	used database driver, for SQLite this is a filename.
+	Supports variable substitution (see below). May
+	not contain semicolons (`;`).
+	Default: '%Ggitcvs.%m.sqlite'
+
+gitcvs.dbdriver::
+	Used DBI driver. You can specify any available driver
+	for this here, but it might not work. cvsserver is tested
+	with 'DBD::SQLite', reported to work with
+	'DBD::Pg', and reported *not* to work with 'DBD::mysql'.
+	Please regard this as an experimental feature. May not
+	contain double colons (`:`).
+	Default: 'SQLite'
+
+gitcvs.dbuser::
+	Database user. Only useful if setting `dbdriver`, since
+	SQLite has no concept of database users. Supports variable
+	substitution (see below).
+
+gitcvs.dbpass::
+	Database password.  Only useful if setting `dbdriver`, since
+	SQLite has no concept of database passwords.
+
+All variables can also be set per access method, see <<configaccessmethod,above>>.
+
+Variable substitution
+^^^^^^^^^^^^^^^^^^^^^
+In `dbdriver` and `dbuser` you can use the following variables:
+
+%G::
+	git directory name
+%g::
+	git directory name, where all characters except for
+	alpha-numeric ones, `.`, and `-` are replaced with
+	`_` (this should make it easier to use the directory
+	name in a filename if wanted)
+%m::
+	CVS module/git head name
+%a::
+	access method (one of "ext" or "pserver")
+%u::
+	Name of the user running git-cvsserver.
+	If no name can be determined, the
+	numeric uid is used.
+
 Eclipse CVS Client Notes
 ------------------------
 
-- 
1.5.1
