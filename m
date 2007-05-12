From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: [PATCH] cvsserver: Complete rewrite of the configuration parser
Date: Sat, 12 May 2007 21:30:52 +0200
Message-ID: <11789982521112-git-send-email-frank@lichtenheld.de>
References: <7v8xbvj5mx.fsf@arte.twinsun.com>
Cc: git@vger.kernel.org, Martin Langhoff <martin.langhoff@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 12 21:31:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmxIz-0004fq-ER
	for gcvg-git@gmane.org; Sat, 12 May 2007 21:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756451AbXELTa4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 15:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756616AbXELTa4
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 15:30:56 -0400
Received: from mail.lenk.info ([217.160.134.107]:4291 "EHLO mail.lenk.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756451AbXELTaz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 15:30:55 -0400
Received: from herkules.lenk.info
	([213.239.194.154] helo=smtp.lenk.info ident=Debian-exim)
	by mail.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA1:32) (Exim 4.63 1)
	id 1HmxHe-0001Fg-IX; Sat, 12 May 2007 21:29:38 +0200
Received: from p3ee3e222.dip.t-dialin.net ([62.227.226.34] helo=localhost)
	by smtp.lenk.info with esmtpsa 
	(Cipher TLS-1.0:RSA_AES_256_CBC_SHA:32) (Exim 4.63 1)
	id 1HmxIq-0005Gp-4F; Sat, 12 May 2007 21:30:52 +0200
Received: from djpig by localhost with local (Exim 4.67)
	(envelope-from <frank@lichtenheld.de>)
	id 1HmxIq-00021s-DZ; Sat, 12 May 2007 21:30:52 +0200
X-Mailer: git-send-email 1.5.1.4
In-Reply-To: <7v8xbvj5mx.fsf@arte.twinsun.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47082>

Move the configuration parsing to a separate GITCVS::config
module. Simplifies using the configuration in the rest of
the code.

Restrict parsed configuration variables to
^gitcvs\.((ext|pserver)\.)?
since we don't use anything else anyway. This also
reduces the risk of getting confused with arbitrary
variables (especially arbitrary subsection names).

Also fixes a bug where the config parser got confused
if a section had a subsection and a variable with the
same name.

Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>
---
 git-cvsserver.perl |  187 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 158 insertions(+), 29 deletions(-)

 Maybe a bit overkill if one only wants to solve the problem Junio discovered
 but I believe it's still worthwile.

 Has a lot of overlap with perl/Git.pm though...

 Not extensively tested but it at least passes the test cases and creates a useful
 log which should take care of the two main code paths (get_gitcvs and
 get_gitcvs_bool).

diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 3e7bf5b..e51ffd0 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -174,27 +174,17 @@ sub req_Root
        return 0;
     }
 
-    my @gitvars = `git-config -l`;
-    if ($?) {
-       print "E problems executing git-config on the server -- this is not a git repository or the PATH is not set correctly.\n";
-        print "E \n";
-        print "error 1 - problem executing git-config\n";
-       return 0;
-    }
-    foreach my $line ( @gitvars )
-    {
-        next unless ( $line =~ /^(.*?)\.(.*?)(?:\.(.*?))?=(.*)$/ );
-        unless ($3) {
-            $cfg->{$1}{$2} = $4;
-        } else {
-            $cfg->{$1}{$2}{$3} = $4;
-        }
+    $cfg = GITCVS::config->new();
+
+    unless ($cfg) {
+	print "E problems executing git-config on the server -- ".
+	    "this is not a git repository or the PATH is not set correctly.\n";
+	print "E \n";
+	print "error 1 - problem executing git-config\n";
+	return 0;
     }
 
-    unless ( ($cfg->{gitcvs}{$state->{method}}{enabled}
-	      and $cfg->{gitcvs}{$state->{method}}{enabled} =~ /^\s*(1|true|yes)\s*$/i)
-	     or ($cfg->{gitcvs}{enabled}
-	      and $cfg->{gitcvs}{enabled} =~ /^\s*(1|true|yes)\s*$/i) )
+    unless ( $cfg->get_gitcvs_bool($state->{method},'enabled') )
     {
         print "E GITCVS emulation needs to be enabled on this repo\n";
         print "E the repo config file needs a [gitcvs] section added, and the parameter 'enabled' set to 1\n";
@@ -203,7 +193,7 @@ sub req_Root
         return 0;
     }
 
-    my $logfile = $cfg->{gitcvs}{$state->{method}}{logfile} || $cfg->{gitcvs}{logfile};
+    my $logfile = $cfg->get_gitcvs($state->{method},'logfile');
     if ( $logfile )
     {
         $log->setfile($logfile);
@@ -1967,7 +1957,7 @@ sub kopts_from_path
 	# what attributes apply to this path.
 
 	# Until then, take the setting from the config file
-    unless ( defined ( $cfg->{gitcvs}{allbinary} ) and $cfg->{gitcvs}{allbinary} =~ /^\s*(1|true|yes)\s*$/i )
+    unless ( $cfg->get_gitcvs_bool('allbinary') )
     {
 		# Return "" to give no special treatment to any path
 		return "";
@@ -1978,6 +1968,147 @@ sub kopts_from_path
     }
 }
 
+package GITCVS::config;
+
+####
+#### Copyright 2007 Frank Lichtenheld <frank@lichtenheld.de>.
+####
+
+use strict;
+use warnings;
+
+=head1 NAME
+
+GITCVS::config -- interface to the git configuration files
+
+=head1 DESCRIPTION
+
+Parses the output of "git-config -l" once and then allows to access that
+information
+
+=head1 METHODS
+
+=cut
+
+=head2 new
+
+Creates a new object and retrieves the config information.
+If retrieving the configuration fails, returns undef.
+
+=cut
+sub new
+{
+    my $class = shift;
+
+    my $self = {};
+
+    bless $self, $class;
+
+    $self->update() or return;
+
+    return $self;
+}
+
+=head2 update
+
+Update the config information. Is called by new on creation.
+Currently limits itself to the variables actually used by
+git-cvsserver since the output of git-config -l is not actually
+completly maschine-parsable. Multi-valued variables are not
+supported, the last value found is used.
+
+=cut
+sub update
+{
+    my $self = shift;
+
+    my @gitvars = `git-config -l`;
+    return if $?;
+    foreach my $line ( @gitvars )
+    {
+	next unless ( $line =~ /^((gitcvs)\.(?:(ext|pserver)\.)?([\w-]+))=(.*)$/ );
+	$self->{cfg}{$1} = $5;
+    }
+
+    return $self;
+}
+
+=head2 get
+
+Retrieve a configuration value. Give the key as array.
+
+=cut
+sub get {
+    my $self = shift;
+    my @key = @_;
+
+    unless (($#key == 1)
+	    || ($#key == 2)) {
+	return;
+    }
+
+    $key[0] = lc $key[0];
+    $key[-1] = lc $key[-1];
+
+    my $key = join('.',@key);
+    if (exists $self->{cfg}{$key}) {
+	return $self->{cfg}{$key};
+    }
+    return;
+}
+
+=head2 get_bool
+
+Retrieve a configuration value. Give the key as array.
+Normalizes the value to either undef, 0, or 1.
+
+=cut
+sub get_bool {
+    my $self = shift;
+    my $value = $self->get(@_);
+
+    return unless defined($value);
+    return 1 if $value =~ /^\s*(1|true|yes)\s*$/i;
+    return 0;
+}
+
+=head2 get_gitcvs
+
+Like get(), but automatically assumes gitcvs as section.
+If given two paramters, tries with second one alone
+if the first query gave no result.
+
+=cut
+sub get_gitcvs {
+    my $self = shift;
+    my @key = @_;
+
+    my $value = $self->get('gitcvs',@key);
+    if (!defined($value) && ($#key == 1)) {
+	$value = $self->get('gitcvs',$key[1]);
+    }
+
+    return $value;
+}
+
+=head2 get_gitcvs_bool
+
+What get_bool is to get that
+is get_gitcvs_bool to get_gitcvs.
+
+=cut
+sub get_gitcvs_bool {
+    my $self = shift;
+    my @key = @_;
+
+    my $value = $self->get_bool('gitcvs',@key);
+    if (!defined($value) && ($#key == 1)) {
+	$value = $self->get_bool('gitcvs',$key[1]);
+    }
+
+    return $value;
+}
+
 package GITCVS::log;
 
 ####
@@ -2189,14 +2320,12 @@ sub new
 
     die "Git repo '$self->{git_path}' doesn't exist" unless ( -d $self->{git_path} );
 
-    $self->{dbdriver} = $cfg->{gitcvs}{$state->{method}}{dbdriver} ||
-        $cfg->{gitcvs}{dbdriver} || "SQLite";
-    $self->{dbname} = $cfg->{gitcvs}{$state->{method}}{dbname} ||
-        $cfg->{gitcvs}{dbname} || "%Ggitcvs.%m.sqlite";
-    $self->{dbuser} = $cfg->{gitcvs}{$state->{method}}{dbuser} ||
-        $cfg->{gitcvs}{dbuser} || "";
-    $self->{dbpass} = $cfg->{gitcvs}{$state->{method}}{dbpass} ||
-        $cfg->{gitcvs}{dbpass} || "";
+    $self->{dbdriver} = $cfg->get_gitcvs($state->{method},'dbdriver') ||
+	"SQLite";
+    $self->{dbname} = $cfg->get_gitcvs($state->{method},'dbname') ||
+	"%Ggitcvs.%m.sqlite";
+    $self->{dbuser} = $cfg->get_gitcvs($state->{method},'dbuser') || "";
+    $self->{dbpass} = $cfg->get_gitcvs($state->{method},'dbpass') || "";
     my %mapping = ( m => $module,
                     a => $state->{method},
                     u => getlogin || getpwuid($<) || $<,
-- 
1.5.1.4
