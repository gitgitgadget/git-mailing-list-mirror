From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] svnimport: support repositories requiring SSL authentication
Date: Sun, 1 Jan 2006 13:25:47 -0800
Message-ID: <20060101212546.GI3963@mail.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jan 01 22:26:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EtAiE-0003Wu-R6
	for gcvg-git@gmane.org; Sun, 01 Jan 2006 22:25:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWAAVZs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jan 2006 16:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932269AbWAAVZs
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jan 2006 16:25:48 -0500
Received: from hand.yhbt.net ([66.150.188.102]:8593 "EHLO mail.yhbt.net")
	by vger.kernel.org with ESMTP id S932266AbWAAVZs (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Jan 2006 16:25:48 -0500
Received: by mail.yhbt.net (Postfix, from userid 500)
	id 412DB7DC005; Sun,  1 Jan 2006 13:25:47 -0800 (PST)
To: git list <git@vger.kernel.org>,
	Matthias Urlichs <smurf@smurf.noris.de>
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14131>

I looked at svn-mirror to see how it did this, seems about right.
"It works for me" when using it against https://svn.musicpd.org

tested command-line: git-svnimport -C mpc -i -m -v  \
	-T mpc/trunk -b mpc/branches -t mpc/tags https://svn.musicpd.org

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 git-svnimport.perl |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

926c84c0c96e43ca0341b541ed23e0f3874b8171
diff --git a/git-svnimport.perl b/git-svnimport.perl
index cb241d1..6e3a44a 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -96,8 +96,10 @@ sub new {
 sub conn {
 	my $self = shift;
 	my $repo = $self->{'fullrep'};
-	my $s = SVN::Ra->new($repo);
-
+	my $auth = SVN::Core::auth_open ([SVN::Client::get_simple_provider,
+			  SVN::Client::get_ssl_server_trust_file_provider,
+			  SVN::Client::get_username_provider]);
+	my $s = SVN::Ra->new(url => $repo, auth => $auth);
 	die "SVN connection to $repo: $!\n" unless defined $s;
 	$self->{'svn'} = $s;
 	$self->{'repo'} = $repo;
-- 
1.0.GIT
