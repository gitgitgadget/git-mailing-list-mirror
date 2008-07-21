From: Brad King <brad.king@kitware.com>
Subject: [PATCH 1/2] git-svn: teach dcommit about svn auto-props
Date: Mon, 21 Jul 2008 17:40:26 -0400
Message-ID: <4885024A.3050200@kitware.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040505050402090503060007"
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 23:49:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KL3GI-0002fz-KJ
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 23:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753706AbYGUVsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 17:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753796AbYGUVsm
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 17:48:42 -0400
Received: from public.kitware.com ([66.194.253.19]:38935 "EHLO
	public.kitware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753706AbYGUVsk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 17:48:40 -0400
Received: from hythloth (hythloth.kitwarein.com [192.168.30.5])
	by public.kitware.com (Postfix) with ESMTP id EC9781F68;
	Mon, 21 Jul 2008 17:41:46 -0400 (EDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by hythloth (Postfix) with ESMTP id 072464F71E;
	Mon, 21 Jul 2008 17:40:27 -0400 (EDT)
User-Agent: Mozilla-Thunderbird 2.0.0.14 (X11/20080509)
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89410>

This is a multi-part message in MIME format.
--------------040505050402090503060007
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Subversion repositories often require files to have properties such as
svn:mime-type and svn:eol-style set when they are added.  Users
typically set these properties automatically using the SVN auto-props
feature with 'svn add'.  This commit teaches dcommit to look at the user
SVN configuration and apply matching auto-props entries for files added
by a diff as it is applied to the SVN remote.  A later commit will make
this feature optional.

Signed-off-by: Brad King <brad.king@kitware.com>
---
This change honors the user's enable-auto-props svn config setting.
The next patch will configure this at the git level and add the
corresponding documentation.

I've tested this by hand on an real SVN repo that checks for mime type.
Unfortunately I'm unable to run the git-svn test suite because I get
the error reported here:

  http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=486527

(even without my changes).

 git-svn.perl |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)






--------------040505050402090503060007
Content-Type: text/x-patch;
 name="31da8bfbf702861ed89b7c6fd307c99ebbd01165.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="31da8bfbf702861ed89b7c6fd307c99ebbd01165.diff"

diff --git a/git-svn.perl b/git-svn.perl
index 2e0e552..1975b62 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3340,6 +3340,7 @@ sub new {
 	$self->{rm} = { };
 	$self->{path_prefix} = length $self->{svn_path} ?
 	                       "$self->{svn_path}/" : '';
+	$self->{config} = $opts->{config};
 	return $self;
 }
 
@@ -3528,6 +3529,51 @@ sub ensure_path {
 	return $bat->{$c};
 }
 
+# Subroutine to convert a globbing pattern to a regular expression.
+# From perl cookbook.
+sub glob2pat {
+	my $globstr = shift;
+	my %patmap = ('*' => '.*', '?' => '.', '[' => '[', ']' => ']');
+	$globstr =~ s{(.)} { $patmap{$1} || "\Q$1" }ge;
+	return '^' . $globstr . '$';
+}
+
+sub check_autoprop {
+	my ($self, $pattern, $properties, $file, $fbat) = @_;
+	# Convert the globbing pattern to a regular expression.
+	my $regex = glob2pat($pattern);
+	# Check if the pattern matches the file name.
+	if($file =~ m/($regex)/) {
+		# Parse the list of properties to set.
+		my @props = split(/;/, $properties);
+		foreach my $prop (@props) {
+			# Parse 'name=value' syntax and set the property.
+			if ($prop =~ /([^=]+)=(.*)/) {
+				$self->change_file_prop($fbat, $1, $2);
+			}
+		}
+	}
+}
+
+sub apply_autoprops {
+	my ($self, $file, $fbat) = @_;
+	my $conf_t = ${$self->{config}}{'config'};
+	no warnings 'once';
+	# Check [miscellany]/enable-auto-props in svn configuration.
+	if (SVN::_Core::svn_config_get_bool($conf_t,
+					    $SVN::_Core::SVN_CONFIG_SECTION_MISCELLANY,
+					    $SVN::_Core::SVN_CONFIG_OPTION_ENABLE_AUTO_PROPS,
+					    0)) {
+		# Auto-props are enabled.  Enumerate them to look for matches.
+		my $callback = sub {
+			$self->check_autoprop($_[0], $_[1], $file, $fbat);
+		};
+		SVN::_Core::svn_config_enumerate($conf_t,
+						 $SVN::_Core::SVN_CONFIG_SECTION_AUTO_PROPS,
+						 $callback);
+	}
+}
+
 sub A {
 	my ($self, $m) = @_;
 	my ($dir, $file) = split_path($m->{file_b});
@@ -3535,6 +3581,7 @@ sub A {
 	my $fbat = $self->add_file($self->repo_path($m->{file_b}), $pbat,
 					undef, -1);
 	print "\tA\t$m->{file_b}\n" unless $::_q;
+        $self->apply_autoprops($file, $fbat);
 	$self->chg_file($fbat, $m);
 	$self->close_file($fbat,undef,$self->{pool});
 }







--------------040505050402090503060007--
