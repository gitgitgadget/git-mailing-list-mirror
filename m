From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/3] git-svn: use YAML format for mergeinfo cache when
 possible
Date: Sat, 9 Jun 2012 17:35:35 -0500
Message-ID: <20120609223535.GG28412@burratino>
References: <1313979422-21286-1-git-send-email-jgross@mit.edu>
 <20110823081546.GA28091@dcvr.yhbt.net>
 <7vobzgrrbg.fsf@alter.siamese.dyndns.org>
 <20120527192541.GA29490@burratino>
 <20120527201450.GA3630@dcvr.yhbt.net>
 <20120609222039.GD28412@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jason Gross <jgross@MIT.EDU>,
	git@vger.kernel.org,
	Sandro Weiser <sandro.weiser@informatik.tu-chemnitz.de>,
	Bdale Garbee <bdale@gag.com>, Andrew Myrick <amyrick@apple.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 00:36:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdUGZ-00068X-8h
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 00:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751968Ab2FIWfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jun 2012 18:35:41 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51436 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843Ab2FIWfk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2012 18:35:40 -0400
Received: by yenm10 with SMTP id m10so1932341yen.19
        for <git@vger.kernel.org>; Sat, 09 Jun 2012 15:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=fr7COdyNbPKMYuJE//WFRADGtQZ6FSGlkxwcfQ2EkHA=;
        b=rdQflJLSL8+4AvKV6sH6OrI3uE928sraydhaWaqjZLizCQTv19XdQ/kP3x81tqKwIp
         dcwEyJAfoyas63vt8Kkw4Xcq79OEYZOvBIFD43OXFOLtVMGu+OLFRmIoEdarAa3oGbWC
         yGtFEnY17mu56XGo0rVutW+djZgvHnsO+zaCZigtKpDLSvKHm5RMsZ+1Bme8fQJCvoKs
         TAxRxvfTvEEBkBO+vHmrChHtDA3FklsZ/jkQ8DE6CQ573/ltVzrhNllMnr99XvjOBuvr
         K12f9zQbgxX6VRuJUWV9y2JS60hQA6UUJP3yV2uKHzcRXlZOdgRJPAjXuCz5lrgSpORV
         m4Ow==
Received: by 10.236.78.36 with SMTP id f24mr8958165yhe.20.1339281339772;
        Sat, 09 Jun 2012 15:35:39 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id h3sm17003544anm.20.2012.06.09.15.35.37
        (version=SSLv3 cipher=OTHER);
        Sat, 09 Jun 2012 15:35:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120609222039.GD28412@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199564>

Since v1.7.0-rc2~11 (git-svn: persistent memoization, 2010-01-30),
git-svn has maintained some private per-repository caches in
.git/svn/.caches to avoid refetching and recalculating some
mergeinfo-related information with every "git svn fetch".

These caches use the 'nstore' format from the perl core module
Storable, which can be read and written quickly and was designed for
transfer over the wire (the 'n' stands for 'network').  This format is
endianness-independent and independent of floating-point
representation.

Unfortunately the format is *not* independent of the perl version ---
new perl versions will write files that very old perl cannot read.
Worse, the format is not independent of the size of a perl integer.
So if you toggle perl's use64bitint compile-time option, then using
'git svn fetch' on your old repositories produces errors like this:

	Byte order is not compatible at ../../lib/Storable.pm (autosplit
	into ../../lib/auto/Storable/_retrieve.al) line 380, at
	/usr/share/perl/5.12/Memoize/Storable.pm line 21

That is, upgrading perl to a version that uses use64bitint for the
first time makes git-svn suddenly refuse to fetch in existing
repositories.  Removing .git/svn/.caches lets git-svn recover.

It's time to switch to a platform independent serializer backend with
better compatibility guarantees.  This patch uses YAML::Any.

Other choices were considered:

 - thawing data from Data::Dumper involves "eval".  Doing that without
   creating a security risk is fussy.

 - the JSON API works on scalars in memory and doesn't provide a
   standard way to serialize straight to disk.

YAML::Any is reasonably fast and has a pleasant API.  In most
backends, LoadFile() reads the entire file into a scalar anyway and
converts it as a second step, but having an interface that allows the
deserialization to happen on the fly without a temporary is still a
comfort.

YAML::Any is not a core perl module, so we take care to use it when
and only when it is available.  Installations without that module
should fall back to using Storable with all its quirks, keeping their
cache files in

	.git/svn/.caches/*.db

Installations with YAML peacefully coexist by keeping a separate set
of cache files in

	.git/svn/.caches/*.yaml.

In most cases, switching between is a one-time thing, so it doesn't
seem worth the complication to migrate existing caches.

The upshot: after this patch, as long as YAML::Any is installed you
can move your git repository between machines with different perl
installations and "git svn fetch" will work fine.  If you do not have
YAML::Any, the behavior is unchanged (and in particular does not get
any worse).

Reported-by: Sandro Weiser <sandro.weiser@informatik.tu-chemnitz.de>
Reported-by: Bdale Garbee <bdale@gag.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks for reading.

 git-svn.perl                 |   31 +++++++++++---
 perl/Git/SVN/Memoize/YAML.pm |   93 ++++++++++++++++++++++++++++++++++++++++++
 perl/Makefile.PL             |    1 +
 3 files changed, 119 insertions(+), 6 deletions(-)
 create mode 100644 perl/Git/SVN/Memoize/YAML.pm

diff --git a/git-svn.perl b/git-svn.perl
index 24c0af2e..0b074c4c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2055,6 +2055,10 @@ use Time::Local;
 use Memoize;  # core since 5.8.0, Jul 2002
 use Memoize::Storable;
 use POSIX qw(:signal_h);
+my $can_use_yaml;
+BEGIN {
+	$can_use_yaml = eval { require Git::SVN::Memoize::YAML; 1};
+}
 
 my ($_gc_nr, $_gc_period);
 
@@ -3577,6 +3581,17 @@ sub has_no_changes {
 		command_oneline("rev-parse", "$commit~1^{tree}"));
 }
 
+sub tie_for_persistent_memoization {
+	my $hash = shift;
+	my $path = shift;
+
+	if ($can_use_yaml) {
+		tie %$hash => 'Git::SVN::Memoize::YAML', "$path.yaml";
+	} else {
+		tie %$hash => 'Memoize::Storable', "$path.db", 'nstore';
+	}
+}
+
 # The GIT_DIR environment variable is not always set until after the command
 # line arguments are processed, so we can't memoize in a BEGIN block.
 {
@@ -3589,22 +3604,26 @@ sub has_no_changes {
 		my $cache_path = "$ENV{GIT_DIR}/svn/.caches/";
 		mkpath([$cache_path]) unless -d $cache_path;
 
-		tie my %lookup_svn_merge_cache => 'Memoize::Storable',
-		    "$cache_path/lookup_svn_merge.db", 'nstore';
+		my %lookup_svn_merge_cache;
+		my %check_cherry_pick_cache;
+		my %has_no_changes_cache;
+
+		tie_for_persistent_memoization(\%lookup_svn_merge_cache,
+		    "$cache_path/lookup_svn_merge");
 		memoize 'lookup_svn_merge',
 			SCALAR_CACHE => 'FAULT',
 			LIST_CACHE => ['HASH' => \%lookup_svn_merge_cache],
 		;
 
-		tie my %check_cherry_pick_cache => 'Memoize::Storable',
-		    "$cache_path/check_cherry_pick.db", 'nstore';
+		tie_for_persistent_memoization(\%check_cherry_pick_cache,
+		    "$cache_path/check_cherry_pick");
 		memoize 'check_cherry_pick',
 			SCALAR_CACHE => 'FAULT',
 			LIST_CACHE => ['HASH' => \%check_cherry_pick_cache],
 		;
 
-		tie my %has_no_changes_cache => 'Memoize::Storable',
-		    "$cache_path/has_no_changes.db", 'nstore';
+		tie_for_persistent_memoization(\%has_no_changes_cache,
+		    "$cache_path/has_no_changes");
 		memoize 'has_no_changes',
 			SCALAR_CACHE => ['HASH' => \%has_no_changes_cache],
 			LIST_CACHE => 'FAULT',
diff --git a/perl/Git/SVN/Memoize/YAML.pm b/perl/Git/SVN/Memoize/YAML.pm
new file mode 100644
index 00000000..9676b8f2
--- /dev/null
+++ b/perl/Git/SVN/Memoize/YAML.pm
@@ -0,0 +1,93 @@
+package Git::SVN::Memoize::YAML;
+use warnings;
+use strict;
+use YAML::Any ();
+
+# based on Memoize::Storable.
+
+sub TIEHASH {
+	my $package = shift;
+	my $filename = shift;
+	my $truehash = (-e $filename) ? YAML::Any::LoadFile($filename) : {};
+	my $self = {FILENAME => $filename, H => $truehash};
+	bless $self => $package;
+}
+
+sub STORE {
+	my $self = shift;
+	$self->{H}{$_[0]} = $_[1];
+}
+
+sub FETCH {
+	my $self = shift;
+	$self->{H}{$_[0]};
+}
+
+sub EXISTS {
+	my $self = shift;
+	exists $self->{H}{$_[0]};
+}
+
+sub DESTROY {
+	my $self = shift;
+	YAML::Any::DumpFile($self->{FILENAME}, $self->{H});
+}
+
+sub SCALAR {
+	my $self = shift;
+	scalar(%{$self->{H}});
+}
+
+sub FIRSTKEY {
+	'Fake hash from Git::SVN::Memoize::YAML';
+}
+
+sub NEXTKEY {
+	undef;
+}
+
+1;
+__END__
+
+=head1 NAME
+
+Git::SVN::Memoize::YAML - store Memoized data in YAML format
+
+=head1 SYNOPSIS
+
+    use Memoize;
+    use Git::SVN::Memoize::YAML;
+
+    tie my %cache => 'Git::SVN::Memoize::YAML', $filename;
+    memoize('slow_function', SCALAR_CACHE => [HASH => \%cache]);
+    slow_function(arguments);
+
+=head1 DESCRIPTION
+
+This module provides a class that can be used to tie a hash to a
+YAML file.  The file is read when the hash is initialized and
+rewritten when the hash is destroyed.
+
+The intent is to allow L<Memoize> to back its cache with a file in
+YAML format, just like L<Memoize::Storable> allows L<Memoize> to
+back its cache with a file in Storable format.  Unlike the Storable
+format, the YAML format is platform-independent and fairly stable.
+
+Carps on error.
+
+=head1 DIAGNOSTICS
+
+See L<YAML::Any>.
+
+=head1 DEPENDENCIES
+
+L<YAML::Any> from CPAN.
+
+=head1 INCOMPATIBILITIES
+
+None reported.
+
+=head1 BUGS
+
+The entire cache is read into a Perl hash when loading the file,
+so this is not very scalable.
diff --git a/perl/Makefile.PL b/perl/Makefile.PL
index 08afdcb2..2c20290f 100644
--- a/perl/Makefile.PL
+++ b/perl/Makefile.PL
@@ -27,6 +27,7 @@ MAKE_FRAG
 my %pm = (
 	'Git.pm' => '$(INST_LIBDIR)/Git.pm',
 	'Git/I18N.pm' => '$(INST_LIBDIR)/Git/I18N.pm',
+	'Git/SVN/Memoize/YAML.pm' => '$(INST_LIBDIR)/Git/SVN/Memoize/YAML.pm',
 	'Git/SVN/Fetcher.pm' => '$(INST_LIBDIR)/Git/SVN/Fetcher.pm',
 	'Git/SVN/Editor.pm' => '$(INST_LIBDIR)/Git/SVN/Editor.pm',
 	'Git/SVN/Prompt.pm' => '$(INST_LIBDIR)/Git/SVN/Prompt.pm',
-- 
1.7.10
