From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH 4/5] cvsserver: Make the database backend configurable
Date: Mon, 19 Mar 2007 16:56:00 +0100
Message-ID: <11743197611364-git-send-email-frank@lichtenheld.de>
References: <11743197614111-git-send-email-frank@lichtenheld.de>
Cc: Frank Lichtenheld <frank@lichtenheld.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 19 16:57:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTKEO-0001s2-Le
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 16:57:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbXCSP4z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 11:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbXCSP4z
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 11:56:55 -0400
Received: from mail.lenk.info ([217.160.134.107]:62759 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030230AbXCSP4y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 11:56:54 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HTKEQ-00047K-EW; Mon, 19 Mar 2007 16:57:11 +0100
Received: from p54b0eb28.dip.t-dialin.net ([84.176.235.40] helo=goedel.djpig.de)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HTKE6-0005uy-H6; Mon, 19 Mar 2007 16:56:50 +0100
Received: from djpig by goedel.djpig.de with local (Exim 4.63)
	(envelope-from <frank@lichtenheld.de>)
	id 1HTKDO-0005vq-Su; Mon, 19 Mar 2007 16:56:06 +0100
X-Mailer: git-send-email 1.5.0.3
In-Reply-To: <11743197614111-git-send-email-frank@lichtenheld.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42629>

Make all the different parts of the database backend connection
configurable. This adds the following string configuration variables:
- gitcvs.dbdriver
- gitcvs.dbname
- gitcvs.dbuser
- gitcvs.dbpass
The default values emulate the current behavior exactly for
backwards compatibility.
All configuration variables can also be specified for a specific
access method (i.e. in the form gitcvs.<method>.<var>)

The dbdriver/dbuser/dbpass variables are added for completness.
No other backend than SQLite is tested yet.
The dbname variable on the other hand is useful with this backend
already (to not discriminate against other possible backends
it was not splitted in dbdir and dbfile).

Both dbname and dbuser support dynamic variable substitution where
the available variables are:
%m -- the CVS 'module' (i.e. GIT 'head') worked on
%a -- CVS access method used (i.e. 'ext' or 'pserver')
%u -- User name of the user invoking git-cvsserver
%G -- .git directory name
%g -- .git directory name, mangled to be used in a filename,
      currently this substitutes all chars except for [\w.-]
      with '_'

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 git-cvsserver.perl |   40 ++++++++++++++++++++++++++++++++++------
 1 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 5d2b6f3..6d10aa3 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2141,19 +2141,33 @@ sub new
 
     bless $self, $class;
 
-    $self->{dbdir} = $config . "/";
-    die "Database dir '$self->{dbdir}' isn't a directory" unless ( defined($self->{dbdir}) and -d $self->{dbdir} );
-
     $self->{module} = $module;
-    $self->{file} = $self->{dbdir} . "/gitcvs.$module.sqlite";
-
     $self->{git_path} = $config . "/";
 
     $self->{log} = $log;
 
     die "Git repo '$self->{git_path}' doesn't exist" unless ( -d $self->{git_path} );
 
-    $self->{dbh} = DBI->connect("dbi:SQLite:dbname=" . $self->{file},"","");
+    $self->{dbdriver} = $cfg->{gitcvs}{$state->{method}}{dbdriver} ||
+        $cfg->{gitcvs}{dbdriver} || "dbi:SQLite";
+    $self->{dbname} = $cfg->{gitcvs}{$state->{method}}{dbname} ||
+        $cfg->{gitcvs}{dbname} || "%Ggitcvs.%m.sqlite";
+    $self->{dbuser} = $cfg->{gitcvs}{$state->{method}}{dbuser} ||
+        $cfg->{gitcvs}{dbuser} || "";
+    $self->{dbpass} = $cfg->{gitcvs}{$state->{method}}{dbpass} ||
+        $cfg->{gitcvs}{dbpass} || "";
+    my %mapping = ( m => $module,
+                    a => $state->{method},
+                    u => getlogin || getpwuid($<) || $<,
+                    G => $self->{git_path},
+                    g => mangle_dirname($self->{git_path}),
+                    );
+    $self->{dbname} =~ s/%([mauGg])/$mapping{$1}/eg;
+    $self->{dbuser} =~ s/%([mauGg])/$mapping{$1}/eg;
+
+    $self->{dbh} = DBI->connect("$self->{dbdriver}:dbname=$self->{dbname}",
+                                $self->{dbuser},
+                                $self->{dbpass});
 
     $self->{tables} = {};
     foreach my $table ( $self->{dbh}->tables )
@@ -2857,5 +2871,19 @@ sub safe_pipe_capture {
     return wantarray ? @output : join('',@output);
 }
 
+=head2 mangle_dirname
+
+create a string from a directory name that is suitable to use as
+part of a filename, mainly by converting all chars except \w.- to _
+
+=cut
+sub mangle_dirname {
+    my $dirname = shift;
+    return unless defined $dirname;
+
+    $dirname =~ s/[^\w.-]/_/g;
+
+    return $dirname;
+}
 
 1;
-- 
1.5.0.3
