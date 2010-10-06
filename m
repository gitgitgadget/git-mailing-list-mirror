From: Jakub Narebski <jnareb@gmail.com>
Subject: [PoC PATCHv5 20/17] gitweb/lib - Benchmarking GitwebCache::SimpleFileCache (in t/9603/)
Date: Thu,  7 Oct 2010 00:02:05 +0200
Message-ID: <1286402526-13143-21-git-send-email-jnareb@gmail.com>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 07 00:04:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3c5r-0002Gb-Ox
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 00:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933260Ab0JFWDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 18:03:19 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53578 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933252Ab0JFWDN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 18:03:13 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so49472bwz.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 15:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=0mWuTkP9qMcd1kcRP3M9Tc/hb3nGWhhX2Rs9TvveYU0=;
        b=T1xRJjkPzdZ5wEnSWdHjWlZbEKsTnhlW3cYPhP3fPEEH9jY79wQWCudRSnFz6dx1n/
         bY84wRiZ2zXxSakxyICE3qb1WkTFUEdQ6JqfM1wahh53E3SM7cCjaiaD1jmT9XnuMbZ/
         QArKgCn08/RfKmZUm4+W3+MYpmvIU0B/7rf5o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Gxk9Rhg8h4gg7yIpRtafgTVeLF0KAJzKYbMBkj8SVjkFMagfvn4LPzSFfWJxRnleoi
         9UD3ylr8zmeR8Ps4glfiJwIZfvkW8MVD6z/359lqypYAyGKC79PIs87RUcPl+WkvQ2q2
         2khH7lgtkzajdacjo0N06ZUSySkJtxlxhtrIk=
Received: by 10.204.100.12 with SMTP id w12mr10352945bkn.90.1286402591583;
        Wed, 06 Oct 2010 15:03:11 -0700 (PDT)
Received: from localhost.localdomain (abwe253.neoplus.adsl.tpnet.pl [83.8.228.253])
        by mx.google.com with ESMTPS id 24sm1044480bkr.19.2010.10.06.15.03.09
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 15:03:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158331>

Add t/t9503/benchmark_caching_interface.pl, which benchmarks 'set' and
'get' methods from GitwebCache::SimpleFileCache, and compares them
against Cache::FileCache, Cache::MemoryCache, and Cache::FastMmap
if they are available.

Includes example benchmark results.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Formerly as patch 06/17 in previous version of series, now marked PoC
("proof of concept"), and moved to the end of series.

Differences from v4:
* Make benchmark as if for persistent (get/set only) and
  non-persistent (setup+get/set) environment.

* Add benchmark for Cache::NullCache (from Cache::Cache distribution)
  as a kind of baseline.

* Do tests for Cache::FastMmap both with and without setting
  raw_values.

* Include versions of modules used in benchmarks, and add new sample
  benchmark results.

 t/t9503/benchmark_caching_interface.pl |  209 ++++++++++++++++++++++++++++++++
 1 files changed, 209 insertions(+), 0 deletions(-)
 create mode 100755 t/t9503/benchmark_caching_interface.pl

diff --git a/t/t9503/benchmark_caching_interface.pl b/t/t9503/benchmark_caching_interface.pl
new file mode 100755
index 0000000..db06f6e
--- /dev/null
+++ b/t/t9503/benchmark_caching_interface.pl
@@ -0,0 +1,209 @@
+#!/usr/bin/perl
+use lib (split(/:/, $ENV{GITPERLLIB}));
+
+use warnings;
+use strict;
+
+use File::Spec;
+use File::Path;
+use Benchmark qw(:all);
+
+# benchmark source version
+sub __DIR__ () {
+	File::Spec->rel2abs(join '', (File::Spec->splitpath(__FILE__))[0, 1]);
+}
+use lib __DIR__."/../../gitweb/lib";
+use GitwebCache::SimpleFileCache;
+
+my $key = 'http://localhost/cgi-bin/gitweb.cgi?p=git/git.git;a=blob_plain;f=lorem.txt;hb=HEAD';
+my $value = <<'EOF';
+Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do
+eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad
+minim veniam, quis nostrud exercitation ullamco laboris nisi ut
+aliquip ex ea commodo consequat. Duis aute irure dolor in
+reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
+pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
+culpa qui officia deserunt mollit anim id est laborum.
+EOF
+
+my $cache_root = __DIR__.'/cache';
+my %cache_options = (
+	'cache_root' => $cache_root, # Cache::FileCache compatibile
+	'root_dir'   => $cache_root, # CHI::Driver::File compatibile
+	'cache_depth' => 1, # Cache::FileCache compatibile
+	'depth'       => 1, # CHI::Driver::File compatibile
+	'default_expires_in' => 24*60*60, # Cache::Cache compatibile
+	'expires_in'         => 24*60*60, # CHI compatibile
+	'expire_time'        => 24*60*60, # Cache::FastMmap compatibile
+);
+
+mkdir($cache_root);
+
+my %caches;
+
+sub add_cache {
+	my ($caches, $cache_key, $module, %extra_opts) = @_;
+	my $namespace = $module;
+	$namespace =~ s/::/-/g;
+
+	$caches->{$cache_key}{'module'} = $module;
+	$caches->{$cache_key}{'start'} = sub {
+		$module->new({
+			'namespace' => $namespace,
+			%cache_options,
+			%extra_opts,
+		});
+	};
+	my $cache = $caches->{$cache_key}{'cache'}
+		= $caches->{$cache_key}{'start'}->();
+	$caches->{$cache_key}{'set'} = sub {
+		$cache->set($key, $value);
+	};
+	$caches->{$cache_key}{'get'} = sub {
+		$cache->get($key);
+	};
+	$caches->{$cache_key}{'setup+set'} = sub {
+		$caches->{$cache_key}{'start'}->();
+		$caches->{$cache_key}{'set'}->();
+	};
+	$caches->{$cache_key}{'setup+get'} = sub {
+		$caches->{$cache_key}{'start'}->();
+		$caches->{$cache_key}{'get'}->();
+	};
+}
+
+add_cache(\%caches, 'SimpleFileCache', 'GitwebCache::SimpleFileCache');
+
+# assume that all Cache::Cache modules are available if one of them is
+if (eval { require Cache::FileCache; 1; }) {
+	add_cache(\%caches, 'C::FileCache',   'Cache::FileCache');
+
+	# for reference
+	require Cache::MemoryCache;
+	add_cache(\%caches, 'C::MemoryCache', 'Cache::MemoryCache');
+	require Cache::NullCache;
+	add_cache(\%caches, 'C::NullCache',   'Cache::NullCache');
+}
+
+if (eval { require Cache::FastMmap; 1 }) {
+	add_cache(\%caches, 'FastMmap', 'Cache::FastMmap',
+		'share_file' => $cache_root.'/Cache-FastMmap',
+		'init_file' => 1,  # clear any exiting values and re-initialize file
+		'raw_values' => 1, # don't freeze/thaw (serialize) data
+	);
+	add_cache(\%caches, 'FastMmap (S)', 'Cache::FastMmap',
+		'share_file' => $cache_root.'/Cache-FastMmap',
+		'init_file' => 1,  # clear any exiting values and re0initialize file
+	);
+}
+
+my %codehash;
+my $count = -10;
+my $result_set;
+
+print '$cache->set($key, $value)'."\n";
+%codehash = map { $_ => $caches{$_}{'set'} } keys %caches;
+$result_set = timethese($count, \%codehash);
+cmpthese($result_set);
+print "\n";
+
+print '$cache->get($key)'."\n";
+%codehash = map { $_ => $caches{$_}{'get'} } keys %caches;
+$result_set = timethese($count, \%codehash);
+cmpthese($result_set);
+print "\n";
+
+## Cache::FastMmap shouldn't use "'init_file' => 1" for this
+#
+# print '$cache->new(...) + $cache->set($key, $value)'."\n";
+# %codehash = map { $_ => $caches{$_}{'setup+set'} } keys %caches;
+# $result_set = timethese($count, \%codehash);
+# cmpthese($result_set);
+# print "\n";
+#
+# print '$cache->new(...) + $cache->get($key)'."\n";
+# %codehash = map { $_ => $caches{$_}{'setup+get'} } keys %caches;
+# $result_set = timethese($count, \%codehash);
+# cmpthese($result_set);
+# print "\n";
+
+rmtree($cache_root);
+
+1;
+__END__
+## EXAMPLE OUTPUT ##
+#
+# Cache::FastMmap version 1.35
+# Cache::Cache (Cache::FileCache, Cache::MemoryCache) version 1.05
+#
+# $cache->set($key, $value)
+# Benchmark: running Cache::FastMmap, Cache::FileCache, Cache::MemoryCache, GitwebCache
+#   for at least 10 CPU seconds...
+# Cache::FastMmap:    11 wallclock secs ( 8.46 usr +  2.17 sys = 10.63 CPU) @ 15710.25/s (n=167000)
+# Cache::FileCache:   15 wallclock secs ( 8.43 usr +  2.25 sys = 10.68 CPU) @ 356.27/s   (n=3805)
+# Cache::MemoryCache: 13 wallclock secs ( 9.91 usr +  0.09 sys = 10.00 CPU) @ 3306.20/s  (n=33062)
+# GitwebCache:        29 wallclock secs ( 7.02 usr +  3.47 sys = 10.49 CPU) @ 605.91/s   (n=6356)
+#                       Rate Cache::FileCache GitwebCache Cache::MemoryCache Cache::FastMmap
+# Cache::FileCache     356/s               --        -41%               -89%            -98%
+# GitwebCache          606/s              70%          --               -82%            -96%
+# Cache::MemoryCache  3306/s             828%        446%                 --            -79%
+# Cache::FastMmap    15710/s            4310%       2493%               375%              --
+#
+# $cache->get($key)  # $key exists in cache
+# Benchmark: running Cache::FastMmap, Cache::FileCache, Cache::MemoryCache, GitwebCache
+#   for at least 10 CPU seconds...
+# Cache::FastMmap:    13 wallclock secs ( 7.32 usr +  2.83 sys = 10.15 CPU) @ 24260.59/s (n=246245)
+# Cache::FileCache:   12 wallclock secs ( 9.22 usr +  1.30 sys = 10.52 CPU) @ 972.62/s   (n=10232)
+# Cache::MemoryCache: 14 wallclock secs ( 9.89 usr +  0.12 sys = 10.01 CPU) @ 3679.52/s  (n=36832)
+# GitwebCache:        20 wallclock secs ( 8.16 usr +  2.36 sys = 10.52 CPU) @ 4401.05/s  (n=46299)
+#                       Rate Cache::FileCache Cache::MemoryCache GitwebCache Cache::FastMmap
+# Cache::FileCache     973/s               --               -74%        -78%            -96%
+# Cache::MemoryCache  3680/s             278%                 --        -16%            -85%
+# GitwebCache         4401/s             352%                20%          --            -82%
+# Cache::FastMmap    24261/s            2394%               559%        451%              --
+
+## EXAMPLE OUTPUT (new version of test, modified SimpleFileCache) ##
+#
+## like for non-persistent environment
+#
+# $cache->new(...) + $cache->set($key, $value)
+# Benchmark: running C::FileCache, C::MemoryCache, C::NullCache, SimpleFileCache
+#   for at least 10 CPU seconds...
+#                    Rate C::FileCache SimpleFileCache C::MemoryCache C::NullCache
+# C::FileCache      271/s           --            -47%           -85%         -99%
+# SimpleFileCache   510/s          88%              --           -71%         -98%
+# C::MemoryCache   1766/s         553%            246%             --         -94%
+# C::NullCache    29119/s       10660%           5612%          1549%           --
+#
+# $cache->new(...) + $cache->get($key)
+# Benchmark: running C::FileCache, C::MemoryCache, C::NullCache, SimpleFileCache
+#   for at least 10 CPU seconds...
+#                    Rate C::FileCache C::MemoryCache SimpleFileCache C::NullCache
+# C::FileCache      510/s           --           -73%            -82%         -98%
+# C::MemoryCache   1905/s         273%             --            -32%         -93%
+# SimpleFileCache  2806/s         450%            47%              --         -90%
+# C::NullCache    28626/s        5509%          1402%            920%           --
+#
+## like for persistent environment
+#
+# $cache->set($key, $value)
+# Benchmark: running C::FileCache, C::MemoryCache, C::NullCache,
+#   FastMmap, FastMmap (S), SimpleFileCache for at least 10 CPU seconds...
+#                     Rate C::FileCache SimpleFileCache C::MemoryCache FastMmap (S) FastMmap C::NullCache
+# C::FileCache       309/s           --            -46%           -90%         -94%     -98%        -100%
+# SimpleFileCache    574/s          86%              --           -82%         -88%     -96%        -100%
+# C::MemoryCache    3168/s         925%            451%             --         -34%     -78%         -99%
+# FastMmap (S)      4828/s        1462%            740%            52%           --     -66%         -99%
+# FastMmap         14289/s        4524%           2387%           351%         196%       --         -98%
+# C::NullCache    572686/s      185208%          99586%         17976%       11761%    3908%           --
+#
+# $cache->get($key)  # $key exists in cache
+# Benchmark: running C::FileCache, C::MemoryCache, C::NullCache,
+#   FastMmap, FastMmap (S), SimpleFileCache for at least 10 CPU seconds...
+#                     Rate C::FileCache SimpleFileCache C::MemoryCache FastMmap (S) FastMmap C::NullCache
+# C::FileCache       830/s           --           -77%            -79%         -94%     -96%        -100%
+# C::MemoryCache    3539/s         326%             --            -12%         -75%     -84%         -99%
+# SimpleFileCache   4040/s         387%            14%              --         -72%     -82%         -99%
+# FastMmap (S)     14367/s        1631%           306%            256%           --     -35%         -97%
+# FastMmap         22247/s        2580%           529%            451%          55%       --         -96%
+# C::NullCache    546698/s       65759%         15348%          13431%        3705%    2357%           --
-- 
1.7.3
