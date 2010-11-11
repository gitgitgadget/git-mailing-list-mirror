From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv7 10/11] gitweb: group remote heads by remote
Date: Thu, 11 Nov 2010 13:26:17 +0100
Message-ID: <1289478378-15604-11-git-send-email-giuseppe.bilotta@gmail.com>
References: <1289478378-15604-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 11 13:28:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGWG0-0000sF-On
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 13:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756581Ab0KKM1C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 07:27:02 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57901 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756512Ab0KKM07 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 07:26:59 -0500
Received: by mail-ww0-f44.google.com with SMTP id 29so64691wwb.1
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 04:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=VjU8zdSvrC4oLzXI2L70TurcUfNgN1WGifsTtUs6mbA=;
        b=xw8LhWS24seGDz13pZ2M5uYuWFCjaIIqcostN/GItoEsLfSvSUAnyM74JGDkke2M45
         z8mWz7nf2Y6gA1r5e4vkGKPpSKOMofydDqSFQVCdA2dtxesEB2joTlf9KXEGjXt4GqGS
         UiNvLp3Zxskaml+4j7DKt8ZkxcxLMCr4jgdWE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oX5MpumcjsHwRUReXpc738HiD+6gRP8Nl/7U9ZSeFmXGgHfJ4ZVIsl9AHDBd6/788S
         uv+rP+LVtAKZewwrlhJK7tNAt/zWy0fQ23RELf8ABjYB/AM37otybs222vSKWKp6Mewy
         srsJeAEOisTt0quzIukAvvcpWmFUhxpHjkuC0=
Received: by 10.216.164.134 with SMTP id c6mr2199790wel.48.1289478417864;
        Thu, 11 Nov 2010 04:26:57 -0800 (PST)
Received: from localhost ([151.60.176.40])
        by mx.google.com with ESMTPS id x12sm1241211weq.18.2010.11.11.04.26.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 04:26:57 -0800 (PST)
X-Mailer: git-send-email 1.7.3.68.g6ec8
In-Reply-To: <1289478378-15604-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161240>

In remote and summary view, display a block for each remote, with the
fetch and push URL(s) as well as the list of the remote heads.

In summary view, if the number of remotes is higher than a prescribed
limit, only display the first <limit> remotes and their fetch and push
urls, without any heads information and without grouping.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl       |  173 ++++++++++++++++++++++++++++++++++++++++-----
 gitweb/static/gitweb.css |    6 ++
 2 files changed, 159 insertions(+), 20 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 64da0cc..8df4a00 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2772,6 +2772,50 @@ sub git_get_last_activity {
 	return (undef, undef);
 }
 
+# Returns a hash ref mapping remote names to their fetch and push URLs.
+# We return a hash ref rather than a hash so that a simple check with defined
+# can be used to tell apart the "no remotes" case from other kinds of
+# failures. The mapping can be restriced to a single remote by specifying its
+# name as optional parameter to the call.
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
@@ -5051,6 +5095,102 @@ sub git_heads_body {
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
+# remotes ($have_all is false), in which case we only display the remote
+# names
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
@@ -5197,7 +5337,7 @@ sub git_summary {
 	# there are more ...
 	my @taglist  = git_get_tags_list(16);
 	my @headlist = git_get_heads_list(16);
-	my @remotelist = $remote_heads ? git_get_heads_list(16, 'remotes') : ();
+	my %remotedata = $remote_heads ? git_get_remotes_list() : ();
 	my @forklist;
 	my $check_forks = gitweb_check_feature('forks');
 
@@ -5275,11 +5415,9 @@ sub git_summary {
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
@@ -5596,6 +5734,7 @@ sub git_heads {
 	git_footer_html();
 }
 
+# used both for single remote view and for list of all the remotes
 sub git_remotes {
 	gitweb_check_feature('remote_heads')
 		or die_error(403, "Remote heads view is disabled");
@@ -5603,32 +5742,26 @@ sub git_remotes {
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
