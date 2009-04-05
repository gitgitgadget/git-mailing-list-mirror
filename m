From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH] perl: add new module Git::Config for cached 'git config' access
Date: Mon,  6 Apr 2009 11:46:15 +1200
Message-ID: <1238975176-14354-1-git-send-email-sam.vilain@catalyst.net.nz>
Cc: Petr Baudis <pasky@suse.cz>,
	Sam Vilain <sam.vilain@catalyst.net.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 06 02:23:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqccf-0005Og-7H
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 02:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069AbZDFAFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 20:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752796AbZDFAFb
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 20:05:31 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:34176 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869AbZDFAFa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 20:05:30 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=localhost.localdomain)
	by mail1.catalyst.net.nz with esmtp (Exim 4.63)
	(envelope-from <sam.vilain@catalyst.net.nz>)
	id 1Lqc2a-0003KK-QU; Mon, 06 Apr 2009 11:46:16 +1200
X-Mailer: git-send-email 1.5.5.1.50.g1d36.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115743>

Add a new module, Git::Config, for a better Git configuration API.

Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
 perl/Git/Config.pm   |  465 ++++++++++++++++++++++++++++++++++++++++++++++++++
 perl/Makefile.PL     |    5 +-
 t/t9700-perl-git.sh  |    8 +
 t/t9700/TestUtils.pm |   77 +++++++++
 t/t9700/config.t     |  127 ++++++++++++++
 5 files changed, 681 insertions(+), 1 deletions(-)
 create mode 100644 perl/Git/Config.pm
 create mode 100644 t/t9700/TestUtils.pm
 create mode 100644 t/t9700/config.t

diff --git a/perl/Git/Config.pm b/perl/Git/Config.pm
new file mode 100644
index 0000000..a0a6a41
--- /dev/null
+++ b/perl/Git/Config.pm
@@ -0,0 +1,465 @@
+
+package Git::Config;
+
+use 5.006;
+use strict;
+use warnings;
+
+use Git;
+use Error qw(:try);
+
+=head1 NAME
+
+Git::Config - caching interface to git-config state
+
+=head1 SYNOPSIS
+
+  use Git::Config;
+
+  my $conf = Git::Config->new( $git );
+
+  # return single config items
+  my $value = $conf->config( VARIABLE );
+
+  # return multi-config items
+  my @values = $conf->config( VARIABLE );
+
+  # manipulate type of slot, for special interpretation
+  $conf->type( VARIABLE => $type );
+
+  # change value
+  $conf->config( VARIABLE => $value );
+
+  # read or configure a global or system variable
+  $conf->global( VARIABLE => $value );
+  $conf->system( VARIABLE => $value );
+
+  # default is to autoflush 
+  $conf->autoflush( 0 );
+
+  # if autoflush is disabled, flush explicitly.
+  $conf->flush;
+
+  # update cache
+  $conf->read;
+
+=head1 DESCRIPTION
+
+This module provides a cached interface to the B<git config> command
+in Perl.
+
+=head1 CONSTRUCTION
+
+=head2 B<Git::Config-E<gt>new( I<$git> )>
+
+Creates a new B<Git::Config> object.  Does not read the configuration
+file yet.
+
+=cut
+
+sub new {
+	my $class = shift;
+	my $git = shift || Git->repository;
+	my $self = bless { git => $git }, $class;
+	while ( my ($item, $value) = splice @_, 0, 2 ) {
+		try {
+			$self->$item($value);
+		}
+		catch {
+			throw Error::Simple (
+				"Invalid constructor arg '$item'",
+			       );
+		};
+	}
+	return $self;
+}
+
+=head1 METHODS
+
+=head2 B<$conf-E<gt>config( C<item> )>
+
+Reads the value of a particular configuration item.
+When called in B<list context>, returns all values of multiple value
+items.
+When called in B<scalar context>, raises an error if the item is
+specified multiple times.
+
+=head2 B<$conf-E<gt>config( C<item> =E<gt> I<$value> )>
+
+Sets the value of an item.
+If an B<array reference> is specified, the entire list of items is
+replaced with the values specified.
+If a single item is passed but the item is specified multiple times in
+the configuration file, raises an error.
+Returns the old value.
+
+=cut
+
+sub config {
+	return $_[0]->_config("", @_[1..$#_]);
+}
+
+sub _config {
+	my $self = shift;
+	my $which = shift;
+	my $item = shift;
+	my $value_passed = @_;
+	my $value = shift;
+
+	my $type = $self->type( $item );
+
+	my $_which = $which ? "${which}_" : "";
+	my $_read = "read_${_which}state";
+	my $_state = "${_which}state";
+
+	if (!$self->{$_read}) {
+		$self->read($which);
+	}
+
+	my $state;
+	if (exists $self->{$_state}{$item}) {
+		$state = $self->{$_state}{$item};
+	}
+	else {
+		$state = $self->{$_read}{$item};
+	}
+
+	if ($value_passed) {
+		if (!ref $value and defined $value and ref $state) {
+			throw Error::Simple (
+				"'$item' is specified multiple times",
+			       );
+		}
+		if ( $type ) {
+			if (ref $value) {
+				$value = [ map { $self->freeze($type, $_) }
+						   @$value ];
+			}
+			else {
+				$value = $self->freeze($type, $value);
+			}
+		}
+		$self->{$_state}{$item} = $value;
+		$self->flush() if $self->autoflush;
+	}
+
+	if (defined wantarray) {
+		my @values = ref $state ? @$state :
+			defined $state ? ($state) : ();
+
+		if ( my $type = $self->type( $item ) ) {
+			@values = map { $self->thaw($type, $_) }
+				@values;
+		}
+
+		if ( @values > 1 and
+			     ( ($value_passed and not ref $value) or
+				       (not $value_passed and not wantarray) )
+			    ) {
+			throw Error::Simple (
+				"'$item' is specified multiple times",
+			       );
+		}
+
+		return (wantarray ? @values : $values[0]);
+	}
+}
+
+=head2 B<$conf-E<gt>read()>
+
+Reads the current state of the configuration file.
+
+=cut
+
+sub read {
+	my $self = shift;
+	my $which = shift;
+
+	my $git = $self->{git};
+
+	my ($fh, $c) = $git->command_output_pipe(
+		'config', ( $which ? ("--$which") : () ),
+		'--list',
+	       );
+	my $read_state = {};
+
+	while (<$fh>) {
+		my ($item, $value) = m{(.*?)=(.*)};
+		my $sl = \( $read_state->{$item} );
+		if (!defined $$sl) {
+			$$sl = $value;
+		}
+		elsif (!ref $$sl) {
+			$$sl = [ $$sl, $value ];
+		}
+		else {
+			push @{ $$sl }, $value;
+		}
+	}
+
+	$git->command_close_pipe($fh, $c);
+
+	if ( $which ) {
+		$which .= "_";
+	}
+	else {
+		$which = "";
+	};
+
+	$self->{"read_${which}state"} = $read_state;
+}
+
+=head2 type( VARIABLE => $type )
+
+Specifies which set of rules to use when returning to and from the
+config file.  C<$type> may be C<string>, C<boolean> or C<integer>.
+Globs such as C<*> are allowed which match everything except C<.>
+(full stop).
+
+=head2 type( VARIABLE )
+
+Returns the first matching defined type rule.
+
+=cut
+
+sub type {
+	my $self = shift;
+	my $item = shift;
+	my $got_type = @_;
+	my $type = shift;
+	$type ||= "string";
+
+	my $types = $self->{types} ||= [];
+	if ( $got_type ) {
+		$item =~ s{([\.(?])}{\\$1}g;
+		$item =~ s{\*}{[^\\.]*}g;
+		$item = qr{^$item$};
+		@$types = grep { $_->[0] ne $item }
+			@$types;
+		push @$types, [ $item, $type ];
+	}
+	else {
+	type:
+		for (@$types) {
+			if ($item =~ m{$_->[0]}) {
+				$type = $_->[1];
+				last type;
+			}
+		}
+
+		$type;
+	}
+}
+
+=head2 global( VARIABLE )
+
+=head2 system( VARIABLE )
+
+Return the value of the given variable in the global or system
+configuration (F<~/.gitconfig> and F</etc/gitconfig> on Unix).
+
+=head2 global( VARIABLE => $value )
+
+=head2 system( VARIABLE => $value )
+
+Set the value of the given variable in the global or system
+configuration.
+
+=cut
+
+sub global { return $_[0]->_config("global", @_[1..$#_]) }
+sub system { return $_[0]->_config("system", @_[1..$#_]) }
+
+=head2 autoflush
+
+Returns 0 or 1 depending on whether autoflush is enabled.  Defaults to
+1.
+
+=head2 autoflush ( $value )
+
+Set the value of autoflush.  If set to 1, flushes immediately.
+
+=cut
+
+sub autoflush {
+	my $self = shift;
+	if (@_) {
+		$self->{autoflush} = shift;
+	}
+	not (defined $self->{autoflush} and not $self->{autoflush});
+}
+
+=head2 flush
+
+Flushes all changed configuration values to the config file(s).
+
+=cut
+
+sub flush {
+	my $self = shift;
+
+	for my $which ("", "global", "system") {
+		my $st = $which . ($which ? "_" : "") . "state";;
+		my $read = "read_$st";
+		if (my $new = delete $self->{$st}) {
+			$self->_write($which, $new, $self->{$read});
+			$self->read($which);
+		}
+	}
+}
+
+sub _write {
+	my $self = shift;
+	my $which = shift;
+	my $state = shift;
+	my $read_state = shift;
+
+	my $git = $self->{git};
+
+	while (my ($item, $value) = each %$state) {
+		my $old_value = $read_state->{$item};
+		my @cmd = ($which ? ("--$which") : () );
+		my $type = $self->type($item);
+		if ($type ne "string") {
+			push @cmd, "--$type";
+		}
+		if (ref $value) {
+			$git->command_oneline (
+				"config", @cmd, "--replace-all",
+				 $item, $value->[0],
+			       );
+			for my $i (1..$#$value) {
+				$git->command_oneline (
+					"config", @cmd, "--add",
+					$item, $value->[$i],
+				       );
+			};
+		}
+		elsif (defined $value) {
+			$git->command_oneline (
+				"config", @cmd, $item, $value,
+			       );
+		}
+		elsif ($read_state->{$item}) {
+			$git->command_oneline (
+				"config", "--unset-all", @cmd,
+				$item, $value,
+			       );
+		}
+		else {
+			# nothing to do - already not in config
+		}
+	}
+}
+
+sub _dispatch {
+	no strict 'refs';
+	my $self = shift;
+	my $func = shift;
+	my $type = shift;
+	my $sym = __PACKAGE__."::${type}::$func";
+	defined &{$sym}
+		or throw Error::Simple "Bad type '$type' in $func";
+	&{$sym}(@_, $self);
+}
+
+sub freeze {
+	my $self = shift;
+	$self->_dispatch("freeze", @_);
+}
+
+sub thaw {
+	my $self = shift;
+	$self->_dispatch("thaw", @_);
+}
+
+{
+	package Git::Config::string;
+	sub freeze { shift }
+	sub thaw   { shift }
+}
+{
+	package Git::Config::integer;
+	our @mul = ("", "k", "M", "G");
+	sub freeze {
+		my $val = shift;
+		my $scale = 0;
+		while ( (my $num = int($val/1024))*1024 == $val ) {
+			$scale++;
+		 	$val = $num;
+			last if $scale == $#mul;
+		}
+		$val.$mul[$scale];
+	}
+	our $mul_re = qr/^(\d+)\s*${\( "(".join("|", @mul).")" )}$/i;
+	sub thaw {
+		my $val = shift;
+		$val =~ m{$mul_re}
+			or throw Error::Simple "Bad value for integer: '$val'";
+		my $num = $1;
+		if ($2) {
+			my $scale = 0;
+			do { $num = $num * 1024 }
+				until (lc($mul[++$scale]) eq lc($2));
+		}
+		$num;
+	}
+}
+{
+	package Git::Config::boolean;
+	our @true = qw(true yes 1);
+	our @false = qw(false no 0);
+	our $true_re = qr/^${\( "(".join("|", @true).")" )}$/i;
+	our $false_re = qr/^${\( "(".join("|", @false).")" )}$/i;
+	sub freeze {
+		my $val = shift;
+		if (!!$val) {
+			$true[0];
+		}
+		else {
+			$false[0];
+		}
+	}
+	sub thaw {
+		my $val = shift;
+		if ($val =~ m{$true_re}) {
+			1;
+		}
+		elsif ($val =~ m{$false_re}) {
+			0;
+		}
+		else {
+			throw Error::Simple "Bad value for boolean: '$val'";
+		}
+	}
+}
+
+1;
+
+__END__
+
+=head1 SEE ALSO
+
+L<Git>
+
+=head1 AUTHOR AND LICENSE
+
+Copyright 2009, Sam Vilain, L<sam@vilain.net>.  All Rights Reserved.
+This program is Free Software; you may use it under the terms of the
+Perl Artistic License 2.0 or later, or the GPL v2 or later.
+
+=cut
+
+# Local Variables:
+#   mode: cperl
+#   cperl-brace-offset: 0
+#   cperl-continued-brace-offset: 0
+#   cperl-indent-level: 8
+#   cperl-label-offset: -8
+#   cperl-merge-trailing-else: nil
+#   cperl-continued-statement-offset: 8
+#   cperl-indent-parens-as-block: t
+#   cperl-indent-wrt-brace: nil
+# End:
+#
+# vim: vim:tw=78:sts=0:noet
diff --git a/perl/Makefile.PL b/perl/Makefile.PL
index 320253e..80df0b0 100644
--- a/perl/Makefile.PL
+++ b/perl/Makefile.PL
@@ -8,7 +8,10 @@ instlibdir:
 MAKE_FRAG
 }
 
-my %pm = ('Git.pm' => '$(INST_LIBDIR)/Git.pm');
+my %pm = (map {( "$_.pm" => "\$(INST_LIBDIR)/$_.pm" )}
+	'Git',
+	'Git/Config',
+	);
 
 # We come with our own bundled Error.pm. It's not in the set of default
 # Perl modules so install it if it's not available on the system yet.
diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index b81d5df..2f53d00 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -37,8 +37,16 @@ test_expect_success \
      git config --add test.int 2k
      '
 
+export PERL5LIB="$TEST_DIRECTORY/t9700:$GITPERLLIB:$PERL5LIB"
+
 test_external_without_stderr \
     'Perl API' \
     perl "$TEST_DIRECTORY"/t9700/test.pl
 
+rm -rf .git
+
+test_external_without_stderr \
+    'config API' \
+    perl "$TEST_DIRECTORY"/t9700/config.t
+
 test_done
diff --git a/t/t9700/TestUtils.pm b/t/t9700/TestUtils.pm
new file mode 100644
index 0000000..72a386d
--- /dev/null
+++ b/t/t9700/TestUtils.pm
@@ -0,0 +1,77 @@
+#!/usr/bin/perl
+
+package TestUtils;
+
+use Carp;
+use base qw(Exporter);
+BEGIN {
+	our @EXPORT = qw(mk_tmp_repo in_empty_repo tmp_git random_port_pair);
+	$SIG{__WARN__} = sub {
+	    my $i = 0;
+	    while (my $caller = caller($i)) {
+		    if ($caller eq "Test::More") {
+			    return 0;
+		    }
+		    $i++;
+	    }
+	    my $culprit = caller;
+	    if ($culprit =~ m{Class::C3}) {
+		return 1;
+	    }
+	    else {
+		print STDERR "*** WARNING FROM $culprit FOLLOWS ***\n";
+	    }
+	    Carp::cluck(@_);
+	    print STDERR "*** END OF STACK DUMP ***\n";
+	    1
+	}
+	unless $ENV{NO_WARNING_TRACES};
+}
+
+use Cwd qw(fast_abs_path);
+use File::Temp qw(tempdir);
+
+sub mk_tmp_repo {
+	my $temp_dir = tempdir( "tmpXXXXX", CLEANUP => 1 );
+	system("cd $temp_dir; git-init >/dev/null 2>&1") == 0
+		or die "git-init failed; rc=$?";
+	fast_abs_path($temp_dir);
+}
+
+use Cwd;
+
+sub in_empty_repo {
+	my $coderef = shift;
+	my $old_wd = getcwd;
+	my $path = mk_tmp_repo();
+	chdir($path);
+	$coderef->();
+	chdir($old_wd);
+}
+
+use Git;
+sub tmp_git {
+	Git->repository(mk_tmp_repo);
+}
+
+# return an array ref of two unprivileged ports
+sub random_port_pair {
+	my $port = int(rand(2**16-1024-1)+1024);
+	[ $port, $port + 1 ];
+}
+
+1;
+
+# Local Variables:
+#   mode: cperl
+#   cperl-brace-offset: 0
+#   cperl-continued-brace-offset: 0
+#   cperl-indent-level: 8
+#   cperl-label-offset: -8
+#   cperl-merge-trailing-else: nil
+#   cperl-continued-statement-offset: 8
+#   cperl-indent-parens-as-block: t
+#   cperl-indent-wrt-brace: nil
+# End:
+#
+# vim: vim:tw=78:sts=0:noet
diff --git a/t/t9700/config.t b/t/t9700/config.t
new file mode 100644
index 0000000..395a5c9
--- /dev/null
+++ b/t/t9700/config.t
@@ -0,0 +1,127 @@
+#!/usr/bin/env perl -- -w
+
+use TestUtils;
+use Test::More no_plan;
+use strict;
+
+use Error qw(:try);
+
+use_ok("Git::Config");
+
+in_empty_repo sub {
+	my $git = Git->repository;
+	$git->command_oneline("config", "foo.bar", "baz");
+	$git->command_oneline("config", "list.value", "one");
+	$git->command_oneline("config", "--add", "list.value", "two");
+	$git->command_oneline("config", "foo.intval", "12g");
+	$git->command_oneline("config", "foo.false.val", "false");
+	$git->command_oneline("config", "foo.true.val", "yes");
+
+	my $conf = Git::Config->new();
+	ok($conf, "constructed a new Git::Config");
+	isa_ok($conf, "Git::Config", "Git::Config->new()");
+
+	is($conf->config("foo.bar"), "baz", "read single line");
+	$conf->config("foo.bar", "frop");
+	like($git->command_oneline("config", "foo.bar"), qr/frop/,
+		"->config() has immediate effect");
+	$conf->autoflush(0);
+	is_deeply(
+		[$conf->config("list.value")],
+		[qw(one two)],
+		"read multi-value item",
+	);
+
+	eval {
+		my $val = $conf->config("list.value");
+	};
+	like ($@, qr{multiple}i,
+	      "produced an error reading a list into a scalar");
+
+	eval {
+		$conf->config("list.value" => "single");
+	};
+	like($@, qr{multiple}i,
+	     "produced an error replacing a list with a scalar");
+
+	ok(eval { $conf->config("foo.bar", [ "baz", "frop"]); 1 },
+		"no error replacing a scalar with a list");
+
+	like($git->command_oneline("config", "foo.bar"), qr/frop/,
+		"->config() no immediate effect with autoflush = 0");
+
+	$conf->flush;
+
+	like($git->command("config", "--get-all", "foo.bar"),
+		qr/baz\s*frop/,
+		"->flush()");
+
+	$conf->config("x.y$$" => undef);
+	my $x = $conf->config("x.y$$");
+	ok(!defined $x, "unset items return undef in scalar context");
+	my @x = $conf->config("x.y$$");
+	ok(@x == 0, "unset items return empty list in list context");
+
+	$conf->config("foo.bar" => undef);
+	@x = $conf->config("foo.bar");
+	ok(@x == 0, "deleted items appear empty immediately");
+	$conf->flush;
+	ok(!eval {
+		$git->command("config", "--get-all", "foo.bar");
+		1;
+	}, "deleted items are removed from the config file");
+
+	$conf->type("foo.intval", "integer");
+	is($conf->type("foo.intval"), "integer",
+	   "->type()");
+	is($conf->config("foo.intval"), 12*1024*1024*1024,
+	   "integer thaw");
+	$conf->config("foo.intval", 1025*1024);
+	$conf->type("foo.intval", "string");
+	is($conf->config("foo.intval"), "1025k",
+	   "integer freeze");
+
+	$conf->type("foo.*.val", "boolean");
+	is($conf->type("foo.this.val"), "boolean",
+	   "wildcard types");
+	is($conf->config("foo.true.val"), 1,
+	   "boolean thaw - 'yes'");
+	is($conf->config("foo.false.val"), 0,
+	   "boolean thaw - 'false'");
+	my $unset = $conf->config("foo.bar.val");
+	is($unset, undef,
+	   "boolean thaw - not present");
+
+	$git->command_oneline("config", "foo.intval", "12g");
+	$git->command_oneline("config", "foo.falseval", "false");
+	$git->command_oneline("config", "foo.trueval", "on");
+
+	SKIP:{
+		if (eval {
+			$git->command(
+				"config", "--global",
+				"--get-all", "foo.bar"
+			       );
+			1;
+		}) {
+			skip "someone set foo.bar in global config", 1;
+		}
+		my @foo_bar = $conf->global("foo.bar");
+		is_deeply(\@foo_bar, [], "->global() reading only");
+	}
+};
+
+
+# Local Variables:
+#   mode: cperl
+#   cperl-brace-offset: 0
+#   cperl-continued-brace-offset: 0
+#   cperl-indent-level: 8
+#   cperl-label-offset: -8
+#   cperl-merge-trailing-else: nil
+#   cperl-continued-statement-offset: 8
+#   cperl-indent-parens-as-block: t
+#   cperl-indent-wrt-brace: nil
+# End:
+#
+# vim: vim:tw=78:sts=0:noet
-- 
1.6.0
