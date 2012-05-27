From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH] git-svn: use YAML format for mergeinfo cache when
 possible
Date: Sun, 27 May 2012 14:25:41 -0500
Message-ID: <20120527192541.GA29490@burratino>
References: <1313979422-21286-1-git-send-email-jgross@mit.edu>
 <20110823081546.GA28091@dcvr.yhbt.net>
 <7vobzgrrbg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, Jason Gross <jgross@MIT.EDU>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 27 21:26:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYj6G-0003tV-Uv
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 21:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934Ab2E0TZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 May 2012 15:25:56 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:55103 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433Ab2E0TZz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2012 15:25:55 -0400
Received: by obbtb18 with SMTP id tb18so4285672obb.19
        for <git@vger.kernel.org>; Sun, 27 May 2012 12:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=DGJ9VBTw0Uu4q2ErtgVxqNmgZseClHZa9RNjXNfe0Rc=;
        b=j78qF7fzyOpoa6DN4QSQgz4TF/EgRA+1k8e7UwW9/4rpZzxz8HHgVmvENsnQxSEJOl
         iBw0+WdZ4c83DVJwKZ+E7zc8LmaFO7o9e1gJYy5L9E6awaCZa6+SfNsmWGp9w6Fwy8/q
         CsOfeznJZ3q4R41ph3AeZX9E7sxjKyrKnVTbOea3ftNhTCYhXZV177Qe4zyr6IS25fJ6
         ZqQepa0REvEucWNNjYQSIbe/RPonApdAgSH/Ic4CVUcRvtbBZK79ut2iOuH4c+N4I2+6
         D9EXRCuuZdYlgDFQYi50ONY6NckINhjr72STc+XXLeSFrZVbDEbmVj0Bf+wHgabRWi8t
         37XQ==
Received: by 10.50.209.41 with SMTP id mj9mr3035478igc.41.1338146754953;
        Sun, 27 May 2012 12:25:54 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id k6sm7777643igw.14.2012.05.27.12.25.53
        (version=SSLv3 cipher=OTHER);
        Sun, 27 May 2012 12:25:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vobzgrrbg.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198616>

In August, 2011, Junio C Hamano wrote:
> Eric Wong <normalperson@yhbt.net> writes:

>> Something like this (untested):
>>
>> 	use Config;
>>
>> 	my $cache_path = "$ENV{GIT_DIR}/svn/.caches/";
>> 	$cache_path .= "$Config{use64bitint}.$Storable::VERSION/";
[...]
> I am wondering if memoize can be told to use a platform independent
> serializer backend that is reasonably efficient.

Here is a rough sketch.  It uses YAML::Any.

Other choices were considered:

 - thawing data from Data::Dumper involves "eval".  Doing that
   without creating a security risk is fussy

 - the JSON API only works on scalars in memory and doesn't provide
   a standard way to serialize straight to disk

YAML::Any is reasonably fast and has a pleasant API.  In most backends,
LoadFile() seems to read the entire file into a scalar anyway and
convert it as a second step, but having an interface that allows the
deserialization to happen on the fly without a temporary is still a
comfort.

YAML::Any is not a core perl module.  This patch uses it when and only
when it is available.  Installations without that module fall back to
using Storable with all its quirks, keeping their cache files in

	.git/svn/.caches/*.db

Installations with YAML peacefully coexist by keeping a new set of
cache files in

	.git/svn/.caches/*.yaml.

In most cases, switching between is a one-time thing, so it doesn't
seem worth the effort to copy over the existing caches.

My personal motivation is the ability to upgrade or downgrade perl or
change perl's use64bitint compile-time parameter without having to
invalidate caches or (worse, what users unaware of .git/svn/.caches
would probably do) reclone repositories.  The Storable format is not
stable enough for forward-compatibility.

Seems to work.  I haven't run any benchmarks.  

Thoughts?  Improvements?

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git-svn.perl |  126 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 120 insertions(+), 6 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index c84842ff..96b6046a 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2039,6 +2039,101 @@ sub gc_directory {
 	}
 }
 
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
+	'Fake hash from Memoize::YAML';
+}
+
+sub NEXTKEY {
+	undef;
+}
+
+1;
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
+    tie my %cache => 'Memoize::YAML', $filename;
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
+
+Error handling is awkward.
+=cut
+
+
 package Git::SVN;
 use strict;
 use warnings;
@@ -2056,6 +2151,10 @@ use Time::Local;
 use Memoize;  # core since 5.8.0, Jul 2002
 use Memoize::Storable;
 use POSIX qw(:signal_h);
+my $can_use_yaml;
+BEGIN {
+	$can_use_yaml = eval { require YAML::Any; 1};
+}
 
 my ($_gc_nr, $_gc_period);
 
@@ -3578,6 +3677,17 @@ sub has_no_changes {
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
@@ -3590,22 +3700,26 @@ sub has_no_changes {
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
-- 
1.7.10
