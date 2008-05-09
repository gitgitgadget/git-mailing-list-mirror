From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH] gitweb: Project search
Date: Fri, 9 May 2008 15:23:23 +0200
Message-ID: <200805091523.24591.jnareb@gmail.com>
References: <200805011220.58871.jnareb@gmail.com> <20080502130456.GN23672@genesis.frugalware.org> <200805031103.14960.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, "J.H." <warthog19@eaglescrag.net>,
	Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 15:24:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuSaI-0001oD-HI
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 15:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757347AbYEINXh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 09:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756947AbYEINXh
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 09:23:37 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:28492 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755595AbYEINXf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 09:23:35 -0400
Received: by nf-out-0910.google.com with SMTP id d3so636395nfc.21
        for <git@vger.kernel.org>; Fri, 09 May 2008 06:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=9ykXJeqeCFI3wHlGn6RVOToD7bEgD1coQlF0X3/Dx7M=;
        b=jg1hfdn3vMYITHoolwUPHQQ4aqFschIuU8NY2y6v6h/Zxd2ry/JShMj1dfaXy7s+d4Qb8eAeuwMloboLlkM/1+7/TPF7aTkUzkDQaVT4fnGlu7CJNOTRCyGazfD1mQhxWySedEF6xLuj8/9hPPuHuU3KLkUAZPygn3jiKz752fA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YwdQFzWU30JkoFMwYg9GySXt1raIH3+L5SCyLJZjS8rhuaG7OqGuJ7qHBBRmyZRHnpSW8xDmBieMLOb+gcl9qHnit6ePQIBt83xaZ9TZjoYT26o7J6Nx5q1OJ/LGg/RQbmf3ifEacalfbsUxQeSbB5Gax+KdSelYbr2GiRhhkJo=
Received: by 10.210.28.6 with SMTP id b6mr4320123ebb.121.1210339413723;
        Fri, 09 May 2008 06:23:33 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.232.51])
        by mx.google.com with ESMTPS id i7sm20425980nfh.8.2008.05.09.06.23.27
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 May 2008 06:23:30 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200805031103.14960.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81613>

If the number of projects is greater than some number, currently for
testing set to 1 (in production probably to 100), then projects
listing is replaced by project search form.  One can search by project
name (project path relative to $projectroot), by project description,
and by owner.  There is also link to show all projects.

Before searching by some field the information we search for must be
filled in.  For this fill_project_list_info() was enhanced to take
additional parameter which part of projects info to fill.  This way we
can limit doing expensive calculations (like running git-for-each-ref
to get 'age' / "Last changed" info) only to projects which we will
show as search results.

To make sorting by given column of project list / project search
results, the 'sort by' links in print_sort_th() subroutine are
generated as 'replay' links.

NOTE: currently match is _not_ highlighted in search results.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch depends on earlier 
  "[RFC/PATCH] gitweb: Simplify git_project_list_body"
patch, and may (but should not) depend textually on
  "[RFC/PATCH] gitweb: Allow project description in project_index file"

As this is quick'n'dirty proof-of-concept patch the styling of project
search form is done in HTML, instead of using CSS to do that.

This patch should reduce both server load and browser load for sites
with very large number of projects.

NOTE 1: in production one would increase threshold above which project
search is used instead of listing all projects.

NOTE 2: I think that for effective caching one would need to cache
data, not final output (to J.H. and Lea Wiemann).

What do you think about this concept?

 gitweb/gitweb.perl |   92 ++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 79 insertions(+), 13 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index b117364..7e1a9b4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -472,7 +472,7 @@ if (defined $page) {
 
 our $searchtype = $cgi->param('st');
 if (defined $searchtype) {
-	if ($searchtype =~ m/[^a-z]/) {
+	if ($searchtype =~ m/[^a-z_]/) {
 		die_error(undef, "Invalid searchtype parameter");
 	}
 }
@@ -3589,29 +3589,61 @@ sub git_patchset_body {
 
 # . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
 
+sub git_project_search_form {
+	my ($projlist, $searchtype, $searchtext, $search_use_regexp);
+
+	$searchtype ||= 'descr';
+	print "\n<!-- START: project_list search form -->\n" .
+	      "<div style=\"text-align: center; margin-top: 20px;\">\n";
+	print $cgi->startform(-method => 'get', -action => $my_uri) .
+	      $cgi->hidden(-name => 'a', -value => 'project_list') . "\n" .
+	      $cgi->popup_menu(-name => 'st', -default => $searchtype,
+	                       -values => ['project', 'descr', 'owner'],
+	                       -labels => {'project' => 'Project',
+	                                   'descr' => 'Description',
+	                                   'owner' => 'Owner'}) . "\n" .
+	      $cgi->textfield(-name => 's', -value => $searchtext,
+	                      -size => 60) . "\n" .
+	      "<span title=\"Extended regular expression\">" .
+	      $cgi->checkbox(-name => 'sr', -value => 1, -label => 're',
+	                     -checked => $search_use_regexp) .
+	      "</span>\n" .
+	      $cgi->submit(-name => 'btnS', -value => 'Search') .
+	      $cgi->end_form() . "\n" .
+	      $cgi->a({-href => href(project => undef, searchtype => 'list_all')},
+	              'List all projects') . "\n";
+	print "</div>\n" .
+	      "<!-- END: project_list search form -->\n\n";
+}
+
 # fills project list info (age, description, owner, forks) for each
-# project in the list, removing invalid projects from returned list
+# project in the list, removing invalid projects from returned list,
+# or fill only specified info (removing only when filling 'age')
 sub fill_project_list_info {
-	my ($projlist, $check_forks) = @_;
+	my ($projlist, $check_forks, $fill_only) = @_;
 	my @projects;
 
  PROJECT:
 	foreach my $pr (@$projlist) {
-		my (@activity) = git_get_last_activity($pr->{'path'});
-		unless (@activity) {
-			next PROJECT;
-		}
-		($pr->{'age'}, $pr->{'age_string'}) = @activity;
-		if (!defined $pr->{'descr'}) {
+		if (!exists $pr->{'age'} &&
+		    (!defined $fill_only || $fill_only eq 'age')) {
+			my (@activity) = git_get_last_activity($pr->{'path'});
+			next PROJECT unless (@activity);
+			($pr->{'age'}, $pr->{'age_string'}) = @activity;
+		}
+		if (!defined $pr->{'descr'} &&
+		    (!defined $fill_only || $fill_only eq 'descr')) {
 			my $descr = git_get_project_description($pr->{'path'}) || "";
 			$descr = to_utf8($descr);
 			$pr->{'descr_long'} = $descr;
 			$pr->{'descr'} = chop_str($descr, $projects_list_description_width, 5);
 		}
-		if (!defined $pr->{'owner'}) {
+		if (!defined $pr->{'owner'} &&
+		    (!defined $fill_only || $fill_only eq 'owner')) {
 			$pr->{'owner'} = git_get_project_owner("$pr->{'path'}") || "";
 		}
-		if ($check_forks) {
+		if ($check_forks &&
+		    (!defined $fill_only || $fill_only eq 'forks')) {
 			my $pname = $pr->{'path'};
 			if (($pname =~ s/\.git$//) &&
 			    ($pname !~ /\/$/) &&
@@ -3627,6 +3659,25 @@ sub fill_project_list_info {
 	return @projects;
 }
 
+# show only projects which match what we search for
+sub filter_project_list {
+	my ($projlist, $searchtype, $search_regexp) = @_;
+	my %keyname = (
+		'project' => 'path',
+		'descr' => 'descr_long',
+		'owner' => 'owner',
+	);
+	my $key = $keyname{$searchtype};
+
+	# fill in the field we search on
+	@$projlist = fill_project_list_info($projlist, 0, $searchtype);
+	# filter projects list
+	@$projlist = grep
+		{	$_->{$key} =~ m/$search_regexp/i; } @$projlist;
+
+	return $projlist;
+}
+
 sub print_sort_th {
 	my ($str_sort, $name, $order, $key, $header, $projlist) = @_;
 	$key    ||= $name;
@@ -3641,7 +3692,7 @@ sub print_sort_th {
 		print "<th>$header</th>\n";
 	} else {
 		print "<th>" .
-		      $cgi->a({-href => href(project=>undef, order=>$name),
+		      $cgi->a({-href => href(-replay => 1, order=>$name),
 		               -class => "header"}, $header) .
 		      "</th>\n";
 	}
@@ -4005,6 +4056,10 @@ sub git_project_list {
 	if (defined $order && $order !~ m/none|project|descr|owner|age/) {
 		die_error(undef, "Unknown order parameter");
 	}
+	if (defined $searchtype &&
+	    $searchtype !~ m/^(project|descr|owner|list_all)$/x) {
+		die_error(undef, "Unknown searchtype parameter");
+	}
 
 	my @list = git_get_projects_list();
 	if (!@list) {
@@ -4019,7 +4074,18 @@ sub git_project_list {
 		close $fd;
 		print "</div>\n";
 	}
-	git_project_list_body(\@list, $order);
+	# 'defined $searchtype' serves as "was search performed" test
+	if (@list > 1 || defined $searchtype) {
+		git_project_search_form(\@list, $searchtype,
+		                        $searchtext, $search_use_regexp);
+		if (defined $searchtype) {
+			filter_project_list(\@list, $searchtype, $search_regexp)
+				unless ($searchtype eq 'list_all');
+			git_project_list_body(\@list, $order);
+		}
+	} else {
+		git_project_list_body(\@list, $order);
+	}
 	git_footer_html();
 }
 
-- 
1.5.5
