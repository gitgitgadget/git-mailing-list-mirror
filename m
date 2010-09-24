From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv5 12/12] gitweb: gather more remote data
Date: Fri, 24 Sep 2010 18:02:47 +0200
Message-ID: <1285344167-8518-13-git-send-email-giuseppe.bilotta@gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 24 18:05:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzAlq-0006ZY-TC
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 18:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374Ab0IXQEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 12:04:51 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40755 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932371Ab0IXQEu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 12:04:50 -0400
Received: by mail-wy0-f174.google.com with SMTP id 28so2052430wyb.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 09:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=0dvP6IBlnWyOYb+ql/w5LQBNKcb0C63oY7ozHHSmdHU=;
        b=DZuhjIELmirNDC6xc5UOrouhD8EK+6zexjHwWlcILF8+vEjQ0RWjknO+1l9dnE7uDZ
         3L6Zab0rBpzzofnpzXAoRKx1U34ri/qWRQ2VaNQoVoYyrJMKcESccWMYX37FcSv8WLea
         ocTK4Fd+wobWX1KKQieKoVekjB8OjxvMb0XEw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oltiQXqtMKIuS7r9Xsbz1WcM0I+w0dFGHI7NVeVIrh2YjtZ95VqmvIEea9Y2EFYHQk
         79oPnV1VsLSECcikgUbB3de7eBzqWhIVMdGaFZrs0rsks9eiG4sd8E5wKG8+pT3PVbPT
         1SekITIMJFONK3FBB++d7zkng8O/AixblSUCI=
Received: by 10.216.71.206 with SMTP id r56mr9637234wed.29.1285344289598;
        Fri, 24 Sep 2010 09:04:49 -0700 (PDT)
Received: from localhost ([151.60.177.109])
        by mx.google.com with ESMTPS id w14sm1435730weq.9.2010.09.24.09.04.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 09:04:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.68.g6ec8
In-Reply-To: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157011>

Collect remote information by gathering the list of remotes, and then
the URL(s) and heads in each remote. In summary view, limit the number
of remotes for which we collect data, as well as the maximum number of
heads per remote that we display.

If the number of remotes is higher than the prescribed limit, do not
collect any heads information and just show the remotes names and the
links to the corresponding fetch and push URLs. Otherwise, create a
group for each remote and display all the information there.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |  171 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 153 insertions(+), 18 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 93017a4..1e671ff 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2758,6 +2758,57 @@ sub git_get_last_activity {
 	return (undef, undef);
 }
 
+# Return an array with: a hash of remote names mapping to the corresponding
+# remote heads, the value of the $limit parameter, and a boolean indicating
+# whether we managed to get all the remotes or not.
+# If $limit is specified and the number of heads found is higher, the head
+# list is empy. Additional filtering on the number of heads can be done when
+# displaying the remotes.
+sub git_get_remotes_data {
+	my ($limit, $wanted) = @_;
+	my %remotes;
+	open my $fd, '-|' , git_cmd(), 'remote', '-v';
+	return unless $fd;
+	my $more = 1;
+	while (my $remote = <$fd> and $more) {
+		chomp $remote;
+		$remote =~ s!\t(.*?)\s+\((\w+)\)$!!;
+		next if $wanted and not $remote eq $wanted;
+		my $url = $1;
+		my $key = $2;
+
+		# a remote may appear more than once because of multiple URLs,
+		# so if this is a remote we know already, be sure to continue,
+		# lest we end up with a remote for which we get the fetch URL
+		# bot not the push URL, for example
+		$more = exists $remotes{$remote};
+		$more ||= defined $limit ? (keys(%remotes) < $limit) : 1;
+		if ($more) {
+			$remotes{$remote} ||= { 'heads' => () };
+			$remotes{$remote}{$key} = $url;
+		}
+	}
+	close $fd or return;
+
+	# if the while finished with $more being true, it means we ran
+	# out of remotes before we hit $limit; paradoxically, it being true out
+	# of the loop means there are 'no more' remotes.
+	# Rather than waste time renaming the variable, we just read it to
+	# answer the question: "did we get all remotes before we hit
+	# the limit?"
+	if ($more) {
+		my @heads = map { "remotes/$_" } keys %remotes;
+		my @remoteheads = git_get_heads_list(undef, @heads);
+		foreach (keys %remotes) {
+			my $remote = $_;
+			$remotes{$remote}{'heads'} = [ grep {
+				$_->{'name'} =~ s!^$remote/!!
+			} @remoteheads ];
+		}
+	}
+	return (\%remotes, $limit, $more);
+}
+
 sub git_get_references {
 	my $type = shift || "";
 	my %refs;
@@ -5018,6 +5069,93 @@ sub git_heads_body {
 	print "</table>\n";
 }
 
+# Display a single remote block
+sub git_remote_body {
+	my ($remote, $rdata, $limit, $head, $single) = @_;
+	my %rdata = %{$rdata};
+	my $heads = $rdata{'heads'};
+
+	my $fetch = $rdata{'fetch'};
+	my $push = $rdata{'push'};
+
+	my $urls = "<table class=\"projects_list\">\n" ;
+
+	if (defined $fetch) {
+		if ($fetch eq $push) {
+			$urls .= git_repo_url("URL", $fetch);
+		} else {
+			$urls .= git_repo_url("Fetch URL", $fetch);
+			$urls .= git_repo_url("Push URL", $push) if defined $push;
+		}
+	} elsif (defined $push) {
+		$urls .= git_repo_url("Push URL", $push);
+	} else {
+		$urls .= git_repo_url("", "No remote URL");
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
+	my $content = sub {
+		print $urls;
+		git_heads_body($heads, $head, 0, $maxheads, $dots);
+	};
+
+	if (defined $single and $single) {
+		$content->();
+	} else {
+		git_group("remotes", $remote, "remotes", $remote, $remote, $content);
+	}
+}
+
+# Display remote heads grouped by remote, unless there are too many
+# remotes ($have_all is false), in which case we only display the remote
+# names
+sub git_remotes_body {
+	my ($remotelist, $limit, $have_all, $head) = @_;
+	my %remotes = %$remotelist;
+	if ($have_all) {
+		while (my ($remote, $rdata) = each %remotes) {
+			git_remote_body($remote, $rdata, $limit, $head);
+		}
+	} else {
+		print "<table class=\"heads\">\n";
+		my $alternate = 1;
+		while (my ($remote, $rdata) = each (%$remotelist)) {
+			my $fetch = $rdata->{'fetch'};
+			my $push = $rdata->{'push'};
+			if ($alternate) {
+				print "<tr class=\"dark\">\n";
+			} else {
+				print "<tr class=\"light\">\n";
+			}
+			$alternate ^= 1;
+			print "<td>" .
+			      $cgi->a({-href=> href(action=>'remotes', hash=>$remote),
+			               -class=> "list name"},esc_html($remote)) . "</td>";
+			print "<td class=\"link\">" .
+			      (defined $fetch ? $cgi->a({-href=> $fetch}, "fetch") : "fetch") .
+			      " | " .
+			      (defined $push ? $cgi->a({-href=> $push}, "push") : "push") .
+			      "</td>";
+
+			print "</tr>\n";
+		}
+		print "<tr>\n" .
+		      "<td colspan=\"3\">" .
+		      $cgi->a({-href => href(action=>"remotes")}, "...") .
+		      "</td>\n" . "</tr>\n";
+		print "</table>";
+	}
+}
+
 sub git_search_grep_body {
 	my ($commitlist, $from, $to, $extra) = @_;
 	$from = 0 unless defined $from;
@@ -5164,7 +5302,7 @@ sub git_summary {
 	# there are more ...
 	my @taglist  = git_get_tags_list(16);
 	my @headlist = git_get_heads_list(16, 'heads');
-	my @remotelist = $remote_heads ? git_get_heads_list(16, 'remotes') : ();
+	my @remotelist = $remote_heads ? git_get_remotes_data(16) : ();
 	my @forklist;
 	my $check_forks = gitweb_check_feature('forks');
 
@@ -5244,9 +5382,7 @@ sub git_summary {
 
 	if (@remotelist) {
 		git_print_header_div('remotes');
-		git_heads_body(\@remotelist, $head, 0, 15,
-		               $#remotelist <= 15 ? undef :
-		               $cgi->a({-href => href(action=>"remotes")}, "..."));
+		git_remotes_body(@remotelist, $head);
 	}
 
 	if (@forklist) {
@@ -5570,26 +5706,25 @@ sub git_remotes {
 	my $head = git_get_head_hash($project);
 	my $remote = $input_params{'hash'};
 
+	my @remotelist = git_get_remotes_data(undef, $remote);
+	die_error(500, "Unable to get remote information") unless @remotelist;
+
+	if (keys(%{$remotelist[0]}) == 0) {
+		die_error(404, defined $remote ?
+			"Remote $remote not found" :
+			"No remotes found");
+	}
+
 	git_header_html(undef, undef, 'header_extra' => $remote);
 	git_print_page_nav('', '',  $head, undef, $head,
 		format_ref_views($remote ? '' : 'remotes'));
-	git_print_header_div('summary', $project);
 
 	if (defined $remote) {
-		# only display the heads in a given remote
-		my @headslist = map {
-			my $ref = $_ ;
-			$ref->{'name'} =~ s!^$remote/!!;
-			$ref
-		} git_get_heads_list(undef, "remotes/$remote");
-		if (@headslist) {
-			git_heads_body(\@headslist, $head);
-		}
+		git_print_header_div('remotes', "$remote remote for $project");
+		git_remote_body($remote, $remotelist[0]->{$remote}, undef, $head, 1);
 	} else {
-		my @remotelist = git_get_heads_list(undef, 'remotes');
-		if (@remotelist) {
-			git_heads_body(\@remotelist, $head);
-		}
+		git_print_header_div('summary', "$project remotes");
+		git_remotes_body(@remotelist, $head);
 	}
 	git_footer_html();
 }
-- 
1.7.3.68.g6ec8
