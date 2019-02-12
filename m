Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 964BC1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 01:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfBLBXw (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 20:23:52 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34384 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726838AbfBLBXs (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Feb 2019 20:23:48 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 80A3360E5F;
        Tue, 12 Feb 2019 01:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1549934626;
        bh=3C3h/fIQfXA/AFv15A/3H8cLzP84LKw7aAbzdZ3Em+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=phxB8hqb+xT5FSqhep5XF7M76acueKI1wF+DeI3LWswg2wcbhp1t6NLg4elCxQJDt
         zWHMghYDd+Rf39euDQllX5exATNS+zlJOwp1Mj/3Gwy2tQlsFOhiWV3flDRfV8fubK
         oBL5VjrIb47F6KM9eTd3QZ2UhQ0Afo6NU+xpZj+h9isMbNsc9rFZ/m2bJiBOaa3wNa
         GNuyLScRW6KrtimnPCnW8XP10L6aeo3UQ3oeF62gdX1F6H4Rrz5tF4KAalo173Jc9a
         i3RY82Xrnicpr9nErjvLUZ6ot8lwRhG86+b1qAe+6YGQ6znrptzwcKK+YbfzFDzI3f
         lYH7ATloPI8mAMJ4a7niZrhcA+MI+SiCTdXnSN5C0IqPmL4EZCRoev5R2t5knubae8
         pe59Ju7OqRmlnv4aW/iniIbFBZVXKGbBumL4ap7+6wsZh/1N2qUj61dvJ06aK0kWWg
         thWMZrlQN5AI+6YLZ2Gir31dhk6DlsO15P4RapeMARdiy5KfbST
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 31/31] gitweb: make hash size independent
Date:   Tue, 12 Feb 2019 01:22:56 +0000
Message-Id: <20190212012256.1005924-32-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a
In-Reply-To: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
References: <20190212012256.1005924-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gitweb has several hard-coded 40 values throughout it to check for
values that are passed in or acquired from Git.  To simplify the code,
introduce a regex variable that matches either exactly 40 or exactly 64
hex characters, and use this variable anywhere we would have previously
hard-coded a 40 in a regex.

Similarly, switch the code that looks for deleted diffinfo information
to look for either 40 or 64 zeros, and update one piece of code to use
this function.  Finally, when formatting a log line, allow an
abbreviated describe output to contain up to 64 characters.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 gitweb/gitweb.perl | 63 ++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2594a4badb..aec8ca3256 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -788,6 +788,9 @@ sub check_loadavg {
 # ======================================================================
 # input validation and dispatch
 
+# A regex matching a valid object ID.
+our $oid_regex = qr/(?:[0-9a-fA-F]{40}(?:[0-9a-fA-F]{24})?)/;
+
 # input parameters can be collected from a variety of sources (presently, CGI
 # and PATH_INFO), so we define an %input_params hash that collects them all
 # together during validation: this allows subsequent uses (e.g. href()) to be
@@ -1516,7 +1519,7 @@ sub is_valid_refname {
 
 	return undef unless defined $input;
 	# textual hashes are O.K.
-	if ($input =~ m/^[0-9a-fA-F]{40}$/) {
+	if ($input =~ m/^$oid_regex$/) {
 		return 1;
 	}
 	# it must be correct pathname
@@ -2037,10 +2040,10 @@ sub format_log_line_html {
             (?<!-) # see strbuf_check_tag_ref(). Tags can't start with -
             [A-Za-z0-9.-]+
             (?!\.) # refs can't end with ".", see check_refname_format()
-            -g[0-9a-fA-F]{7,40}
+            -g[0-9a-fA-F]{7,64}
             |
             # Just a normal looking Git SHA1
-            [0-9a-fA-F]{7,40}
+            [0-9a-fA-F]{7,64}
         )
         \b
     }{
@@ -2286,7 +2289,7 @@ sub format_extended_diff_header_line {
 		         ')</span>';
 	}
 	# match <hash>
-	if ($line =~ m/^index [0-9a-fA-F]{40},[0-9a-fA-F]{40}/) {
+	if ($line =~ m/^index $oid_regex,$oid_regex/) {
 		# can match only for combined diff
 		$line = 'index ';
 		for (my $i = 0; $i < $diffinfo->{'nparents'}; $i++) {
@@ -2308,7 +2311,7 @@ sub format_extended_diff_header_line {
 			$line .= '0' x 7;
 		}
 
-	} elsif ($line =~ m/^index [0-9a-fA-F]{40}..[0-9a-fA-F]{40}/) {
+	} elsif ($line =~ m/^index $oid_regex..$oid_regex/) {
 		# can match only for ordinary diff
 		my ($from_link, $to_link);
 		if ($from->{'href'}) {
@@ -2834,7 +2837,7 @@ sub git_get_hash_by_path {
 	}
 
 	#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
-	$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t/;
+	$line =~ m/^([0-9]+) (.+) ($oid_regex)\t/;
 	if (defined $type && $type ne $2) {
 		# type doesn't match
 		return undef;
@@ -3333,7 +3336,7 @@ sub git_get_references {
 
 	while (my $line = <$fd>) {
 		chomp $line;
-		if ($line =~ m!^([0-9a-fA-F]{40})\srefs/($type.*)$!) {
+		if ($line =~ m!^($oid_regex)\srefs/($type.*)$!) {
 			if (defined $refs{$1}) {
 				push @{$refs{$1}}, $2;
 			} else {
@@ -3407,7 +3410,7 @@ sub parse_tag {
 	$tag{'id'} = $tag_id;
 	while (my $line = <$fd>) {
 		chomp $line;
-		if ($line =~ m/^object ([0-9a-fA-F]{40})$/) {
+		if ($line =~ m/^object ($oid_regex)$/) {
 			$tag{'object'} = $1;
 		} elsif ($line =~ m/^type (.+)$/) {
 			$tag{'type'} = $1;
@@ -3451,15 +3454,15 @@ sub parse_commit_text {
 	}
 
 	my $header = shift @commit_lines;
-	if ($header !~ m/^[0-9a-fA-F]{40}/) {
+	if ($header !~ m/^$oid_regex/) {
 		return;
 	}
 	($co{'id'}, my @parents) = split ' ', $header;
 	while (my $line = shift @commit_lines) {
 		last if $line eq "\n";
-		if ($line =~ m/^tree ([0-9a-fA-F]{40})$/) {
+		if ($line =~ m/^tree ($oid_regex)$/) {
 			$co{'tree'} = $1;
-		} elsif ((!defined $withparents) && ($line =~ m/^parent ([0-9a-fA-F]{40})$/)) {
+		} elsif ((!defined $withparents) && ($line =~ m/^parent ($oid_regex)$/)) {
 			push @parents, $1;
 		} elsif ($line =~ m/^author (.*) ([0-9]+) (.*)$/) {
 			$co{'author'} = to_utf8($1);
@@ -3591,7 +3594,7 @@ sub parse_difftree_raw_line {
 
 	# ':100644 100644 03b218260e99b78c6df0ed378e59ed9205ccc96d 3b93d5e7cc7f7dd4ebed13a5cc1a4ad976fc94d8 M	ls-files.c'
 	# ':100644 100644 7f9281985086971d3877aca27704f2aaf9c448ce bc190ebc71bbd923f2b728e505408f5e54bd073a M	rev-tree.c'
-	if ($line =~ m/^:([0-7]{6}) ([0-7]{6}) ([0-9a-fA-F]{40}) ([0-9a-fA-F]{40}) (.)([0-9]{0,3})\t(.*)$/) {
+	if ($line =~ m/^:([0-7]{6}) ([0-7]{6}) ($oid_regex) ($oid_regex) (.)([0-9]{0,3})\t(.*)$/) {
 		$res{'from_mode'} = $1;
 		$res{'to_mode'} = $2;
 		$res{'from_id'} = $3;
@@ -3606,7 +3609,7 @@ sub parse_difftree_raw_line {
 	}
 	# '::100755 100755 100755 60e79ca1b01bc8b057abe17ddab484699a7f5fdb 94067cc5f73388f33722d52ae02f44692bc07490 94067cc5f73388f33722d52ae02f44692bc07490 MR	git-gui/git-gui.sh'
 	# combined diff (for merge commit)
-	elsif ($line =~ s/^(::+)((?:[0-7]{6} )+)((?:[0-9a-fA-F]{40} )+)([a-zA-Z]+)\t(.*)$//) {
+	elsif ($line =~ s/^(::+)((?:[0-7]{6} )+)((?:$oid_regex )+)([a-zA-Z]+)\t(.*)$//) {
 		$res{'nparents'}  = length($1);
 		$res{'from_mode'} = [ split(' ', $2) ];
 		$res{'to_mode'} = pop @{$res{'from_mode'}};
@@ -3616,7 +3619,7 @@ sub parse_difftree_raw_line {
 		$res{'to_file'} = unquote($5);
 	}
 	# 'c512b523472485aef4fff9e57b229d9d243c967f'
-	elsif ($line =~ m/^([0-9a-fA-F]{40})$/) {
+	elsif ($line =~ m/^($oid_regex)$/) {
 		$res{'commit'} = $1;
 	}
 
@@ -3644,7 +3647,7 @@ sub parse_ls_tree_line {
 
 	if ($opts{'-l'}) {
 		#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa   16717	panic.c'
-		$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40}) +(-|[0-9]+)\t(.+)$/s;
+		$line =~ m/^([0-9]+) (.+) ($oid_regex) +(-|[0-9]+)\t(.+)$/s;
 
 		$res{'mode'} = $1;
 		$res{'type'} = $2;
@@ -3657,7 +3660,7 @@ sub parse_ls_tree_line {
 		}
 	} else {
 		#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
-		$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t(.+)$/s;
+		$line =~ m/^([0-9]+) (.+) ($oid_regex)\t(.+)$/s;
 
 		$res{'mode'} = $1;
 		$res{'type'} = $2;
@@ -4799,7 +4802,7 @@ sub fill_from_file_info {
 sub is_deleted {
 	my $diffinfo = shift;
 
-	return $diffinfo->{'to_id'} eq ('0' x 40);
+	return $diffinfo->{'to_id'} eq ('0' x 40) || $diffinfo->{'to_id'} eq ('0' x 64);
 }
 
 # does patch correspond to [previous] difftree raw line
@@ -6285,7 +6288,7 @@ sub git_search_changes {
 			              -class => "list subject"},
 			              chop_and_escape_str($co{'title'}, 50) . "<br/>");
 		} elsif (defined $set{'to_id'}) {
-			next if ($set{'to_id'} =~ m/^0{40}$/);
+			next if is_deleted(\%set);
 
 			print $cgi->a({-href => href(action=>"blob", hash_base=>$co{'id'},
 			                             hash=>$set{'to_id'}, file_name=>$set{'to_file'}),
@@ -6829,7 +6832,7 @@ sub git_blame_common {
 			# the header: <SHA-1> <src lineno> <dst lineno> [<lines in group>]
 			# no <lines in group> for subsequent lines in group of lines
 			my ($full_rev, $orig_lineno, $lineno, $group_size) =
-			   ($line =~ /^([0-9a-f]{40}) (\d+) (\d+)(?: (\d+))?$/);
+			   ($line =~ /^($oid_regex) (\d+) (\d+)(?: (\d+))?$/);
 			if (!exists $metainfo{$full_rev}) {
 				$metainfo{$full_rev} = { 'nprevious' => 0 };
 			}
@@ -6879,7 +6882,7 @@ sub git_blame_common {
 			}
 			# 'previous' <sha1 of parent commit> <filename at commit>
 			if (exists $meta->{'previous'} &&
-			    $meta->{'previous'} =~ /^([a-fA-F0-9]{40}) (.*)$/) {
+			    $meta->{'previous'} =~ /^($oid_regex) (.*)$/) {
 				$meta->{'parent'} = $1;
 				$meta->{'file_parent'} = unquote($2);
 			}
@@ -6996,7 +6999,7 @@ sub git_blob_plain {
 		} else {
 			die_error(400, "No file name defined");
 		}
-	} elsif ($hash =~ m/^[0-9a-fA-F]{40}$/) {
+	} elsif ($hash =~ m/^$oid_regex$/) {
 		# blobs defined by non-textual hash id's can be cached
 		$expires = "+1d";
 	}
@@ -7057,7 +7060,7 @@ sub git_blob {
 		} else {
 			die_error(400, "No file name defined");
 		}
-	} elsif ($hash =~ m/^[0-9a-fA-F]{40}$/) {
+	} elsif ($hash =~ m/^$oid_regex$/) {
 		# blobs defined by non-textual hash id's can be cached
 		$expires = "+1d";
 	}
@@ -7515,7 +7518,7 @@ sub git_commit {
 
 	# non-textual hash id's can be cached
 	my $expires;
-	if ($hash =~ m/^[0-9a-fA-F]{40}$/) {
+	if ($hash =~ m/^$oid_regex$/) {
 		$expires = "+1d";
 	}
 	my $refs = git_get_references();
@@ -7609,7 +7612,7 @@ sub git_object {
 		close $fd;
 
 		#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
-		unless ($line && $line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t/) {
+		unless ($line && $line =~ m/^([0-9]+) (.+) ($oid_regex)\t/) {
 			die_error(404, "File or directory for given base does not exist");
 		}
 		$type = $2;
@@ -7649,7 +7652,7 @@ sub git_blobdiff {
 				or die_error(404, "Blob diff not found");
 
 		} elsif (defined $hash &&
-		         $hash =~ /[0-9a-fA-F]{40}/) {
+		         $hash =~ $oid_regex) {
 			# try to find filename from $hash
 
 			# read filtered raw output
@@ -7659,7 +7662,7 @@ sub git_blobdiff {
 			@difftree =
 				# ':100644 100644 03b21826... 3b93d5e7... M	ls-files.c'
 				# $hash == to_id
-				grep { /^:[0-7]{6} [0-7]{6} [0-9a-fA-F]{40} $hash/ }
+				grep { /^:[0-7]{6} [0-7]{6} $oid_regex $hash/ }
 				map { chomp; $_ } <$fd>;
 			close $fd
 				or die_error(404, "Reading git-diff-tree failed");
@@ -7682,8 +7685,8 @@ sub git_blobdiff {
 		$hash        ||= $diffinfo{'to_id'};
 
 		# non-textual hash id's can be cached
-		if ($hash_base =~ m/^[0-9a-fA-F]{40}$/ &&
-		    $hash_parent_base =~ m/^[0-9a-fA-F]{40}$/) {
+		if ($hash_base =~ m/^$oid_regex$/ &&
+		    $hash_parent_base =~ m/^$oid_regex$/) {
 			$expires = '+1d';
 		}
 
@@ -7819,7 +7822,7 @@ sub git_commitdiff {
 		    $hash_parent ne '-c' && $hash_parent ne '--cc') {
 			# commitdiff with two commits given
 			my $hash_parent_short = $hash_parent;
-			if ($hash_parent =~ m/^[0-9a-fA-F]{40}$/) {
+			if ($hash_parent =~ m/^$oid_regex$/) {
 				$hash_parent_short = substr($hash_parent, 0, 7);
 			}
 			$formats_nav .=
@@ -7928,7 +7931,7 @@ sub git_commitdiff {
 
 	# non-textual hash id's can be cached
 	my $expires;
-	if ($hash =~ m/^[0-9a-fA-F]{40}$/) {
+	if ($hash =~ m/^$oid_regex$/) {
 		$expires = "+1d";
 	}
 
