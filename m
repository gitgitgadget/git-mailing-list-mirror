From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH (WIP)] Git.pm: Add get_config() method and related subroutines
Date: Thu, 3 Jul 2008 18:24:53 +0200
Message-ID: <200807031824.55958.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, Lea Wiemann <lewiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 03 18:27:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEReA-0001Rx-P7
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 18:27:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbYGCQZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 12:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751694AbYGCQZs
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 12:25:48 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:49981 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492AbYGCQZq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 12:25:46 -0400
Received: by yw-out-2324.google.com with SMTP id 9so372832ywe.1
        for <git@vger.kernel.org>; Thu, 03 Jul 2008 09:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=qb/86I+rfha0D8y5I3hWE5L3VQ22dUPr/1i/zzQE4Uw=;
        b=FsKp22wZjpBOeiDmKaJcgE601PvNaXQIVg9l1z9qA10C0gd30Yvj0ZoST3RbK2A+Dz
         Q3OspNMJgl//WzERLKu4Rq4gqMCztH5g8xWh0tRakMYWj6ypzJvBE5dPU7dgzUVJvVpm
         hhholY6BpYFNFPFRXnEs2q2OQH39+mZZty7RA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=uiDfNl6t+Alns2trUobBhNF+6kRmJ04AaC8TJae3MpQMLGhUcUeCqsLtgeKUvPj4+d
         IeOaue62cNOZ7rNgaAkEEuFdvmpbG2qtIUMOV7u2UJm6L5iYycBcNWuaESTGgtstCB7c
         AG0CM3/+begA/ZYw13rWJMmhBCRyIY+vuQ1LQ=
Received: by 10.114.113.1 with SMTP id l1mr851629wac.47.1215102330323;
        Thu, 03 Jul 2008 09:25:30 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.253.104])
        by mx.google.com with ESMTPS id w43sm174024hsa.3.2008.07.03.09.24.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Jul 2008 09:25:29 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87296>

Add get_config([PREFIX]) method, taken from current gitweb, which
parses whole (or selected part) config file into hash (reading
"git config -z -l" output).  This means that we do not have to call
one git command per config variable... but it also means that
conversion to boolean, to integer, or to color must be done from
within Perl; you can use config_val_to_* functions for that.

NOTE: Currently config_val_to_color and config_val_to_colorbool
are lacking; error checking is more relaxed in config_val_to_bool().

One advantage of ->get_config() over ->config(VARIABLE) is that it can
deal correctly with "no value" variables: they are !defined(), but
they do exists().


Tests are included; while at it add some more tests for generic
->config*() methods.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Cc-ed Petr "Pasky" Baudis, who is author of Git.pm, and Lea Wiemann,
who is author of Git.pm test t/t9700-perl-git.sh.  Lea is also
working on object interface to git in Perl (Git::Repo etc.); I hope
I am not repeating her work.


This is WIP (Work In Progress) as much as an RFC (Request For Comments)
patch, as there are a few things which are not finished or not cleaned
up:

 * there is no config_val_to_*() equivalent of ->get_colorbool() and
   ->get_color() methods to convert config values to ANSI color escape
   sequences.

 * config_val_to_bool() and config_val_to_int() does not error out
   on values which are not boolean or not integer, contrary to what
   usage of "git config --bool" and "git config --int" does in
   ->config_bool() and ->config_int() methods, respectively.

   This should be fairly easy to add by manually throwing Error...
   the minor trouble would be to follow what ->config_bool etc. does.

 * neither config_val_to_bool nor config_val_to_int are exported.

 * tests contain some cruft in 'set up test repository' stage, which
   was inspected manually that is correct (by examining Data::Dumper
   output of new ->get_config() method against tested config file),
   but for which actual tests were written.


There are also a few things which I'd like some comments about:

 * Do config_val_to_bool and config_val_to_int should be exported
   by default?

 * Should config_val_to_bool and config_val_to_int throw error or
   just return 'undef' on invalid values?  One can check if variable
   is defined using "exists($config_hash{'varname'})".

 * How config_val_to_bool etc. should be named? Perhaps just
   config_to_bool, like in gitweb?

 * Is "return wantarray ? %config : \%config;" DWIM-mery good style?
   I am _not_ a Perl hacker...

 * Should ->get_config() use ->command_output_pipe, or simpler
   ->command() method, reading whole config into array?

 * What should ->get_config() method be named? ->get_config()
   or perhaps ->config_hash(), or ->config_hashref()?

 * What should ->get_config() have as an optional parameter:
   PREFIX (/^$prefix/o), or simply SECTION (/^(?:$section)\./o)?

 * Should config_val_to_* be tested against ->config_* output?

 * Should we perltie hash?

As this is an RFC I have not checked if manpage (generated from
embedded POD documentation) renders correctly.

 perl/Git.pm         |  107 +++++++++++++++++++++++++++++++++++++++++++++++++++
 t/t9700-perl-git.sh |   10 ++++-
 t/t9700/test.pl     |   32 +++++++++++++++
 3 files changed, 148 insertions(+), 1 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 97e61ef..2f4a306 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -668,6 +668,113 @@ sub get_color {
 	return $color;
 }
 
+=item get_config ( [ PREFIX ] )
+
+Return hash (in list context) or hashref of the whole configuration,
+in the similar manner that C<config --list>, optionally limited
+to config entries which fully qualified key (variable) name begins
+with C<PREFIX> (usually name of section).
+
+The keys of returned hash are fully qualified value names (section,
+optional subsection, and variable name joined using '.'). If variable
+is set only once its value is used as hash value, if variable is set
+multiple times array reference of all values is used as hash value
+for given key.
+
+Please remember that section names and key names in config hash keys
+(in fully qualified config variable name) are normalized, which means
+that they are in lowercase.
+
+=cut
+
+sub get_config {
+	my ($self, $prefix) = _maybe_self(@_);
+
+	my @cmd = ('config');
+	unshift @cmd, $self if $self;
+	my ($fh, $ctx) = command_output_pipe(@cmd, '-z', '--list');
+
+	my %config;
+	local $/ = "\0";
+	$prefix = quotemeta($prefix) if defined($prefix);
+	while (my $keyval = <$fh>) {
+		chomp $keyval;
+		my ($key, $value) = split(/\n/, $keyval, 2);
+
+		if (!defined $prefix || $key =~ /^$prefix/o) {
+			# store multiple values for single key as anonymous array reference
+			# single values stored directly in the hash, not as [ <value> ]
+			if (!exists $config{$key}) {
+				$config{$key} = $value;
+			} elsif (!ref $config{$key}) {
+				$config{$key} = [ $config{$key}, $value ];
+			} else {
+				push @{$config{$key}}, $value;
+			}
+		}
+	}
+	my @ctx = ($fh, $ctx);
+	unshift @ctx, $self if $self;
+	command_close_pipe(@ctx);
+
+	return wantarray ? %config : \%config;
+}
+
+=item config_val_to_bool ( VALUE )
+
+Convert config value C<VALUE> to boolean; no value, number > 0, 'true'
+and 'yes' values are true, rest of values are treated as false (never
+as error, at least for now).
+
+This function is meant to be used on values in hash returned by
+C<get_config>.
+
+=cut
+
+sub config_val_to_bool {
+	my $val = shift;
+
+	# strip leading and trailing whitespace
+	$val =~ s/^\s+//;
+	$val =~ s/\s+$//;
+
+	return (!defined $val ||               # section.key
+	        ($val =~ /^\d+$/ && $val) ||   # section.key = 1
+	        ($val =~ /^(?:true|yes)$/i));  # section.key = true
+}
+
+=item config_val_to_int ( VALUE )
+
+Convert config value C<VALUE> to simple decimal number; an optional
+value suffix of 'k', 'm', or 'g' will cause the value to be multiplied
+by 1024, 1048576 (1024 x 1024), or 1073741824 (1024 x 1024 x 1024),
+respectively (unknown unit is treated as 1, at least for now).
+
+It does not throw error on argument which is not integer.
+
+This function is meant to be used on values in hash returned by
+C<get_config>.
+
+=cut
+
+sub config_val_to_int {
+	my $val = shift;
+
+	# strip leading and trailing whitespace
+	$val =~ s/^\s+//;
+	$val =~ s/\s+$//;
+
+	if (my ($num, $unit) = ($val =~ /^([0-9]*)([kmg])$/i)) {
+		$unit = lc($unit);
+		# unknown unit is treated as 1
+		return $num * ($unit eq 'g' ? 1073741824 :
+		               $unit eq 'm' ?    1048576 :
+		               $unit eq 'k' ?       1024 : 1);
+	}
+	return $val;
+}
+
+
 =item ident ( TYPE | IDENTSTR )
 
 =item ident_person ( TYPE | IDENTSTR | IDENTARRAY )
diff --git a/t/t9700-perl-git.sh b/t/t9700-perl-git.sh
index 9706ee5..af6ac58 100755
--- a/t/t9700-perl-git.sh
+++ b/t/t9700-perl-git.sh
@@ -34,9 +34,17 @@ test_expect_success \
      git-config --add test.booltrue true &&
      git-config --add test.boolfalse no &&
      git-config --add test.boolother other &&
-     git-config --add test.int 2k
+     git-config --add test.int 2k &&
+     git-config --add teSt.duP val1 &&
+     git-config --add tesT.Dup val2 &&
+     git-config --add test.subsection.noDup val &&
+     git-config --add test.subSection.nodup val &&
+     git-config --add "test.sub # \\ \" '\'' section.key" val &&
+     echo "[test] noval" >> .git/config
      '
 
+test_debug 'cat .git/config'
+
 test_external_without_stderr \
     'Perl API' \
     perl ../t9700/test.pl
diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index 4d23125..4dd8bbf 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -11,6 +11,8 @@ use Cwd;
 use File::Basename;
 use File::Temp;
 
+use Data::Dumper;
+
 BEGIN { use_ok('Git') }
 
 # set up
@@ -30,11 +32,36 @@ is($r->config_int("test.int"), 2048, "config_int: integer");
 is($r->config_int("test.nonexistent"), undef, "config_int: nonexistent");
 ok($r->config_bool("test.booltrue"), "config_bool: true");
 ok(!$r->config_bool("test.boolfalse"), "config_bool: false");
+ok($r->config_bool("test.noval"), "config_bool: true (noval)");
 our $ansi_green = "\x1b[32m";
 is($r->get_color("color.test.slot1", "red"), $ansi_green, "get_color");
 # Cannot test $r->get_colorbool("color.foo")) because we do not
 # control whether our STDOUT is a terminal.
 
+# testing get_config() and related functions/subroutines/methods
+is_deeply(scalar($r->get_config('color.')), {'color.test.slot1' => 'green'},
+          "get_config('color.')");
+my %config;
+ok(%config = $r->get_config(), "get_config(): list context");
+is($config{"test.string"}, "value",
+	"\%config scalar: string");
+is_deeply($config{"test.dupstring"}, ["value1", "value2"],
+	"\%config array: string");
+is($config{"test.nonexistent"}, undef,
+	"\%config scalar: nonexistent (undef)");
+ok(!exists($config{"test.nonexistent"}),
+	"\%config scalar: nonexistent (!exists)");
+is(Git::config_val_to_int($config{"test.int"}), 2048,
+	"config_val_to_int: integer");
+is(Git::config_val_to_int($config{"test.nonexistent"}), undef,
+	"config_val_to_int: nonexistent");
+ok( Git::config_val_to_bool($config{"test.booltrue"}),
+	"config_val_to_bool: true");
+ok(!Git::config_val_to_bool($config{"test.boolfalse"}),
+	"config_val_to_bool: false");
+ok( Git::config_val_to_bool($config{"test.noval"}),
+	"config_val_to_bool: true (noval)");
+
 # Failure cases for config:
 # Save and restore STDERR; we will probably extract this into a
 # "dies_ok" method and possibly move the STDERR handling to Git.pm.
@@ -43,6 +70,11 @@ eval { $r->config("test.dupstring") };
 ok($@, "config: duplicate entry in scalar context fails");
 eval { $r->config_bool("test.boolother") };
 ok($@, "config_bool: non-boolean values fail");
+TODO: {
+	$TODO = "config_val_to_bool returns false on non-bool values";
+	eval { Git::config_val_to_bool($config{"test.boolother"}) };
+	ok($@, "config_val_to_bool: non-boolean values fail");
+}
 open STDERR, ">&", $tmpstderr or die "cannot restore STDERR";
 
 # ident
-- 
1.5.6.1
