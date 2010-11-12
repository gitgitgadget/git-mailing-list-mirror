From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv7bis 10/11] gitweb: group remote heads by remote
Date: Fri, 12 Nov 2010 09:13:54 +0100
Message-ID: <1289549634-19149-1-git-send-email-giuseppe.bilotta@gmail.com>
References: <201011112025.30095.jnareb@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 12 09:14:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGoll-0007GH-F6
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 09:14:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410Ab0KLIN4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 03:13:56 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:45663 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752052Ab0KLINz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 03:13:55 -0500
Received: by wwi17 with SMTP id 17so849wwi.1
        for <git@vger.kernel.org>; Fri, 12 Nov 2010 00:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=jEhRS280CBtdlfpXoqH3G5NSZQqcMTuKfHOB6wWYJlY=;
        b=k+n4/LEq03CvQBgRwE0qIv0oFW9N9V4u/E2+cWmk8/K8zLBqpdVjNIzmLo8xg3FapX
         OhFBeToWCxmg5yRJRvWr6ndKaA+VPQq4fKDDBY//XRM5l6dgQa94f8R/vykc7HUsvmUL
         tiAhRinzHOQkjJ2lbL8JIqdq5PuyQfNpH38QQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NQep5QOTAmWA1nHyp+Tmolkuovp9GP3wu5Dinf0QgFaL7H00i5lKhAPlQf8ZxN/2cA
         h1E18ghqGwe2HPq7waOYP0VxW3VS/VsNykC9u1kaZapt76VQ6jP8v1PHNQcxquVJlW5M
         L/sKxe5lWBeEvTMSBlPNBla5vnV3UmXm/brjg=
Received: by 10.227.133.147 with SMTP id f19mr1989155wbt.71.1289549632540;
        Fri, 12 Nov 2010 00:13:52 -0800 (PST)
Received: from localhost ([151.60.176.40])
        by mx.google.com with ESMTPS id f14sm2558863wbe.14.2010.11.12.00.13.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Nov 2010 00:13:51 -0800 (PST)
X-Mailer: git-send-email 1.7.3.68.g6ec8
In-Reply-To: <201011112025.30095.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161329>

In remote and summary view, display a block for each remote, with the
fetch and push URL(s) as well as the list of the remote heads.

In summary view, if the number of remotes is higher than a prescribed
limit, only display the first <limit> remotes and their fetch and push
urls, without any heads information and without grouping.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl       |  172 ++++++++++++++++++++++++++++++++++++++++------
 gitweb/static/gitweb.css |    6 ++
 2 files changed, 158 insertions(+), 20 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 64da0cc..fc177f7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2772,6 +2772,50 @@ sub git_get_last_activity {
 	return (undef, undef);
 }
 
+# Returns a hash mapping remote names to their fetch and push URLs. In scalar
+# context, a hash ref is returned, allowing callers to tell apart the "no
+# remotes" case (ref to empty hash is returned) from other kinds of failures
+# (undef is returned). The mapping can be restriced to a single remote by
+# specifying its name as optional parameter to the call.
+#
+# Implementation note: when a single remote is wanted, we cannot use 'git
+# remote show -n' because that command always work (assuming it's a remote URL
+# if it's not defined), and we cannot use 'git remote show' because that would
+# try to make a network roundtrip. So the only way to find if that particular
+# remote is defined is to walk the list provided by 'git remote -v' and stop if
+# and when we find what we want.
+sub git_get_remotes_list {
+	my $wanted = shift;
+	my %remotes = ();
+
+	open my $fd, '-|' , git_cmd(), 'remote', '-v';
+	return unless $fd;
+	while (my $remote = <$fd>) {
+		chomp $remote;
+		$remote =~ s!\t(.*?)\s+\((\w+)\)$!!;
+		next if $wanted and not $remote eq $wanted;
+		my ($url, $key) = ($1, $2);
+
+		$remotes{$remote} ||= { 'heads' => () };
+		$remotes{$remote}{$key} = $url;
+	}
+	close $fd or return;
+	return wantarray ? %remotes : \%remotes;
+}
+
+# Takes a hash of remotes as first parameter and fills it by adding the
+# available remote heads for each of the indicated remotes.
+sub fill_remote_heads {
+	my $remotes = shift;
+	my @heads = map { "remotes/$_" } keys %$remotes;
+	my @remoteheads = git_get_heads_list(undef, @heads);
+	foreach my $remote (keys %$remotes) {
+		$remotes->{$remote}{'heads'} = [ grep {
+			$_->{'name'} =~ s!^$remote/!!
+			} @remoteheads ];
+	}
+}
+
 sub git_get_references {
 	my $type = shift || "";
 	my %refs;
@@ -5051,6 +5095,101 @@ sub git_heads_body {
 	print "</table>\n";
 }
 
+# Display a single remote block
+sub git_remote_block {
+	my ($remote, $rdata, $limit, $head) = @_;
+
+	my $heads = $rdata->{'heads'};
+	my $fetch = $rdata->{'fetch'};
+	my $push = $rdata->{'push'};
+
+	my $urls_table = "<table class=\"projects_list\">\n" ;
+
+	if (defined $fetch) {
+		if ($fetch eq $push) {
+			$urls_table .= format_repo_url("URL", $fetch);
+		} else {
+			$urls_table .= format_repo_url("Fetch URL", $fetch);
+			$urls_table .= format_repo_url("Push URL", $push) if defined $push;
+		}
+	} elsif (defined $push) {
+		$urls_table .= format_repo_url("Push URL", $push);
+	} else {
+		$urls_table .= format_repo_url("", "No remote URL");
+	}
+
+	$urls_table .= "</table>\n";
+
+	my $dots;
+	if (defined $limit && $limit < @$heads) {
+		$dots = $cgi->a({-href => href(action=>"remotes", hash=>$remote)}, "...");
+	}
+
+	print $urls_table;
+	git_heads_body($heads, $head, 0, $limit, $dots);
+}
+
+# Display a list of remote names with the respective fetch and push URLs
+sub git_remotes_list {
+	my ($remotedata, $limit) = @_;
+	print "<table class=\"heads\">\n";
+	my $alternate = 1;
+	my @remotes = sort keys %$remotedata;
+
+	my $limited = $limit && $limit < @remotes;
+
+	$#remotes = $limit - 1 if $limited;
+
+	while (my $remote = shift @remotes) {
+		my $rdata = $remotedata->{$remote};
+		my $fetch = $rdata->{'fetch'};
+		my $push = $rdata->{'push'};
+		if ($alternate) {
+			print "<tr class=\"dark\">\n";
+		} else {
+			print "<tr class=\"light\">\n";
+		}
+		$alternate ^= 1;
+		print "<td>" .
+		      $cgi->a({-href=> href(action=>'remotes', hash=>$remote),
+			       -class=> "list name"},esc_html($remote)) .
+		      "</td>";
+		print "<td class=\"link\">" .
+		      (defined $fetch ? $cgi->a({-href=> $fetch}, "fetch") : "fetch") .
+		      " | " .
+		      (defined $push ? $cgi->a({-href=> $push}, "push") : "push") .
+		      "</td>";
+
+		print "</tr>\n";
+	}
+
+	if ($limited) {
+		print "<tr>\n" .
+		      "<td colspan=\"3\">" .
+		      $cgi->a({-href => href(action=>"remotes")}, "...") .
+		      "</td>\n" . "</tr>\n";
+	}
+
+	print "</table>";
+}
+
+# Display remote heads grouped by remote, unless there are too many
+# remotes, in which case we only display the remote names
+sub git_remotes_body {
+	my ($remotedata, $limit, $head) = @_;
+	if ($limit and $limit < keys %$remotedata) {
+		git_remotes_list($remotedata, $limit);
+	} else {
+		fill_remote_heads($remotedata);
+		while (my ($remote, $rdata) = each %$remotedata) {
+			git_print_section({-class=>"remote", -id=>$remote},
+				["remotes", $remote, $remote], sub {
+					git_remote_block($remote, $rdata, $limit, $head);
+				});
+		}
+	}
+}
+
 sub git_search_grep_body {
 	my ($commitlist, $from, $to, $extra) = @_;
 	$from = 0 unless defined $from;
@@ -5197,7 +5336,7 @@ sub git_summary {
 	# there are more ...
 	my @taglist  = git_get_tags_list(16);
 	my @headlist = git_get_heads_list(16);
-	my @remotelist = $remote_heads ? git_get_heads_list(16, 'remotes') : ();
+	my %remotedata = $remote_heads ? git_get_remotes_list() : ();
 	my @forklist;
 	my $check_forks = gitweb_check_feature('forks');
 
@@ -5275,11 +5414,9 @@ sub git_summary {
 		               $cgi->a({-href => href(action=>"heads")}, "..."));
 	}
 
-	if (@remotelist) {
+	if (%remotedata) {
 		git_print_header_div('remotes');
-		git_heads_body(\@remotelist, $head, 0, 15,
-		               $#remotelist <= 15 ? undef :
-		               $cgi->a({-href => href(action=>"remotes")}, "..."));
+		git_remotes_body(\%remotedata, 15, $head);
 	}
 
 	if (@forklist) {
@@ -5596,6 +5733,7 @@ sub git_heads {
 	git_footer_html();
 }
 
+# used both for single remote view and for list of all the remotes
 sub git_remotes {
 	gitweb_check_feature('remote_heads')
 		or die_error(403, "Remote heads view is disabled");
@@ -5603,32 +5741,26 @@ sub git_remotes {
 	my $head = git_get_head_hash($project);
 	my $remote = $input_params{'hash'};
 
-	my @remotelist;
+	my $remotedata = git_get_remotes_list($remote);
+	die_error(500, "Unable to get remote information") unless defined $remotedata;
 
-	if (defined $remote) {
-		# only display the heads in a given remote, stripping the
-		# remote name which is already visible elsewhere
-		@remotelist = map {
-			my $ref = $_ ;
-			$ref->{'name'} =~ s!^$remote/!!;
-			$ref
-		} git_get_heads_list(undef, "remotes/$remote");
-	} else {
-		@remotelist = git_get_heads_list(undef, 'remotes');
+	unless (%$remotedata) {
+		die_error(404, defined $remote ?
+			"Remote $remote not found" :
+			"No remotes found");
 	}
 
 	git_header_html(undef, undef, -action_extra => $remote);
 	git_print_page_nav('', '',  $head, undef, $head,
 		format_ref_views($remote ? '' : 'remotes'));
 
+	fill_remote_heads($remotedata);
 	if (defined $remote) {
 		git_print_header_div('remotes', "$remote remote for $project");
+		git_remote_block($remote, $remotedata->{$remote}, undef, $head);
 	} else {
 		git_print_header_div('summary', "$project remotes");
-	}
-
-	if (@remotelist) {
-		git_heads_body(\@remotelist, $head);
+		git_remotes_body($remotedata, undef, $head);
 	}
 
 	git_footer_html();
diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
index 4132aab..79d7eeb 100644
--- a/gitweb/static/gitweb.css
+++ b/gitweb/static/gitweb.css
@@ -573,6 +573,12 @@ div.binary {
 	font-style: italic;
 }
 
+div.remote {
+	margin: .5em;
+	border: 1px solid #d9d8d1;
+	display: inline-block;
+}
+
 /* Style definition generated by highlight 2.4.5, http://www.andre-simon.de/ */
 
 /* Highlighting theme definition: */
-- 
1.7.3.68.g6ec8
