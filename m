From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv6 10/10] gitweb: group remote heads by remote
Date: Sun, 24 Oct 2010 12:45:36 +0200
Message-ID: <1287917136-26103-11-git-send-email-giuseppe.bilotta@gmail.com>
References: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 24 12:46:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9y5z-0004rf-UP
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 12:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932488Ab0JXKq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 06:46:28 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39237 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932465Ab0JXKq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 06:46:26 -0400
Received: by mail-ww0-f44.google.com with SMTP id 15so2499176wwe.1
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 03:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=dai2gMRJU/IOsMyhNTdtw6TzbmOkEKdilxP+WL02jOI=;
        b=gboGx9hrKN/zq+4rmyhnooeIeAB59Xk9u0eNHZM1giNAL8hMe43p6gO/fDCsz1SKmm
         46OWGV5+eWTs25ywMEkS4xseP5BpVrfMZSdVsW8+xbQ6khfrcKlNg083wiNVg1tWAK4T
         86NDJhZI8ZkZ8S6OiWvOg/1lXsbT9pHbgPTns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AjJy9mV4XRxGV3lirq1TNHpR1oQKO+4R0gxsz/Bdj4mlLiDTrdlAM/4KPQEuy7QaaP
         X4R7MTd3DLenG/jdW0BR7q8BryiWOmyDEROWdT7P3/hYDxPXSOrYr+PNbTCzy0qnhbg+
         kEU1/iB3WcNbuc3Chz3TKYUk/SaKasyb/LXzQ=
Received: by 10.227.129.146 with SMTP id o18mr3917662wbs.45.1287917185846;
        Sun, 24 Oct 2010 03:46:25 -0700 (PDT)
Received: from localhost ([151.60.176.122])
        by mx.google.com with ESMTPS id f14sm4507632wbe.20.2010.10.24.03.46.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Oct 2010 03:46:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.68.g6ec8
In-Reply-To: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159850>

In remote and summary view, display a block for each remote, with the
fetch and push URL(s) as well as the list of the remote heads.

In summary view, if the number of remotes is higher than a prescribed
limit, only display the first <limit> remotes and their fetch and push
urls, without any heads information and without grouping.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl       |  185 +++++++++++++++++++++++++++++++++++++++++-----
 gitweb/static/gitweb.css |    6 ++
 2 files changed, 172 insertions(+), 19 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index feca8bc..5f08dcc 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2772,6 +2772,66 @@ sub git_get_last_activity {
 	return (undef, undef);
 }
 
+# Returns a hash ref mapping remote names to their fetch and push URLs.
+# We return a hash ref rather than a hash so that a simple check with defined
+# can be used to tell apart the "no remotes" case from other kinds of
+# failures.
+#
+# It is possible to limit the retrieved remotes either by number
+# (specifying a -limit parameter) or by name (-wanted parameter).
+#
+# When a single remote is wanted, we cannot use 'git remote show -n' because
+# that command always work (assuming it's a remote URL if it's not defined),
+# and we cannot use 'git remote show' because that would try to make a network
+# roundtrip. So the only way to find if that particular remote is defined is to
+# walk the list provided by 'git remote -v' and stop if and when we find what
+# we want.
+sub git_get_remotes_list {
+	my %params = @_;
+	my $limit = $params{-limit};
+	my $wanted = $params{-wanted};
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
+		# a remote may appear more than once because of multiple URLs,
+		# so if this is a remote we know already, be sure to continue,
+		# lest we end up with a remote for which we get the fetch URL
+		# bot not the push URL, for example
+		my $more = exists $remotes{$remote};
+		$more ||= defined $limit ? (keys(%remotes) <= $limit) : 1;
+		if ($more) {
+			$remotes{$remote} ||= { 'heads' => () };
+			$remotes{$remote}{$key} = $url;
+		} else {
+			last;
+		}
+	}
+	close $fd or return;
+	return \%remotes;
+}
+
+# Takes a hash of remotes as first parameter and fills it by adding the
+# available remote heads for each of the indicated remotes.
+# A maximum number of heads can also be specified.
+sub git_get_remote_heads {
+	my ($remotes, $limit) = @_;
+	my @heads = map { "remotes/$_" } keys %$remotes;
+	my @remoteheads = git_get_heads_list($limit, @heads);
+	foreach (keys %$remotes) {
+		my $remote = $_;
+		$remotes->{$remote}{'heads'} = [ grep {
+			$_->{'name'} =~ s!^$remote/!!
+			} @remoteheads ];
+	}
+}
+
 sub git_get_references {
 	my $type = shift || "";
 	my %refs;
@@ -5054,6 +5114,100 @@ sub git_heads_body {
 	print "</table>\n";
 }
 
+# Display a single remote block
+sub git_remote_body {
+	my ($remote, $rdata, $limit, $head) = @_;
+
+	my $heads = $rdata->{'heads'};
+	my $fetch = $rdata->{'fetch'};
+	my $push = $rdata->{'push'};
+
+	my $urls = "<table class=\"projects_list\">\n" ;
+
+	if (defined $fetch) {
+		if ($fetch eq $push) {
+			$urls .= format_repo_url("URL", $fetch);
+		} else {
+			$urls .= format_repo_url("Fetch URL", $fetch);
+			$urls .= format_repo_url("Push URL", $push) if defined $push;
+		}
+	} elsif (defined $push) {
+		$urls .= format_repo_url("Push URL", $push);
+	} else {
+		$urls .= format_repo_url("", "No remote URL");
+	}
+
+	$urls .= "</table>\n";
+
+	my ($maxheads, $dots);
+	if (defined $limit) {
+		$maxheads = $limit - 1;
+		if ($#{$heads} > $maxheads) {
+			$dots = $cgi->a({-href => href(action=>"remotes", hash=>$remote)}, "...");
+		}
+	}
+
+	print $urls;
+	git_heads_body($heads, $head, 0, $maxheads, $dots);
+}
+
+# Display a list of remote names with the respective fetch and push URLs
+# This routine only gets called when there are more remotes than the given
+# limit, so we know that we have to append an ellipsis to the table and
+# that we have to pop one of the keys.
+sub git_remotes_list {
+	my ($remotedata) = @_;
+	print "<table class=\"heads\">\n";
+	my $alternate = 1;
+	my @keys = sort keys %$remotedata;
+	pop @keys;
+
+	while (my $remote = shift @keys) {
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
+			       -class=> "list name"},esc_html($remote)) . "</td>";
+		print "<td class=\"link\">" .
+		      (defined $fetch ? $cgi->a({-href=> $fetch}, "fetch") : "fetch") .
+		      " | " .
+		      (defined $push ? $cgi->a({-href=> $push}, "push") : "push") .
+		      "</td>";
+
+		print "</tr>\n";
+	}
+	print "<tr>\n" .
+	      "<td colspan=\"3\">" .
+	      $cgi->a({-href => href(action=>"remotes")}, "...") .
+	      "</td>\n" . "</tr>\n";
+	print "</table>";
+}
+
+# Display remote heads grouped by remote, unless there are too many
+# remotes ($have_all is false), in which case we only display the remote
+# names
+sub git_remotes_body {
+	my ($remotedata, $limit, $head) = @_;
+	if (not defined $limit or scalar keys %$remotedata <= $limit) {
+		git_get_remote_heads($remotedata, $limit);
+		while (my ($remote, $rdata) = each %$remotedata) {
+			git_print_section({-class=>"remote", -id=>$remote},
+				["remotes", $remote, $remote], sub {
+					git_remote_body($remote, $rdata, $limit, $head);
+				});
+		}
+	} else {
+		git_remotes_list($remotedata, $limit);
+	}
+}
+
 sub git_search_grep_body {
 	my ($commitlist, $from, $to, $extra) = @_;
 	$from = 0 unless defined $from;
@@ -5200,7 +5354,7 @@ sub git_summary {
 	# there are more ...
 	my @taglist  = git_get_tags_list(16);
 	my @headlist = git_get_heads_list(16, 'heads');
-	my @remotelist = $remote_heads ? git_get_heads_list(16, 'remotes') : ();
+	my $remotedata = $remote_heads ? git_get_remotes_list(-limit => 16) : undef;
 	my @forklist;
 	my $check_forks = gitweb_check_feature('forks');
 
@@ -5278,11 +5432,9 @@ sub git_summary {
 		               $cgi->a({-href => href(action=>"heads")}, "..."));
 	}
 
-	if (@remotelist) {
+	if ($remotedata) {
 		git_print_header_div('remotes');
-		git_heads_body(\@remotelist, $head, 0, 15,
-		               $#remotelist <= 15 ? undef :
-		               $cgi->a({-href => href(action=>"remotes")}, "..."));
+		git_remotes_body($remotedata, 16, $head);
 	}
 
 	if (@forklist) {
@@ -5606,31 +5758,26 @@ sub git_remotes {
 	my $head = git_get_head_hash($project);
 	my $remote = $input_params{'hash'};
 
-	my @remotelist;
+	my $remotedata = git_get_remotes_list(-wanted => $remote);
+	die_error(500, "Unable to get remote information") unless defined $remotedata;
 
-	if (defined $remote) {
-		# only display the heads in a given remote
-		@remotelist = map {
-			my $ref = $_ ;
-			$ref->{'name'} =~ s!^$remote/!!;
-			$ref
-		} git_get_heads_list(undef, "remotes/$remote");
-	} else {
-		@remotelist = git_get_heads_list(undef, 'remotes');
+	if (keys(%$remotedata) == 0) {
+		die_error(404, defined $remote ?
+			"Remote $remote not found" :
+			"No remotes found");
 	}
 
 	git_header_html(undef, undef, -action_extra => $remote);
 	git_print_page_nav('', '',  $head, undef, $head,
 		format_ref_views($remote ? '' : 'remotes'));
 
+	git_get_remote_heads($remotedata, undef);
 	if (defined $remote) {
 		git_print_header_div('remotes', "$remote remote for $project");
+		git_remote_body($remote, $remotedata->{$remote}, undef, $head);
 	} else {
 		git_print_header_div('summary', "$project remotes");
-	}
-
-	if (@remotelist) {
-		git_heads_body(\@remotelist, $head);
+		git_remotes_body($remotedata, undef $head);
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
