From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Support for snapshot
Date: Sat, 19 Aug 2006 03:51:16 -0700
Message-ID: <7virkp3snv.fsf@assigned-by-dhcp.cox.net>
References: <44E54AC6.9010600@gmail.com>
	<20060818195148.66411.qmail@web31807.mail.mud.yahoo.com>
	<7v64gp7prk.fsf@assigned-by-dhcp.cox.net>
	<cc723f590608190110t68e6de8etbf6b5b002fd83ca1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Luben Tuikov" <ltuikov@yahoo.com>, git@vger.kernel.org,
	"jakub narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 19 12:51:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEOQE-0007Hx-9s
	for gcvg-git@gmane.org; Sat, 19 Aug 2006 12:51:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbWHSKvT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Aug 2006 06:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbWHSKvT
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Aug 2006 06:51:19 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:6608 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751280AbWHSKvS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Aug 2006 06:51:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060819105117.PJJL29796.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 19 Aug 2006 06:51:17 -0400
To: "Aneesh Kumar" <aneesh.kumar@gmail.com>
In-Reply-To: <cc723f590608190110t68e6de8etbf6b5b002fd83ca1@mail.gmail.com>
	(Aneesh Kumar's message of "Sat, 19 Aug 2006 13:40:31 +0530")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25712>

What I had in mind is more like this.

 * The global hash %feature defines optional features that site
   administrator can enable (or allow repo-owners to enable).
   The hash is keyed with feature name.

 * The value of the hash is an array whose first two elements
   are a sub and a bool, and the rest of the elements are the
   default values of feature specific parameters.

 * The bool tells gitweb_check_feature if the feature is
   overridable per repository, and the sub is called with the
   rest of elements in the array only when it is overridable.
   The sub should read from the repository config and if the
   values are satisfactory return them; otherwise it should
   throw back the default parameters.

 * When you want to know if a feature with enabled (and with
   what option), you call gitweb_check_feature with the feature
   name.  It will return either the default parameters for the
   feature, or the parameters overridden by the repository.

In the example, I do not allow overriding the setting of
'blame', so calling gitweb_check_feature('blame') would always
return 0 (because the third element of the feature array is that
value).

If you want to allow repositories to override, you put true
value as the second member; then repositories that define their
own gitweb.blame can override the default.

The patch demonstrates the use of overridable configuration;
gitweb.snapshot can be left undefined (to get site-wide
default), or defined to be 'none' (to disable it for the
repository even when site-wide default allows it), or 'gzip', or
'bzip2'.

While I was at it, I got rid of git_get_project_config_bool()
which was poorly designed.  It did not understand various ways
you can spell true and false, and did not distinguish between
defining a variable to false and not having any definition for
the variable.

I did this patch as a demonstration of the overall framework, so
minor details of feature_xxx implementation might be wrong.
Obviously patch is not tested.

But personally, this patch makes things a bit easier to read
(but I am biased -- I wrote it).

---
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f8d1036..af8867e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -67,6 +67,51 @@ # file to use for guessing MIME types be
 # (relative to the current git repository)
 our $mimetypes_file = undef;
 
+################################################################
+# Feature configuration.
+# These subs are only called when per repository
+# overrides are allowed.  They take the default options,
+# inspect the repository and return the values from there if
+# the repository wants to override the system default.
+
+sub feature_blame {
+	my ($val) = git_get_project_config('blame', '--bool');
+	if ($val eq 'true') { return 1; }
+	elsif ($val eq 'false') { return 0; }
+
+	return $_[0];
+}
+
+sub feature_snapshot {
+	my ($ctype, $suffix, $command) = @_;
+	my ($val) = git_get_project_config('snapshot');
+	if ($val eq 'gzip') { return ('gzip', 'gz'); }
+	elsif ($val eq 'bzip2') { return ('bzip2', 'bz2'); }
+	elsif ($val eq 'none') { return (); }
+
+	return ($ctype, $suffix, $command);
+}
+
+# You define site-wide feature defaults here; override them with
+# $GITWEB_CONFIG as necessary.
+our %feature = 
+(
+	# feature	=> [feature-sub, allow-override, default options...]
+
+	'blame'		=> [\&feature_blame, 0, 0],
+ 	'snapshot'	=> [\&feature_snapshot, 0, 'x-gzip', 'gz', 'gzip'],
+);
+
+sub gitweb_check_feature {
+	my ($name) = @_;
+	return undef unless exists $feature{$name};
+	my ($sub, $override, @defaults) = @{$feature{$name}};
+	if (!$override) { return @defaults; }
+	return $sub->(@defaults);
+}
+
+################################################################
+
 our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
 require $GITWEB_CONFIG if -e $GITWEB_CONFIG;
 
@@ -485,24 +530,19 @@ sub git_get_type {
 }
 
 sub git_get_project_config {
-	my $key = shift;
+	my ($key, $type) = @_;
 
 	return unless ($key);
 	$key =~ s/^gitweb\.//;
 	return if ($key =~ m/\W/);
 
-	my $val = qx($GIT repo-config --get gitweb.$key);
+	my @x = ($GIT, 'repo-config', '--get');
+	if (defined $type) { push @x, $type; }
+	push @x, "gitweb.$key";
+	my $val = qx(@x);
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
@@ -1397,7 +1437,10 @@ sub git_difftree_body {
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
 
@@ -1858,7 +1901,10 @@ sub git_tag {
 sub git_blame2 {
 	my $fd;
 	my $ftype;
-	die_error(undef, "Permission denied") if (!git_get_project_config_bool ('blame'));
+
+	if (!gitweb_check_feature('blame')) {
+		die_error(undef, "Permission denied");
+	}
 	die_error('404 Not Found', "File name not defined") if (!$file_name);
 	$hash_base ||= git_get_head_hash($project);
 	die_error(undef, "Couldn't find base commit") unless ($hash_base);
@@ -1916,7 +1962,10 @@ sub git_blame2 {
 
 sub git_blame {
 	my $fd;
-	die_error('403 Permission denied', "Permission denied") if (!git_get_project_config_bool ('blame'));
+
+	if (!gitweb_check_feature('blame')) {
+		die_error(undef, "Permission denied");
+	}
 	die_error('404 Not Found', "File name not defined") if (!$file_name);
 	$hash_base ||= git_get_head_hash($project);
 	die_error(undef, "Couldn't find base commit") unless ($hash_base);
@@ -2195,25 +2244,31 @@ sub git_tree {
 
 sub git_snapshot {
 
+	my ($ctype, $suffix, $command) = gitweb_check_feature('snapshot');
+	my $have_snapshot = (defined $ctype && defined $suffix);
+	if (!$have_snapshot) {
+		die_error(undef, "Permission denied");
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
