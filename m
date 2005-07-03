From: Sven Verdoolaege <skimo@kotnet.org>
Subject: [PATCH] git-cvsimport-script: Support :ext: access method.
Date: Sun, 3 Jul 2005 13:38:30 +0200
Message-ID: <20050703113830.GB18608MdfPADPa@garage.linux.student.kuleuven.ac.be>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de> <20050630150239.GA20928@pc117b.liacs.nl> <20050630152125.GO10850@kiste.smurf.noris.de> <20050630154453.GA26808@pc117b.liacs.nl> <20050630161043.GR10850@kiste.smurf.noris.de> <20050630161423.GC26808@pc117b.liacs.nl> <20050630163000.GT10850@kiste.smurf.noris.de> <Pine.LNX.4.63.0506301321350.1667@localhost.localdomain> <pan.2005.07.01.09.43.24.106822@smurf.noris.de> <20050703103517.GJ5992MdfPADPa@garage.linux.student.kuleuven.ac.be>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jul 03 13:56:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dp34a-0006rM-UQ
	for gcvg-git@gmane.org; Sun, 03 Jul 2005 13:55:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbVGCLza (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jul 2005 07:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVGCLza
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jul 2005 07:55:30 -0400
Received: from nibbel.kulnet.kuleuven.ac.be ([134.58.240.41]:30876 "EHLO
	nibbel.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S261397AbVGCLyx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jul 2005 07:54:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by nibbel.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 23B5A4BF1A
	for <git@vger.kernel.org>; Sun,  3 Jul 2005 13:54:51 +0200 (CEST)
Received: from antonius.kulnet.kuleuven.ac.be (antonius.kulnet.kuleuven.ac.be [134.58.240.73])
	by nibbel.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 7D4A84BF11
	for <git@vger.kernel.org>; Sun,  3 Jul 2005 13:54:48 +0200 (CEST)
Received: from garage.linux.student.kuleuven.ac.be (garage.linux.student.kuleuven.be [193.190.253.84])
	by antonius.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 61DBC4C33C
	for <git@vger.kernel.org>; Sun,  3 Jul 2005 13:54:48 +0200 (CEST)
Received: (qmail 23108 invoked by uid 500); 3 Jul 2005 11:38:30 -0000
To: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
Mail-Followup-To: Matthias Urlichs <smurf@smurf.noris.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050703103517.GJ5992MdfPADPa@garage.linux.student.kuleuven.ac.be>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by KULeuven Antivirus Cluster
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Support :ext: access method.

---
commit 34155390a576d8124e0adc864aaf2f11bbf5168b
tree 4918235816314f1d9981456cb05e395b6030c035
parent 8d0ea3117597933610e02907d14b443f8996ca3b
author Sven Verdoolaege <skimo@kotnet.org> Sun, 03 Jul 2005 13:02:06 +0200
committer Sven Verdoolaege <skimo@kotnet.org> Sun, 03 Jul 2005 13:02:06 +0200

 Documentation/git-cvsimport-script.txt |    3 ++-
 git-cvsimport-script                   |   23 +++++++++++++++++++++--
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-cvsimport-script.txt b/Documentation/git-cvsimport-script.txt
--- a/Documentation/git-cvsimport-script.txt
+++ b/Documentation/git-cvsimport-script.txt
@@ -26,7 +26,8 @@ OPTIONS
 -------
 -d <CVSROOT>::
 	The root of the CVS archive. May be local (a simple path) or remote;
-	currently, only the :pserver: access method is supported.
+	currently, only the :local:, :ext: and :pserver: access methods 
+	are supported.
 
 -o <branch-for-HEAD>::
 	The 'HEAD' branch from CVS is imported to the 'origin' branch within
diff --git a/git-cvsimport-script b/git-cvsimport-script
--- a/git-cvsimport-script
+++ b/git-cvsimport-script
@@ -143,13 +143,32 @@ sub conn {
 		}
 		$self->{'socketo'} = $s;
 		$self->{'socketi'} = $s;
-	} else { # local: Fork off our own cvs server.
+	} else { # local or ext: Fork off our own cvs server.
 		my $pr = IO::Pipe->new();
 		my $pw = IO::Pipe->new();
 		my $pid = fork();
 		die "Fork: $!\n" unless defined $pid;
 		my $cvs = 'cvs';
 		$cvs = $ENV{CVS_SERVER} if exists $ENV{CVS_SERVER};
+		my $rsh = 'rsh';
+		$rsh = $ENV{CVS_RSH} if exists $ENV{CVS_RSH};
+
+		my @cvs = ($cvs, 'server');
+		my ($local, $user, $host);
+		$local = $repo =~ s/:local://;
+		if (!$local) {
+		    $repo =~ s/:ext://;
+		    $local = !($repo =~ s/^(?:([^\@:]+)\@)?([^:]+)://);
+		    ($user, $host) = ($1, $2);
+		}
+		if (!$local) {
+		    if ($user) {
+			unshift @cvs, $rsh, '-l', $user, $host;
+		    } else {
+			unshift @cvs, $rsh, $host;
+		    }
+		}
+
 		unless($pid) {
 			$pr->writer();
 			$pw->reader();
@@ -157,7 +176,7 @@ sub conn {
 			dup2($pr->fileno(),1);
 			$pr->close();
 			$pw->close();
-			exec($cvs,"server");
+			exec(@cvs);
 		}
 		$pw->writer();
 		$pr->reader();
