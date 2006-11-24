X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: handle authentication without relying on cached tokens on disk
Date: Fri, 24 Nov 2006 01:38:04 -0800
Message-ID: <11643610841150-git-send-email-normalperson@yhbt.net>
NNTP-Posting-Date: Fri, 24 Nov 2006 09:38:23 +0000 (UTC)
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.4.1.g22a08
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32205>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnXVd-000087-O9 for gcvg-git@gmane.org; Fri, 24 Nov
 2006 10:38:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757657AbWKXJiK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 04:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757662AbWKXJiJ
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 04:38:09 -0500
Received: from hand.yhbt.net ([66.150.188.102]:47318 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S1757657AbWKXJiG (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 04:38:06 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 4FB807DC098; Fri, 24 Nov 2006 01:38:04 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 24 Nov 2006
 01:38:04 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

This is mostly gleaned off SVN::Mirror, with added support for
--no-auth-cache and --config-dir.

Even with this patch, git-svn does not yet support repositories
where the user only has partial read permissions.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |  156 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 148 insertions(+), 8 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index bb8935a..47cd3e2 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -39,7 +39,7 @@ memoize('revisions_eq');
 memoize('cmt_metadata');
 memoize('get_commit_time');
 
-my ($SVN_PATH, $SVN, $SVN_LOG, $_use_lib);
+my ($SVN_PATH, $SVN, $SVN_LOG, $_use_lib, $AUTH_BATON, $AUTH_CALLBACKS);
 
 sub nag_lib {
 	print STDERR <<EOF;
@@ -66,7 +66,8 @@ my ($_revision,$_stdin,$_no_ignore_ext,$
 	$_template, $_shared, $_no_default_regex, $_no_graft_copy,
 	$_limit, $_verbose, $_incremental, $_oneline, $_l_fmt, $_show_commit,
 	$_version, $_upgrade, $_authors, $_branch_all_refs, @_opt_m,
-	$_merge, $_strategy, $_dry_run, $_ignore_nodate, $_non_recursive);
+	$_merge, $_strategy, $_dry_run, $_ignore_nodate, $_non_recursive,
+	$_username, $_config_dir, $_no_auth_cache);
 my (@_branch_from, %tree_map, %users, %rusers, %equiv);
 my ($_svn_co_url_revs, $_svn_pg_peg_revs);
 my @repo_path_split_cache;
@@ -79,6 +80,9 @@ my %fc_opts = ( 'no-ignore-externals' =>
 		'repack:i' => \$_repack,
 		'no-metadata' => \$_no_metadata,
 		'quiet|q' => \$_q,
+		'username=s' => \$_username,
+		'config-dir=s' => \$_config_dir,
+		'no-auth-cache' => \$_no_auth_cache,
 		'ignore-nodate' => \$_ignore_nodate,
 		'repack-flags|repack-args|repack-opts=s' => \$_repack_flags);
 
@@ -2683,18 +2687,154 @@ sub libsvn_load {
 		my $kill_stupid_warnings = $SVN::Node::none.$SVN::Node::file.
 					$SVN::Node::dir.$SVN::Node::unknown.
 					$SVN::Node::none.$SVN::Node::file.
-					$SVN::Node::dir.$SVN::Node::unknown;
+					$SVN::Node::dir.$SVN::Node::unknown.
+					$SVN::Auth::SSL::CNMISMATCH.
+					$SVN::Auth::SSL::NOTYETVALID.
+					$SVN::Auth::SSL::EXPIRED.
+					$SVN::Auth::SSL::UNKNOWNCA.
+					$SVN::Auth::SSL::OTHER;
 		1;
 	};
 }
 
+sub _simple_prompt {
+	my ($cred, $realm, $default_username, $may_save, $pool) = @_;
+	$may_save = undef if $_no_auth_cache;
+	$default_username = $_username if defined $_username;
+	if (defined $default_username && length $default_username) {
+		if (defined $realm && length $realm) {
+			print "Authentication realm: $realm\n";
+		}
+		$cred->username($default_username);
+	} else {
+		_username_prompt($cred, $realm, $may_save, $pool);
+	}
+	$cred->password(_read_password("Password for '" .
+	                               $cred->username . "': ", $realm));
+	$cred->may_save($may_save);
+	$SVN::_Core::SVN_NO_ERROR;
+}
+
+sub _ssl_server_trust_prompt {
+	my ($cred, $realm, $failures, $cert_info, $may_save, $pool) = @_;
+	$may_save = undef if $_no_auth_cache;
+	print "Error validating server certificate for '$realm':\n";
+	if ($failures & $SVN::Auth::SSL::UNKNOWNCA) {
+		print " - The certificate is not issued by a trusted ",
+		      "authority. Use the\n",
+	              "   fingerprint to validate the certificate manually!\n";
+	}
+	if ($failures & $SVN::Auth::SSL::CNMISMATCH) {
+		print " - The certificate hostname does not match.\n";
+	}
+	if ($failures & $SVN::Auth::SSL::NOTYETVALID) {
+		print " - The certificate is not yet valid.\n";
+	}
+	if ($failures & $SVN::Auth::SSL::EXPIRED) {
+		print " - The certificate has expired.\n";
+	}
+	if ($failures & $SVN::Auth::SSL::OTHER) {
+		print " - The certificate has an unknown error.\n";
+	}
+	printf( "Certificate information:\n".
+	        " - Hostname: %s\n".
+	        " - Valid: from %s until %s\n".
+	        " - Issuer: %s\n".
+	        " - Fingerprint: %s\n",
+	        map $cert_info->$_, qw(hostname valid_from valid_until
+	                               issuer_dname fingerprint) );
+	my $choice;
+prompt:
+	print $may_save ?
+	      "(R)eject, accept (t)emporarily or accept (p)ermanently? " :
+	      "(R)eject or accept (t)emporarily? ";
+	$choice = lc(substr(<STDIN> || 'R', 0, 1));
+	if ($choice =~ /^t$/i) {
+		$cred->may_save(undef);
+	} elsif ($choice =~ /^r$/i) {
+		return -1;
+	} elsif ($may_save && $choice =~ /^p$/i) {
+		$cred->may_save($may_save);
+	} else {
+		goto prompt;
+	}
+	$cred->accepted_failures($failures);
+	$SVN::_Core::SVN_NO_ERROR;
+}
+
+sub _ssl_client_cert_prompt {
+	my ($cred, $realm, $may_save, $pool) = @_;
+	$may_save = undef if $_no_auth_cache;
+	print "Client certificate filename: ";
+	chomp(my $filename = <STDIN>);
+	$cred->cert_file($filename);
+	$cred->may_save($may_save);
+	$SVN::_Core::SVN_NO_ERROR;
+}
+
+sub _ssl_client_cert_pw_prompt {
+	my ($cred, $realm, $may_save, $pool) = @_;
+	$may_save = undef if $_no_auth_cache;
+	$cred->password(_read_password("Password: ", $realm));
+	$cred->may_save($may_save);
+	$SVN::_Core::SVN_NO_ERROR;
+}
+
+sub _username_prompt {
+	my ($cred, $realm, $may_save, $pool) = @_;
+	$may_save = undef if $_no_auth_cache;
+	if (defined $realm && length $realm) {
+		print "Authentication realm: $realm\n";
+	}
+	my $username;
+	if (defined $_username) {
+		$username = $_username;
+	} else {
+		print "Username: ";
+		chomp($username = <STDIN>);
+	}
+	$cred->username($username);
+	$cred->may_save($may_save);
+	$SVN::_Core::SVN_NO_ERROR;
+}
+
+sub _read_password {
+	my ($prompt, $realm) = @_;
+	print $prompt;
+	require Term::ReadKey;
+	Term::ReadKey::ReadMode('noecho');
+	my $password = '';
+	while (defined(my $key = Term::ReadKey::ReadKey(0))) {
+		last if $key =~ /[\012\015]/; # \n\r
+		$password .= $key;
+	}
+	Term::ReadKey::ReadMode('restore');
+	print "\n";
+	$password;
+}
+
 sub libsvn_connect {
 	my ($url) = @_;
-	my $auth = SVN::Core::auth_open([SVN::Client::get_simple_provider(),
-			  SVN::Client::get_ssl_server_trust_file_provider(),
-			  SVN::Client::get_username_provider()]);
-	my $s = eval { SVN::Ra->new(url => $url, auth => $auth) };
-	return $s;
+	if (!$AUTH_BATON || !$AUTH_CALLBACKS) {
+		SVN::_Core::svn_config_ensure($_config_dir, undef);
+		($AUTH_BATON, $AUTH_CALLBACKS) = SVN::Core::auth_open_helper([
+		    SVN::Client::get_simple_provider(),
+		    SVN::Client::get_ssl_server_trust_file_provider(),
+		    SVN::Client::get_simple_prompt_provider(
+		      \&_simple_prompt, 2),
+		    SVN::Client::get_ssl_client_cert_prompt_provider(
+		      \&_ssl_client_cert_prompt, 2),
+		    SVN::Client::get_ssl_client_cert_pw_prompt_provider(
+		      \&_ssl_client_cert_pw_prompt, 2),
+		    SVN::Client::get_username_provider(),
+		    SVN::Client::get_ssl_server_trust_prompt_provider(
+		      \&_ssl_server_trust_prompt),
+		    SVN::Client::get_username_prompt_provider(
+		      \&_username_prompt, 2),
+		  ]);
+	}
+	SVN::Ra->new(url => $url, auth => $AUTH_BATON,
+	             auth_provider_callbacks => $AUTH_CALLBACKS);
 }
 
 sub libsvn_get_file {
-- 
1.4.4.1.g22a08
