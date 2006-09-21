From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH] gitweb: Add committags support
Date: Thu, 21 Sep 2006 23:56:31 +0200
Message-ID: <200609212356.31806.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Sham Chukoury <eleusis@xmms.org>
X-From: git-owner@vger.kernel.org Thu Sep 21 23:57:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQWXt-0003EQ-Gf
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 23:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751637AbWIUV4c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 17:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751641AbWIUV4c
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 17:56:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:1317 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751627AbWIUV42 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 17:56:28 -0400
Received: by ug-out-1314.google.com with SMTP id o38so183600ugd
        for <git@vger.kernel.org>; Thu, 21 Sep 2006 14:56:27 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JHBSFPQp1iXKTufCNvNq1D149/tiHSp5v9CYFMtAeJfKv7O38UFsT/SGHQs74aDYbvDk25PX7xpN+U91jsgqXP98qD5y54Pq7R76ZlStEM+qGmtV9kkBrJ4SnzLPxE8k4UUtij+Y5CZpwyyO2iMCSH18WmNzTbMrY+VHo9ZDuVQ=
Received: by 10.67.100.12 with SMTP id c12mr9742568ugm;
        Thu, 21 Sep 2006 14:56:27 -0700 (PDT)
Received: from host-81-190-26-109.torun.mm.pl ( [81.190.26.109])
        by mx.gmail.com with ESMTP id m4sm1079423ugc.2006.09.21.14.56.25;
        Thu, 21 Sep 2006 14:56:26 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27504>

Below there is preliminary (hence RFC) committag support for gitweb,
based on the idea introduced by Sham Chukoury to gitweb-xmms2.

The code has all the possible committags I could think of enabled;
not all are tested, though. This includes existing commitsha tag
support (full sha links to commit view, is sha is sha of commit),
mantis bug and feature tags from gitweb-xmms2 (there is no release
committag of gitweb-xmms2, but it should be fairly easy to add it),
bugzilla committag for the Linux kernel, plain text URL committag
(probably doesn't work that well, marking as links examples, and
sometimes protocol specification), and Message-Id committag via
GMane git mailing list (and not only) archive -- not tested.

Comments? Discussion?

This patch is rather not for inclusion; it is not in format-patch form.

P.S. I've corrected git_get_type for comparison
  git_get_type($hash) eq "commit"
to work without Perl syntax errors.

-- >8 --

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7ed963c..5eb0dd0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -173,6 +173,118 @@ sub feature_pickaxe {
 	return ($_[0]);
 }
 
+# You define site-wide comittags defaults here; override them with
+# $GITWEB_CONFIG as necessary.
+our %committags = (
+	# 'committag' => {
+	# 	'pattern' => regexp (use 'qr' quote-like operator)
+	# 	'sub' => committag-sub (subroutine),
+	# 	'enabled' => is given committag enabled,
+	# fields below can be defined, but don't need to
+	# 	'options' => [ default options...] (array reference),
+	# 	'insubject' => should given committag be enabled in commit/tag subject,
+	# 	'islink' => if the result is hyperlink,
+	# }
+	#
+	# You should ensure that enabled committags cannot overlap
+	#
+	# The committag subroutine is called with match for pattern,
+	# and options if they are defined. Match is replaced by return
+	# value of committag-sub.
+
+	'commitsha' => {
+		'pattern' => qr/[0-9a-fA-F]{40}/,
+		'enabled' => 1,
+		'islink'  => 1,
+		'sub' => \&tag_commit_id},
+
+	'mantis' => {
+		'pattern' => qr/(BUG|FEATURE)\(\d+\)/,
+		'enabled' => 1,
+		'insubject' => 1,
+		'islink' => 1,
+		'options' => [ 'http://bugs.xmms2.xmms.se/view.php?id=' ],
+		'sub' => \&tag_bugtracker},
+
+	'bugzilla' => {
+		'pattern' => qr/bug(&nbsp;)+\(\d+\)/,
+		'enabled' => 1,
+		'insubject' => 1,
+		'islink' => 1,
+		'options' => [ 'http://bugzilla.kernel.org/show_bug.cgi?id=' ],
+		'sub' => \&tag_bugtracker},
+
+	'URL' => {
+		'pattern' => qr!(http|ftp)s?://[a-zA-Z0-9_%./]+!,
+		'enabled' => 1,
+		'islink' => 1,
+		'sub' => \&tag_url},
+
+	'message_id' => {
+		'pattern' => qr/(message|msg)[- ]?id&nbsp;&lt;([^&]*)&rt;/i,
+		'enabled' => 1,
+		'options' => [
+			'http://news.gmane.org/find-root.php?message_id=',
+			\&quote_msgid_gmane ],
+		'sub' => \&tag_msgid},
+);
+
+sub tag_commit_id {
+	my $hash_text = shift;
+
+	if (git_get_type($hash_text) eq "commit") {
+		return $cgi->a({-href => href(action=>"commit", hash=>$hash_text),
+		               -class => "text"}, $hash_text);
+	}
+
+	return;
+}
+
+sub tag_bugtracker {
+	my $match = shift;
+	my $URL = shift || return $match;
+	my ($issue) = $match =~ m/(\d+)/;
+
+	return $match if (!defined $issue);
+
+	return $cgi->a({-href => "$URL$issue"}, $match);
+}
+
+sub tag_url {
+	my $url_text = shift;
+
+	return $cgi->a({-href => $url_text}, $url_text);
+}
+
+sub quote_msgid_gmane {
+	my $msgid = shift || return;
+
+	return '<'.(quotemeta $msgid).'>';
+}
+
+sub quote_msgid_marc {
+	my $msgid = shift || return;
+	my ($user, $host) = split(/\@/, $msgid, 2);
+	$host =~ s/\./ ! /g;
+
+	return $user.' () '.$host;
+}
+
+
+sub tag_msgid {
+	my $text = shift;
+	my $URL = shift || return $text;
+	my $repl = shift;
+
+	my ($msgid) =~ m/&lt;([^&]*)&rt;/;
+	my $msgid_url = (ref($repl) eq "CODE") ? $repl->($msgid) : $msgid;
+	my $link = $cgi->a({-href => "$URL$msgid_url"}, $msgid);
+
+	$text =~ s/$msgid/$link/;
+
+	return $text;
+}
+
 # rename detection options for git-diff and git-diff-tree
 # - default is '-M', with the cost proportional to
 #   (number of removed files) * (number of new files).
@@ -191,6 +303,10 @@ our $git_version = qx($GIT --version) =~
 
 $projects_list ||= $projectroot;
 
+# enabled committags, and committags enabled for subject
+our @committags  = grep { $committags{$_}{'enabled'} } keys %committags;
+our @subjecttags = grep { $committags{$_}{'insubject'} } @committags;
+
 # ======================================================================
 # input validation and dispatch
 our $action = $cgi->param('a');
@@ -577,18 +693,43 @@ ## which don't beling to other sections
 # format line of commit message or tag comment
 sub format_log_line_html {
 	my $line = shift;
+	my @tags = @_;
+	my $a_attr;
+	my %subst;
+
+	if (!@tags) {
+		@tags = @committags;
+	} else {
+		$a_attr = ref($tags[0]) eq "HASH" ? shift @tags : undef;
+	}
 
 	$line = esc_html($line);
 	$line =~ s/ /&nbsp;/g;
-	if ($line =~ m/([0-9a-fA-F]{40})/) {
-		my $hash_text = $1;
-		if (git_get_type($hash_text) eq "commit") {
-			my $link =
-				$cgi->a({-href => href(action=>"commit", hash=>$hash_text),
-				        -class => "text"}, $hash_text);
-			$line =~ s/$hash_text/$link/;
+
+	foreach my $ct (@tags) {
+		next unless exists $committags{$ct};
+		my $wrap = $a_attr && %$a_attr && $committags{$ct}{'islink'};
+		my @opts =
+			exists $committags{$ct}{'options'} ?
+			@{$committags{$ct}{'options'}} :
+			();
+
+		while ($line =~ m/($committags{$ct}{'pattern'})/gc) {
+			my $match = $1;
+			my $repl = $committags{$ct}{'sub'}->($match, @opts);
+			next unless $repl;
+
+			if ($wrap) {
+				$repl = $cgi->end_a() . $repl . $cgi->start_a($a_attr);
+			}
+
+			$subst{quotemeta $match} = $repl;
 		}
 	}
+
+	while (my ($from, $to) = each %subst) {
+		$line =~ s/$from/$to/g;
+	}
 	return $line;
 }
 
@@ -626,12 +767,13 @@ sub format_subject_html {
 	$extra = '' unless defined($extra);
 
 	if (length($short) < length($long)) {
-		return $cgi->a({-href => $href, -class => "list subject",
-		                -title => $long},
-		       esc_html($short) . $extra);
+		my $a_attr = {-href => $href, -class => "list subject", -title => $long};
+		return $cgi->a($a_attr,
+		       format_log_line_html($short, $a_attr, @subjecttags) . $extra);
 	} else {
-		return $cgi->a({-href => $href, -class => "list subject"},
-		       esc_html($long)  . $extra);
+		my $a_attr = {-href => $href, -class => "list subject"};
+		return $cgi->a($a_attr,
+		       format_log_line_html($long,  $a_attr, @subjecttags) . $extra);
 	}
 }
 
@@ -693,9 +835,9 @@ sub git_get_type {
 
 	open my $fd, "-|", git_cmd(), "cat-file", '-t', $hash or return;
 	my $type = <$fd>;
-	close $fd or return;
+	close $fd or return "unknown";
 	chomp $type;
-	return $type;
+	return ($type || "unknown");
 }
 
 sub git_get_project_config {
@@ -1585,7 +1727,7 @@ sub git_print_log ($;%) {
 			$empty = 0;
 		}
 
-		print format_log_line_html($line) . "<br/>\n";
+		print format_log_line_html($line, @committags) . "<br/>\n";
 	}
 
 	if ($opts{'-final_empty_line'}) {
