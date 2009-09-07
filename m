From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Add 'show-sizes' feature to show blob sizes in tree
	view
Date: Mon, 07 Sep 2009 14:40:00 +0200
Message-ID: <20090907123917.28597.11284.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 07 14:40:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkdWV-0002Gd-8h
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 14:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbZIGMk3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 08:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752211AbZIGMk3
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 08:40:29 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:41009 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659AbZIGMk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 08:40:28 -0400
Received: by bwz19 with SMTP id 19so1543760bwz.37
        for <git@vger.kernel.org>; Mon, 07 Sep 2009 05:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:date
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=K5ibnLaz43tnG4fgRNtm8edfM9qsQmxXoE9JFk6dGIs=;
        b=bPjzhb1pxfUiyEAUiXIhuT0JBIVuMcWFgRTkp44Prcmr7LDbWWLHarrZ9vZ9fpomYs
         gwa7EvbYylVnoipNRMkjjEmbdiG1SRam/V6+KeBdJkY5jCtUilTEavDVwgoS6tgT93te
         muW9ZPp786ALGyF1FLZLRxwsPcYaKDTNwQAMo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=T+1i8hWHhXGYVQTWxMNeZMrj19ZDQBHsJWDPyD1dHJUY360pVciFzTcoUgD56hb7FR
         LpCU7X6oVM1FT5/4S4Dxjgcw+0BasZT+oj6qVYEST/awHriCIADsr2tsZvtou2qDJB0I
         kcdTGCtM4yHKqKaHUrgaczuT1OqiOJEPqLN1o=
Received: by 10.204.21.4 with SMTP id h4mr11996430bkb.58.1252327229555;
        Mon, 07 Sep 2009 05:40:29 -0700 (PDT)
Received: from localhost.localdomain (abwl70.neoplus.adsl.tpnet.pl [83.8.235.70])
        by mx.google.com with ESMTPS id 1sm2291410fks.5.2009.09.07.05.40.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Sep 2009 05:40:28 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n87Ce0d7028638
	for <git@vger.kernel.org>; Mon, 7 Sep 2009 14:40:10 +0200
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127925>

Add support for 'show-sizes' feature to show (in separate column,
between mode and filename) the size of blobs (files) in the 'tree'
view.  It passes '-l' option to "git ls-tree" invocation.

For the 'tree' and 'commit' (submodule) entries, '-' is shown in place
of size; for generated '..' "up directory" entry nothing is shown.

The 'show-sizes' feature is enabled by default.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
I am sorry if this patch was sent twice to git mailing list


I don't quite like 'show-sizes' as a name for this feature.  
Does anyone has any better ideas?

Not tested extensively (just that it works, and looks correct),
in particular I didn't test that having 'gitweb.showsizes' as
config variable name while 'show-sizes' as feature name works
as expected.

Previous version of this idea was presented in
  http://thread.gmane.org/gmane.comp.version-control.git/54335/focus=54334
It required to pass '-l' to 'tree' action via 'opt' (extra options)
parameter.  This one uses features mechanism.

This patch might have @extra_options passed unnecessary...

 gitweb/gitweb.css  |    6 +++++
 gitweb/gitweb.perl |   69 +++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 60 insertions(+), 15 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 8f68fe3..d60bfc1 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -341,6 +341,12 @@ td.mode {
 	font-family: monospace;
 }
 
+/* format of (optional) objects size in 'tree' view */
+td.size {
+	font-family: monospace;
+	text-align: right;
+}
+
 /* styling of diffs (patchsets): commitdiff and blobdiff views */
 div.diff.header,
 div.diff.extended_header {
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 24b2193..7b1c60e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -297,6 +297,19 @@ our %feature = (
 		'override' => 0,
 		'default' => [1]},
 
+	# Enable showing size of blobs in a 'tree' view, in a separate
+	# column, similar to what 'ls -l' does.  This cost a bit of IO.
+
+	# To disable system wide have in $GITWEB_CONFIG
+	# $feature{'show-sizes'}{'default'} = [0];
+	# To have project specific config enable override in $GITWEB_CONFIG
+	# $feature{'show-sizes'}{'override'} = 1;
+	# and in project config gitweb.showsizes = 0|1;
+	'show-sizes' => {
+		'sub' => sub { feature_bool('showsizes', @_) },
+		'override' => 0,
+		'default' => [1]},
+
 	# Make gitweb use an alternative format of the URLs which can be
 	# more readable and natural-looking: project name is embedded
 	# directly in the path and the query string contains other
@@ -2764,16 +2777,31 @@ sub parse_ls_tree_line {
 	my %opts = @_;
 	my %res;
 
-	#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
-	$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t(.+)$/s;
+	if ($opts{'-l'}) {
+		#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa   16717	panic.c'
+		$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40}) +(-|[0-9]+)\t(.+)$/s;
 
-	$res{'mode'} = $1;
-	$res{'type'} = $2;
-	$res{'hash'} = $3;
-	if ($opts{'-z'}) {
-		$res{'name'} = $4;
+		$res{'mode'} = $1;
+		$res{'type'} = $2;
+		$res{'hash'} = $3;
+		$res{'size'} = $4;
+		if ($opts{'-z'}) {
+			$res{'name'} = $5;
+		} else {
+			$res{'name'} = unquote($5);
+		}
 	} else {
-		$res{'name'} = unquote($4);
+		#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
+		$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t(.+)$/s;
+
+		$res{'mode'} = $1;
+		$res{'type'} = $2;
+		$res{'hash'} = $3;
+		if ($opts{'-z'}) {
+			$res{'name'} = $4;
+		} else {
+			$res{'name'} = unquote($4);
+		}
 	}
 
 	return wantarray ? %res : \%res;
@@ -3564,6 +3592,9 @@ sub git_print_tree_entry {
 	# and link is the action links of the entry.
 
 	print "<td class=\"mode\">" . mode_str($t->{'mode'}) . "</td>\n";
+	if (exists $t->{'size'}) {
+		print "<td class=\"size\">$t->{'size'}</td>\n";
+	}
 	if ($t->{'type'} eq "blob") {
 		print "<td class=\"list\">" .
 			$cgi->a({-href => href(action=>"blob", hash=>$t->{'hash'},
@@ -3609,12 +3640,14 @@ sub git_print_tree_entry {
 	} elsif ($t->{'type'} eq "tree") {
 		print "<td class=\"list\">";
 		print $cgi->a({-href => href(action=>"tree", hash=>$t->{'hash'},
-		                             file_name=>"$basedir$t->{'name'}", %base_key)},
+		                             file_name=>"$basedir$t->{'name'}",
+		                             %base_key)},
 		              esc_path($t->{'name'}));
 		print "</td>\n";
 		print "<td class=\"link\">";
 		print $cgi->a({-href => href(action=>"tree", hash=>$t->{'hash'},
-		                             file_name=>"$basedir$t->{'name'}", %base_key)},
+		                             file_name=>"$basedir$t->{'name'}",
+		                             %base_key)},
 		              "tree");
 		if (defined $hash_base) {
 			print " | " .
@@ -5088,10 +5121,14 @@ sub git_tree {
 	}
 	die_error(404, "No such tree") unless defined($hash);
 
+	my $show_sizes = gitweb_check_feature('show-sizes');
+	my $have_blame = gitweb_check_feature('blame');
+
 	my @entries = ();
 	{
 		local $/ = "\0";
-		open my $fd, "-|", git_cmd(), "ls-tree", '-z', $hash
+		open my $fd, "-|", git_cmd(), "ls-tree", '-z',
+			($show_sizes ? '-l' : ()), @extra_options, $hash
 			or die_error(500, "Open git-ls-tree failed");
 		@entries = map { chomp; $_ } <$fd>;
 		close $fd
@@ -5102,7 +5139,6 @@ sub git_tree {
 	my $ref = format_ref_marker($refs, $hash_base);
 	git_header_html();
 	my $basedir = '';
-	my $have_blame = gitweb_check_feature('blame');
 	if (defined $hash_base && (my %co = parse_commit($hash_base))) {
 		my @views_nav = ();
 		if (defined $file_name) {
@@ -5118,7 +5154,8 @@ sub git_tree {
 			# FIXME: Should be available when we have no hash base as well.
 			push @views_nav, $snapshot_links;
 		}
-		git_print_page_nav('tree','', $hash_base, undef, undef, join(' | ', @views_nav));
+		git_print_page_nav('tree','', $hash_base, undef, undef,
+		                   join(' | ', @views_nav));
 		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash_base);
 	} else {
 		undef $hash_base;
@@ -5151,8 +5188,10 @@ sub git_tree {
 		undef $up unless $up;
 		# based on git_print_tree_entry
 		print '<td class="mode">' . mode_str('040000') . "</td>\n";
+		print '<td class="size">&nbsp;</td>'."\n" if $show_sizes;
 		print '<td class="list">';
-		print $cgi->a({-href => href(action=>"tree", hash_base=>$hash_base,
+		print $cgi->a({-href => href(action=>"tree",
+		                             hash_base=>$hash_base,
 		                             file_name=>$up)},
 		              "..");
 		print "</td>\n";
@@ -5161,7 +5200,7 @@ sub git_tree {
 		print "</tr>\n";
 	}
 	foreach my $line (@entries) {
-		my %t = parse_ls_tree_line($line, -z => 1);
+		my %t = parse_ls_tree_line($line, -z => 1, -l => $show_sizes);
 
 		if ($alternate) {
 			print "<tr class=\"dark\">\n";
