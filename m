From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [RFC PATCH] gitweb: Support filtering projects by .htaccess files.
Date: Mon, 3 Nov 2008 19:43:29 +0300
Organization: HOME
Message-ID: <200811031943.30033.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 17:46:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx2Zj-0000rf-LE
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 17:46:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756581AbYKCQpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 11:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755309AbYKCQpc
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 11:45:32 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:2635 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756708AbYKCQpa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 11:45:30 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2300300fgg.17
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 08:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=m2RV7Y7i8LE/kWqOh8pWiDWUmzDviNKyDzC8RS42+MM=;
        b=NgGBPPakOErLgaHBlXaKMAs85JJiDzsopVL4R/8aHmfhm9YDNQEysNPabsm2p6b75M
         J4rXMcAGlUGHftqsYWsE+UJ2lliXcstXjg0jtJvqnYD9cKzg4fxP1Hu/hDiIzmURzkfb
         8VSZ8p77TovPJD9fc+jkeZCzAx2yWR+MTy5uA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=sUnYN9RiDn3++d6qnyZYj93rF1C6GlZ837AKmw0AwagibgiKMc/aE11e6uGcXUW3dO
         fUullJz8l0HdCsCDL3hwuU/laWSbNpKZ/6UIhBKa3CtSfS2v67U8HKJ3g6bt+HYW+9rU
         wF+7e7s0MWX1RmWtXkM2YsLZmgPFeizFs98mo=
Received: by 10.181.239.8 with SMTP id q8mr95183bkr.1.1225730728671;
        Mon, 03 Nov 2008 08:45:28 -0800 (PST)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id d13sm10722967fka.19.2008.11.03.08.45.24
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 03 Nov 2008 08:45:26 -0800 (PST)
User-Agent: KMail/1.10.1 (Linux/2.6.26.6-79.fc9.i686; KDE/4.1.2; i686; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99962>

Some environments may require selective limiting of read access to
repositories. While even dumb http transport supports it through .htaccess
files, gitweb currently does not implement discretionary access control.

This patch adds a configuration-contolled check that matches simple
'Reguire user'/'Reguire group' lines in the .htaccess files with the
authenticated user name. Using group authentication requires specifying
a path to the Apache group file in the configuration.

Using htaccess has an additional bonus that the same authentication
data can be used both for gitweb and the dumb http transport.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---

	I also created a gitosis fork that can generate the necessary files:

		http://repo.or.cz/w/gitosis/httpauth.git

	-- Alexander

 gitweb/INSTALL     |   14 ++++++++++
 gitweb/gitweb.perl |   68 +++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/gitweb/INSTALL b/gitweb/INSTALL
index 26967e2..0841db6 100644
--- a/gitweb/INSTALL
+++ b/gitweb/INSTALL
@@ -166,6 +166,20 @@ Gitweb repositories
   shows repositories only if this file exists in its object database
   (if directory has the magic file named $export_ok).
 
+- Finally, it is possible to use primitive .htaccess authentication by
+  enabling the $check_htaccess variable in the config file. Gitweb
+  recognizes the following htaccess commands:
+
+    Require user name1 name2 ...     # grant access to the listed users
+    Require group group1 group2 ...  # grant access to the listed groups
+    Deny from all                    # deny unless overridden by a Require
+
+  Access is granted if the currently authenticated user matches one
+  of the Require lines, or if the file does not contain any of the listed
+  commands, or if .htaccess does not exist. If the file exists but cannot
+  be opened, access is denied. To use group authentication you have to
+  point $auth_group_file to the group list in Apache format.
+
 Generating projects list using gitweb
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 63c793e..4b962c3 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -98,6 +98,12 @@ our $export_ok = "++GITWEB_EXPORT_OK++";
 # only allow viewing of repositories also shown on the overview page
 our $strict_export = "++GITWEB_STRICT_EXPORT++";
 
+# check basic authentication rules in .htaccess
+our $check_htaccess  = 0;
+
+# name of the file that lists groups for htaccess check
+our $auth_group_file = "";
+
 # list of git base URLs used for URL to where fetch project from,
 # i.e. full URL is "$git_base_url/$project"
 our @git_base_url_list = grep { $_ ne '' } ("++GITWEB_BASE_URL++");
@@ -397,10 +403,64 @@ sub check_head_link {
 		(-l $headfile && readlink($headfile) =~ /^refs\/heads\//));
 }
 
+# set of htaccess groups for the current user
+our %cur_auth_groups = ();
+
+sub find_current_groups($$) {
+	my ($gfile, $user) = @_;
+	return () unless $gfile && $user;
+
+	my @groups;
+	open my $gf, $gfile or return ();
+
+	while(<$gf>) {
+		next unless /^\s*(\S+)\s*:\s*(\S.*\S)\s*$/;
+		my ($grp, $usrs) = ($1, $2);
+		push @groups, $grp if grep { $_ eq $user } split (' ', $usrs);
+	}
+
+	close $gf;
+	return @groups;
+}
+
+sub check_htaccess_files($) {
+	my ($dir) = @_;
+	my $user = $cgi->remote_user() || ' ';
+
+	while (length $dir >= length $projectroot) {
+		my $file = "$dir/.htaccess";
+		next unless -e $file;
+		open my $htf, $file or return 0;
+
+		my $ok = 0;
+		my $need_ok = 0;
+		while (<$htf>) {
+			if (/^\s*Require\s+user\s+(\S.*\S)\s*$/i) {
+				$ok++ if grep { $_ eq $user; } split (' ', $1);
+				$need_ok++;
+			} elsif (/^\s*Require\s+group\s+(\S.*\S)\s*$/i) {
+				$ok++ if grep { $cur_auth_groups{$_}; } split(' ', $1);
+				$need_ok++;
+			} elsif (/^\s*Deny\s+from\s+all\s*$/ix) {
+				$need_ok++;
+			}
+		}
+		close $htf;
+
+		return $ok if $need_ok;
+		last;
+	} continue {
+		$dir =~ s/\/[^\/]*$// or last;
+	}
+
+	return 1;
+}
+
 sub check_export_ok {
 	my ($dir) = @_;
 	return (check_head_link($dir) &&
-		(!$export_ok || -e "$dir/$export_ok"));
+		(!$export_ok || -e "$dir/$export_ok") &&
+		(!$check_htaccess || check_htaccess_files($dir)));
 }
 
 # process alternate names for backward compatibility
@@ -626,6 +686,9 @@ if (defined $action) {
 	}
 }
 
+# compute authenticated groups
+$cur_auth_groups{$_}++ for find_current_groups($auth_group_file, $cgi->remote_user());
+
 # parameters which are pathnames
 our $project = $input_params{'project'};
 if (defined $project) {
@@ -853,8 +916,7 @@ sub validate_project {
 	my $input = shift || return undef;
 	if (!validate_pathname($input) ||
 		!(-d "$projectroot/$input") ||
-		!check_head_link("$projectroot/$input") ||
-		($export_ok && !(-e "$projectroot/$input/$export_ok")) ||
+		!check_export_ok("$projectroot/$input") ||
 		($strict_export && !project_in_list($input))) {
 		return undef;
 	} else {
-- 
1.6.0.3.15.gb8d36
