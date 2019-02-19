Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62DA41F453
	for <e@80x24.org>; Tue, 19 Feb 2019 00:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732336AbfBSAGY (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Feb 2019 19:06:24 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:34908 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732266AbfBSAGW (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Feb 2019 19:06:22 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:3dc7:72ec:75fa:fee5])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 501DA6098B;
        Tue, 19 Feb 2019 00:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1550534778;
        bh=liRtFZn5X08lEfRkf+Ltl7neUtcKKpDCW2Wjg3+oLV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=w3Iq6zgj+M8hAy1Mh4r+3xJuSbYs5fOkEiAFXIdEUSD88UhkvSnkPyE2zm1xeVSzv
         2c7YsPzsJqOUOdvncyw/fgYvOoolHwNK3oEByB30ZBUfMMqKo3SpDcJhAo3RYUfE/i
         1ODpFmmF9QsTo0KLaYc9yLi6rz+D4BzEk2k5OAT8gjCmovBaVPNFHSmWMWLaZuOMtO
         gLtXL2wTzH2fiN7cjikjrBA5PriTCvDtls3+OO4voCeECRv11oWRffc/GmShOaXc7N
         wj8Juo9nN0tcp4WzjcKdUXfnioyXLATIc/C3kfeWFYWO/255kogNs75AfVFgO33Mhs
         wabXTGhnDnIETr/B+9xfqUDBa6YoW+UxMTD7tl2v9rtg/wwDeSpuge/3AHrtrFJ4EH
         Q0Xo3/aOgPJ61xldHGJHUiGBWasn8fktFM+2pJDd8rAVBwgmaKY1MeDOImtD5IlXgo
         VUosoHcLAVM5p7dq95BVdVurm78QeBjwSvbpKfxy7yZA2x1ink+
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Subject: [PATCH v2 35/35] gitweb: make hash size independent
Date:   Tue, 19 Feb 2019 00:05:26 +0000
Message-Id: <20190219000526.476553-36-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e
In-Reply-To: <20190219000526.476553-1-sandals@crustytoothpaste.net>
References: <20190219000526.476553-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add some helper functions which allow us to write tighter regexes that
match exactly the number of hex characters we're expecting.

Similarly, switch the code that looks for deleted diffinfo information
to look for either 40 or 64 zeros, and update one piece of code to use
this function.  Finally, when formatting a log line, allow an
abbreviated describe output to contain up to 64 characters.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 gitweb/gitweb.perl | 97 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 67 insertions(+), 30 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2594a4badb..7fef19fe59 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -788,6 +788,38 @@ sub check_loadavg {
 # ======================================================================
 # input validation and dispatch
 
+# Various hash size-related values.
+my $sha1_len = 40;
+my $sha256_extra_len = 24;
+my $sha256_len = $sha1_len + $sha256_extra_len;
+
+# A regex matching $len hex characters. $len may be a range (e.g. 7,64).
+sub oid_nlen_regex {
+	my $len = shift;
+	my $hchr = qr/[0-9a-fA-F]/;
+	return qr/(?:(?:$hchr){$len})/;
+}
+
+# A regex matching two sets of $nlen hex characters, prefixed by the literal
+# string $prefix and with the literal string $infix between them.
+sub oid_nlen_prefix_infix_regex {
+	my $nlen = shift;
+	my $prefix = shift;
+	my $infix = shift;
+
+	my $rx = oid_nlen_regex($nlen);
+
+	return qr/^\Q$prefix\E$rx\Q$infix\E$rx$/;
+}
+
+# A regex matching a valid object ID.
+our $oid_regex;
+{
+	my $x = oid_nlen_regex($sha1_len);
+	my $y = oid_nlen_regex($sha256_extra_len);
+	$oid_regex = qr/(?:$x(?:$y)?)/;
+}
+
 # input parameters can be collected from a variety of sources (presently, CGI
 # and PATH_INFO), so we define an %input_params hash that collects them all
 # together during validation: this allows subsequent uses (e.g. href()) to be
@@ -1516,7 +1548,7 @@ sub is_valid_refname {
 
 	return undef unless defined $input;
 	# textual hashes are O.K.
-	if ($input =~ m/^[0-9a-fA-F]{40}$/) {
+	if ($input =~ m/^$oid_regex$/) {
 		return 1;
 	}
 	# it must be correct pathname
@@ -2028,6 +2060,9 @@ sub file_type_long {
 sub format_log_line_html {
 	my $line = shift;
 
+	# Potentially abbreviated OID.
+	my $regex = oid_nlen_regex("7,64");
+
 	$line = esc_html($line, -nbsp=>1);
 	$line =~ s{
         \b
@@ -2037,10 +2072,10 @@ sub format_log_line_html {
             (?<!-) # see strbuf_check_tag_ref(). Tags can't start with -
             [A-Za-z0-9.-]+
             (?!\.) # refs can't end with ".", see check_refname_format()
-            -g[0-9a-fA-F]{7,40}
+            -g$regex
             |
             # Just a normal looking Git SHA1
-            [0-9a-fA-F]{7,40}
+	    $regex
         )
         \b
     }{
@@ -2286,7 +2321,8 @@ sub format_extended_diff_header_line {
 		         ')</span>';
 	}
 	# match <hash>
-	if ($line =~ m/^index [0-9a-fA-F]{40},[0-9a-fA-F]{40}/) {
+	if ($line =~ oid_nlen_prefix_infix_regex($sha1_len, "index ", ",") |
+	    $line =~ oid_nlen_prefix_infix_regex($sha256_len, "index ", ",")) {
 		# can match only for combined diff
 		$line = 'index ';
 		for (my $i = 0; $i < $diffinfo->{'nparents'}; $i++) {
@@ -2308,7 +2344,8 @@ sub format_extended_diff_header_line {
 			$line .= '0' x 7;
 		}
 
-	} elsif ($line =~ m/^index [0-9a-fA-F]{40}..[0-9a-fA-F]{40}/) {
+	} elsif ($line =~ oid_nlen_prefix_infix_regex($sha1_len, "index ", "..") |
+		 $line =~ oid_nlen_prefix_infix_regex($sha256_len, "index ", "..")) {
 		# can match only for ordinary diff
 		my ($from_link, $to_link);
 		if ($from->{'href'}) {
@@ -2834,7 +2871,7 @@ sub git_get_hash_by_path {
 	}
 
 	#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
-	$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t/;
+	$line =~ m/^([0-9]+) (.+) ($oid_regex)\t/;
 	if (defined $type && $type ne $2) {
 		# type doesn't match
 		return undef;
@@ -3333,7 +3370,7 @@ sub git_get_references {
 
 	while (my $line = <$fd>) {
 		chomp $line;
-		if ($line =~ m!^([0-9a-fA-F]{40})\srefs/($type.*)$!) {
+		if ($line =~ m!^($oid_regex)\srefs/($type.*)$!) {
 			if (defined $refs{$1}) {
 				push @{$refs{$1}}, $2;
 			} else {
@@ -3407,7 +3444,7 @@ sub parse_tag {
 	$tag{'id'} = $tag_id;
 	while (my $line = <$fd>) {
 		chomp $line;
-		if ($line =~ m/^object ([0-9a-fA-F]{40})$/) {
+		if ($line =~ m/^object ($oid_regex)$/) {
 			$tag{'object'} = $1;
 		} elsif ($line =~ m/^type (.+)$/) {
 			$tag{'type'} = $1;
@@ -3451,15 +3488,15 @@ sub parse_commit_text {
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
@@ -3591,7 +3628,7 @@ sub parse_difftree_raw_line {
 
 	# ':100644 100644 03b218260e99b78c6df0ed378e59ed9205ccc96d 3b93d5e7cc7f7dd4ebed13a5cc1a4ad976fc94d8 M	ls-files.c'
 	# ':100644 100644 7f9281985086971d3877aca27704f2aaf9c448ce bc190ebc71bbd923f2b728e505408f5e54bd073a M	rev-tree.c'
-	if ($line =~ m/^:([0-7]{6}) ([0-7]{6}) ([0-9a-fA-F]{40}) ([0-9a-fA-F]{40}) (.)([0-9]{0,3})\t(.*)$/) {
+	if ($line =~ m/^:([0-7]{6}) ([0-7]{6}) ($oid_regex) ($oid_regex) (.)([0-9]{0,3})\t(.*)$/) {
 		$res{'from_mode'} = $1;
 		$res{'to_mode'} = $2;
 		$res{'from_id'} = $3;
@@ -3606,7 +3643,7 @@ sub parse_difftree_raw_line {
 	}
 	# '::100755 100755 100755 60e79ca1b01bc8b057abe17ddab484699a7f5fdb 94067cc5f73388f33722d52ae02f44692bc07490 94067cc5f73388f33722d52ae02f44692bc07490 MR	git-gui/git-gui.sh'
 	# combined diff (for merge commit)
-	elsif ($line =~ s/^(::+)((?:[0-7]{6} )+)((?:[0-9a-fA-F]{40} )+)([a-zA-Z]+)\t(.*)$//) {
+	elsif ($line =~ s/^(::+)((?:[0-7]{6} )+)((?:$oid_regex )+)([a-zA-Z]+)\t(.*)$//) {
 		$res{'nparents'}  = length($1);
 		$res{'from_mode'} = [ split(' ', $2) ];
 		$res{'to_mode'} = pop @{$res{'from_mode'}};
@@ -3616,7 +3653,7 @@ sub parse_difftree_raw_line {
 		$res{'to_file'} = unquote($5);
 	}
 	# 'c512b523472485aef4fff9e57b229d9d243c967f'
-	elsif ($line =~ m/^([0-9a-fA-F]{40})$/) {
+	elsif ($line =~ m/^($oid_regex)$/) {
 		$res{'commit'} = $1;
 	}
 
@@ -3644,7 +3681,7 @@ sub parse_ls_tree_line {
 
 	if ($opts{'-l'}) {
 		#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa   16717	panic.c'
-		$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40}) +(-|[0-9]+)\t(.+)$/s;
+		$line =~ m/^([0-9]+) (.+) ($oid_regex) +(-|[0-9]+)\t(.+)$/s;
 
 		$res{'mode'} = $1;
 		$res{'type'} = $2;
@@ -3657,7 +3694,7 @@ sub parse_ls_tree_line {
 		}
 	} else {
 		#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
-		$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t(.+)$/s;
+		$line =~ m/^([0-9]+) (.+) ($oid_regex)\t(.+)$/s;
 
 		$res{'mode'} = $1;
 		$res{'type'} = $2;
@@ -4799,7 +4836,7 @@ sub fill_from_file_info {
 sub is_deleted {
 	my $diffinfo = shift;
 
-	return $diffinfo->{'to_id'} eq ('0' x 40);
+	return $diffinfo->{'to_id'} eq ('0' x 40) || $diffinfo->{'to_id'} eq ('0' x 64);
 }
 
 # does patch correspond to [previous] difftree raw line
@@ -6285,7 +6322,7 @@ sub git_search_changes {
 			              -class => "list subject"},
 			              chop_and_escape_str($co{'title'}, 50) . "<br/>");
 		} elsif (defined $set{'to_id'}) {
-			next if ($set{'to_id'} =~ m/^0{40}$/);
+			next if is_deleted(\%set);
 
 			print $cgi->a({-href => href(action=>"blob", hash_base=>$co{'id'},
 			                             hash=>$set{'to_id'}, file_name=>$set{'to_file'}),
@@ -6829,7 +6866,7 @@ sub git_blame_common {
 			# the header: <SHA-1> <src lineno> <dst lineno> [<lines in group>]
 			# no <lines in group> for subsequent lines in group of lines
 			my ($full_rev, $orig_lineno, $lineno, $group_size) =
-			   ($line =~ /^([0-9a-f]{40}) (\d+) (\d+)(?: (\d+))?$/);
+			   ($line =~ /^($oid_regex) (\d+) (\d+)(?: (\d+))?$/);
 			if (!exists $metainfo{$full_rev}) {
 				$metainfo{$full_rev} = { 'nprevious' => 0 };
 			}
@@ -6879,7 +6916,7 @@ sub git_blame_common {
 			}
 			# 'previous' <sha1 of parent commit> <filename at commit>
 			if (exists $meta->{'previous'} &&
-			    $meta->{'previous'} =~ /^([a-fA-F0-9]{40}) (.*)$/) {
+			    $meta->{'previous'} =~ /^($oid_regex) (.*)$/) {
 				$meta->{'parent'} = $1;
 				$meta->{'file_parent'} = unquote($2);
 			}
@@ -6996,7 +7033,7 @@ sub git_blob_plain {
 		} else {
 			die_error(400, "No file name defined");
 		}
-	} elsif ($hash =~ m/^[0-9a-fA-F]{40}$/) {
+	} elsif ($hash =~ m/^$oid_regex$/) {
 		# blobs defined by non-textual hash id's can be cached
 		$expires = "+1d";
 	}
@@ -7057,7 +7094,7 @@ sub git_blob {
 		} else {
 			die_error(400, "No file name defined");
 		}
-	} elsif ($hash =~ m/^[0-9a-fA-F]{40}$/) {
+	} elsif ($hash =~ m/^$oid_regex$/) {
 		# blobs defined by non-textual hash id's can be cached
 		$expires = "+1d";
 	}
@@ -7515,7 +7552,7 @@ sub git_commit {
 
 	# non-textual hash id's can be cached
 	my $expires;
-	if ($hash =~ m/^[0-9a-fA-F]{40}$/) {
+	if ($hash =~ m/^$oid_regex$/) {
 		$expires = "+1d";
 	}
 	my $refs = git_get_references();
@@ -7609,7 +7646,7 @@ sub git_object {
 		close $fd;
 
 		#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
-		unless ($line && $line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t/) {
+		unless ($line && $line =~ m/^([0-9]+) (.+) ($oid_regex)\t/) {
 			die_error(404, "File or directory for given base does not exist");
 		}
 		$type = $2;
@@ -7649,7 +7686,7 @@ sub git_blobdiff {
 				or die_error(404, "Blob diff not found");
 
 		} elsif (defined $hash &&
-		         $hash =~ /[0-9a-fA-F]{40}/) {
+		         $hash =~ $oid_regex) {
 			# try to find filename from $hash
 
 			# read filtered raw output
@@ -7659,7 +7696,7 @@ sub git_blobdiff {
 			@difftree =
 				# ':100644 100644 03b21826... 3b93d5e7... M	ls-files.c'
 				# $hash == to_id
-				grep { /^:[0-7]{6} [0-7]{6} [0-9a-fA-F]{40} $hash/ }
+				grep { /^:[0-7]{6} [0-7]{6} $oid_regex $hash/ }
 				map { chomp; $_ } <$fd>;
 			close $fd
 				or die_error(404, "Reading git-diff-tree failed");
@@ -7682,8 +7719,8 @@ sub git_blobdiff {
 		$hash        ||= $diffinfo{'to_id'};
 
 		# non-textual hash id's can be cached
-		if ($hash_base =~ m/^[0-9a-fA-F]{40}$/ &&
-		    $hash_parent_base =~ m/^[0-9a-fA-F]{40}$/) {
+		if ($hash_base =~ m/^$oid_regex$/ &&
+		    $hash_parent_base =~ m/^$oid_regex$/) {
 			$expires = '+1d';
 		}
 
@@ -7819,7 +7856,7 @@ sub git_commitdiff {
 		    $hash_parent ne '-c' && $hash_parent ne '--cc') {
 			# commitdiff with two commits given
 			my $hash_parent_short = $hash_parent;
-			if ($hash_parent =~ m/^[0-9a-fA-F]{40}$/) {
+			if ($hash_parent =~ m/^$oid_regex$/) {
 				$hash_parent_short = substr($hash_parent, 0, 7);
 			}
 			$formats_nav .=
@@ -7928,7 +7965,7 @@ sub git_commitdiff {
 
 	# non-textual hash id's can be cached
 	my $expires;
-	if ($hash =~ m/^[0-9a-fA-F]{40}$/) {
+	if ($hash =~ m/^$oid_regex$/) {
 		$expires = "+1d";
 	}
 
