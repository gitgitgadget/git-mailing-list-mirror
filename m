From: "Bernhard R. Link" <brl+git@mail.brlink.eu>
Subject: [PATCH v4 1/2] gitweb: add project_filter to limit project list to a
 subdirectory
Date: Sun, 29 Jan 2012 17:06:15 +0100
Message-ID: <20120129160615.GA13937@server.brlink.eu>
References: <20120128165606.GA6770@server.brlink.eu>
 <m3wr8bcuon.fsf@localhost.localdomain>
 <20120129012234.GD16079@server.brlink.eu>
 <201201291354.50241.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 29 17:06:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrXGZ-0002ff-S6
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jan 2012 17:06:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240Ab2A2QGB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jan 2012 11:06:01 -0500
Received: from server.brlink.eu ([78.46.187.186]:54069 "EHLO server.brlink.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752797Ab2A2QGA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2012 11:06:00 -0500
Received: from mfs.mathematik.uni-freiburg.de ([132.230.30.170] helo=client.brlink.eu)
	by server.brlink.eu with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <brl@mail.brlink.eu>)
	id 1RrXGP-0005EM-7g; Sun, 29 Jan 2012 17:05:57 +0100
Received: from brl by client.brlink.eu with local (Exim 4.77)
	(envelope-from <brl@mail.brlink.eu>)
	id 1RrXGh-0003sX-QB; Sun, 29 Jan 2012 17:06:15 +0100
Content-Disposition: inline
In-Reply-To: <201201291354.50241.jnareb@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189290>

This commit changes the project listing views (project_list,
project_index and opml) to limit the output to only projects in a
subdirectory if the new optional parameter ?pf=directory name is used.

The change is quite minimal as git_get_projects_list already can limit
itself to a subdirectory (though that was previously only used for
'forks').

If there is a GITWEB_LIST file, the contents are just filtered like
with the forks action.

Without a GITWEB_LIST file only the given subdirectory is searched
for projects (like with forks) unless GITWEB_STRICT_EXPORT is enabled.
In the later case GITWEB_PROJECTROOT is traversed normally (unlike
with forks) and projects not in the directory ignored.
(As there is no check if the filter_path would have been found in
the usual search as the project path is checked with forks).

Reusing $project instead of adding a new parameter would have been
nicer from a UI point-of-view (including PATH_INFO support) but
would complicate the $project validating code that is currently being
used to ensure nothing is exported that should not be viewable.

Signed-off-by: Bernhard R. Link <brlink@debian.org>
---

* Jakub Narebski <jnareb@gmail.com> [120129 13:54]:
> On Sun, 29 Jan 2012, Bernhard R. Link wrote:
> Though I am not sure if this "paranoid mode" is really necessary.  I don't
> see how you could get in situation where scanning from $project_list and
> filtering with $project_filter prefix, and scanning from
> $project_list/$project_filter would give different results.
>
> I think you are overly paranoid here, but perhaps it is better to be
> overly strict, and then relax it if it turns out to be not necessary.

As far as I do understand it, this is the only (hopefully unecessary)
effect strict_export without a project_list has in gitweb, so I did not
want to remove that with this change.

> Excuse me changing my mind, but I think that as far as this patch series
> is applied as whole, it would be better for maintability to keep those
> two patches split; though put the above as a [part of] commit message
> in 2/2 patch.

Split again, though this time only the change for existing pages in the
second commit and the code duplication you spoke against removed.

 gitweb/gitweb.perl |   43 ++++++++++++++++++++++++++++++++++++-------
 1 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index abb5a79..f0e03d8 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -760,6 +760,7 @@ our @cgi_param_mapping = (
 	search_use_regexp => "sr",
 	ctag => "by_tag",
 	diff_style => "ds",
+	project_filter => "pf",
 	# this must be last entry (for manipulation from JavaScript)
 	javascript => "js"
 );
@@ -976,7 +977,7 @@ sub evaluate_path_info {
 
 our ($action, $project, $file_name, $file_parent, $hash, $hash_parent, $hash_base,
      $hash_parent_base, @extra_options, $page, $searchtype, $search_use_regexp,
-     $searchtext, $search_regexp);
+     $searchtext, $search_regexp, $project_filter);
 sub evaluate_and_validate_params {
 	our $action = $input_params{'action'};
 	if (defined $action) {
@@ -994,6 +995,13 @@ sub evaluate_and_validate_params {
 		}
 	}
 
+	our $project_filter = $input_params{'project_filter'};
+	if (defined $project_filter) {
+		if (!validate_pathname($project_filter)) {
+			die_error(404, "Invalid project_filter parameter");
+		}
+	}
+
 	our $file_name = $input_params{'file_name'};
 	if (defined $file_name) {
 		if (!validate_pathname($file_name)) {
@@ -2827,6 +2835,7 @@ sub git_get_project_url_list {
 
 sub git_get_projects_list {
 	my $filter = shift || '';
+	my $paranoid = shift;
 	my @list;
 
 	$filter =~ s/\.git$//;
@@ -2839,7 +2848,7 @@ sub git_get_projects_list {
 		my $pfxlen = length("$dir");
 		my $pfxdepth = ($dir =~ tr!/!!);
 		# when filtering, search only given subdirectory
-		if ($filter) {
+		if ($filter and not $paranoid) {
 			$dir .= "/$filter";
 			$dir =~ s!/+$!!;
 		}
@@ -2864,6 +2873,10 @@ sub git_get_projects_list {
 				}
 
 				my $path = substr($File::Find::name, $pfxlen + 1);
+				# paranoidly only filter here
+				if ($paranoid && $filter && $path !~ m!^\Q$filter\E/!) {
+					next;
+				}
 				# we check related file in $projectroot
 				if (check_export_ok("$projectroot/$path")) {
 					push @list, { path => $path };
@@ -3823,6 +3836,18 @@ sub print_header_links {
 	}
 }
 
+sub print_nav_breadcrumbs_path {
+	my $dirprefix = undef;
+	while (my $part = shift) {
+		$dirprefix .= "/" if defined $dirprefix;
+		$dirprefix .= $part;
+		print $cgi->a({-href => href(project => undef,
+		                             project_filter => $dirprefix,
+					     action=>"project_list")},
+			      esc_html($part)) . " / ";
+	}
+}
+
 sub print_nav_breadcrumbs {
 	my %opts = @_;
 
@@ -3841,6 +3866,8 @@ sub print_nav_breadcrumbs {
 			print " / $opts{-action_extra}";
 		}
 		print "\n";
+	} elsif (defined $project_filter) {
+		print_nav_breadcrumbs_path(split '/', $project_filter);
 	}
 }
 
@@ -3963,9 +3990,11 @@ sub git_footer_html {
 		}
 
 	} else {
-		print $cgi->a({-href => href(project=>undef, action=>"opml"),
+		print $cgi->a({-href => href(project=>undef, action=>"opml",
+		                             project_filter => $project_filter),
 		              -class => $feed_class}, "OPML") . " ";
-		print $cgi->a({-href => href(project=>undef, action=>"project_index"),
+		print $cgi->a({-href => href(project=>undef, action=>"project_index",
+		                             project_filter => $project_filter),
 		              -class => $feed_class}, "TXT") . "\n";
 	}
 	print "</div>\n"; # class="page_footer"
@@ -5979,7 +6008,7 @@ sub git_project_list {
 		die_error(400, "Unknown order parameter");
 	}
 
-	my @list = git_get_projects_list();
+	my @list = git_get_projects_list($project_filter, $strict_export);
 	if (!@list) {
 		die_error(404, "No projects found");
 	}
@@ -6018,7 +6047,7 @@ sub git_forks {
 }
 
 sub git_project_index {
-	my @projects = git_get_projects_list();
+	my @projects = git_get_projects_list($project_filter, $strict_export);
 	if (!@projects) {
 		die_error(404, "No projects found");
 	}
@@ -7855,7 +7884,7 @@ sub git_atom {
 }
 
 sub git_opml {
-	my @list = git_get_projects_list();
+	my @list = git_get_projects_list($project_filter, $strict_export);
 	if (!@list) {
 		die_error(404, "No projects found");
 	}
-- 
1.7.8.3
