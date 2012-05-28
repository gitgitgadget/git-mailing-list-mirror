From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] git-svn: use YAML format for mergeinfo cache when
 possible
Date: Sun, 27 May 2012 19:39:01 -0500
Message-ID: <20120528003901.GA11103@burratino>
References: <1313979422-21286-1-git-send-email-jgross@mit.edu>
 <20110823081546.GA28091@dcvr.yhbt.net>
 <7vobzgrrbg.fsf@alter.siamese.dyndns.org>
 <20120527192541.GA29490@burratino>
 <20120527201450.GA3630@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jason Gross <jgross@MIT.EDU>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon May 28 02:39:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYnzx-0004OP-Kv
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 02:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578Ab2E1AjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 May 2012 20:39:11 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:53957 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191Ab2E1AjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2012 20:39:09 -0400
Received: by obbtb18 with SMTP id tb18so4600296obb.19
        for <git@vger.kernel.org>; Sun, 27 May 2012 17:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Hx7vrbrU/gn5bznSYxa+onjpY4WLqDuGQHhi2fYVD5c=;
        b=Pl9hWATuFcXQya4tt/5vKtb+/KJ5utVajDR1EF/tGUcXyK3hNjh3Ia3aPPZQs8MtTO
         mqgtoBZR38CTo1tZqZnvxY4P07F0I74EKBHXJGHIK4F70sPU7SwlyfCso7HX4SVxPy25
         SIiMKex1arizMKmuKvxPhC01X8wBVwaDwC6BbdSxe7ukRzi0oHQ8ockbrZLcxidUYE2R
         5DLIg4B9o7nn/hTASUAxVlGe1DDOhHa2FA9seD2J/KJWtvQBRcvrzokj6TU8wrF6+JS9
         695aN/Fdji+apDvzw0i/SodFdZes2w3VIuuuUnebLml2p8IgP3kJ+Ik6KoOC2nhjlhtU
         FE3g==
Received: by 10.50.17.226 with SMTP id r2mr3312562igd.47.1338165548836;
        Sun, 27 May 2012 17:39:08 -0700 (PDT)
Received: from burratino (adsl-99-135-194-50.dsl.chcgil.sbcglobal.net. [99.135.194.50])
        by mx.google.com with ESMTPS id gh2sm8723118igb.9.2012.05.27.17.39.07
        (version=SSLv3 cipher=OTHER);
        Sun, 27 May 2012 17:39:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120527201450.GA3630@dcvr.yhbt.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198620>

Eric Wong wrote:
> Jonathan Nieder <jrnieder@gmail.com> wrote:

>> +package Git::SVN::Memoize::YAML;
>
> Can we use this as an opportunity to start splitting git-svn.perl into
> multiple .pm files?

Not a bad idea.  I've included an example patch to sanity-check the
approach below.

>> +	my $truehash = (-e $filename) ? YAML::Any::LoadFile($filename) : {};
>
>> +	YAML::Any::DumpFile($self->{FILENAME}, $self->{H});
>
> These should die on errors, right?

At least in YAML::Old, they use Carp::croak.  Maybe something like

	local @CARP_NOT = qw(YAML::Any);

to blame the caller for the error would bring sanity.

>> +=head1 BUGS
>
>> +Error handling is awkward.
>
> How so?

I mostly meant that it's not obvious what the state of %hash is at the
point marked with (*) below:

	if (not eval {
		tie my %hash => 'Foo::Bar', @params;
		1;
	}) {
		my $err = $@ ||
			# a destructor might have clobbered $@
			"Zombie error";
		die $err if worth_dying($err);

		(*) ... try to recover ...
	}

That's not specific to Memoize::YAML, though.  It probably is not
awkward for wizards who know the details. :)

-- >8 --
Subject: git-svn: move Git::SVN::Prompt into its own file

git-svn.perl is very long (around 6500 lines) and although it is
nicely split into modules, some new readers do not even notice --- it
is too distracting to see all this functionality collected in a single
file.

Splitting it into multiple files would make it easier for people
to read individual modules straight through and to experiment with
components separately.

Let's start with Git::SVN::Prompt.  For simplicity, we install this as
a module in the standard search path, just like the existing Git and
Git::I18N modules.  In the process, add a manpage explaining its
interface and that it is not likely to be useful for other projects to
avoid confusion.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks for a thoughtful review.
Jonathan

 git-svn.perl           |  145 +---------------------------------
 perl/Git/SVN/Prompt.pm |  202 ++++++++++++++++++++++++++++++++++++++++++++++++
 perl/Makefile.PL       |    1 +
 3 files changed, 204 insertions(+), 144 deletions(-)
 create mode 100644 perl/Git/SVN/Prompt.pm

diff --git a/git-svn.perl b/git-svn.perl
index 1b4ef68f..ef60b874 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -80,6 +80,7 @@ use File::Find;
 use Getopt::Long qw/:config gnu_getopt no_ignore_case auto_abbrev/;
 use IPC::Open3;
 use Git;
+use Git::SVN::Prompt qw//;
 use Memoize;  # core since 5.8.0, Jul 2002
 
 BEGIN {
@@ -4441,150 +4442,6 @@ sub remove_username {
 	$_[0] =~ s{^([^:]*://)[^@]+@}{$1};
 }
 
-package Git::SVN::Prompt;
-use strict;
-use warnings;
-require SVN::Core;
-use vars qw/$_no_auth_cache $_username/;
-
-sub simple {
-	my ($cred, $realm, $default_username, $may_save, $pool) = @_;
-	$may_save = undef if $_no_auth_cache;
-	$default_username = $_username if defined $_username;
-	if (defined $default_username && length $default_username) {
-		if (defined $realm && length $realm) {
-			print STDERR "Authentication realm: $realm\n";
-			STDERR->flush;
-		}
-		$cred->username($default_username);
-	} else {
-		username($cred, $realm, $may_save, $pool);
-	}
-	$cred->password(_read_password("Password for '" .
-	                               $cred->username . "': ", $realm));
-	$cred->may_save($may_save);
-	$SVN::_Core::SVN_NO_ERROR;
-}
-
-sub ssl_server_trust {
-	my ($cred, $realm, $failures, $cert_info, $may_save, $pool) = @_;
-	$may_save = undef if $_no_auth_cache;
-	print STDERR "Error validating server certificate for '$realm':\n";
-	{
-		no warnings 'once';
-		# All variables SVN::Auth::SSL::* are used only once,
-		# so we're shutting up Perl warnings about this.
-		if ($failures & $SVN::Auth::SSL::UNKNOWNCA) {
-			print STDERR " - The certificate is not issued ",
-			    "by a trusted authority. Use the\n",
-			    "   fingerprint to validate ",
-			    "the certificate manually!\n";
-		}
-		if ($failures & $SVN::Auth::SSL::CNMISMATCH) {
-			print STDERR " - The certificate hostname ",
-			    "does not match.\n";
-		}
-		if ($failures & $SVN::Auth::SSL::NOTYETVALID) {
-			print STDERR " - The certificate is not yet valid.\n";
-		}
-		if ($failures & $SVN::Auth::SSL::EXPIRED) {
-			print STDERR " - The certificate has expired.\n";
-		}
-		if ($failures & $SVN::Auth::SSL::OTHER) {
-			print STDERR " - The certificate has ",
-			    "an unknown error.\n";
-		}
-	} # no warnings 'once'
-	printf STDERR
-	        "Certificate information:\n".
-	        " - Hostname: %s\n".
-	        " - Valid: from %s until %s\n".
-	        " - Issuer: %s\n".
-	        " - Fingerprint: %s\n",
-	        map $cert_info->$_, qw(hostname valid_from valid_until
-	                               issuer_dname fingerprint);
-	my $choice;
-prompt:
-	print STDERR $may_save ?
-	      "(R)eject, accept (t)emporarily or accept (p)ermanently? " :
-	      "(R)eject or accept (t)emporarily? ";
-	STDERR->flush;
-	$choice = lc(substr(<STDIN> || 'R', 0, 1));
-	if ($choice =~ /^t$/i) {
-		$cred->may_save(undef);
-	} elsif ($choice =~ /^r$/i) {
-		return -1;
-	} elsif ($may_save && $choice =~ /^p$/i) {
-		$cred->may_save($may_save);
-	} else {
-		goto prompt;
-	}
-	$cred->accepted_failures($failures);
-	$SVN::_Core::SVN_NO_ERROR;
-}
-
-sub ssl_client_cert {
-	my ($cred, $realm, $may_save, $pool) = @_;
-	$may_save = undef if $_no_auth_cache;
-	print STDERR "Client certificate filename: ";
-	STDERR->flush;
-	chomp(my $filename = <STDIN>);
-	$cred->cert_file($filename);
-	$cred->may_save($may_save);
-	$SVN::_Core::SVN_NO_ERROR;
-}
-
-sub ssl_client_cert_pw {
-	my ($cred, $realm, $may_save, $pool) = @_;
-	$may_save = undef if $_no_auth_cache;
-	$cred->password(_read_password("Password: ", $realm));
-	$cred->may_save($may_save);
-	$SVN::_Core::SVN_NO_ERROR;
-}
-
-sub username {
-	my ($cred, $realm, $may_save, $pool) = @_;
-	$may_save = undef if $_no_auth_cache;
-	if (defined $realm && length $realm) {
-		print STDERR "Authentication realm: $realm\n";
-	}
-	my $username;
-	if (defined $_username) {
-		$username = $_username;
-	} else {
-		print STDERR "Username: ";
-		STDERR->flush;
-		chomp($username = <STDIN>);
-	}
-	$cred->username($username);
-	$cred->may_save($may_save);
-	$SVN::_Core::SVN_NO_ERROR;
-}
-
-sub _read_password {
-	my ($prompt, $realm) = @_;
-	my $password = '';
-	if (exists $ENV{GIT_ASKPASS}) {
-		open(PH, "-|", $ENV{GIT_ASKPASS}, $prompt);
-		$password = <PH>;
-		$password =~ s/[\012\015]//; # \n\r
-		close(PH);
-	} else {
-		print STDERR $prompt;
-		STDERR->flush;
-		require Term::ReadKey;
-		Term::ReadKey::ReadMode('noecho');
-		while (defined(my $key = Term::ReadKey::ReadKey(0))) {
-			last if $key =~ /[\012\015]/; # \n\r
-			$password .= $key;
-		}
-		Term::ReadKey::ReadMode('restore');
-		print STDERR "\n";
-		STDERR->flush;
-	}
-	$password;
-}
-
 package SVN::Git::Fetcher;
 use vars qw/@ISA $_ignore_regex $_preserve_empty_dirs $_placeholder_filename
             @deleted_gpath %added_placeholder $repo_id/;
diff --git a/perl/Git/SVN/Prompt.pm b/perl/Git/SVN/Prompt.pm
new file mode 100644
index 00000000..3a6f8af0
--- /dev/null
+++ b/perl/Git/SVN/Prompt.pm
@@ -0,0 +1,202 @@
+package Git::SVN::Prompt;
+use strict;
+use warnings;
+require SVN::Core;
+use vars qw/$_no_auth_cache $_username/;
+
+sub simple {
+	my ($cred, $realm, $default_username, $may_save, $pool) = @_;
+	$may_save = undef if $_no_auth_cache;
+	$default_username = $_username if defined $_username;
+	if (defined $default_username && length $default_username) {
+		if (defined $realm && length $realm) {
+			print STDERR "Authentication realm: $realm\n";
+			STDERR->flush;
+		}
+		$cred->username($default_username);
+	} else {
+		username($cred, $realm, $may_save, $pool);
+	}
+	$cred->password(_read_password("Password for '" .
+	                               $cred->username . "': ", $realm));
+	$cred->may_save($may_save);
+	$SVN::_Core::SVN_NO_ERROR;
+}
+
+sub ssl_server_trust {
+	my ($cred, $realm, $failures, $cert_info, $may_save, $pool) = @_;
+	$may_save = undef if $_no_auth_cache;
+	print STDERR "Error validating server certificate for '$realm':\n";
+	{
+		no warnings 'once';
+		# All variables SVN::Auth::SSL::* are used only once,
+		# so we're shutting up Perl warnings about this.
+		if ($failures & $SVN::Auth::SSL::UNKNOWNCA) {
+			print STDERR " - The certificate is not issued ",
+			    "by a trusted authority. Use the\n",
+			    "   fingerprint to validate ",
+			    "the certificate manually!\n";
+		}
+		if ($failures & $SVN::Auth::SSL::CNMISMATCH) {
+			print STDERR " - The certificate hostname ",
+			    "does not match.\n";
+		}
+		if ($failures & $SVN::Auth::SSL::NOTYETVALID) {
+			print STDERR " - The certificate is not yet valid.\n";
+		}
+		if ($failures & $SVN::Auth::SSL::EXPIRED) {
+			print STDERR " - The certificate has expired.\n";
+		}
+		if ($failures & $SVN::Auth::SSL::OTHER) {
+			print STDERR " - The certificate has ",
+			    "an unknown error.\n";
+		}
+	} # no warnings 'once'
+	printf STDERR
+	        "Certificate information:\n".
+	        " - Hostname: %s\n".
+	        " - Valid: from %s until %s\n".
+	        " - Issuer: %s\n".
+	        " - Fingerprint: %s\n",
+	        map $cert_info->$_, qw(hostname valid_from valid_until
+	                               issuer_dname fingerprint);
+	my $choice;
+prompt:
+	print STDERR $may_save ?
+	      "(R)eject, accept (t)emporarily or accept (p)ermanently? " :
+	      "(R)eject or accept (t)emporarily? ";
+	STDERR->flush;
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
+sub ssl_client_cert {
+	my ($cred, $realm, $may_save, $pool) = @_;
+	$may_save = undef if $_no_auth_cache;
+	print STDERR "Client certificate filename: ";
+	STDERR->flush;
+	chomp(my $filename = <STDIN>);
+	$cred->cert_file($filename);
+	$cred->may_save($may_save);
+	$SVN::_Core::SVN_NO_ERROR;
+}
+
+sub ssl_client_cert_pw {
+	my ($cred, $realm, $may_save, $pool) = @_;
+	$may_save = undef if $_no_auth_cache;
+	$cred->password(_read_password("Password: ", $realm));
+	$cred->may_save($may_save);
+	$SVN::_Core::SVN_NO_ERROR;
+}
+
+sub username {
+	my ($cred, $realm, $may_save, $pool) = @_;
+	$may_save = undef if $_no_auth_cache;
+	if (defined $realm && length $realm) {
+		print STDERR "Authentication realm: $realm\n";
+	}
+	my $username;
+	if (defined $_username) {
+		$username = $_username;
+	} else {
+		print STDERR "Username: ";
+		STDERR->flush;
+		chomp($username = <STDIN>);
+	}
+	$cred->username($username);
+	$cred->may_save($may_save);
+	$SVN::_Core::SVN_NO_ERROR;
+}
+
+sub _read_password {
+	my ($prompt, $realm) = @_;
+	my $password = '';
+	if (exists $ENV{GIT_ASKPASS}) {
+		open(PH, "-|", $ENV{GIT_ASKPASS}, $prompt);
+		$password = <PH>;
+		$password =~ s/[\012\015]//; # \n\r
+		close(PH);
+	} else {
+		print STDERR $prompt;
+		STDERR->flush;
+		require Term::ReadKey;
+		Term::ReadKey::ReadMode('noecho');
+		while (defined(my $key = Term::ReadKey::ReadKey(0))) {
+			last if $key =~ /[\012\015]/; # \n\r
+			$password .= $key;
+		}
+		Term::ReadKey::ReadMode('restore');
+		print STDERR "\n";
+		STDERR->flush;
+	}
+	$password;
+}
+
+1;
+__END__
+
+Git::SVN::Prompt - authentication callbacks for git-svn
+
+=head1 SYNOPSIS
+
+    use Git::SVN::Prompt qw(simple ssl_client_cert ssl_client_cert_pw
+                            ssl_server_trust username);
+    use SVN::Client ();
+
+    my $cached_simple = SVN::Client::get_simple_provider();
+    my $git_simple = SVN::Client::get_simple_prompt_provider(\&simple, 2);
+    my $cached_ssl = SVN::Client::get_ssl_server_trust_file_provider();
+    my $git_ssl = SVN::Client::get_ssl_server_trust_prompt_provider(
+        \&ssl_server_trust);
+    my $cached_cert = SVN::Client::get_ssl_client_cert_file_provider();
+    my $git_cert = SVN::Client::get_ssl_client_cert_prompt_provider(
+        \&ssl_client_cert, 2);
+    my $cached_cert_pw = SVN::Client::get_ssl_client_cert_pw_file_provider();
+    my $git_cert_pw = SVN::Client::get_ssl_client_cert_pw_prompt_provider(
+        \&ssl_client_cert_pw, 2);
+    my $cached_username = SVN::Client::get_username_provider();
+    my $git_username = SVN::Client::get_username_prompt_provider(
+        \&username, 2);
+
+    my $ctx = new SVN::Client(
+        auth => [
+            $cached_simple, $git_simple,
+            $cached_ssl, $git_ssl,
+            $cached_cert, $git_cert,
+            $cached_cert_pw, $git_cert_pw,
+            $cached_username, $git_username
+        ]);
+
+=head1 DESCRIPTION
+
+This module is an implementation detail of the "git svn" command.
+It implements git-svn's authentication policy.  Do not use it unless
+you are developing git-svn.
+
+The interface will change as git-svn evolves.
+
+=head1 DEPENDENCIES
+
+L<SVN::Core>.
+
+=head1 SEE ALSO
+
+L<SVN::Client>.
+
+=head1 INCOMPATIBILITIES
+
+None reported.
+
+=head1 BUGS
+
+None.
diff --git a/perl/Makefile.PL b/perl/Makefile.PL
index 456d45bf..4d8e31d2 100644
--- a/perl/Makefile.PL
+++ b/perl/Makefile.PL
@@ -27,6 +27,7 @@ MAKE_FRAG
 my %pm = (
 	'Git.pm' => '$(INST_LIBDIR)/Git.pm',
 	'Git/I18N.pm' => '$(INST_LIBDIR)/Git/I18N.pm',
+	'Git/SVN/Prompt.pm' => '$(INST_LIBDIR)/Git/SVN/Prompt.pm',
 );
 
 # We come with our own bundled Error.pm. It's not in the set of default
-- 
1.7.10
