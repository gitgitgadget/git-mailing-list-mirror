From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH 3/3] gitweb: use new Git::Repo API, and add optional caching
Date: Fri, 11 Jul 2008 03:11:48 +0200
Message-ID: <1215738708-5212-1-git-send-email-LeWiemann@gmail.com>
References: <4876B223.4070707@gmail.com>
Cc: John Hawley <warthog19@eaglescrag.net>,
	Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 11 03:13:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH7CY-000351-HR
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 03:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755513AbYGKBM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 21:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755287AbYGKBM2
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 21:12:28 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:12590 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753921AbYGKBMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 21:12:25 -0400
Received: by py-out-1112.google.com with SMTP id p76so2026429pyb.10
        for <git@vger.kernel.org>; Thu, 10 Jul 2008 18:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:from;
        bh=4Cm1j+jf58bRZTNBWam5TLkBC7pml17nJKfaIrvJljE=;
        b=UEXoqIpmlqixi0CVNUUUWgY9mw7M+g+6c7VtP6ZWXtlu/c0AroEOW9kicAehU8QR48
         gblZ7Q+GXu/TOZYCq9ILpllpn7eKDZxBUDDNFjHWGWGd1tVLI4/JvNx9HPdtq8iwc92S
         fOhfgkWHBiffVWzVdJduP9IXZ+ReRcYD0maD4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:in-reply-to:references:from;
        b=E6o2dWPxe4iBOK55orcAEo1Olj4r12CQsLq003Jz60ZzvWChGiuAXPKSwCRL/ASp8z
         s53ReR488NcdhHGUduXZ5Tq3NjHIgQuE5M8mUBZID0uRbwKDZiFOIu+5nvPXxsAfRYqZ
         pROXGU0THj41DyE4WTSaEAXbNANANKpKXWcpE=
Received: by 10.114.176.1 with SMTP id y1mr12753555wae.118.1215738741795;
        Thu, 10 Jul 2008 18:12:21 -0700 (PDT)
Received: from fly ( [91.33.220.178])
        by mx.google.com with ESMTPS id 13sm1979362fks.6.2008.07.10.18.11.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Jul 2008 18:12:21 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <lea@fly>)
	id 1KH7Aq-0001MQ-AR; Fri, 11 Jul 2008 03:11:48 +0200
X-Mailer: git-send-email 1.5.6.2.456.g63fc0
In-Reply-To: <4876B223.4070707@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88071>

Gitweb now uses the Git::Repo API; this change is behavior-preserving,
except for slightly more aggressive error handling; see below.

This patch also adds an optional caching layer for caching repository
data in memory and (for larger cacheable items, like blobs, snapshots,
or diffs) on disk.

Other minor changes:

- Gitweb would previously accept invalid input and either (a) display
  nothing, (b) display an obscure error message, or (c) proceed as
  normal since the parameter happens to be unused in the particular
  code path used.  This has changed in that gitweb will check for
  parameter correctness more aggressively, and display meaningful
  error messages.  This change is only relevant if you manually edit
  gitweb's CGI parameters, since gitweb only generates valid links.

- Empty projects:

  - Only display summary link for empty projects in project list to
    avoid broken links (yielding 404).

  - Slim down summary page for empty projects to avoid some broken
    links and unnecessary vertical space.

  - Sort empty projects at the bottom of the project list when sorting
    by last change.

  - Add test for empty projects to t9503 (the Mechanize test), now
    that there no broken links anymore.

- For HTML pages, remove the "Expires" HTTP response header, and add
  "Cache-Control: no-cache" instead.  This is because pages can
  contain dynamic content (like the subject of the latest commit), so
  the Expires headers would be wrong.

  This makes gitweb's responsiveness slightly worse, but it will get
  much better once If-Last-Modified is implemented.  It's better to be
  correct than to be convenient here, since having to press the reload
  button makes for lousy user experience (IOW, users should be able to
  always trust gitweb's output).

  Raw diffs and blobs still get the Expires header, where appropriate.

- Add a $page_info option to display cache stats at the bottom of each
  page; the option is named generically to allow for adding non-cache
  page info there at some point (timings perhaps?).

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
It's all documented of course :-), but for the impatient here's a
snippet for gitweb_config.perl to activate caching:

use Cache::Memcached;
$cache = Cache::Memcached->new( { servers => ['localhost:11211'], compress_threshold => 1000 } );
$large_cache_root = '/home/lewiemann/gitweb-cache';
$large_cache_case_sensitive = 1;
# Invalidate cache on changes to gitweb without version number bump;
# useful for development.
$cache_key = (stat '/home/lewiemann/gitweb')[9] . (stat '/home/lewiemann/gitweb/gitweb.cgi')[9];
# Display detailed cache info at the bottom of each page.
$page_info = 2;

A live demo is here: http://odin3.kernel.org/git-lewiemann/

 Makefile                               |   27 +-
 gitweb/README                          |   14 +
 gitweb/gitweb.css                      |   16 +
 gitweb/gitweb.perl                     | 1415 +++++++++++++++++++-------------
 t/t9500-gitweb-standalone-no-errors.sh |    4 +-
 t/t9503-gitweb-Mechanize.sh            |   10 +
 t/t9503/test.pl                        |    5 +
 7 files changed, 911 insertions(+), 580 deletions(-)

diff --git a/Makefile b/Makefile
index 15f210e..a65aa4d 100644
--- a/Makefile
+++ b/Makefile
@@ -1099,25 +1099,28 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): perl/perl.mak
 perl/perl.mak: GIT-CFLAGS perl/Makefile perl/Makefile.PL
 	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' $(@F)
 
+PERL_USE_LIB_REWRITE = \
+	-e '1{' \
+	-e '	s|\#!.*perl|\#!$(PERL_PATH_SQ)|' \
+	-e '	h' \
+	-e '	s=.*=use lib (split(/:/, \$$ENV{GITPERLLIB} || \"@@INSTLIBDIR@@\"));=' \
+	-e '	H' \
+	-e '	x' \
+	-e '}' \
+	-e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
+	-e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g'
+
 $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
-	sed -e '1{' \
-	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
-	    -e '	h' \
-	    -e '	s=.*=use lib (split(/:/, $$ENV{GITPERLLIB} || "@@INSTLIBDIR@@"));=' \
-	    -e '	H' \
-	    -e '	x' \
-	    -e '}' \
-	    -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
-	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
-	    $@.perl >$@+ && \
+	sed $(PERL_USE_LIB_REWRITE) $@.perl >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
 
 gitweb/gitweb.cgi: gitweb/gitweb.perl
 	$(QUIET_GEN)$(RM) $@ $@+ && \
-	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
+	INSTLIBDIR=`MAKEFLAGS= $(MAKE) -C perl -s --no-print-directory instlibdir` && \
+	sed $(PERL_USE_LIB_REWRITE) \
 	    -e 's|++GIT_VERSION++|$(GIT_VERSION)|g' \
 	    -e 's|++GIT_BINDIR++|$(bindir)|g' \
 	    -e 's|++GITWEB_CONFIG++|$(GITWEB_CONFIG)|g' \
@@ -1125,7 +1128,7 @@ gitweb/gitweb.cgi: gitweb/gitweb.perl
 	    -e 's|++GITWEB_HOME_LINK_STR++|$(GITWEB_HOME_LINK_STR)|g' \
 	    -e 's|++GITWEB_SITENAME++|$(GITWEB_SITENAME)|g' \
 	    -e 's|++GITWEB_PROJECTROOT++|$(GITWEB_PROJECTROOT)|g' \
-	    -e 's|"++GITWEB_PROJECT_MAXDEPTH++"|$(GITWEB_PROJECT_MAXDEPTH)|g' \
+	    -e 's|++GITWEB_PROJECT_MAXDEPTH++|$(GITWEB_PROJECT_MAXDEPTH)|g' \
 	    -e 's|++GITWEB_EXPORT_OK++|$(GITWEB_EXPORT_OK)|g' \
 	    -e 's|++GITWEB_STRICT_EXPORT++|$(GITWEB_STRICT_EXPORT)|g' \
 	    -e 's|++GITWEB_BASE_URL++|$(GITWEB_BASE_URL)|g' \
diff --git a/gitweb/README b/gitweb/README
index 6908036..fb5a027 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -214,6 +214,20 @@ not include variables usually directly set during build):
    Rename detection options for git-diff and git-diff-tree. By default
    ('-M'); set it to ('-C') or ('-C', '-C') to also detect copies, or
    set it to () if you don't want to have renames detection.
+ * $cache
+   To activate caching, set this to an instance of a Cache::Cache
+   compatible cache (e.g. Cache::Memcached).
+ * $large_cache_root
+   A directory in which gitweb will store potentially large cache
+   items (like snapshots or blobs).  Cache items in this directory are
+   not deleted, so you should clean it up yourself periodically.
+   Default: undef (no caching for large items).
+ * $large_cache_case_sensitive
+   Set this to 1 if the file system on which the large cache resides
+   is case sensitive; it will result in a shorter file names.
+ * $page_info
+   Set to 1 to display cache statistics at the bottom of each page;
+   can be used to check whether your cache works.
 
 
 Projects list file format
diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index aa0eeca..849bb8e 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -71,6 +71,22 @@ div.page_footer_text {
 	font-style: italic;
 }
 
+div.page_info {
+	color: #777777;
+	padding: 4px 8px;
+	margin-top: 0.5em;
+	background-color: #ecebe8;
+}
+
+div.page_info p {
+	margin: 0px;
+	padding: 0px;
+}
+
+pre.cache_list {
+	margin: 0.5em 2em;
+}
+
 div.page_body {
 	padding: 8px;
 	font-family: monospace;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 90cd99b..01deca0 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -16,6 +16,9 @@ use Encode;
 use Fcntl ':mode';
 use File::Find qw();
 use File::Basename qw(basename);
+
+use Git::RepoRoot;
+
 binmode STDOUT, ':utf8';
 
 BEGIN {
@@ -161,6 +164,49 @@ our %known_snapshot_format_aliases = (
 	'x-zip' => undef, '' => undef,
 );
 
+# Cache::Cache object to cache data from the repository, or undef for
+# no cache.  You would typically use a Cache::Memcached instance here.
+our $cache = undef;
+
+# Expiration time in seconds for transient cache entries, or undef for
+# no expiration.  (Only used if $cache is defined.)
+#
+# Transient cache entries (like get_sha1('HEAD')) are automatically
+# invalidated when an mtime of either the repository's root directory
+# or of the refs directory or any subdirectory changes.  This
+# mechanism *should* detect changes to the repository reliably if you
+# only use git or rsync to access it, and hence this expiration time
+# can be set very high.  (This does not default to non-expiring
+# [undef] just in case a change goes undetected for some reason.)  You
+# might want to set this to a lower time (e.g. a few minutes) if
+# developers change files in the refs directories on your server by
+# non-standard means (i.e. manually).
+#
+# You can usually go with the default here.
+our $cache_transient_expiration_time = 60 * 60 * 24;
+
+# Directory on disk to hold potentially large cache items (in
+# particular, snapshots, diffs and blobs), or undef for no cache.
+# Cache files will be created in this directory, but they will not be
+# expired; you should periodically delete old files yourself.  Setting
+# $large_cache_root but not $cache is possible, but usually not
+# sensible.
+our $large_cache_root = undef;
+
+# Is the file system on which your large cache resides case-sensitive?
+our $large_cache_case_sensitive = 0;
+
+# Extra cache key component to use.  This should stringify to a string
+# without null bytes; it is used as a means to discard old cache
+# entries whenever this key changes.  Since Gitweb already uses its
+# own version number as a cache key component, you don't normally need
+# this unless you're developing gitweb.
+our $cache_key = undef;
+
+# Display information in the footer of each page (currently only cache
+# statistics): 0 = none, 1 = short, 2 = long.
+our $page_info = 0;
+
 # You define site-wide feature defaults here; override them with
 # $GITWEB_CONFIG as necessary.
 our %feature = (
@@ -376,8 +422,375 @@ if (-e $GITWEB_CONFIG) {
 	do $GITWEB_CONFIG_SYSTEM if -e $GITWEB_CONFIG_SYSTEM;
 }
 
-# version of the core git binary
-our $git_version = qx("$GIT" --version) =~ m/git version (.*)$/ ? $1 : "unknown";
+
+# ======================================================================
+# caching layer
+
+package CachedRepo;
+
+use Digest::MD5 qw(md5_base64 md5_hex);
+use List::Util qw(max);
+
+use base qw(Git::Repo);
+
+# Global statistics, collected across repositories.
+# Hits, misses, sets, and failed_sets are counters, and get_list is an
+# arrayref of keys, where a key is an arrayref of key items.
+our %cache_statistics = (
+	hits => 0, misses => 0, sets => 0, failed_sets => 0, get_list => []);
+our %large_cache_statistics = (
+	hits => 0, misses => 0, sets => 0, failed_sets => 0, get_list => []);
+
+# Options: like Git::Repo->new, and the following:
+# cache: a Cache::Cache conforming cache instance
+# transient_expiration_time: expiration time in seconds for transient
+#     cache entries (like get_hash('HEAD')), or undef; do not set to
+#     30 days or more, since it makes Cache::Memcached hiccup
+sub new {
+	my ($class, %opts) = @_;
+	my $cache = delete $opts{cache};
+	my $large_cache_root = delete $opts{large_cache_root};
+	my $transient_expiration_time = delete $opts{transient_expiration_time};
+	my $self = $class->SUPER::new(%opts);
+	$self->{cache} = $cache;
+	$self->{large_cache_root} = $large_cache_root;
+	$self->{transient_expiration_time} = $transient_expiration_time;
+	return $self;
+}
+
+sub cache { shift->{cache} }
+sub large_cache_root { shift->{large_cache_root} }
+sub transient_expiration_time { shift->{transient_expiration_time} }
+
+# Fast function to generate a unique (short) key for the cache to use.
+# None of the parameters should contain null bytes.  Example:
+# $repo->get_key('sha1', 'HEAD:file1') eq 'dK2M2Y8AsgTpgAmY7PhC3q'
+sub get_key {
+	my $self = shift;
+	# Some caches (like Cache::FileCache) hash keys themselves,
+        # but Cache::Memcached does not like long keys, so we need to
+        # hash them.  MD5 is fine here, since (as of July 2008) there
+        # are only collision attacks, but no practical preimage
+        # attacks on MD5.  Constructing two colliding keys doesn't
+        # seem to pose much of a threat for the cache.  Digest::SHA1
+        # is only in core as of Perl 5.9.
+	return md5_base64(join "\0", $self->_key_items(@_));
+}
+
+# Same as get_key, but returns a case insensitive (but longer) key.
+sub get_case_insensitive_key {
+	my $self = shift;
+	return md5_hex(join "\0", $self->_key_items(@_));
+}
+
+# Return a list of strings that can be used to generate a key.
+sub _key_items {
+	my $self = shift;
+	return map { defined $_ ? " $_" : '' }
+	    ('gitweb', $version, $cache_key, 'project', $self->repo_dir, @_);
+}
+
+# Convenience function: cache_set(\@key, $value, $expire);
+# $expire is boolean and indicates whether an expiry time should be set.
+sub cache_set {
+	my ($self, $key, $value, $expire) = @_;
+	return unless $self->cache;
+	my $expiration_token = $expire ? $self->get_last_modification() : undef;
+	my $ok = $self->cache->set(
+		$self->get_key($expiration_token, @$key), $value,
+		$expire ? $self->transient_expiration_time : ());
+	$ok ? $cache_statistics{sets}++ : $cache_statistics{failed_sets}++;
+	return $ok;
+}
+
+# Convenience function: cache_get(\@key, $expire)
+# $expire must be the same that has been used for cache_set or the
+# lookup will fail.
+sub cache_get {
+	my ($self, $key, $expire) = @_;
+	return unless $self->cache;
+	my $expiration_token = $expire ? $self->get_last_modification() : undef;
+	my $val = $self->cache->get($self->get_key($expiration_token, @$key));
+	defined $val ? $cache_statistics{hits}++ : $cache_statistics{misses}++;
+	push @{$cache_statistics{get_list}},
+	    [$self->repo_dir, $expire ? 1 : 0, @$key];
+	return $val;
+}
+
+# Like Git::Repo->cmd_output, but with an added 'cache' option to
+# indicate that the output can be cached: if 1, it is cached but
+# expires when the repo is modified, if 2, it is cached indefinitely.
+sub cmd_output {
+	my ($self, %opts) = @_;
+	my $key = ['cmd', $opts{max_exit_code}, @{$opts{cmd}}];
+	my $output;
+	unless ($opts{cache} && defined($output = $self->cache_get(
+						$key, $opts{cache} == 1))) {
+		$output = $self->SUPER::cmd_output(%opts);
+		$self->cache_set($key, $output, $opts{cache} == 1) if $opts{cache};
+	}
+	return $output;
+}
+
+# The following methods override the base class (Git::Repo) methods to
+# add caching.
+
+sub get_sha1 {
+	my ($self, $object_id) = @_;
+	my $expire = ($object_id !~ /^[0-9a-f]{40}(?![0-9a-f])/);
+	my $triple = $self->cache_get(['SHA1', $object_id], $expire);
+	unless (defined $triple) {
+		$triple = [$self->SUPER::get_sha1($object_id)];
+		# Do not cache failed lookups -- missing SHA1s would
+		# be permanently cached, but a subsequent push to the
+		# repository might add those missing SHA1s to the
+		# repository.
+		return unless $triple->[0];
+		$self->cache_set(['SHA1', $object_id], $triple, $expire);
+	}
+	return wantarray ? @$triple : $triple->[0];
+}
+
+sub cat_file {
+	my ($self, $sha1) = @_;
+	my $type_content = $self->cache_get(['cat-file', $sha1], 0);
+	unless (defined $type_content) {
+		$type_content = [$self->SUPER::cat_file($sha1)];
+		die 'unexpected empty return value' unless @$type_content;
+		$self->cache_set(['cat-file', $sha1], $type_content, 0);
+	}
+	return wantarray ? @$type_content : $type_content->[1];
+}
+
+# get_commit and get_tag only return empty Commit and Tag objects,
+# which when loaded (lazily), happen to call cat_file and thus are
+# cached as well.
+
+# Mostly copied from base class.
+sub get_path {
+	my ($self, $tree, $file_sha1) = @_;
+	assert_sha1($tree, $file_sha1);
+	# This can be quite large, so use progressive_cmd_output.
+	my $ls_tree_read = $self->progressive_cmd_output(
+		cmd => [qw(ls-tree -r -t), $tree], separator => "\n",
+		cache => 1);
+	while (my $line = $ls_tree_read->()) {
+		if ($line =~ /^[0-9]+ [a-z]+ $file_sha1\t(.+)$/) {
+			while ($ls_tree_read->()) { } # cache it
+			return $1;
+		}
+	}
+	return undef;
+}
+
+sub get_refs {
+	my ($self, $pattern) = @_;
+	my $refs = $self->cache_get(['refs', $pattern], 1);
+	unless (defined $refs ) {
+		$refs = $self->SUPER::get_refs($pattern);
+		$self->cache_set(['refs', $pattern], $refs, 1);
+	}
+	return $refs;
+}
+
+sub name_rev {
+	my ($self, $sha1, $tags_only) = @_;
+	my $name = $self->cache_get(['name-rev', $sha1, $tags_only], 1);
+	unless (defined $name) {
+		# || '' is to cache failed lookups (name_rev doesn't
+		# ever return empty names).
+		$name = $self->SUPER::name_rev($sha1, $tags_only) || '';
+		$self->cache_set(['name-rev', $sha1, $tags_only], $name, 1);
+	}
+	return $name || undef;
+}
+
+# progressive_cmd_output(%opts)
+#
+# Return a coderef that returns a chunk of the output of the given
+# command each time it is called, or undef when the output is
+# exhausted.  For the output to be cached, it must be read until the
+# coderef returns undef, otherwise it will leave a stale temporary
+# file in the cache.
+#
+# Options:
+# cmd: an arrayref or string of arguments to git; if it's a string, it will be
+#     passed to the shell
+# max_exit_code: die if the command exits with a higher exit code (default: 0)
+# separator: like $/; if undef, read the output in chunks of arbitrary size
+# cache: if true, cache the output of the command (without expiration)
+#
+# Example:
+# my $diff_read = $repo->progressive_cmd_output(
+#     cmd => ['diff', $from_sha1, $to_sha1], separator => "\n", cache => 1]);
+# while (my $line = $diff_read->()) {
+# 	chomp $line;
+# 	...
+# }
+my $_file_seq = 0;
+sub progressive_cmd_output {
+	die 'must pass an odd number of arguments' unless @_ % 2;
+	my ($self, %opts) = @_;
+	local $/ = defined $opts{separator} ? delete $opts{separator} : \32768;
+	# Half of cmd_output has been copied here, but there's no
+	# pretty way to generalize it.
+	my (@cmd, $cmd_str);
+	if (ref($opts{cmd}) eq 'ARRAY') {
+		@cmd = ($self->_get_git_cmd, @{$opts{cmd}});
+		$cmd_str = join " ", @cmd;  # only used for diagnostics
+	} else {
+		$cmd_str = main::quote_command($self->_get_git_cmd) .
+		    " $opts{cmd}";  # this will be passed to the shell
+	}
+	# We read from $fh, whether it's a pipe or a cache file.  If
+	# it's a pipe, we also progressively cache it to
+	# $tmp_cache_file, and at the end move $tmp_cache_file_name to
+	# $cache_file_name.  This avoids having partially written
+	# cache entries.
+	my ($fh, $cache_file_name, $tmp_cache_file_name, $tmp_cache_file);
+	if ($opts{cache} && $self->large_cache_root) {
+		my @key_items = ('cmd', $opts{max_exit_code},
+				 ref($opts{cmd}) eq 'ARRAY' ?
+				 (@{$opts{cmd}}) : (undef, $opts{cmd}));
+		push @{$large_cache_statistics{get_list}},
+		    [$self->repo_dir, @key_items];
+		my $key = $large_cache_case_sensitive ?
+		    $self->get_key(@key_items) :
+		    $self->get_case_insensitive_key(@key_items);
+		# Make the key file-system safe; _ and @ are available
+		# on most file systems and sort after the dot as a
+		# bonus.
+		$key =~ tr{+/}{_@};
+		$cache_file_name = File::Spec->catfile(
+			$self->large_cache_root, $key);
+		$tmp_cache_file_name = File::Spec->catfile(
+			$self->large_cache_root,
+			join('.', $$, $_file_seq++, 'tmp'));
+	}
+	unless ($cache_file_name && open $fh, '<', $cache_file_name) {
+		# Not in cache -- open pipe, and open cache file to write to.
+		if (@cmd) {
+			open $fh, '-|', @cmd;
+		} else {
+			open $fh, '-|', $cmd_str;
+		}
+		die "cannot open pipe: $cmd_str" unless $fh;
+		open $tmp_cache_file, '>', $tmp_cache_file_name
+		    if $tmp_cache_file_name;
+		# Increment failed_sets; it will be decremented upon
+		# successful finalization of the cache entry.
+		$large_cache_statistics{failed_sets}++;
+		# Do not die if the open fails, it simply leaves
+		# $tmp_cache_file undefined.
+		# Record uncached calls as misses.
+		$large_cache_statistics{misses}++;
+	} else {
+		$large_cache_statistics{hits}++;
+	}
+	my $read = sub {
+		return undef unless $fh;  # already closed
+		my $output = <$fh>;
+		if ($output) {
+			# Write to cache and return.
+			if ($tmp_cache_file && ! print $tmp_cache_file $output) {
+				# Writing to cache failed; clean up
+				# and stop caching this pipe.
+				close $tmp_cache_file;
+				$tmp_cache_file = undef;
+				unlink $tmp_cache_file_name;
+			}
+			return $output;
+		}
+		# End of output; close and finalize cache.
+		if (close $fh) {
+			# We sometimes get mysterious "Bad file
+			# descriptor" errors here, but reading from
+			# the pipe worked fine, so let's not die.
+			#die "error closing pipe ($!): $cmd_str" if $!;
+			my $exit_code = $? >> 8;
+			die "Command died with exit code $exit_code: $cmd_str"
+			    if $exit_code > ($opts{max_exit_code} || 0);
+		}
+		$fh = undef;
+		if ($tmp_cache_file && close $tmp_cache_file) {
+			# Cache file written OK, move it in place.
+			if (rename $tmp_cache_file_name, $cache_file_name) {
+				$large_cache_statistics{failed_sets}--;
+				$large_cache_statistics{sets}++;
+			}
+		}
+		return undef;
+	};
+	# We can also provide a &close function here in case it
+	# becomes necessary to close pipes prematurely.
+	return $read;
+}
+
+# Return the seconds since epoch when the repository was last touched.
+sub get_last_modification {
+	my $self = shift;
+	return $self->{last_modification} if $self->{last_modification};
+	# Hashref mapping absolute paths of directories to mtimes.  We
+	# rely on the fact here that every time git updates a file, it
+	# creates it under a different name and then moves it in
+	# place, thus causing the mtime of the containing directory to
+	# be updated.  Hence it's enough to just stat the directories.
+	my $mtimes = $self->cache_get(['mtimes'], 0);
+	if ($mtimes) {
+		CHECK_CACHE: {
+			# Check if the cache response is up to date.
+			while (my ($dir, $mtime) = each %$mtimes) {
+				last CHECK_CACHE if (stat $dir)[9] != $mtime;
+			}
+			$self->{last_modification} = max(values %$mtimes);
+			return max(values %$mtimes);
+		}
+	}
+	# Either mtimes are not in cache, or at least one directory
+	# has been updated.  Traverse the whole ref tree and record
+	# all directory mtimes -- this is a bit slower than the
+	# up-to-date-ness check above since we end up stat'ing all
+	# files in the refs directory.
+	my $time = time;
+	$mtimes = { $self->repo_dir => (stat $self->repo_dir)[9] };
+	my $cacheable = 1;
+	File::Find::find(
+		sub {
+			my $time = time;  # get time first
+			# No way to avoid stat'ing unconditionally
+			# with File::Find.
+			my @stat = stat($_);
+			if (Fcntl::S_ISDIR($stat[2])) {
+				# Record the directory's mtime.
+				$mtimes->{$File::Find::name} = $stat[9];
+				# Mtimes have a 1-second granularity,
+				# so if the directory has *just* been
+				# modified, we might miss subsequent
+				# modifictions in the same second if
+				# we cached it.
+				$cacheable = 0 if $stat[9] >= $time;
+			}
+		}, File::Spec->catfile($self->repo_dir, 'refs'));
+	$self->cache_set(['mtimes'], $mtimes, 0) if $cacheable;
+	$self->{last_modification} = max(values %$mtimes);
+	return max(values %$mtimes);
+}
+
+package main;
+
+
+our $repo_root = Git::RepoRoot->new(directory => $projectroot,
+				    git_binary => $GIT,
+				    cache => $cache,
+				    large_cache_root => $large_cache_root,
+				    transient_expiration_time =>
+				      $cache_transient_expiration_time,
+				    repo_class => 'CachedRepo'
+    );
+
+# Version of the core git binary.  This should normally be the same as
+# the gitweb version, but it may diverge slightly during development.
+our $git_version = $repo_root->repo(directory => 'dummy')->version;
 
 $projects_list ||= $projectroot;
 
@@ -392,6 +805,7 @@ if (defined $action) {
 
 # parameters which are pathnames
 our $project = $cgi->param('p');
+our $repo = $repo_root->repo(directory => $project) if $project;
 if (defined $project) {
 	if (!validate_pathname($project) ||
 	    !(-d "$projectroot/$project") ||
@@ -509,13 +923,14 @@ sub evaluate_path_info {
 		undef $project;
 		return;
 	}
+	$repo = $repo_root->repo(directory => $project);
 	# do not change any parameters if an action is given using the query string
 	return if $action;
 	$path_info =~ s,^\Q$project\E/*,,;
 	my ($refname, $pathname) = split(/:/, $path_info, 2);
 	if (defined $pathname) {
 		# we got "project.git/branch:filename" or "project.git/branch:dir/"
-		# we could use git_get_type(branch:pathname), but it needs $git_dir
+		# we could use git_get_type(branch:pathname) here
 		$pathname =~ s,^/+,,;
 		if (!$pathname || substr($pathname, -1) eq "/") {
 			$action  ||= "tree";
@@ -533,10 +948,6 @@ sub evaluate_path_info {
 }
 evaluate_path_info();
 
-# path to the current git repository
-our $git_dir;
-$git_dir = "$projectroot/$project" if $project;
-
 # dispatch
 my %actions = (
 	"blame" => \&git_blame,
@@ -597,8 +1008,7 @@ sub href (%) {
 	# default is to use -absolute url() i.e. $my_uri
 	my $href = $params{-full} ? $my_url : $my_uri;
 
-	# XXX: Warning: If you touch this, check the search form for updating,
-	# too.
+	# If you touch this, check the search form for updating, too.
 
 	my @mapping = (
 		project => "p",
@@ -1309,10 +1719,12 @@ sub format_diff_cc_simplified {
 	$result .= "<div class=\"diff header\">" .
 	           "diff --cc ";
 	if (!is_deleted($diffinfo)) {
-		$result .= $cgi->a({-href => href(action=>"blob",
-		                                  hash_base=>$hash,
-		                                  hash=>$diffinfo->{'to_id'},
-		                                  file_name=>$diffinfo->{'to_file'}),
+		$result .= $cgi->a(
+			{-href => href(action=>"blob",
+				       $hash && git_get_type($hash) eq 'commit' ?
+				       (hash_base=>$hash) : (),
+				       hash=>$diffinfo->{'to_id'},
+				       file_name=>$diffinfo->{'to_file'}),
 		                    -class => "path"},
 		                   esc_path($diffinfo->{'to_file'}));
 	} else {
@@ -1332,8 +1744,6 @@ sub format_diff_line {
 	my ($from, $to) = @_;
 	my $diff_class = "";
 
-	chomp $line;
-
 	if ($from && $to && ref($from->{'href'}) eq "ARRAY") {
 		# combined diff
 		my $prefix = substr($line, 0, scalar @{$from->{'href'}});
@@ -1495,11 +1905,6 @@ sub get_feed_info {
 ## ----------------------------------------------------------------------
 ## git utility subroutines, invoking git commands
 
-# returns path to the core git executable and the --git-dir parameter as list
-sub git_cmd {
-	return $GIT, '--git-dir='.$git_dir;
-}
-
 # quote the given arguments for passing them to the shell
 # quote_command("command", "arg 1", "arg with ' and ! characters")
 # => "'command' 'arg 1' 'arg with '\'' and '\!' characters'"
@@ -1509,33 +1914,55 @@ sub quote_command {
 		    map( { my $a = $_; $a =~ s/(['!])/'\\$1'/g; "'$a'" } @_ ));
 }
 
-# get HEAD ref of given project as hash
-sub git_get_head_hash {
-	my $project = shift;
-	my $o_git_dir = $git_dir;
-	my $retval = undef;
-	$git_dir = "$projectroot/$project";
-	if (open my $fd, "-|", git_cmd(), "rev-parse", "--verify", "HEAD") {
-		my $head = <$fd>;
-		close $fd;
-		if (defined $head && $head =~ /^([0-9a-fA-F]{40})$/) {
-			$retval = $1;
+# git_get_sha1_or_die ( EXTENDED_OBJECT_IDENTIFER [, TYPE] )
+#
+# Look up the object referred to by C<EXTENDED_OBJECT_IDENTIFER> and
+# return its SHA1 hash in scalar context or its ($hash, $type, $size)
+# in list context.  Return an error page to the browser if the object
+# couldn't be found.
+#
+# If C<TYPE> is given, resolve tag and commit objects if necessary and
+# die unless the object found has the right type.  The $type return
+# value is guaranteed to equal C<TYPE>.
+sub git_get_sha1_or_die {
+	my ($object_id, $want_type) = @_;
+	# This method shouldn't be used for checking missing
+	# parameters, since it cannot generate proper error messages.
+	# Hence we die with 500.
+	die_error(500, 'No object given') unless $object_id;
+	my ($hash, $type, $size) = $repo->get_sha1($object_id);
+	unless ($hash) {
+		my $human_type = ucfirst($want_type || 'object');
+		die_error(404, "$human_type not found: '$object_id'");
+	}
+	if ($want_type && $want_type ne $type) {
+		if ($type eq 'tag') {
+			return git_get_sha1_or_die(
+				$repo->get_tag($hash)->object, $want_type);
+		} elsif ($type eq 'commit' && $want_type eq 'tree') {
+			return git_get_sha1_or_die(
+				$repo->get_commit($hash)->tree, $want_type);
+		} else {
+			# $object_id and $type can be off due to recursion,
+			# but fixing it complicates the code too much.
+			die_error(400, "Expected a $want_type object, but " .
+				  "'$object_id' is a $type object");
 		}
 	}
-	if (defined $o_git_dir) {
-		$git_dir = $o_git_dir;
-	}
-	return $retval;
+	return wantarray ? ($hash, $type, $size) : $hash;
+}
+
+# get HEAD ref hash of current project or die if no HEAD ref was found
+sub git_get_head_hash {
+	die_error(400, 'no project given') unless $project;
+	my $sha1 = $repo->get_sha1('HEAD')
+	    or die_error(500, "HEAD ref not found for project '$project'");
+	return $sha1;
 }
 
 # get type of given object
 sub git_get_type {
-	my $hash = shift;
-
-	open my $fd, "-|", git_cmd(), "cat-file", '-t', $hash or return;
-	my $type = <$fd>;
-	close $fd or return;
-	chomp $type;
+	my($sha1, $type, $size) = $repo->get_sha1(shift);
 	return $type;
 }
 
@@ -1563,20 +1990,14 @@ sub git_parse_project_config {
 	my $section_regexp = shift;
 	my %config;
 
-	local $/ = "\0";
-
-	open my $fh, "-|", git_cmd(), "config", '-z', '-l',
-		or return;
-
-	while (my $keyval = <$fh>) {
-		chomp $keyval;
+	return unless $repo;
+	for my $keyval (split "\0", $repo->cmd_output(
+				cmd => [qw(config -z -l)], cache => 1)) {
 		my ($key, $value) = split(/\n/, $keyval, 2);
 
 		hash_set_multi(\%config, $key, $value)
 			if (!defined $section_regexp || $key =~ /^(?:$section_regexp)\./o);
 	}
-	close $fh;
-
 	return %config;
 }
 
@@ -1639,9 +2060,9 @@ sub git_get_project_config {
 
 	# get config
 	if (!defined $config_file ||
-	    $config_file ne "$git_dir/config") {
+	    $config_file ne "$projectroot/$project/config") {
 		%config = git_parse_project_config('gitweb');
-		$config_file = "$git_dir/config";
+		$config_file = "$projectroot/$project/config";
 	}
 
 	# ensure given type
@@ -1656,65 +2077,42 @@ sub git_get_project_config {
 	return $config{"gitweb.$key"};
 }
 
-# get hash of given path at given ref
-sub git_get_hash_by_path {
-	my $base = shift;
-	my $path = shift || return undef;
-	my $type = shift;
-
+# Return the SHA1 of the blob or tree at the path in the given commit,
+# or return undef if it does not exist.
+sub git_get_sha1_by_path {
+	my ($base, $path, $type) = @_;
 	$path =~ s,/+$,,;
-
-	open my $fd, "-|", git_cmd(), "ls-tree", $base, "--", $path
-		or die_error(500, "Open git-ls-tree failed");
-	my $line = <$fd>;
-	close $fd or return undef;
-
-	if (!defined $line) {
-		# there is no tree or hash given by $path at $base
-		return undef;
-	}
-
-	#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
-	$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t/;
-	if (defined $type && $type ne $2) {
-		# type doesn't match
-		return undef;
-	}
-	return $3;
+	return $repo->get_sha1("$base:$path", $type);
 }
 
-# get path of entry with given hash at given tree-ish (ref)
-# used to get 'from' filename for combined diff (merge commit) for renames
+# Get path of entry with given hash at given tree-ish (ref); used to
+# get 'from' filename for combined diff (merge commit) for renames.
+# Note that this does not resolve tag or commit objects in the $hash
+# parameter, you must pass a tree or blob object.
 sub git_get_path_by_hash {
 	my $base = shift || return;
 	my $hash = shift || return;
 
-	local $/ = "\0";
+	my $tree = git_get_sha1_or_die($base, 'tree');
+	my ($file_sha1, $file_type) = $repo->get_sha1($hash);
+	die_error(404, "object not found: '$hash'") unless $file_sha1;
+	die_error(400, "'$hash' is a $file_type object, not a tree or blob object")
+	    unless $file_type eq 'blob' || $file_type eq 'tree';
 
-	open my $fd, "-|", git_cmd(), "ls-tree", '-r', '-t', '-z', $base
-		or return undef;
-	while (my $line = <$fd>) {
-		chomp $line;
-
-		#'040000 tree 595596a6a9117ddba9fe379b6b012b558bac8423	gitweb'
-		#'100644 blob e02e90f0429be0d2a69b76571101f20b8f75530f	gitweb/README'
-		if ($line =~ m/(?:[0-9]+) (?:.+) $hash\t(.+)$/) {
-			close $fd;
-			return $1;
-		}
-	}
-	close $fd;
-	return undef;
+	return $repo->get_path($tree, $file_sha1);
 }
 
 ## ......................................................................
 ## git utility functions, directly accessing git repository
 
+# The following subroutines locally change the global $project
+# variable as a side-effect so that their calls to
+# git_get_project_config work.
+
 sub git_get_project_description {
-	my $path = shift;
+	local $project = shift;
 
-	$git_dir = "$projectroot/$path";
-	open my $fd, "$git_dir/description"
+	open my $fd, "$projectroot/$project/description"
 		or return git_get_project_config('description');
 	my $descr = <$fd>;
 	close $fd;
@@ -1725,10 +2123,9 @@ sub git_get_project_description {
 }
 
 sub git_get_project_url_list {
-	my $path = shift;
+	local $project = shift;
 
-	$git_dir = "$projectroot/$path";
-	open my $fd, "$git_dir/cloneurl"
+	open my $fd, "$projectroot/$project/cloneurl"
 		or return wantarray ?
 		@{ config_to_multi(git_get_project_config('url')) } :
 		   config_to_multi(git_get_project_config('url'));
@@ -1863,11 +2260,10 @@ sub git_get_project_list_from_file {
 }
 
 sub git_get_project_owner {
-	my $project = shift;
+	local $project = shift;
 	my $owner;
 
 	return undef unless $project;
-	$git_dir = "$projectroot/$project";
 
 	if (!defined $gitweb_project_owner) {
 		git_get_project_list_from_file();
@@ -1880,44 +2276,45 @@ sub git_get_project_owner {
 		$owner = git_get_project_config('owner');
 	}
 	if (!defined $owner) {
-		$owner = get_file_owner("$git_dir");
+		$owner = get_file_owner("$projectroot/$project");
 	}
 
 	return $owner;
 }
 
 sub git_get_last_activity {
-	my ($path) = @_;
-	my $fd;
+	my $path = shift;
 
-	$git_dir = "$projectroot/$path";
-	open($fd, "-|", git_cmd(), 'for-each-ref',
-	     '--format=%(committer)',
-	     '--sort=-committerdate',
-	     '--count=1',
-	     'refs/heads') or return;
-	my $most_recent = <$fd>;
-	close $fd or return;
-	if (defined $most_recent &&
-	    $most_recent =~ / (\d+) [-+][01]\d\d\d$/) {
-		my $timestamp = $1;
-		my $age = time - $timestamp;
-		return ($age, age_string($age));
-	}
-	return (undef, undef);
+	chomp(my $most_recent = $repo_root->repo(directory => $path)->cmd_output(
+		      cmd => [ qw(for-each-ref --count=1 --format=%(committer)),
+			       qw(--sort=-committerdate refs/heads) ],
+		      cache => 1, max_exit_code => 255)) or return;
+	$most_recent =~ / (\d+) [-+][01]\d\d\d$/ or return;
+	my $timestamp = $1;
+	my $age = time - $timestamp;
+	return ($age, age_string($age));
 }
 
+# Return a hashref from SHA1s to arrayrefs of ref names.  Example:
+# { '7e51...' => ['tags/tag-object'], # tag SHA1
+#   '51ba...' => ['tags/tag-object'], # referenced commit SHA1
+#   '3c4a...' => ['heads/master', 'tags/another-tag'] }
 sub git_get_references {
 	my $type = shift || "";
 	my %refs;
-	# 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c refs/tags/v2.6.11
-	# c39ae07f393806ccf406ef966e9a15afc43cc36a refs/tags/v2.6.11^{}
-	open my $fd, "-|", git_cmd(), "show-ref", "--dereference",
-		($type ? ("--", "refs/$type") : ()) # use -- <pattern> if $type
-		or return;
-
-	while (my $line = <$fd>) {
-		chomp $line;
+	# This is not implementable in terms of $repo->get_refs
+	# because get_refs doesn't dereference, and we cannot
+	# dereference a lot of SHA1s ourselves as long as there is no
+	# implementation that uses Cache::Memcached->get_multi.
+	# Hence, we use cmd_output.
+	my @lines = split "\n", $repo->cmd_output(
+		cmd => ['show-ref', '--dereference',
+			($type ? ("--", "refs/$type") : ())],
+		max_exit_code => 1,  # exits with status 1 on empty repos
+		cache => 1);
+	for my $line (@lines) {
+		# 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c refs/tags/v2.6.11
+		# c39ae07f393806ccf406ef966e9a15afc43cc36a refs/tags/v2.6.11^{}
 		if ($line =~ m!^([0-9a-fA-F]{40})\srefs/($type/?[^^]+)!) {
 			if (defined $refs{$1}) {
 				push @{$refs{$1}}, $2;
@@ -1926,24 +2323,15 @@ sub git_get_references {
 			}
 		}
 	}
-	close $fd or return;
 	return \%refs;
 }
 
 sub git_get_rev_name_tags {
-	my $hash = shift || return undef;
+	my $hash = shift or die_error();
 
-	open my $fd, "-|", git_cmd(), "name-rev", "--tags", $hash
-		or return;
-	my $name_rev = <$fd>;
-	close $fd;
-
-	if ($name_rev =~ m|^$hash tags/(.*)$|) {
-		return $1;
-	} else {
-		# catches also '$hash undefined' output
-		return undef;
-	}
+	my $name = $repo->name_rev($hash);
+	$name =~ s!^tags/!! if $name;
+	return $name;
 }
 
 ## ----------------------------------------------------------------------
@@ -1982,14 +2370,12 @@ sub parse_date {
 }
 
 sub parse_tag {
-	my $tag_id = shift;
+	my $sha1 = shift;
 	my %tag;
 	my @comment;
 
-	open my $fd, "-|", git_cmd(), "cat-file", "tag", $tag_id or return;
-	$tag{'id'} = $tag_id;
-	while (my $line = <$fd>) {
-		chomp $line;
+	my ($raw_header, $raw_comment) = split "\n\n", $repo->cat_file($sha1), 2;
+	for my $line (split "\n", $raw_header) {
 		if ($line =~ m/^object ([0-9a-fA-F]{40})$/) {
 			$tag{'object'} = $1;
 		} elsif ($line =~ m/^type (.+)$/) {
@@ -2000,19 +2386,9 @@ sub parse_tag {
 			$tag{'author'} = $1;
 			$tag{'epoch'} = $2;
 			$tag{'tz'} = $3;
-		} elsif ($line =~ m/--BEGIN/) {
-			push @comment, $line;
-			last;
-		} elsif ($line eq "") {
-			last;
 		}
 	}
-	push @comment, <$fd>;
-	$tag{'comment'} = \@comment;
-	close $fd or return;
-	if (!defined $tag{'name'}) {
-		return
-	};
+	$tag{'comment'} = [split "\n", $raw_comment];
 	return %tag
 }
 
@@ -2021,8 +2397,6 @@ sub parse_commit_text {
 	my @commit_lines = split '\n', $commit_text;
 	my %co;
 
-	pop @commit_lines; # Remove '\0'
-
 	if (! @commit_lines) {
 		return;
 	}
@@ -2117,48 +2491,38 @@ sub parse_commit_text {
 
 sub parse_commit {
 	my ($commit_id) = @_;
-	my %co;
-
-	local $/ = "\0";
-
-	open my $fd, "-|", git_cmd(), "rev-list",
-		"--parents",
-		"--header",
-		"--max-count=1",
-		$commit_id,
-		"--",
-		or die_error(500, "Open git-rev-list failed");
-	%co = parse_commit_text(<$fd>, 1);
-	close $fd;
+	# This currently supports arbitrary object names, so we
+	# resolve it here.
+	my $sha1 = git_get_sha1_or_die($commit_id, 'commit');
 
-	return %co;
+	# This formats commits slightly differently than the raw
+	# cat-file, so we cannot use cat_file here.  This function
+	# should be replaced by $repo->get_commit anyway.
+	my $commit_text = $repo->cmd_output(
+		cmd => [qw(rev-list --parents --header --max-count=1), $sha1, '--'],
+		cache => 2);
+	$commit_text =~ s/\x00$//;
+	return parse_commit_text($commit_text, 1);
 }
 
 sub parse_commits {
 	my ($commit_id, $maxcount, $skip, $filename, @args) = @_;
-	my @cos;
+	# This currently supports arbitrary object names, so we
+	# resolve it here.
+	my $sha1 = git_get_sha1_or_die($commit_id);
+	git_get_sha1_or_die("$sha1:$filename") if $filename;  # check existence
 
 	$maxcount ||= 1;
 	$skip ||= 0;
 
-	local $/ = "\0";
-
-	open my $fd, "-|", git_cmd(), "rev-list",
-		"--header",
-		@args,
-		("--max-count=" . $maxcount),
-		("--skip=" . $skip),
-		@extra_options,
-		$commit_id,
-		"--",
-		($filename ? ($filename) : ())
-		or die_error(500, "Open git-rev-list failed");
-	while (my $line = <$fd>) {
-		my %co = parse_commit_text($line);
-		push @cos, \%co;
-	}
-	close $fd;
-
+	# TODO: Integrate this into Git::Repo, and get rid of @args
+	# and @extra_options.
+	my @raw_commits = split "\0", $repo->cmd_output(
+		cmd => ['rev-list', '--header', @args, "--max-count=$maxcount",
+			"--skip=$skip", @extra_options,	$sha1, "--",
+			$filename || ()],
+		cache => 2);
+	my @cos = map { { parse_commit_text($_) } } @raw_commits;
 	return wantarray ? @cos : \@cos;
 }
 
@@ -2263,7 +2627,9 @@ sub parse_from_to_diffinfo {
 		# ordinary (not combined) diff
 		$from->{'file'} = $diffinfo->{'from_file'};
 		if ($diffinfo->{'status'} ne "A") { # not new (added) file
-			$from->{'href'} = href(action=>"blob", hash_base=>$hash_parent,
+			$from->{'href'} = href(action=>"blob",
+					       $hash_parent && git_get_type($hash_parent) eq 'commit' ?
+					       (hash_base=>$hash_parent) : (),
 			                       hash=>$diffinfo->{'from_id'},
 			                       file_name=>$from->{'file'});
 		} else {
@@ -2273,7 +2639,9 @@ sub parse_from_to_diffinfo {
 
 	$to->{'file'} = $diffinfo->{'to_file'};
 	if (!is_deleted($diffinfo)) { # file exists in result
-		$to->{'href'} = href(action=>"blob", hash_base=>$hash,
+		$to->{'href'} = href(action=>"blob",
+				     $hash && git_get_type($hash) eq 'commit' ?
+				     (hash_base=>$hash) : (),
 		                     hash=>$diffinfo->{'to_id'},
 		                     file_name=>$to->{'file'});
 	} else {
@@ -2288,15 +2656,15 @@ sub git_get_heads_list {
 	my $limit = shift;
 	my @headslist;
 
-	open my $fd, '-|', git_cmd(), 'for-each-ref',
-		($limit ? '--count='.($limit+1) : ()), '--sort=-committerdate',
-		'--format=%(objectname) %(refname) %(subject)%00%(committer)',
-		'refs/heads'
-		or return;
-	while (my $line = <$fd>) {
+	my @lines = split "\n", $repo->cmd_output(
+		cmd => ['for-each-ref', '--sort=-committerdate',
+			$limit ? '--count='.($limit+1) : (),
+			'--format=%(objectname) %(refname) %(subject)%00%(committer)',
+			'refs/heads'],
+		cache => 1);
+	for my $line (@lines) {
 		my %ref_item;
 
-		chomp $line;
 		my ($refinfo, $committerinfo) = split(/\0/, $line);
 		my ($hash, $name, $title) = split(' ', $refinfo, 3);
 		my ($committer, $epoch, $tz) =
@@ -2316,7 +2684,6 @@ sub git_get_heads_list {
 
 		push @headslist, \%ref_item;
 	}
-	close $fd;
 
 	return wantarray ? @headslist : \@headslist;
 }
@@ -2325,16 +2692,16 @@ sub git_get_tags_list {
 	my $limit = shift;
 	my @tagslist;
 
-	open my $fd, '-|', git_cmd(), 'for-each-ref',
-		($limit ? '--count='.($limit+1) : ()), '--sort=-creatordate',
-		'--format=%(objectname) %(objecttype) %(refname) '.
-		'%(*objectname) %(*objecttype) %(subject)%00%(creator)',
-		'refs/tags'
-		or return;
-	while (my $line = <$fd>) {
+	my @lines = split "\n", $repo->cmd_output(
+		cmd => ['for-each-ref', '--sort=-creatordate',
+			($limit ? '--count='.($limit+1) : ()),
+			'--format=%(objectname) %(objecttype) %(refname) '.
+			'%(*objectname) %(*objecttype) %(subject)%00%(creator)',
+			'refs/tags'],
+		cache => 1);
+	for my $line (@lines) {
 		my %ref_item;
 
-		chomp $line;
 		my ($refinfo, $creatorinfo) = split(/\0/, $line);
 		my ($id, $type, $name, $refid, $reftype, $title) = split(' ', $refinfo, 6);
 		my ($creator, $epoch, $tz) =
@@ -2365,7 +2732,6 @@ sub git_get_tags_list {
 
 		push @tagslist, \%ref_item;
 	}
-	close $fd;
 
 	return wantarray ? @tagslist : \@tagslist;
 }
@@ -2429,8 +2795,16 @@ sub mimetype_guess {
 	return $mime;
 }
 
+# Replacement for (heuristic) -T operator.  (perldoc -f -T)
+sub is_ascii_text {
+	my $text = shift;
+	return ((grep { ord($_) > 127 } split('', $text)) / length $text) <= 0.3;
+}
+
+# Determine the MIME type of a blob based on its file name ($filename)
+# and its first n bytes ($snippet).
 sub blob_mimetype {
-	my $fd = shift;
+	my $snippet = shift;
 	my $filename = shift;
 
 	if ($filename) {
@@ -2438,10 +2812,7 @@ sub blob_mimetype {
 		$mime and return $mime;
 	}
 
-	# just in case
-	return $default_blob_plain_mimetype unless $fd;
-
-	if (-T $fd) {
+	if (is_ascii_text($snippet)) {
 		return 'text/plain';
 	} elsif (! $filename) {
 		return 'application/octet-stream';
@@ -2457,9 +2828,9 @@ sub blob_mimetype {
 }
 
 sub blob_contenttype {
-	my ($fd, $file_name, $type) = @_;
+	my ($snippet, $file_name, $type) = @_;
 
-	$type ||= blob_mimetype($fd, $file_name);
+	$type ||= blob_mimetype($snippet, $file_name);
 	if ($type eq 'text/plain' && defined $default_text_plain_charset) {
 		$type .= "; charset=$default_text_plain_charset";
 	}
@@ -2472,7 +2843,6 @@ sub blob_contenttype {
 
 sub git_header_html {
 	my $status = shift || "200 OK";
-	my $expires = shift;
 
 	my $title = "$site_name";
 	if (defined $project) {
@@ -2500,7 +2870,7 @@ sub git_header_html {
 		$content_type = 'text/html';
 	}
 	print $cgi->header(-type=>$content_type, -charset => 'utf-8',
-	                   -status=> $status, -expires => $expires);
+	                   -status=> $status, -cache_control => 'no-cache');
 	my $mod_perl_version = $ENV{'MOD_PERL'} ? " $ENV{'MOD_PERL'}" : '';
 	print <<EOF;
 <?xml version="1.0" encoding="utf-8"?>
@@ -2573,7 +2943,7 @@ EOF
 	print "</head>\n" .
 	      "<body>\n";
 
-	if (-f $site_header) {
+	if ($site_header && -f $site_header) {
 		open (my $fd, $site_header);
 		print <$fd>;
 		close $fd;
@@ -2593,8 +2963,8 @@ EOF
 	}
 	print "</div>\n";
 
-	my ($have_search) = gitweb_check_feature('search');
-	if (defined $project && $have_search) {
+	if (defined $project && gitweb_check_feature('search') &&
+	    $repo->get_sha1('HEAD')) {
 		if (!defined $searchtext) {
 			$searchtext = "";
 		}
@@ -2662,6 +3032,39 @@ sub git_footer_html {
 	}
 	print "</div>\n"; # class="page_footer"
 
+	if ($page_info) {
+		print "<div class=\"page_info\">\n";
+		my $print_stats = sub {
+			my ($name, $cache_exists) = (shift, shift);
+			my %s = @_;  # statistics hash
+			if ($cache_exists) {
+				my $gets = $s{hits} + $s{misses};
+				print "<p>" . ucfirst($name) . ": " .
+				    "<b>$gets</b> gets " .
+				    "(<b>$s{hits}</b> hits + ".
+				    "<b>$s{misses}</b> misses); " .
+				    "<b>$s{sets}</b> sets, " .
+				    "<b>$s{failed_sets}</b> failed sets.</p>\n";
+				if ($page_info == 2 && @{$s{get_list}}) {
+					print "<pre class=\"cache_list\">";
+					print join("\n",
+						   map(esc_html(join ',',
+								map(defined $_ ? " $_" : '',
+								    @$_)),
+						       @{$s{get_list}}));
+					print "</pre>\n";
+				}
+			} else {
+				print "<p><i>No $name.</i></p>\n";
+			}
+		};
+		$print_stats->('main cache', $cache,
+			       %CachedRepo::cache_statistics);
+		$print_stats->('large cache', $large_cache_root,
+			       %CachedRepo::large_cache_statistics);
+		print "</div>\n"; # class="page_info"
+	}
+
 	if (-f $site_footer) {
 		open (my $fd, $site_footer);
 		print <$fd>;
@@ -2710,6 +3113,8 @@ sub git_print_page_nav {
 	my ($current, $suppress, $head, $treehead, $treebase, $extra) = @_;
 	$extra = '' if !defined $extra; # pager or formats
 
+	return unless $repo->get_sha1('HEAD');  # no navigation for empty repos
+
 	my @navs = qw(summary shortlog log commit commitdiff tree);
 	if ($suppress) {
 		@navs = grep { $_ ne $suppress } @navs;
@@ -2893,20 +3298,8 @@ sub git_print_log ($;%) {
 
 # return link target (what link points to)
 sub git_get_link_target {
-	my $hash = shift;
-	my $link_target;
-
-	# read link
-	open my $fd, "-|", git_cmd(), "cat-file", "blob", $hash
-		or return;
-	{
-		local $/;
-		$link_target = <$fd>;
-	}
-	close $fd
-		or return;
-
-	return $link_target;
+	my $sha1 = shift;
+	return $repo->cat_file($sha1);
 }
 
 # given link target, and the directory (basedir) the link is in,
@@ -3383,7 +3776,7 @@ sub git_difftree_body {
 }
 
 sub git_patchset_body {
-	my ($fd, $difftree, $hash, @hash_parents) = @_;
+	my ($read, $difftree, $hash, @hash_parents) = @_;
 	my ($hash_parent) = $hash_parents[0];
 
 	my $is_combined = (@hash_parents > 1);
@@ -3397,7 +3790,7 @@ sub git_patchset_body {
 	print "<div class=\"patchset\">\n";
 
 	# skip to first patch
-	while ($patch_line = <$fd>) {
+	while ($patch_line = $read->()) {
 		chomp $patch_line;
 
 		last if ($patch_line =~ m/^diff /);
@@ -3465,7 +3858,7 @@ sub git_patchset_body {
 		# print extended diff header
 		print "<div class=\"diff extended_header\">\n";
 	EXTENDED_HEADER:
-		while ($patch_line = <$fd>) {
+		while ($patch_line = $read->()) {
 			chomp $patch_line;
 
 			last EXTENDED_HEADER if ($patch_line =~ m/^--- |^diff /);
@@ -3484,7 +3877,7 @@ sub git_patchset_body {
 		#assert($patch_line =~ m/^---/) if DEBUG;
 
 		my $last_patch_line = $patch_line;
-		$patch_line = <$fd>;
+		$patch_line = $read->();
 		chomp $patch_line;
 		#assert($patch_line =~ m/^\+\+\+/) if DEBUG;
 
@@ -3494,7 +3887,7 @@ sub git_patchset_body {
 
 		# the patch itself
 	LINE:
-		while ($patch_line = <$fd>) {
+		while ($patch_line = $read->()) {
 			chomp $patch_line;
 
 			next PATCH if ($patch_line =~ m/^diff /);
@@ -3545,9 +3938,6 @@ sub fill_project_list_info {
  PROJECT:
 	foreach my $pr (@$projlist) {
 		my (@activity) = git_get_last_activity($pr->{'path'});
-		unless (@activity) {
-			next PROJECT;
-		}
 		($pr->{'age'}, $pr->{'age_string'}) = @activity;
 		if (!defined $pr->{'descr'}) {
 			my $descr = git_get_project_description($pr->{'path'}) || "";
@@ -3585,7 +3975,9 @@ sub print_sort_th {
 		if ($str_sort) {
 			@$list = sort {$a->{$key} cmp $b->{$key}} @$list;
 		} else {
-			@$list = sort {$a->{$key} <=> $b->{$key}} @$list;
+			# Sort undefined keys last.
+			@$list = sort { (defined $a->{$key} ? $a->{$key} : 1e30) <=>
+					(defined $b->{$key} ? $b->{$key} : 1e30)} @$list;
 		}
 		print "<th>$header</th>\n";
 	} else {
@@ -3653,16 +4045,20 @@ sub git_project_list_body {
 		      "<td>" . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary"),
 		                        -class => "list", -title => $pr->{'descr_long'}},
 		                        esc_html($pr->{'descr'})) . "</td>\n" .
-		      "<td><i>" . chop_and_escape_str($pr->{'owner'}, 15) . "</i></td>\n";
-		print "<td class=\"". age_class($pr->{'age'}) . "\">" .
+		      "<td><i>" . chop_and_escape_str($pr->{'owner'}, 15) . "</i></td>\n" .
+		      "<td class=\"". age_class($pr->{'age'}) . "\">" .
 		      (defined $pr->{'age_string'} ? $pr->{'age_string'} : "No commits") . "</td>\n" .
 		      "<td class=\"link\">" .
-		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary")}, "summary")   . " | " .
-		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"shortlog")}, "shortlog") . " | " .
-		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"log")}, "log") . " | " .
-		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"tree")}, "tree") .
-		      ($pr->{'forks'} ? " | " . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"forks")}, "forks") : '') .
-		      "</td>\n" .
+		      $cgi->a({-href => href(project=>$pr->{'path'}, action=>"summary")}, "summary");
+		if ($pr->{'age_string'}) {
+			# Non-empty repository.
+			print " | " .
+			    $cgi->a({-href => href(project=>$pr->{'path'}, action=>"shortlog")}, "shortlog") . " | " .
+			    $cgi->a({-href => href(project=>$pr->{'path'}, action=>"log")}, "log") . " | " .
+			    $cgi->a({-href => href(project=>$pr->{'path'}, action=>"tree")}, "tree");
+		}
+		print " | " . $cgi->a({-href => href(project=>$pr->{'path'}, action=>"forks")}, "forks") if $pr->{'forks'};
+		print "</td>\n" .
 		      "</tr>\n";
 	}
 	if (defined $extra) {
@@ -3760,8 +4156,8 @@ sub git_history_body {
 		      $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff");
 
 		if ($ftype eq 'blob') {
-			my $blob_current = git_get_hash_by_path($hash_base, $file_name);
-			my $blob_parent  = git_get_hash_by_path($commit, $file_name);
+			my $blob_current = git_get_sha1_by_path($hash_base, $file_name);
+			my $blob_parent = git_get_sha1_by_path($commit, $file_name);
 			if (defined $blob_current && defined $blob_parent &&
 					$blob_current ne $blob_parent) {
 				print " | " .
@@ -4016,9 +4412,9 @@ sub git_project_index {
 
 sub git_summary {
 	my $descr = git_get_project_description($project) || "none";
-	my %co = parse_commit("HEAD");
-	my %cd = %co ? parse_date($co{'committer_epoch'}, $co{'committer_tz'}) : ();
-	my $head = $co{'id'};
+	my $head = $repo->get_sha1('HEAD', 'commit');
+	my %co = parse_commit($head) if $head;
+	my %cd = parse_date($co{'committer_epoch'}, $co{'committer_tz'}) if $head;
 
 	my $owner = git_get_project_owner($project);
 
@@ -4037,7 +4433,7 @@ sub git_summary {
 	git_header_html();
 	git_print_page_nav('summary','', $head);
 
-	print "<div class=\"title\">&nbsp;</div>\n";
+	print "<div class=\"title\">&nbsp;</div>\n" if $head;
 	print "<table class=\"projects_list\">\n" .
 	      "<tr><td>description</td><td>" . esc_html($descr) . "</td></tr>\n" .
 	      "<tr><td>owner</td><td>" . esc_html($owner) . "</td></tr>\n";
@@ -4103,14 +4499,12 @@ sub git_summary {
 }
 
 sub git_tag {
-	my $head = git_get_head_hash($project);
+	my $head = git_get_head_hash();
+	my $sha1 = git_get_sha1_or_die($hash, 'tag');
 	git_header_html();
 	git_print_page_nav('','', $head,undef,$head);
-	my %tag = parse_tag($hash);
-
-	if (! %tag) {
-		die_error(404, "Unknown tag object");
-	}
+	# TODO: This wants to become $repo->get_tag.
+	my %tag = parse_tag($sha1);
 
 	git_print_header_div('commit', esc_html($tag{'name'}), $hash);
 	print "<div class=\"title_text\">\n" .
@@ -4134,7 +4528,6 @@ sub git_tag {
 	print "<div class=\"page_body\">";
 	my $comment = $tag{'comment'};
 	foreach my $line (@$comment) {
-		chomp $line;
 		print esc_html($line, -nbsp=>1) . "<br/>\n";
 	}
 	print "</div>\n";
@@ -4145,25 +4538,19 @@ sub git_blame {
 	my $fd;
 	my $ftype;
 
-	gitweb_check_feature('blame')
-	    or die_error(403, "Blame view not allowed");
+	die_error(403, "Blame view not allowed")
+	    unless gitweb_check_feature('blame');
 
 	die_error(400, "No file name given") unless $file_name;
-	$hash_base ||= git_get_head_hash($project);
-	die_error(404, "Couldn't find base commit") unless ($hash_base);
-	my %co = parse_commit($hash_base)
-		or die_error(404, "Commit not found");
-	if (!defined $hash) {
-		$hash = git_get_hash_by_path($hash_base, $file_name, "blob")
-			or die_error(404, "Error looking up file");
-	}
-	$ftype = git_get_type($hash);
-	if ($ftype !~ "blob") {
-		die_error(400, "Object is not a blob");
-	}
-	open ($fd, "-|", git_cmd(), "blame", '-p', '--',
-	      $file_name, $hash_base)
-		or die_error(500, "Open git-blame failed");
+	$hash_base ||= git_get_head_hash();
+	my $hash_base_sha1 = git_get_sha1_or_die($hash_base, 'commit');
+	my %co = parse_commit($hash_base);
+	$hash ||= git_get_sha1_by_path($hash_base, $file_name, 'blob')
+	    or die_error(404, "Error looking up file: '$file_name'");
+	git_get_sha1_or_die($hash, 'blob');  # check existence
+	my @blame_lines = split "\n", $repo->cmd_output(
+		cmd => ['blame', '-p', '--', $file_name, $hash_base_sha1],
+	    cache => 2);
 	git_header_html();
 	my $formats_nav =
 		$cgi->a({-href => href(action=>"blob", -replay=>1)},
@@ -4188,7 +4575,7 @@ sub git_blame {
 HTML
 	my %metainfo = ();
 	while (1) {
-		$_ = <$fd>;
+		$_ = shift @blame_lines;
 		last unless defined $_;
 		my ($full_rev, $orig_lineno, $lineno, $group_size) =
 		    /^([0-9a-f]{40}) (\d+) (\d+)(?: (\d+))?$/;
@@ -4196,14 +4583,13 @@ HTML
 			$metainfo{$full_rev} = {};
 		}
 		my $meta = $metainfo{$full_rev};
-		while (<$fd>) {
+		while ($_ = shift @blame_lines) {
 			last if (s/^\t//);
 			if (/^(\S+) (.*)$/) {
 				$meta->{$1} = $2;
 			}
 		}
 		my $data = $_;
-		chomp $data;
 		my $rev = substr($full_rev, 0, 8);
 		my $author = $meta->{'author'};
 		my %date = parse_date($meta->{'author-time'},
@@ -4224,11 +4610,9 @@ HTML
 			              esc_html($rev));
 			print "</td>\n";
 		}
-		open (my $dd, "-|", git_cmd(), "rev-parse", "$full_rev^")
-			or die_error(500, "Open git-rev-parse failed");
-		my $parent_commit = <$dd>;
-		close $dd;
-		chomp($parent_commit);
+		# TODO: $parent_commit can be undef, in which case the
+		# link becomes invalid.
+		my $parent_commit = $repo->get_sha1("$full_rev^");
 		my $blamed = href(action => 'blame',
 		                  file_name => $meta->{'filename'},
 		                  hash_base => $parent_commit);
@@ -4243,13 +4627,11 @@ HTML
 	}
 	print "</table>\n";
 	print "</div>";
-	close $fd
-		or print "Reading blob failed\n";
 	git_footer_html();
 }
 
 sub git_tags {
-	my $head = git_get_head_hash($project);
+	my $head = git_get_head_hash();
 	git_header_html();
 	git_print_page_nav('','', $head,undef,$head);
 	git_print_header_div('summary', $project);
@@ -4262,7 +4644,7 @@ sub git_tags {
 }
 
 sub git_heads {
-	my $head = git_get_head_hash($project);
+	my $head = git_get_head_hash();
 	git_header_html();
 	git_print_page_nav('','', $head,undef,$head);
 	git_print_header_div('summary', $project);
@@ -4280,9 +4662,9 @@ sub git_blob_plain {
 
 	if (!defined $hash) {
 		if (defined $file_name) {
-			my $base = $hash_base || git_get_head_hash($project);
-			$hash = git_get_hash_by_path($base, $file_name, "blob")
-				or die_error(404, "Cannot find file");
+			my $base = $hash_base || git_get_head_hash();
+			$hash = git_get_sha1_by_path($base, $file_name, 'blob')
+			    or die_error(404, "Cannot find file: '$file_name'");
 		} else {
 			die_error(400, "No file name defined");
 		}
@@ -4291,11 +4673,15 @@ sub git_blob_plain {
 		$expires = "+1d";
 	}
 
-	open my $fd, "-|", git_cmd(), "cat-file", "blob", $hash
-		or die_error(500, "Open git-cat-file blob '$hash' failed");
+	my $sha1 = git_get_sha1_or_die($hash, 'blob');
+	my $blob_read = $repo->progressive_cmd_output(
+		cmd => ['cat-file', 'blob', $sha1], separator => undef,
+		cache => 1);
+	my $first_chunk = $blob_read->() || '';
 
 	# content-type (can include charset)
-	$type = blob_contenttype($fd, $file_name, $type);
+	$type = blob_contenttype(substr($first_chunk, 0, 1024),
+				 $file_name, $type);
 
 	# "save as" filename, even when no $file_name is given
 	my $save_as = "$hash";
@@ -4309,42 +4695,47 @@ sub git_blob_plain {
 		-type => $type,
 		-expires => $expires,
 		-content_disposition => 'inline; filename="' . $save_as . '"');
-	undef $/;
-	binmode STDOUT, ':raw';
-	print <$fd>;
-	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
-	$/ = "\n";
-	close $fd;
+	{
+		local $/;
+		binmode STDOUT, ':raw';
+		print $first_chunk;
+		while (my $chunk = $blob_read->()) {
+			print $chunk;
+		}
+		binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
+	}
 }
 
 sub git_blob {
-	my $expires;
-
 	if (!defined $hash) {
 		if (defined $file_name) {
-			my $base = $hash_base || git_get_head_hash($project);
-			$hash = git_get_hash_by_path($base, $file_name, "blob")
-				or die_error(404, "Cannot find file");
+			my $base = $hash_base || git_get_head_hash();
+			$hash = git_get_sha1_by_path($base, $file_name, 'blob')
+			    or die_error(404, "Cannot find file: '$file_name'");
 		} else {
 			die_error(400, "No file name defined");
 		}
-	} elsif ($hash =~ m/^[0-9a-fA-F]{40}$/) {
-		# blobs defined by non-textual hash id's can be cached
-		$expires = "+1d";
 	}
 
 	my ($have_blame) = gitweb_check_feature('blame');
-	open my $fd, "-|", git_cmd(), "cat-file", "blob", $hash
-		or die_error(500, "Couldn't cat $file_name, $hash");
-	my $mimetype = blob_mimetype($fd, $file_name);
-	if ($mimetype !~ m!^(?:text/|image/(?:gif|png|jpeg)$)! && -B $fd) {
-		close $fd;
-		return git_blob_plain($mimetype);
-	}
+	my $sha1 = git_get_sha1_or_die($hash, 'blob');
+	my $blob_read = $repo->progressive_cmd_output(
+		cmd => ['cat-file', 'blob', $sha1], separator => "\n",
+		cache => 1);
+	my @first_lines;
+	for my $i (0..20) {
+		my $line = $blob_read->() or last;
+		push @first_lines, $line;
+	}
+	my $test_snippet = join("\n", @first_lines);
+	my $mimetype = blob_mimetype($test_snippet, $file_name);
+	return git_blob_plain($mimetype)
+	    if ($mimetype !~ m!^(?:text/|image/(?:gif|png|jpeg)$)! &&
+		! is_ascii_text($test_snippet));
 	# we can have blame only for text/* mimetype
 	$have_blame &&= ($mimetype =~ m!^text/!);
 
-	git_header_html(undef, $expires);
+	git_header_html();
 	my $formats_nav = '';
 	if (defined $hash_base && (my %co = parse_commit($hash_base))) {
 		if (defined $file_name) {
@@ -4389,7 +4780,7 @@ sub git_blob {
 		      qq!" />\n!;
 	} else {
 		my $nr;
-		while (my $line = <$fd>) {
+		while (my $line = shift @first_lines || $blob_read->()) {
 			chomp $line;
 			$nr++;
 			$line = untabify($line);
@@ -4397,29 +4788,23 @@ sub git_blob {
 			       $nr, $nr, $nr, esc_html($line, -nbsp=>1);
 		}
 	}
-	close $fd
-		or print "Reading blob failed.\n";
 	print "</div>";
 	git_footer_html();
 }
 
 sub git_tree {
-	if (!defined $hash_base) {
-		$hash_base = "HEAD";
-	}
+	$hash_base ||= "HEAD";
 	if (!defined $hash) {
 		if (defined $file_name) {
-			$hash = git_get_hash_by_path($hash_base, $file_name, "tree");
+			$hash = git_get_sha1_by_path($hash_base, $file_name, 'tree')
+			    or die_error(404, "Cannot find file: '$file_name'");
 		} else {
 			$hash = $hash_base;
 		}
 	}
-	$/ = "\0";
-	open my $fd, "-|", git_cmd(), "ls-tree", '-z', $hash
-		or die_error(500, "Open git-ls-tree failed");
-	my @entries = map { chomp; $_ } <$fd>;
-	close $fd or die_error(404, "Reading tree failed");
-	$/ = "\n";
+	my $sha1 = git_get_sha1_or_die($hash, 'tree');
+	my @entries = split "\0", $repo->cmd_output(
+		cmd => ['ls-tree', '-z', $sha1], cache => 2);
 
 	my $refs = git_get_references();
 	my $ref = format_ref_marker($refs, $hash_base);
@@ -4520,9 +4905,8 @@ sub git_snapshot {
 		die_error(403, "Unsupported snapshot format");
 	}
 
-	if (!defined $hash) {
-		$hash = git_get_head_hash($project);
-	}
+	$hash ||= git_get_head_hash();
+	my $sha1 = git_get_sha1_or_die($hash);
 
 	my $name = $project;
 	$name =~ s,([^/])/*\.git$,$1,;
@@ -4532,9 +4916,9 @@ sub git_snapshot {
 	my $cmd;
 	$filename .= "-$hash$known_snapshot_formats{$format}{'suffix'}";
 	$cmd = quote_command(
-		git_cmd(), 'archive',
+		'archive',
 		"--format=$known_snapshot_formats{$format}{'format'}",
-		"--prefix=$name/", $hash);
+		"--prefix=$name/", $sha1);
 	if (exists $known_snapshot_formats{$format}{'compressor'}) {
 		$cmd .= ' | ' . quote_command(@{$known_snapshot_formats{$format}{'compressor'}});
 	}
@@ -4544,16 +4928,17 @@ sub git_snapshot {
 		-content_disposition => 'inline; filename="' . "$filename" . '"',
 		-status => '200 OK');
 
-	open my $fd, "-|", $cmd
-		or die_error(500, "Execute git-archive failed");
+	my $snapshot_read = $repo->progressive_cmd_output(
+		cmd => $cmd, separator => undef, cache => 1);
 	binmode STDOUT, ':raw';
-	print <$fd>;
+	while (my $chunk = $snapshot_read->()) {
+		print $chunk;
+	}
 	binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
-	close $fd;
 }
 
 sub git_log {
-	my $head = git_get_head_hash($project);
+	my $head = git_get_head_hash();
 	if (!defined $hash) {
 		$hash = $head;
 	}
@@ -4613,8 +4998,8 @@ sub git_log {
 
 sub git_commit {
 	$hash ||= $hash_base || "HEAD";
-	my %co = parse_commit($hash)
-	    or die_error(404, "Unknown commit object");
+	my $sha1 = git_get_sha1_or_die($hash, 'commit');
+	my %co = parse_commit($hash);
 	my %ad = parse_date($co{'author_epoch'}, $co{'author_tz'});
 	my %cd = parse_date($co{'committer_epoch'}, $co{'committer_tz'});
 
@@ -4649,24 +5034,15 @@ sub git_commit {
 	if (!defined $parent) {
 		$parent = "--root";
 	}
-	my @difftree;
-	open my $fd, "-|", git_cmd(), "diff-tree", '-r', "--no-commit-id",
-		@diff_opts,
-		(@$parents <= 1 ? $parent : '-c'),
-		$hash, "--"
-		or die_error(500, "Open git-diff-tree failed");
-	@difftree = map { chomp; $_ } <$fd>;
-	close $fd or die_error(404, "Reading git-diff-tree failed");
-
-	# non-textual hash id's can be cached
-	my $expires;
-	if ($hash =~ m/^[0-9a-fA-F]{40}$/) {
-		$expires = "+1d";
-	}
+	my @difftree = split "\n", $repo->cmd_output(
+		cmd => ['diff-tree', '-r', '--no-commit-id', @diff_opts,
+			(@$parents <= 1 ? $parent : '-c'), $sha1, '--'],
+		cache => 2);
+
 	my $refs = git_get_references();
 	my $ref = format_ref_marker($refs, $co{'id'});
 
-	git_header_html(undef, $expires);
+	git_header_html();
 	git_print_page_nav('commit', '',
 	                   $hash, $co{'tree'}, $hash,
 	                   $formats_nav);
@@ -4743,41 +5119,16 @@ sub git_object {
 	# - hash_base and file_name
 	my $type;
 
-	# - hash or hash_base alone
 	if ($hash || ($hash_base && !defined $file_name)) {
-		my $object_id = $hash || $hash_base;
-
-		open my $fd, "-|", quote_command(
-			git_cmd(), 'cat-file', '-t', $object_id) . ' 2> /dev/null'
-			or die_error(404, "Object does not exist");
-		$type = <$fd>;
-		chomp $type;
-		close $fd
-			or die_error(404, "Object does not exist");
-
-	# - hash_base and file_name
+		# hash or hash_base alone
+		$type = (git_get_sha1_or_die($hash || $hash_base))[1];
 	} elsif ($hash_base && defined $file_name) {
+		# hash_base and file_name
 		$file_name =~ s,/+$,,;
-
-		system(git_cmd(), "cat-file", '-e', $hash_base) == 0
-			or die_error(404, "Base object does not exist");
-
-		# here errors should not hapen
-		open my $fd, "-|", git_cmd(), "ls-tree", $hash_base, "--", $file_name
-			or die_error(500, "Open git-ls-tree failed");
-		my $line = <$fd>;
-		close $fd;
-
-		#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
-		unless ($line && $line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t/) {
-			die_error(404, "File or directory for given base does not exist");
-		}
-		$type = $2;
-		$hash = $3;
+		($hash, $type) = git_get_sha1_or_die("$hash_base:$file_name");
 	} else {
 		die_error(400, "Not enough information to find object");
 	}
-
 	print $cgi->redirect(-uri => href(action=>$type, -full=>1,
 	                                  hash=>$hash, hash_base=>$hash_base,
 	                                  file_name=>$file_name),
@@ -4787,47 +5138,25 @@ sub git_object {
 sub git_blobdiff {
 	my $format = shift || 'html';
 
-	my $fd;
 	my @difftree;
 	my %diffinfo;
-	my $expires;
+	my $diff_read;
 
-	# preparing $fd and %diffinfo for git_patchset_body
+	# prepare $diff_read and %diffinfo for git_patchset_body
 	# new style URI
 	if (defined $hash_base && defined $hash_parent_base) {
-		if (defined $file_name) {
-			# read raw output
-			open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
-				$hash_parent_base, $hash_base,
-				"--", (defined $file_parent ? $file_parent : ()), $file_name
-				or die_error(500, "Open git-diff-tree failed");
-			@difftree = map { chomp; $_ } <$fd>;
-			close $fd
-				or die_error(404, "Reading git-diff-tree failed");
-			@difftree
-				or die_error(404, "Blob diff not found");
-
-		} elsif (defined $hash &&
-		         $hash =~ /[0-9a-fA-F]{40}/) {
-			# try to find filename from $hash
-
-			# read filtered raw output
-			open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
-				$hash_parent_base, $hash_base, "--"
-				or die_error(500, "Open git-diff-tree failed");
-			@difftree =
-				# ':100644 100644 03b21826... 3b93d5e7... M	ls-files.c'
-				# $hash == to_id
-				grep { /^:[0-7]{6} [0-7]{6} [0-9a-fA-F]{40} $hash/ }
-				map { chomp; $_ } <$fd>;
-			close $fd
-				or die_error(404, "Reading git-diff-tree failed");
-			@difftree
-				or die_error(404, "Blob diff not found");
-
-		} else {
-			die_error(400, "Missing one of the blob diff parameters");
-		}
+		my $commit_sha1 = git_get_sha1_or_die($hash_base, 'commit');
+		my $parent_base_sha1 = git_get_sha1_or_die($hash_parent_base, 'commit');
+		git_get_sha1_or_die($file_parent, 'blob') if $file_parent;
+		# There used to be code to handle hash (h) parameters,
+		# but it's not used (anymore), so we can require $file_name.
+		die_error(400, "No file name given") unless $file_name;
+		# read raw output
+		@difftree = split "\n", $repo->cmd_output(
+			cmd => ['diff-tree', '-r', @diff_opts, $parent_base_sha1,
+				$commit_sha1, '--', $file_parent || (),
+				$file_name],
+			cache => 2);
 
 		if (@difftree > 1) {
 			die_error(400, "Ambiguous blob diff specification");
@@ -4840,21 +5169,17 @@ sub git_blobdiff {
 		$hash_parent ||= $diffinfo{'from_id'};
 		$hash        ||= $diffinfo{'to_id'};
 
-		# non-textual hash id's can be cached
-		if ($hash_base =~ m/^[0-9a-fA-F]{40}$/ &&
-		    $hash_parent_base =~ m/^[0-9a-fA-F]{40}$/) {
-			$expires = '+1d';
-		}
-
 		# open patch output
-		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
-			'-p', ($format eq 'html' ? "--full-index" : ()),
-			$hash_parent_base, $hash_base,
-			"--", (defined $file_parent ? $file_parent : ()), $file_name
-			or die_error(500, "Open git-diff-tree failed");
+		my $hash_base_sha1 = git_get_sha1_or_die($hash_base, 'commit');
+		$diff_read = $repo->progressive_cmd_output(  # TODO: uncovered
+			cmd => ['diff-tree', '-r', @diff_opts, '-p',
+				($format eq 'html' ? '--full-index' : ()),
+				$parent_base_sha1, $hash_base_sha1, '--',
+				$file_parent || (), $file_name],
+			separator => "\n", cache => 1);
 	}
 
-	# old/legacy style URI
+	# old/legacy style URI (still used in feed [Atom/RSS] view)
 	if (!%diffinfo && # if new style URI failed
 	    defined $hash && defined $hash_parent) {
 		# fake git-diff-tree raw output
@@ -4877,17 +5202,14 @@ sub git_blobdiff {
 			$diffinfo{'to_file'}   = $hash;
 		}
 
-		# non-textual hash id's can be cached
-		if ($hash =~ m/^[0-9a-fA-F]{40}$/ &&
-		    $hash_parent =~ m/^[0-9a-fA-F]{40}$/) {
-			$expires = '+1d';
-		}
-
 		# open patch output
-		open $fd, "-|", git_cmd(), "diff", @diff_opts,
-			'-p', ($format eq 'html' ? "--full-index" : ()),
-			$hash_parent, $hash, "--"
-			or die_error(500, "Open git-diff failed");
+		my $parent_sha1 = git_get_sha1_or_die($hash_parent, 'blob');
+		my $sha1 = git_get_sha1_or_die($hash, 'commit');
+		$diff_read = $repo->progressive_cmd_output(
+			cmd => ['diff', @diff_opts, '-p',
+				($format eq 'html' ? '--full-index' : ()),
+				$parent_sha1, $sha1, '--'],
+			separator => "\n", cache => 1);
 	} else  {
 		die_error(400, "Missing one of the blob diff parameters")
 			unless %diffinfo;
@@ -4898,7 +5220,7 @@ sub git_blobdiff {
 		my $formats_nav =
 			$cgi->a({-href => href(action=>"blobdiff_plain", -replay=>1)},
 			        "raw");
-		git_header_html(undef, $expires);
+		git_header_html();
 		if (defined $hash_base && (my %co = parse_commit($hash_base))) {
 			git_print_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
 			git_print_header_div('commit', esc_html($co{'title'}), $hash_base);
@@ -4913,6 +5235,8 @@ sub git_blobdiff {
 		}
 
 	} elsif ($format eq 'plain') {
+		my $expires = ($hash =~ m/^[0-9a-f]{40}$/ &&
+			       $hash_parent =~ m/^[0-9a-f]{40}$/) ? '+1d' : undef;
 		print $cgi->header(
 			-type => 'text/plain',
 			-charset => 'utf-8',
@@ -4929,14 +5253,13 @@ sub git_blobdiff {
 	if ($format eq 'html') {
 		print "<div class=\"page_body\">\n";
 
-		git_patchset_body($fd, [ \%diffinfo ], $hash_base, $hash_parent_base);
-		close $fd;
+		git_patchset_body($diff_read, [ \%diffinfo ], $hash_base, $hash_parent_base);
 
 		print "</div>\n"; # class="page_body"
 		git_footer_html();
 
 	} else {
-		while (my $line = <$fd>) {
+		while (my $line = $diff_read->()) {
 			$line =~ s!a/($hash|$hash_parent)!'a/'.esc_path($diffinfo{'from_file'})!eg;
 			$line =~ s!b/($hash|$hash_parent)!'b/'.esc_path($diffinfo{'to_file'})!eg;
 
@@ -4944,9 +5267,9 @@ sub git_blobdiff {
 
 			last if $line =~ m!^\+\+\+!;
 		}
-		local $/ = undef;
-		print <$fd>;
-		close $fd;
+		while (my $line = $diff_read->()) {
+			print $line;
+		}
 	}
 }
 
@@ -4957,12 +5280,20 @@ sub git_blobdiff_plain {
 sub git_commitdiff {
 	my $format = shift || 'html';
 	$hash ||= $hash_base || "HEAD";
-	my %co = parse_commit($hash)
-	    or die_error(404, "Unknown commit object");
+	my $sha1 = git_get_sha1_or_die($hash, 'commit');
+	my %co = parse_commit($hash);
 
 	# choose format for commitdiff for merge
-	if (! defined $hash_parent && @{$co{'parents'}} > 1) {
-		$hash_parent = '--cc';
+	my $hash_parent_param = $hash_parent;
+	# Unfortunately we can pass in command line options as
+	# $hash_parent.
+	if ($hash_parent_param && $hash_parent_param ne '-c' &&
+	    $hash_parent_param ne '--cc') {
+		$hash_parent_param =
+		    git_get_sha1_or_die($hash_parent_param, 'commit');
+	}
+	if (! defined $hash_parent_param && @{$co{'parents'}} > 1) {
+		$hash_parent_param = '--cc';
 	}
 	# we need to prepare $formats_nav before almost any parameter munging
 	my $formats_nav;
@@ -4971,8 +5302,7 @@ sub git_commitdiff {
 			$cgi->a({-href => href(action=>"commitdiff_plain", -replay=>1)},
 			        "raw");
 
-		if (defined $hash_parent &&
-		    $hash_parent ne '-c' && $hash_parent ne '--cc') {
+		if (defined $hash_parent) {
 			# commitdiff with two commits given
 			my $hash_parent_short = $hash_parent;
 			if ($hash_parent =~ m/^[0-9a-fA-F]{40}$/) {
@@ -5004,7 +5334,7 @@ sub git_commitdiff {
 				')';
 		} else {
 			# merge commit
-			if ($hash_parent eq '--cc') {
+			if ($hash_parent && $hash_parent eq '--cc') {
 				$formats_nav .= ' | ' .
 					$cgi->a({-href => href(action=>"commitdiff",
 					                       hash=>$hash, hash_parent=>'-c')},
@@ -5026,7 +5356,6 @@ sub git_commitdiff {
 		}
 	}
 
-	my $hash_parent_param = $hash_parent;
 	if (!defined $hash_parent_param) {
 		# --cc for multiple parents, --root for parentless
 		$hash_parent_param =
@@ -5034,34 +5363,26 @@ sub git_commitdiff {
 	}
 
 	# read commitdiff
-	my $fd;
+	my $diff_read;
 	my @difftree;
 	if ($format eq 'html') {
-		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
-			"--no-commit-id", "--patch-with-raw", "--full-index",
-			$hash_parent_param, $hash, "--"
-			or die_error(500, "Open git-diff-tree failed");
-
-		while (my $line = <$fd>) {
+		$diff_read = $repo->progressive_cmd_output(
+			cmd => ['diff-tree', '-r', @diff_opts, '--no-commit-id',
+				'--patch-with-raw', '--full-index',
+				$hash_parent_param, $sha1, '--'],
+			separator => "\n", cache => 1);
+		while (my $line = $diff_read->()) {
 			chomp $line;
 			# empty line ends raw part of diff-tree output
 			last unless $line;
 			push @difftree, scalar parse_difftree_raw_line($line);
 		}
-
-	} elsif ($format eq 'plain') {
-		open $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
-			'-p', $hash_parent_param, $hash, "--"
-			or die_error(500, "Open git-diff-tree failed");
-
 	} else {
-		die_error(400, "Unknown commitdiff format");
-	}
-
-	# non-textual hash id's can be cached
-	my $expires;
-	if ($hash =~ m/^[0-9a-fA-F]{40}$/) {
-		$expires = "+1d";
+		die unless $format eq 'plain';
+		$diff_read = $repo->progressive_cmd_output(
+			cmd => ['diff-tree', '-r', @diff_opts, '-p',
+				$hash_parent_param, $sha1, '--'],
+			separator => "\n", cache => 1);
 	}
 
 	# write commit message
@@ -5069,7 +5390,7 @@ sub git_commitdiff {
 		my $refs = git_get_references();
 		my $ref = format_ref_marker($refs, $co{'id'});
 
-		git_header_html(undef, $expires);
+		git_header_html();
 		git_print_page_nav('commitdiff','', $hash,$co{'tree'},$hash, $formats_nav);
 		git_print_header_div('commit', esc_html($co{'title'}) . $ref, $hash);
 		git_print_authorship(\%co);
@@ -5081,10 +5402,10 @@ sub git_commitdiff {
 		}
 
 	} elsif ($format eq 'plain') {
-		my $refs = git_get_references("tags");
-		my $tagname = git_get_rev_name_tags($hash);
+		my $tagname = git_get_rev_name_tags($sha1);
 		my $filename = basename($project) . "-$hash.patch";
 
+		my $expires = ($hash =~ m/^[0-9a-f]{40}$/) ? '+1d' : undef;
 		print $cgi->header(
 			-type => 'text/plain',
 			-charset => 'utf-8',
@@ -5112,17 +5433,15 @@ sub git_commitdiff {
 		                  $use_parents ? @{$co{'parents'}} : $hash_parent);
 		print "<br/>\n";
 
-		git_patchset_body($fd, \@difftree, $hash,
+		git_patchset_body($diff_read, \@difftree, $hash,
 		                  $use_parents ? @{$co{'parents'}} : $hash_parent);
-		close $fd;
 		print "</div>\n"; # class="page_body"
 		git_footer_html();
 
 	} elsif ($format eq 'plain') {
-		local $/ = undef;
-		print <$fd>;
-		close $fd
-			or print "Reading git-diff-tree failed\n";
+		while (my $line = $diff_read->()) {
+			print $line;
+		}
 	}
 }
 
@@ -5131,37 +5450,29 @@ sub git_commitdiff_plain {
 }
 
 sub git_history {
-	if (!defined $hash_base) {
-		$hash_base = git_get_head_hash($project);
-	}
-	if (!defined $page) {
-		$page = 0;
-	}
+	$hash_base ||= git_get_head_hash();
+	$page ||= 0;
 	my $ftype;
-	my %co = parse_commit($hash_base)
-	    or die_error(404, "Unknown commit object");
+	my %co = parse_commit($hash_base);
 
 	my $refs = git_get_references();
 	my $limit = sprintf("--max-count=%i", (100 * ($page+1)));
 
 	my @commitlist = parse_commits($hash_base, 101, (100 * $page),
-	                               $file_name, "--full-history")
-	    or die_error(404, "No such file or directory on given branch");
+	                               $file_name, "--full-history");
 
 	if (!defined $hash && defined $file_name) {
 		# some commits could have deleted file in question,
 		# and not have it in tree, but one of them has to have it
 		for (my $i = 0; $i <= @commitlist; $i++) {
-			$hash = git_get_hash_by_path($commitlist[$i]{'id'}, $file_name);
+			$hash = git_get_sha1_by_path($commitlist[$i]{'id'}, $file_name);
 			last if defined $hash;
 		}
 	}
 	if (defined $hash) {
+		git_get_sha1_or_die($hash);
 		$ftype = git_get_type($hash);
 	}
-	if (!defined $ftype) {
-		die_error(500, "Unknown type of object");
-	}
 
 	my $paging_nav = '';
 	if ($page > 0) {
@@ -5202,13 +5513,8 @@ sub git_search {
 	if (!defined $searchtext) {
 		die_error(400, "Text field is empty");
 	}
-	if (!defined $hash) {
-		$hash = git_get_head_hash($project);
-	}
+	$hash ||= git_get_head_hash();
 	my %co = parse_commit($hash);
-	if (!%co) {
-		die_error(404, "Unknown commit object");
-	}
 	if (!defined $page) {
 		$page = 0;
 	}
@@ -5280,12 +5586,15 @@ sub git_search {
 		print "<table class=\"pickaxe search\">\n";
 		my $alternate = 1;
 		$/ = "\n";
-		open my $fd, '-|', git_cmd(), '--no-pager', 'log', @diff_opts,
-			'--pretty=format:%H', '--no-abbrev', '--raw', "-S$searchtext",
-			($search_use_regexp ? '--pickaxe-regex' : ());
+		my $pickaxe_read = $repo->progressive_cmd_output(
+			cmd => ['log', @diff_opts, '--pretty=format:%H',
+				'--no-abbrev', '--raw', "-S$searchtext",
+				($search_use_regexp ? '--pickaxe-regex' : ()),
+				git_get_head_hash()],
+			separator => "\n", cache => 1);
 		undef %co;
 		my @files;
-		while (my $line = <$fd>) {
+		while (my $line = $pickaxe_read->()) {
 			chomp $line;
 			next unless $line;
 
@@ -5326,7 +5635,6 @@ sub git_search {
 				      "<br/>\n";
 			}
 		}
-		close $fd;
 
 		# finish last commit (warning: repetition!)
 		if (%co) {
@@ -5349,12 +5657,13 @@ sub git_search {
 		print "<table class=\"grep_search\">\n";
 		my $alternate = 1;
 		my $matches = 0;
-		$/ = "\n";
-		open my $fd, "-|", git_cmd(), 'grep', '-n',
-			$search_use_regexp ? ('-E', '-i') : '-F',
-			$searchtext, $co{'tree'};
+		my $grep_read = $repo->progressive_cmd_output(
+			cmd => ['grep', '-n',
+				$search_use_regexp ? ('-E', '-i') : '-F',
+				$searchtext, $co{'tree'}],
+			separator => "\n", cache => 1);
 		my $lastfile = '';
-		while (my $line = <$fd>) {
+		while (my $line = $grep_read->()) {
 			chomp $line;
 			my ($file, $lno, $ltext, $binary);
 			last if ($matches++ > 1000);
@@ -5406,7 +5715,6 @@ sub git_search {
 		} else {
 			print "<div class=\"diff nodifferences\">No matches found</div>\n";
 		}
-		close $fd;
 
 		print "</table>\n";
 	}
@@ -5458,7 +5766,7 @@ EOT
 }
 
 sub git_shortlog {
-	my $head = git_get_head_hash($project);
+	my $head = git_get_head_hash();
 	if (!defined $hash) {
 		$hash = $head;
 	}
@@ -5500,33 +5808,22 @@ sub git_feed {
 	}
 
 	# log/feed of current (HEAD) branch, log of given branch, history of file/directory
-	my $head = $hash || 'HEAD';
-	my @commitlist = parse_commits($head, 150, 0, $file_name);
+	my $head = $hash || $repo->get_sha1('HEAD');  # can be undef
+	my %last_modified = parse_date($repo->get_last_modification);
 
-	my %latest_commit;
-	my %latest_date;
 	my $content_type = "application/$format+xml";
 	if (defined $cgi->http('HTTP_ACCEPT') &&
 		 $cgi->Accept('text/xml') > $cgi->Accept($content_type)) {
 		# browser (feed reader) prefers text/xml
 		$content_type = 'text/xml';
 	}
-	if (defined($commitlist[0])) {
-		%latest_commit = %{$commitlist[0]};
-		%latest_date   = parse_date($latest_commit{'author_epoch'});
-		print $cgi->header(
-			-type => $content_type,
-			-charset => 'utf-8',
-			-last_modified => $latest_date{'rfc2822'});
-	} else {
-		print $cgi->header(
-			-type => $content_type,
-			-charset => 'utf-8');
-	}
+	print $cgi->header(
+		-type => $content_type, -charset => 'utf-8',
+		-last_modified => $last_modified{'rfc2822'});
 
 	# Optimization: skip generating the body if client asks only
 	# for Last-Modified date.
-	return if ($cgi->request_method() eq 'HEAD');
+	return if $cgi->request_method() && $cgi->request_method() eq 'HEAD';
 
 	# header variables
 	my $title = "$site_name - $project/$action";
@@ -5593,15 +5890,11 @@ XML
 			# not twice as wide as tall: 72 x 27 pixels
 			print "<logo>" . esc_url($logo) . "</logo>\n";
 		}
-		if (! %latest_date) {
-			# dummy date to keep the feed valid until commits trickle in:
-			print "<updated>1970-01-01T00:00:00Z</updated>\n";
-		} else {
-			print "<updated>$latest_date{'iso-8601'}</updated>\n";
-		}
+		print "<updated>$last_modified{'iso-8601'}</updated>\n";
 	}
 
 	# contents
+	my @commitlist = parse_commits($head, 150, 0, $file_name) if $head;
 	for (my $i = 0; $i <= $#commitlist; $i++) {
 		my %co = %{$commitlist[$i]};
 		my $commit = $co{'id'};
@@ -5612,13 +5905,11 @@ XML
 		my %cd = parse_date($co{'author_epoch'});
 
 		# get list of changed files
-		open my $fd, "-|", git_cmd(), "diff-tree", '-r', @diff_opts,
-			$co{'parent'} || "--root",
-			$co{'id'}, "--", (defined $file_name ? $file_name : ())
-			or next;
-		my @difftree = map { chomp; $_ } <$fd>;
-		close $fd
-			or next;
+		my @difftree = split "\n", $repo->cmd_output(
+			cmd => ['diff-tree', '-r', @diff_opts,
+				$co{'parent'} || '--root', $co{'id'}, '--',
+				(defined $file_name ? $file_name : ())],
+			cache => 2);
 
 		# print element (entry, item)
 		my $co_url = href(-full=>1, action=>"commitdiff", hash=>$commit);
@@ -5733,16 +6024,8 @@ XML
 
 	foreach my $pr (@list) {
 		my %proj = %$pr;
-		my $head = git_get_head_hash($proj{'path'});
-		if (!defined $head) {
-			next;
-		}
-		$git_dir = "$projectroot/$proj{'path'}";
-		my %co = parse_commit($head);
-		if (!%co) {
-			next;
-		}
-
+		next unless $repo_root->repo(directory => $proj{'path'})
+		    ->get_sha1('HEAD');
 		my $path = esc_html(chop_str($proj{'path'}, 25, 5));
 		my $rss  = "$my_url?p=$proj{'path'};a=rss";
 		my $html = "$my_url?p=$proj{'path'};a=summary";
diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index ae7082b..e04fb5f 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -54,7 +54,7 @@ gitweb_run () {
 	# written to web server logs, so we are not interested in that:
 	# we are interested only in properly formatted errors/warnings
 	rm -f gitweb.log &&
-	perl -- "$(pwd)/../../gitweb/gitweb.perl" \
+	"$PERL_PATH" -- "$(pwd)/../../gitweb/gitweb.cgi" \
 		>/dev/null 2>gitweb.log &&
 	if grep -q -s "^[[]" gitweb.log >/dev/null; then false; else true; fi
 
@@ -71,7 +71,7 @@ safe_chmod () {
 
 . ./test-lib.sh
 
-perl -MEncode -e 'decode_utf8("", Encode::FB_CROAK)' >/dev/null 2>&1 || {
+"$PERL_PATH" -MEncode -e 'decode_utf8("", Encode::FB_CROAK)' >/dev/null 2>&1 || {
     test_expect_success 'skipping gitweb tests, perl version is too old' :
     test_done
     exit
diff --git a/t/t9503-gitweb-Mechanize.sh b/t/t9503-gitweb-Mechanize.sh
index 53f2a8a..c0558e5 100755
--- a/t/t9503-gitweb-Mechanize.sh
+++ b/t/t9503-gitweb-Mechanize.sh
@@ -89,6 +89,16 @@ test_expect_success 'set up test repository' '
 	test_tick && git pull . b
 '
 
+# set up empty repository
+# create this as a subdirectory of trash directory; not pretty, but simple
+test_expect_success 'set up empty repository' '
+
+	mkdir empty.git &&
+	cd empty.git &&
+	git init --bare &&
+	cd ..
+'
+
 # set up gitweb configuration
 safe_pwd="$("$PERL_PATH" -MPOSIX=getcwd -e 'print quotemeta(getcwd)')"
 large_cache_root="../t9503/large_cache.tmp"
diff --git a/t/t9503/test.pl b/t/t9503/test.pl
index b0a8269..2d83158 100755
--- a/t/t9503/test.pl
+++ b/t/t9503/test.pl
@@ -274,6 +274,11 @@ if (test_page '', 'project list (implicit)') {
 		"title contains $site_name");
 	$mech->content_contains('t9503-gitweb-Mechanize test repository',
 		'lists test repository (by description)');
+	if (follow_link( { text => 'empty.git' }, 'empty git repository')) {
+		# Just check that the empty.git summary page is linked
+		# and doesn't die.
+		$mech->back;
+	}
 }
 
 
-- 
1.5.6.2.456.g63fc0
