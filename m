From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: Re: [PATCH] gitweb: Support for snapshot
Date: Sat, 19 Aug 2006 21:47:25 +0530
Message-ID: <ec7dil$vcf$1@sea.gmane.org>
References: <44E54AC6.9010600@gmail.com>	<20060818195148.66411.qmail@web31807.mail.mud.yahoo.com>	<7v64gp7prk.fsf@assigned-by-dhcp.cox.net>	<cc723f590608190110t68e6de8etbf6b5b002fd83ca1@mail.gmail.com> <7virkp3snv.fsf@assigned-by-dhcp.cox.net> <44E71888.30104@gmail.com> <ec76rd$8qf$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020707010109050207030404"
X-From: git-owner@vger.kernel.org Sat Aug 19 18:18:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GETWq-0001B6-VT
	for gcvg-git@gmane.org; Sat, 19 Aug 2006 18:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWHSQRv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Aug 2006 12:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWHSQRv
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Aug 2006 12:17:51 -0400
Received: from main.gmane.org ([80.91.229.2]:49602 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932081AbWHSQRu (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Aug 2006 12:17:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GETW0-000125-Lv
	for git@vger.kernel.org; Sat, 19 Aug 2006 18:17:40 +0200
Received: from 59.92.132.198 ([59.92.132.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 19 Aug 2006 18:17:40 +0200
Received: from aneesh.kumar by 59.92.132.198 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 19 Aug 2006 18:17:40 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 59.92.132.198
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
In-Reply-To: <ec76rd$8qf$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25727>

This is a multi-part message in MIME format.
--------------020707010109050207030404
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Jakub Narebski wrote:
> Aneesh Kumar K.V wrote:
> 
>> I tested this and added some comments. I also fixed some code. 
>> I am attaching the full diff. 
> 
> Below comments to the patch.
> 

updated patch attached. I guess i have taken care of all your comments. 


-aneesh 

--------------020707010109050207030404
Content-Type: text/x-patch;
 name="gitweb.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gitweb.diff"

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f8d1036..e8a4a6f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -67,6 +67,68 @@ # file to use for guessing MIME types be
 # (relative to the current git repository)
 our $mimetypes_file = undef;
 
+# You define site-wide feature defaults here; override them with
+# $GITWEB_CONFIG as necessary.
+our %feature =
+(
+
+# feature  => {'sub' => feature-sub, 'override' => allow-override, 'default' => [ default options...]
+
+'blame'         => {'sub' => \&feature_blame, 'override' => 0, 'default' => [0]},
+'snapshot'      => {'sub' => \&feature_snapshot, 'override' => 0, 'default' => ['x-gzip', 'gz', 'gzip']},
+
+);
+
+sub gitweb_check_feature {
+	my ($name) = @_;
+	return undef unless exists $feature{$name};
+	my ($sub, $override, @defaults) = ($feature{$name}{'sub'},
+						$feature{$name}{'override'},
+						@{$feature{$name}{'default'}});
+	if (!$override) { return @defaults; }
+	return $sub->(@defaults);
+}
+
+# To enable system wide have in $GITWEB_CONFIG
+# $feature{'blame'}{'default'} =  [0];
+# To have project specific config enable override in  $GITWEB_CONFIG
+# $feature{'blame'}{'override'} =  1;
+# and in project config gitweb.blame = 0|1;
+
+sub feature_blame {
+	my ($val) = git_get_project_config('blame', '--bool');
+
+	if ($val eq 'true') {
+		return 1;
+	} elsif ($val eq 'false') {
+		return 0;
+	}
+
+	return $_[0];
+}
+
+# To disable system wide have in $GITWEB_CONFIG
+# $feature{'snapshot'}{'default'} =  [undef];
+# To have project specific config enable override in  $GITWEB_CONFIG
+# $feature{'blame'}{'override'} =  1;
+# and in project config  gitweb.snapshot = no|gzip|bzip2
+
+sub feature_snapshot {
+	my ($ctype, $suffix, $command) = @_;
+
+	my ($val) = git_get_project_config('snapshot');
+
+	if ($val eq 'gzip') {
+		return ('x-gzip', 'gz', 'gzip');
+	} elsif ($val eq 'bzip2') {
+		return ('x-bzip2', 'bz2', 'bzip2');
+	} elsif ($val eq 'none') {
+		return ();
+	}
+
+	return ($ctype, $suffix, $command);
+}
+
 our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
 require $GITWEB_CONFIG if -e $GITWEB_CONFIG;
 
@@ -485,24 +547,21 @@ sub git_get_type {
 }
 
 sub git_get_project_config {
-	my $key = shift;
+	my ($key, $type) = @_;
 
 	return unless ($key);
 	$key =~ s/^gitweb\.//;
 	return if ($key =~ m/\W/);
 
-	my $val = qx($GIT repo-config --get gitweb.$key);
+	my @x = ($GIT, 'repo-config');
+	if (defined $type) { push @x, $type; }
+	push @x, "--get";
+	push @x, "gitweb.$key";
+	my $val = qx(@x);
+	chomp $val;
 	return ($val);
 }
 
-sub git_get_project_config_bool {
-	my $val = git_get_project_config (@_);
-	if ($val and $val =~ m/true|yes|on/) {
-		return (1);
-	}
-	return; # implicit false
-}
-
 # get hash of given path at given ref
 sub git_get_hash_by_path {
 	my $base = shift;
@@ -1397,7 +1456,10 @@ sub git_difftree_body {
 sub git_shortlog_body {
 	# uses global variable $project
 	my ($revlist, $from, $to, $refs, $extra) = @_;
-	my $have_snapshot = git_get_project_config_bool('snapshot');
+
+	my ($ctype, $suffix, $command) = gitweb_check_feature('snapshot');
+	my $have_snapshot = (defined $ctype && defined $suffix);
+
 	$from = 0 unless defined $from;
 	$to = $#{$revlist} if (!defined $to || $#{$revlist} < $to);
 
@@ -1858,7 +1920,10 @@ sub git_tag {
 sub git_blame2 {
 	my $fd;
 	my $ftype;
-	die_error(undef, "Permission denied") if (!git_get_project_config_bool ('blame'));
+
+	if (!gitweb_check_feature('blame')) {
+		die_error('403 Permission denied', "Permission denied");
+	}
 	die_error('404 Not Found', "File name not defined") if (!$file_name);
 	$hash_base ||= git_get_head_hash($project);
 	die_error(undef, "Couldn't find base commit") unless ($hash_base);
@@ -1916,7 +1981,10 @@ sub git_blame2 {
 
 sub git_blame {
 	my $fd;
-	die_error('403 Permission denied', "Permission denied") if (!git_get_project_config_bool ('blame'));
+
+	if (!gitweb_check_feature('blame')) {
+		die_error('403 Permission denied', "Permission denied");
+	}
 	die_error('404 Not Found', "File name not defined") if (!$file_name);
 	$hash_base ||= git_get_head_hash($project);
 	die_error(undef, "Couldn't find base commit") unless ($hash_base);
@@ -2069,7 +2137,7 @@ sub git_blob {
 			die_error(undef, "No file name defined");
 		}
 	}
-	my $have_blame = git_get_project_config_bool ('blame');
+	my $have_blame = gitweb_check_feature('blame');
 	open my $fd, "-|", $GIT, "cat-file", "blob", $hash
 		or die_error(undef, "Couldn't cat $file_name, $hash");
 	my $mimetype = blob_mimetype($fd, $file_name);
@@ -2134,7 +2202,7 @@ sub git_tree {
 	git_header_html();
 	my %base_key = ();
 	my $base = "";
-	my $have_blame = git_get_project_config_bool ('blame');
+	my $have_blame = gitweb_check_feature('blame');
 	if (defined $hash_base && (my %co = parse_commit($hash_base))) {
 		$base_key{hash_base} = $hash_base;
 		git_print_page_nav('tree','', $hash_base);
@@ -2195,25 +2263,31 @@ sub git_tree {
 
 sub git_snapshot {
 
+	my ($ctype, $suffix, $command) = gitweb_check_feature('snapshot');
+	my $have_snapshot = (defined $ctype && defined $suffix);
+	if (!$have_snapshot) {
+		die_error('403 Permission denied', "Permission denied");
+	}
+
 	if (!defined $hash) {
 		$hash = git_get_head_hash($project);
 	}
 
-	my $filename = basename($project) . "-$hash.tar.gz";
+	my $filename = basename($project) . "-$hash.tar.$suffix";
 
 	print $cgi->header(-type => 'application/x-tar',
-			-content-encoding => 'x-gzip',
-			'-content-disposition' => "inline; filename=\"$filename\"",
-			-status => '200 OK');
+			   -content-encoding => $ctype,
+			   '-content-disposition' =>
+			   "inline; filename=\"$filename\"",
+			   -status => '200 OK');
 
-	open my $fd, "-|", "$GIT tar-tree $hash \'$project\' | gzip" or
-				die_error(undef, "Execute git-tar-tree failed.");
+	open my $fd, "-|", "$GIT tar-tree $hash \'$project\' | $command" or
+		die_error(undef, "Execute git-tar-tree failed.");
 	binmode STDOUT, ':raw';
 	print <$fd>;
 	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
 	close $fd;
 
-
 }
 
 sub git_log {
@@ -2293,7 +2367,10 @@ sub git_commit {
 	}
 	my $refs = git_get_references();
 	my $ref = format_ref_marker($refs, $co{'id'});
-	my $have_snapshot = git_get_project_config_bool('snapshot');
+
+	my ($ctype, $suffix, $command) = gitweb_check_feature('snapshot');
+	my $have_snapshot = (defined $ctype && defined $suffix);
+
 	my $formats_nav = '';
 	if (defined $file_name && defined $co{'parent'}) {
 		my $parent = $co{'parent'};

--------------020707010109050207030404--
